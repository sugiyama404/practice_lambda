# サーバレスアーキテクチャによる静的ウェブサイト構築

![Git](https://img.shields.io/badge/GIT-E44C30?logo=git&logoColor=white)
![gitignore](https://img.shields.io/badge/gitignore%20io-204ECF?logo=gitignoredotio&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?logo=terraform&logoColor=white)

このリポジトリは、S3、API Gateway、Lambda、RDSを使用したサーバレスアーキテクチャの構築に関するものです。静的ウェブサイトのホスティングとTerraformによるインフラストラクチャ管理について説明します。

# 構成
このアーキテクチャは、以下のコンポーネントで構成されています。

+ S3: 静的コンテンツのホスティングに使用されます。
+ API Gateway: クライアントからのリクエストをLambda関数にルーティングするために使用されます。
+ Lambda: ウェブサイトのロジックを実装するために使用される関数です。
+ RDS: データベースの保存に使用されます。
+ Terraform: インフラストラクチャをコードとして定義および管理するために使用されます。
+ IAM を使用したアクセス制御

# 動作
クライアントがウェブサイトにアクセスすると、リクエストはAPI Gatewayに送信されます。
API Gatewayは、リクエストを適切なLambda関数にルーティングします。
Lambda関数は、S3から静的コンテンツをフェッチし、必要に応じてRDSからデータをクエリし、レスポンスを生成します。
API Gatewayは、生成されたレスポンスをクライアントに返します。

# 利点
このアーキテクチャには、以下のような利点があります。

+ スケーラビリティ: トラフィックが増加すると、自動的にスケールアップできます。
+ コスト効率: 使用した分だけ支払う従量課金制モデルです。
+ 運用管理: サーバーを管理する必要はありません。
+ 高可用性: 冗長構成により、高い可用性を提供します。

# 起動方法
以下のコードを実行すると実行されます。
```
bin/terraform_apply
```

# 停止方法
以下のコードを実行すると実行されます。
```
bin/terraform_destroy
```











