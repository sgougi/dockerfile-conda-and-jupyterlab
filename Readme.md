# Dockerを利用したAnaconda仮想環境(Conda環境)の構築とJupyterLabの利用
このリポジトリのDockerfileを利用することで、Anaconda仮想環境とJupyterLabを利用可能となる。また、VSCodeを使ったNotebookの編集やJupyterLabのサービスを利用したコードの実行も可能となる。

## Dockerを利用してConda環境を用意する
- イメージの作成
  - ``build_image.{sh|bat}``を実行してDockerイメージを作成する。
    - 具体的な実行方法（他のシェルやバッチも同様）：
      - linuxやMacOS: sh build_image.sh
      - windows: build_image.bat
- コンテナの実行
  - ``start_container.{sh|bat}``を実行する。
  - これにより、Conda環境やJupyterLabの利用が可能となる。
  - ※ このスクリプトで作られたコンテナは終了すると自動で削除される。

## Conda環境に入る
- ``enter_containter.{sh|bat}``を実行する。
  - ユーザ``jupyter``のConda環境に入る事になる。

## ブラウザからJupyterLabにアクセスする
- ``start_container.{sh|bat}`` を起動後、端末に表示されるURIにブラウザからアクセスする。
  - URIは、ふたつ表示されるが、下側の``http//127.0.0.1:8888/lab?token=XXXX``の方を利用する。

## VSCodeのRemote-SSH拡張機能を使ってJupyterLabの作業ディレクトリにあるファイルを編集する
ここにある設定をしてVSCodeからNotebookを編集できるようにすることで、コードの編集時にintellisenseが利用可能となるだけでなく、VSCode上でJupyterが動作するためブラウザからJupyterLabにアクセスする必要もないことになる(※コードの実行には、JupyterLabのサービスを利用する)。

- ~/.ssh/config に以下の設定を追加。
  -  補足：jupyter_rsaは、``anaconda-docker/ssh_keys/``の下に存在する。そのまま利用するか、``~/.ssh``などにコピーして利用する。
  - ※　jupyter_rsaに、パスフレーズは設定していない。
```
Host localhost-anaconda
  HostName 127.0.0.1
  User jupyter
  Port 222
  # '(jupyter_rsaが存在するディレクトリのパス)'の箇所にはjupyter_rsaファイルが存在するディレクトリのパスを設定する。
  IdentityFile (jupyter_rsaが存在するディレクトリのパス)/jupyter_rsa
```

- ``Remote-SSH``で ``localhost-anaconda`` に接続する。
- 接続後、適当なディレクトリを開くと編集できる。
- JupyterLab関係のファイル編集は、``/home/jupyter/workdir/`` を``フォルダーを開く…``で開く。
  - このディレクトリの中のファイルにあるNotebookは、ブラウザからJupyterLabを通して参照できる。
- ``Jupyter拡張機能``を``SSH: local-anaconda``にインストール
- ``Ctrl+SHIFT+P``で、コマンドパレットを開いて、``Jupyter: Specify local or remote jupyter server for connections``を選択
  - すでに起動しているJupyter Serverを利用する場合は、``Existing``を選択し、
    - ``start_anaconda`` の起動後に標準出力に表示されるログ中のURIを入力する
      - URIはふたつ表示されるが、下側の``http//127.0.0.1:8888/lab?token=XXXX``の方をコピーして入力する
  - SSH接続環境下で新たにJupyter Serverを起動してそれを利用する場合は、``Default``を選択する。
    - ※この``Default``の選択は、一度``Existing``で接続した後はうまく機能する(SSH接続しているlocal-anacondaの中でサービスを立ち上げる)が、そうでない場合はうまく機能しない感じ。今一つ理解できていない。

# 書籍「[Pythonで儲かるAIをつくる](https://amzn.to/3kZpi0V)」のNotebookを実行する上での覚書

- 書籍のための記述されGithubで公開されている「[すべてのNotebook](https://github.com/makaishi2/profitable_ai_book_info)」が動作することを確認している。
- Githubからダウンロードしたファイルをworkdirの下に配置することで、
  - ブラウザからJupyterLabを通して参照できる。
  - VSCodeからもRemote-SSHやJupyter拡張を通してアクセスできる。
## l2_03_matplotlib.ipynb

「データ準備」のセルの``fetch_openml()``の呼び出しを次のように修正する必要がある：
- ``as_frame=False``を付ける
- なお、なぜこのNotebookではなぜ修正しないといけないのかは現時点ではよくわからない。というのも、ac_02_nmist.ipynbの同様の箇所は修正せずとも動作するため。

```
# データ準備

# 手書き数字データ
# 時間がかかるので注意してください
from sklearn.datasets import fetch_openml
mnist = fetch_openml(name='mnist_784', version=1, as_frame=False)
```

## コロナ予測.ipynb
「2020-2021に絞り込み」のセルの内容を次のように修正する必要がある：
 - ``日付``を``Date``に書き換え
```
# 2020-2021に絞り込み
df2 = df2.query('Date>"2019-12-31" & Date<"2021-12-31"')
```
