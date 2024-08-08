# 株式会社ゆめみ iOS 未経験者エンジニア向けコードチェック課題

## 環境
- IDE：Xcode 15.4.0
- Swift：Swift 5.10
- 開発ターゲット：iOS 17.5

### 成果物動画

| 標準モードの動画 | ダークモードの動画 |
|----------------|----------------|
| [Standard Mode Video](https://github.com/user-attachments/assets/b12e2b61-0892-41bb-9225-c9d39eaeea7a) | [Dark Mode Video](https://github.com/user-attachments/assets/06db9fa4-239a-4001-8a4c-52fbb3d66d93) |

### 機能

| スタート画面 | 占いデータ入力画面 | 結果表示画面 | 保存表示画面 |
|--------------|-------------------|-------------|--------------|
| ![Simulator Screenshot - iPhone 15 Plus - 2024-08-08 at 09 09 25](https://github.com/user-attachments/assets/19f23356-2bfd-46db-9d48-bcae1406d490) | ![Simulator Screenshot - iPhone 15 Plus - 2024-08-08 at 09 09 29](https://github.com/user-attachments/assets/6a34e0f4-6d8e-4fe0-b06d-b548ac0b2643) | ![Simulator Screenshot - iPhone 15 Plus - 2024-08-08 at 09 10 02](https://github.com/user-attachments/assets/82c76e51-2777-425b-bc76-da01044bca42) | ![Simulator Screenshot - iPhone 15 Plus - 2024-08-08 at 09 09 34](https://github.com/user-attachments/assets/ef133933-0f95-4189-a3c1-cd9ba5aa5ca9) |


## Gitの使用方法
本プロジェクトではGit Flowを意識して作成しました。ブランチは`main`、`develop`、`feature`に分けて管理しています。コミットメッセージは1機能につき1コミットを目安に、[こちらのガイド](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)に従って作成しました。

## 工夫したポイント

### SwiftDataの利用
- **iOS 17から導入されたSwiftDataを活用しました。**

### SwiftLintの利用
- **SwiftLintを利用しフォーマットを意識した実装を行いました。**

### エラーハンドリング
- **エラーハンドリングを可能な限り細かく実装しました。** どのタイミングでエラーが発生したのかをログを通じて把握できるように細かなエラーハンドリングを意識しました。

### ユーザーインターフェース
- **入力データの不足時にアラートを出力します。** ユーザーが必要な情報を入力しなかった場合に適切なアラートを出力するよう実装しました。

### ダークモード対応
- **ボタンをダークモードに対応させました。** 
