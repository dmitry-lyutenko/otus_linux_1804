#!/bin/bash
cat <<\EOT >> /root/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAuXWShdSF7QZfKPZD5OSA5N+p3PhETTRYf8MmxvT1SBkRXi6B
GxQyQhiBG+dJC71SuZLR+nNXEreLfnbZG7ojQwNK9nCp2d+GiBrtdGJaiWQnh/5d
n+qvoNTiuTpkx5HwLiDYmL+VIeKt32UD+ZxTFQoskdfVKOa8thFirgB9Fye/5VFl
LaG0TwFA2GtLs23KUS7giEKMc3wHGOd9DULJFZCoY711O/rWL0PaYLZhuCsNrPOM
93bD4ySTgZvLetZAvijV/MK9Fb3gSyg8j3syZuO8KziGSz3oteTM7rdbabAEtESa
YGiUVTqz+WjfuH5gZh199G2dilfhLm7iuQT99QIDAQABAoIBAGnl9sqwdeDIWKId
LNuQlwEZrfbdVLL5Bue9WXEWAtEubzpmN5Zsy93t/Bsg0BcB/jC0422tWrT3VZHa
71Hj0aq8QJvD7VjZSAqDxb9FQgldxSzkVDWyXqLprKSz8UP70zejzco66z80HrCH
D+QCHXbQHm8Q3UjDqFIWT1CoOsVzFkpjc44KJBGZKzKmhg2O1VyXh7KW9YJfhcy9
nzhic9w0avXPOswZLbTsFoIt9l8HAKMpnv5+ZTsGm6zg9I+w8MeUneMXDJ3wJxsk
W6LNCsUFwkBaBjAAZyS+aTXl7ep8fSuz1TZLdUHdu6Tp4Oktkkhp+BOcjbi7Wa9e
TNWgtIECgYEA2tQxhaRfuEo5zHQRNaO6x6fH0N0AaTuHo+7XenX9MafQOrk7kTY8
U2aEsboUEZI/PqM3ewFGsGVcv5ArSIZrLrErwp2hNuj2ITCz9NQhv6t+8SThAfRo
Lili0TmdyrKkSJBFz72Dw583Vi55yvOGznSj4hbkMalpm4Ths3FMLPECgYEA2PZL
2MtlyfjzGBiLAehRJuUhlUVWk9aFALHUtqgrzLb9B9841uf8iCIQFynr2VQkeyPg
+AitEyq7s3dPv1r+eZPJJKrab39YOBUiuz1A3WwTpr1qgOsnt0Hj6vVzgrq5NW2q
NFdInQMab+4q9C+SgaJ5gn0P6wBEtfih4kQO8UUCgYAE+aIOmcgbVoSt402o3IoY
k/X1B7FEszfIQFvhyuDwyhHv49o42PTSKJiHueVO6PZLJEbUoxjKVeOf71UslvHE
4/5MtGy/5NgDtSnCPThvNSTzspTzCG197y7x9s9hlmIpzC3qJTLjtbD6YqAePx8n
fntjXoXdoy5lfMXs4HyM4QKBgEDcIICHDb77dXDWpXfEg74k8Y02VVOM5eX3Q6f3
TmC8s5gO22cjoxLvW/AQ0DkANoe5ih+cOGFqfQKBwI1sHncp/w+/I94BK9ZYOzHO
df27uYQ3TAeORSk7wW8UQZvrRkL6rc9H6KVHsDeV87FcJ2gpsjmYOZH/Wosr8Pk7
b1whAoGBAJVWns2qgp2PyllLxHPJ+PBgkxB57aRF2jqj/yjGLAalLsqMQ5b9I9ui
hMGPYXGgUIJXjzF/URJHMlKNC0h1arWpQAx8AtBq2MihsmuO065pNsfdOBakADWB
DVgDMbcQzCa3WwGaPpD55lTmXg3UXqrTvdu++AgJoTfe+gHEY02o
-----END RSA PRIVATE KEY-----
EOT

cat <<\EOT > /home/vagrant/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAuXWShdSF7QZfKPZD5OSA5N+p3PhETTRYf8MmxvT1SBkRXi6B
GxQyQhiBG+dJC71SuZLR+nNXEreLfnbZG7ojQwNK9nCp2d+GiBrtdGJaiWQnh/5d
n+qvoNTiuTpkx5HwLiDYmL+VIeKt32UD+ZxTFQoskdfVKOa8thFirgB9Fye/5VFl
LaG0TwFA2GtLs23KUS7giEKMc3wHGOd9DULJFZCoY711O/rWL0PaYLZhuCsNrPOM
93bD4ySTgZvLetZAvijV/MK9Fb3gSyg8j3syZuO8KziGSz3oteTM7rdbabAEtESa
YGiUVTqz+WjfuH5gZh199G2dilfhLm7iuQT99QIDAQABAoIBAGnl9sqwdeDIWKId
LNuQlwEZrfbdVLL5Bue9WXEWAtEubzpmN5Zsy93t/Bsg0BcB/jC0422tWrT3VZHa
71Hj0aq8QJvD7VjZSAqDxb9FQgldxSzkVDWyXqLprKSz8UP70zejzco66z80HrCH
D+QCHXbQHm8Q3UjDqFIWT1CoOsVzFkpjc44KJBGZKzKmhg2O1VyXh7KW9YJfhcy9
nzhic9w0avXPOswZLbTsFoIt9l8HAKMpnv5+ZTsGm6zg9I+w8MeUneMXDJ3wJxsk
W6LNCsUFwkBaBjAAZyS+aTXl7ep8fSuz1TZLdUHdu6Tp4Oktkkhp+BOcjbi7Wa9e
TNWgtIECgYEA2tQxhaRfuEo5zHQRNaO6x6fH0N0AaTuHo+7XenX9MafQOrk7kTY8
U2aEsboUEZI/PqM3ewFGsGVcv5ArSIZrLrErwp2hNuj2ITCz9NQhv6t+8SThAfRo
Lili0TmdyrKkSJBFz72Dw583Vi55yvOGznSj4hbkMalpm4Ths3FMLPECgYEA2PZL
2MtlyfjzGBiLAehRJuUhlUVWk9aFALHUtqgrzLb9B9841uf8iCIQFynr2VQkeyPg
+AitEyq7s3dPv1r+eZPJJKrab39YOBUiuz1A3WwTpr1qgOsnt0Hj6vVzgrq5NW2q
NFdInQMab+4q9C+SgaJ5gn0P6wBEtfih4kQO8UUCgYAE+aIOmcgbVoSt402o3IoY
k/X1B7FEszfIQFvhyuDwyhHv49o42PTSKJiHueVO6PZLJEbUoxjKVeOf71UslvHE
4/5MtGy/5NgDtSnCPThvNSTzspTzCG197y7x9s9hlmIpzC3qJTLjtbD6YqAePx8n
fntjXoXdoy5lfMXs4HyM4QKBgEDcIICHDb77dXDWpXfEg74k8Y02VVOM5eX3Q6f3
TmC8s5gO22cjoxLvW/AQ0DkANoe5ih+cOGFqfQKBwI1sHncp/w+/I94BK9ZYOzHO
df27uYQ3TAeORSk7wW8UQZvrRkL6rc9H6KVHsDeV87FcJ2gpsjmYOZH/Wosr8Pk7
b1whAoGBAJVWns2qgp2PyllLxHPJ+PBgkxB57aRF2jqj/yjGLAalLsqMQ5b9I9ui
hMGPYXGgUIJXjzF/URJHMlKNC0h1arWpQAx8AtBq2MihsmuO065pNsfdOBakADWB
DVgDMbcQzCa3WwGaPpD55lTmXg3UXqrTvdu++AgJoTfe+gHEY02o
-----END RSA PRIVATE KEY-----
EOT

cat <<\EOT >> /root/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5dZKF1IXtBl8o9kPk5IDk36nc+ERNNFh/wybG9PVIGRFeLoEbFDJCGIEb50kLvVK5ktH6c1cSt4t+dtkbuiNDA0r2cKnZ34aIGu10YlqJZCeH/l2f6q+g1OK5OmTHkfAuINiYv5Uh4q3fZQP5nFMVCiyR19Uo5ry2EWKuAH0XJ7/lUWUtobRPAUDYa0uzbcpRLuCIQoxzfAcY530NQskVkKhjvXU7+tYvQ9pgtmG4Kw2s84z3dsPjJJOBm8t61kC+KNX8wr0VveBLKDyPezJm47wrOIZLPei15Mzut1tpsAS0RJpgaJRVOrP5aN+4fmBmHX30bZ2KV+EubuK5BP31 root@openvpn1
EOT

cat <<\EOT > /home/vagrant/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5dZKF1IXtBl8o9kPk5IDk36nc+ERNNFh/wybG9PVIGRFeLoEbFDJCGIEb50kLvVK5ktH6c1cSt4t+dtkbuiNDA0r2cKnZ34aIGu10YlqJZCeH/l2f6q+g1OK5OmTHkfAuINiYv5Uh4q3fZQP5nFMVCiyR19Uo5ry2EWKuAH0XJ7/lUWUtobRPAUDYa0uzbcpRLuCIQoxzfAcY530NQskVkKhjvXU7+tYvQ9pgtmG4Kw2s84z3dsPjJJOBm8t61kC+KNX8wr0VveBLKDyPezJm47wrOIZLPei15Mzut1tpsAS0RJpgaJRVOrP5aN+4fmBmHX30bZ2KV+EubuK5BP31 root@openvpn1
EOT


chmod 600 /root/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa
chown vagrant. -R  /home/vagrant/.ssh/
