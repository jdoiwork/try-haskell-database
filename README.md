# try-haskell-database

- Haskell の データベース接続のサンプル


# 動かし方
## データベースの準備

### SQLite

```bash
# sqlite3コマンドを実行する
sqlite3

# データベースファイルを作る
.open ./hoge.db

# usersテーブルを作る
.read db/sqlite/create-users-table.sql

# usersテーブルへデータを追加
.read db/add-users.sql
```

### PostgreSQL

1. http://localhost:8080 を開く。
2. ログインする
3. メニューの `データベースを作成` をクリック
4. `hoge` と入力して `保存` をクリック
5. 左側の `SQLコマンド` をクリック
6. DB: `hoge`, スキーマ: `public` にする
7. [./db/postgres/create-users-table.sql](./db/postgres/create-users-table.sql) の内容をテキストフィールドへコピペする
8. 実行をクリックして、usersテーブルを作成する
9. [./db/add-users.sql](./db/add-users.sql) の内容をテキストフィールドへコピペする
10. 実行をクリックして、usersテーブルにデータを追加する


#### 認証情報
| Key | Value |
| ---- | ---- |
| データベース種類 | `PostgreSQL` |
| サーバ | `db` |
| ユーザー名 | `postgres` |
| パスワード | `example` |
| データベース | |

## ビルドと実行
vscode の `Cmd + Shift + P` して `Reopen in Container` する。

```bash
# 初回のみ
stack setup

# ビルド
stack build

# 実行
stack run
```

