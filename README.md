## 概要
DockerコンテナによるWordPressサイトの構築  
![Inception drawio](https://github.com/tmuramat081/42_inception/assets/91453112/26f42137-602b-41f5-a994-85969d5d4f31)
[コンテナ構成図](https://drive.google.com/file/d/1IMgh776KeyKcMkrlNZrRkRfS6xgtrrsP/view?usp=sharing)

## セットアップ
- ボリュームにマウントするディレクトリを作成　　
```
midkr ~/data/mariadb/ ~/data/wordpress ~/data/redis ~/data/adminer
```
- SSL証明書の取得（X.509・自己署名）
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout srcs/requirements/nginx/ssl/private.key -out srcs/requirements/nginx/ssl/certificate.crt
```

- ホストネームの変更  
今回は独自のDNSサーバーを使用して名前解決を行う。  
/etc/resolv.conに以下を追加  
```
echo "nameserver 172.30.0.2" | sudo resolvconf -a eth0
```

参考: DNSサーバーを使用しない場合
```
echo "127.0.0.1 tmuramat.42.fr" | sudo tee -a /etc/hosts > /dev/null
```

- 静的解析ツール（あると便利）
```
curl -L https://github.com/hadolint/hadolint/releases/download/v2.8.0/hadolint-Linux-x86_64 -o /usr/local/bin/hadolint
chmod 755 /usr/local/bin/hadolint
```

- FTPクライアント
```
apt-get install filezilla
```

### Mandatory
Nginx+PHP7.4(php-fpm)+MariaDBでWordPressを構築する

## Nginx
- HTTPSのリクエストのみ受け付ける
- SSL証明書としてマウントされたディレクトリを指定
- FastCGI（php-fpm）を使ってアプリケーションサーバーに転送

## WordPress
- /var/www/htmlにWordPressをインストール
- wp-cliを用いて初期設定を行う
- DBの起動を待つ

## MariaDB
- 記事・コメント・ユーザー情報・設定などを管理
- DBの起動後、WordPress用のデータベースを作成する

### Bonus
以下のコンテナを追加し、利便性を高める。

## bind
DNSサーバー
- RNDC(Remote Name Daemon Control)をインストール
- ZONEファイルに基づきドメインをIPに名前解決
- cf. RFC1034, 1035

## adminer
- MariaDBの管理ツール
- phpmyadminと比べて軽量
- php-fpmで実行

## redis
- インメモリキャッシュ
- 永続化の方法としてRDBとAOFの二種類がある
RDBはスナップショットを保存、AODは書き込みコマンド単位で保存
```
redis-cli -h [hostname] -p [port] -a [password]
SET keyname "value"
GET keyname
KEYS *
```

## NestJS
- 静的サイトのホスティング
- nginxからリバースプロキシで接続される

## vsfpd
- クライアントツール（filezilla）で接続
- ルートディレクトリは/var/www/html

