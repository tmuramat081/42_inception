## セットアップ
- ボリュームにマウントするディレクトリを作成
~/data/mariadb/ ~/data/wordpress
- SSL証明書の取得
Let's encrypt

### Mandatory

- Mariadb

- wordpress

### Bonus

- bind
DNSサーバー
 
- NestJS
静的サイトのホスティング
nginxからリバースプロキシで接続される

### 構成図
graph RL;
    style U fill:#e0ffff,color:#fffed,shape:ellipse;
    U[User/Host Machine] -->|HTTP Request|A[Nginx];
    A[Nginx] -->|FastCGI| B[Wordpress];
    B -->|SQL Query| C[MariaDB];
    C -->|Result| B;
    B -->|FastCGI| A;
    A -->|HTTP Response|U;
    