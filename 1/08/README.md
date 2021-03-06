### Домашнее задание
#### Размещаем свой RPM в своем репозитории
1) ***создать свой RPM (можно взять свое приложение, либо собрать к примеру апач с определенными опциями)***
    
    Решено собрать nginx с модулем Pagespeed
    
    Устанавливаем зависимости.  
    ```bash
    yum install gcc-c++ pcre-devel zlib-devel make unzip \ 
    wget openssl-devel libxml2-devel libxslt-devel gd-devel \ 
    perl-ExtUtils-Embed GeoIP-devel gperftools-devel rpm-build \
    redhat-lsb-core libuuid-devel mock rpmdevtools -y
    ```
    Добавляем пользователя под которым будем собирать.
    ```bash
    useradd -m otus
    ```
    Скачиваем свежий сорс [отсюда](https://nginx.org/packages/centos/7/SRPMS/)
    ```bash
    rpm -Uvh https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.0-1.el7_4.ngx.src.rpm
    ```
    Перемещаем исходники в директорию пользователя под которым будем производить сборку.
    ```bash
    mv /root/rpmbuild /home/otus/ && chown -R otus. /home/otus/rpmbuild
    ```
    Заходим под пользователем.
    ```bash
    su otus
    cd ~/rpmbuild/SOURCES/
    ```
    Скачиваем [последнюю](https://github.com/apache/incubator-pagespeed-ngx/releases) версию Pagespeed
    
    Структура переменных взята из [официального руководства](https://www.modpagespeed.com/doc/build_ngx_pagespeed_from_source)
    ```bash
    NPS_VERSION=1.13.35.2-stable
    wget https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip
    unzip v${NPS_VERSION}.zip
    rm v${NPS_VERSION}.zip
    ```
    В распакованную директорию Pagespeed скачиваем требуемую библиотеку PSOL.
   ```bash
    nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d)
    cd "$nps_dir"
    NPS_RELEASE_NUMBER=${NPS_VERSION/beta/}
    NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
    psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
    [ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
    wget ${psol_url}
    tar -xzvf $(basename ${psol_url})
    rm $(basename ${psol_url})   
    ```
    Запаковываем Pagespeed и PSOL в один архив
    ```bash
    cd ..
    tar -zcvf incubator-pagespeed-ngx-${NPS_VERSION}.tar.gz incubator-pagespeed-ngx-${NPS_VERSION}
    rm -r incubator-pagespeed-ngx-${NPS_VERSION}
    cd ~
    ```
    Редактируем spec-файл nginx
    ```bash
    nano ~/rpmbuild/SPECS/nginx.spec
    ``` 
    Ищем ```%define main_release 1%{?dist}.ngx``` и добавляем следующую строку ниже:
    ```bash
    %define pagespeed_version 1.13.35.2-stable
    ```
    Должно выглядеть примерно так
    ```bash
    %define main_version 1.14.0  
    %define main_release 1%{?dist}.ngx
    %define pagespeed_version 1.13.35.2-stable
    ```
    В секции ```%if 0%{?rhel} == 7``` ищем ```BuildRequires: openssl-devel >= 1.0.1``` и добавляем
    ```bash
    BuildRequires: libuuid-devel
    ```
    Должно выглядеть примерно так
    ```bash
    %if 0%{?rhel} == 7
    %define _group System Environment/Daemons
    %define epoch 1
    Epoch: %{epoch}
    Requires(pre): shadow-utils
    Requires: systemd
    Requires: openssl >= 1.0.1
    BuildRequires: systemd
    BuildRequires: openssl-devel >= 1.0.1
    BuildRequires: libuuid-devel
    %endif
    ```
    Ищем ```--with-stream_ssl_preread_module``` и добавляем следующую строку после неё:
    ```bash
    --add-module=%{_builddir}/%{name}-%{main_version}/incubator-pagespeed-ngx-%{pagespeed_version}
    ```
    Должно выглядеть примерно так
    ```bash
    %define BASE_CONFIGURE_ARGS $(echo "--prefix=%{_sysconfdir}/nginx --sbin-path=%{_sbindir}/nginx --modules-path=%{_libdir}/nginx/modules --conf-path=%{_sysconfdir}/nginx/nginx.conf --error-log-path=%{_localstatedir}/log/nginx/error.log --http-log-path=%{_localstatedir}/log/nginx/access.log --pid-path=%{_localstatedir}/run/nginx.pid --lock-path=%{_localstatedir}/run/nginx.lock --http-client-body-temp-path=%{_localstatedir}/cache/nginx/client_temp --http-proxy-temp-path=%{_localstatedir}/cache/nginx/proxy_temp --http-fastcgi-temp-path=%{_localstatedir}/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=%{_localstatedir}/cache/nginx/uwsgi_temp --http-scgi-temp-path=%{_localstatedir}/cache/nginx/scgi_temp --user=%{nginx_user} --group=%{nginx_group} --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --add-module=%{_builddir}/%{name}-%{main_version}/incubator-pagespeed-ngx-%{pagespeed_version}")
    ```
    Ищем ```Source13: nginx.check-reload.sh``` и добавляем под неё:
    ```bash
    Source14: incubator-pagespeed-ngx-%{pagespeed_version}.tar.gz
    ```
    Должно выглядеть примерно так
    ```bash
    Source13: nginx.check-reload.sh
    Source14: incubator-pagespeed-ngx-%{pagespeed_version}.tar.gz
    ```
    Ищем ```%setup -q``` и добавляем под неё:
    ```bash
    tar zxvf %SOURCE14
    %setup -T -D -a 14
    ```
    Должно выглядеть примерно так
    ```bash
    %prep
    %setup -q
    tar zxvf %SOURCE14
    %setup -T -D -a 14
    cp %{SOURCE2} .
    sed -e 's|%%DEFAULTSTART%%|2 3 4 5|g' -e 's|%%DEFAULTSTOP%%|0 1 6|g' \
    ```
    Собираем пакет
    ```bash
    spectool -g -R rpmbuild/SPECS/nginx.spec
    rpmbuild -bs ~/rpmbuild/SPECS/nginx.spec
    mock -r epel-7-x86_64 --rebuild ~/rpmbuild/SRPMS/nginx-1.14.0-1.el7_4.ngx.src.rpm
    ```
    Во время стадии конфигурирования появится приглашение с вопросом. Пишем ```Y```
    ```bash
    You have set --with-debug for building nginx, but precompiled Debug binaries for
        PSOL, which ngx_pagespeed depends on, aren't available.  If you're trying to
        debug PSOL you need to build it from source.  If you just want to run nginx with
        debug-level logging you can use the Release binaries.
        
        Use the available Release binaries? [Y/n] Y
        
    ```
    Откиньтесь на спинку кресла и отдохните, пока ~~Windows 98 устанавливается на ваш компьютер~~ собирается пакет.
    
    Если всё пройдёт без ошибок, в результате будет написано примерно следующее:
    ```bash
    Processing files: nginx-1.14.0-1.el7_4.ngx.x86_64
    Provides: config(nginx) = 1:1.14.0-1.el7_4.ngx nginx = 1:1.14.0-1.el7_4.ngx nginx(x86-64) = 1:1.14.0-1.el7_4.ngx webserver
    Requires(interp): /bin/sh /bin/sh /bin/sh /bin/sh
    Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
    Requires(pre): /bin/sh shadow-utils
    Requires(post): /bin/sh
    Requires(preun): /bin/sh
    Requires(postun): /bin/sh
    Requires: /bin/sh ld-linux-x86-64.so.2()(64bit) ld-linux-x86-64.so.2(GLIBC_2.3)(64bit) libc.so.6()(64bit) libc.so.6(GLIBC_2.10)(64bit) libc.so.6(GLIBC_2.11)(64bit) libc.so.6(GLIBC_2.14)(64bit) libc.so.6(GLIBC_2.2.5)(64bit) libc.so.6(GLIBC_2.3)(64bit) libc.so.6(GLIBC_2.3.2)(64bit) libc.so.6(GLIBC_2.3.3)(64bit) libc.so.6(GLIBC_2.3.4)(64bit) libc.so.6(GLIBC_2.4)(64bit) libc.so.6(GLIBC_2.7)(64bit) libc.so.6(GLIBC_2.8)(64bit) libcrypt.so.1()(64bit) libcrypt.so.1(GLIBC_2.2.5)(64bit) libcrypto.so.10()(64bit) libcrypto.so.10(OPENSSL_1.0.2)(64bit) libcrypto.so.10(libcrypto.so.10)(64bit) libdl.so.2()(64bit) libdl.so.2(GLIBC_2.2.5)(64bit) libgcc_s.so.1()(64bit) libgcc_s.so.1(GCC_3.0)(64bit) libm.so.6()(64bit) libm.so.6(GLIBC_2.2.5)(64bit) libpcre.so.1()(64bit) libpthread.so.0()(64bit) libpthread.so.0(GLIBC_2.12)(64bit) libpthread.so.0(GLIBC_2.2.5)(64bit) libpthread.so.0(GLIBC_2.3.2)(64bit) libpthread.so.0(GLIBC_2.3.3)(64bit) libpthread.so.0(GLIBC_2.4)(64bit) librt.so.1()(64bit) librt.so.1(GLIBC_2.2.5)(64bit) libssl.so.10()(64bit) libssl.so.10(libssl.so.10)(64bit) libstdc++.so.6()(64bit) libstdc++.so.6(CXXABI_1.3)(64bit) libstdc++.so.6(CXXABI_1.3.5)(64bit) libstdc++.so.6(GLIBCXX_3.4)(64bit) libstdc++.so.6(GLIBCXX_3.4.11)(64bit) libstdc++.so.6(GLIBCXX_3.4.14)(64bit) libstdc++.so.6(GLIBCXX_3.4.15)(64bit) libstdc++.so.6(GLIBCXX_3.4.18)(64bit) libstdc++.so.6(GLIBCXX_3.4.9)(64bit) libuuid.so.1()(64bit) libz.so.1()(64bit) rtld(GNU_HASH)
    Processing files: nginx-debuginfo-1.14.0-1.el7_4.ngx.x86_64
    Provides: nginx-debuginfo = 1:1.14.0-1.el7_4.ngx nginx-debuginfo(x86-64) = 1:1.14.0-1.el7_4.ngx
    Requires(rpmlib): rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1 rpmlib(CompressedFileNames) <= 3.0.4-1
    Checking for unpackaged file(s): /usr/lib/rpm/check-files /home/otus/rpmbuild/BUILDROOT/nginx-1.14.0-1.el7_4.ngx.x86_64
    Wrote: /home/otus/rpmbuild/SRPMS/nginx-1.14.0-1.el7_4.ngx.src.rpm
    Wrote: /home/otus/rpmbuild/RPMS/x86_64/nginx-1.14.0-1.el7_4.ngx.x86_64.rpm
    Wrote: /home/otus/rpmbuild/RPMS/x86_64/nginx-debuginfo-1.14.0-1.el7_4.ngx.x86_64.rpm
    Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.cPyiHj
    + umask 022
    + cd /home/otus/rpmbuild/BUILD
    + cd nginx-1.14.0
    + /usr/bin/rm -rf /home/otus/rpmbuild/BUILDROOT/nginx-1.14.0-1.el7_4.ngx.x86_64
    + exit 0
    Finish: rpmbuild nginx-1.14.0-1.el7_4.ngx.src.rpm
    Finish: build phase for nginx-1.14.0-1.el7_4.ngx.src.rpm
    INFO: Done(/home/otus/rpmbuild/SRPMS/nginx-1.14.0-1.el7_4.ngx.src.rpm) Config(epel-7-x86_64) 5 minutes 23 seconds
    INFO: Results and/or logs in: /var/lib/mock/epel-7-x86_64/result
    Finish: run
    ```
    Пакет находится в ```/home/otus/rpmbuild/RPMS/x86_64/nginx-1.14.0-1.el7_4.ngx.x86_64.rpm```
    Можно установить его
    ```bash
    sudo yum update /home/otus/rpmbuild/RPMS/x86_64/nginx-1.14.0-1.el7_4.ngx.x86_64.rpm
    ```
        
2) ***создать свой репо и разместить там свой RPM
реализовать это все либо в вагранте, либо развернуть у себя через nginx и дать ссылку на репо***

    ```bash
    yum install createrepo
    mkdir -p /var/www/html/repos/centos/7/Packages/
    cp /home/otus/rpmbuild/RPMS/x86_64/* /var/www/html/repos/centos/7/Packages/
    createrepo /var/www/html/repos/centos/7/
     ```
     Добавляем файл /etc/yum.repos.d/nginx-pgspeed.repo
     ```bash
    [nginx-pagespeed]
    name=Nginx Pagespeed
    failovermethod=priority
    baseurl=https://repo.domain.tld/centos/7/
    enabled=1
    gpgcheck=0
    ```
  
     Ссылка на репозиторий в чате.
     ```bash
    yum --showduplicates list nginx
         Loaded plugins: etckeeper, fastestmirror, merge-conf
         Loading mirror speeds from cached hostfile
          * base: mirror.reconn.ru
          * epel: mirror.awanti.com
          * extras: mirror.awanti.com
          * remi: mirror.awanti.com
          * remi-php71: mirror.awanti.com
          * remi-safe: mirror.awanti.com
          * updates: mirror.awanti.com
         Available Packages
         nginx.x86_64     1:1.12.2-2.el7           epel           
         nginx.x86_64     1:1.14.0-1.el7_4.ngx     nginx-pagespeed
         ```
     ```bash
    yum update nginx-1.14.0-1.el7_4.ngx                                                                                                                                                    
    Loaded plugins: etckeeper, fastestmirror, merge-conf
    Loading mirror speeds from cached hostfile
     * base: mirror.reconn.ru
     * epel: mirror.awanti.com
     * extras: mirror.awanti.com
     * remi: mirror.awanti.com
     * remi-php71: mirror.awanti.com
     * remi-safe: mirror.awanti.com
     * updates: mirror.awanti.com
    Resolving Dependencies
    --> Running transaction check
    ---> Package nginx.x86_64 1:1.14.0-1.el7_4.ngx will be installed
    --> Finished Dependency Resolution
    
    Dependencies Resolved
   ======================================================
    Package        Arch      Version      Repository   Size
   ===========================================================
    Installing:
    nginx         x86_64     1:1.14.0-1.el7_4.ngx  nginx-pagespeed 8.9 M
    
    Transaction Summary
    ================================================================
    Install  1 Package
    
    Total download size: 8.9 M
    Installed size: 27 M
    Is this ok [y/d/N]:
    ```
    
    Если не запускается с ошибкой ```error while loading shared libraries: cannot create cache for search path: Cannot allocate memory``` добавляем правило в selinux ```setsebool -P httpd_execmem on```
    