class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  #フォームの入力内容が入る空のインスタンスを@boardに代入しておく
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to @board, notice: "投稿に成功しました"
      # なんで@boardで詳細に飛ぶんだろう？
      # rails routesで調べると詳細画面のURLはboardだった。@board=Board.new(board_params)で代入されているから、その投稿のidを含んだ詳細画面に飛べるということなのかな？
    else
      render :new
    end 
  end

  def show
    # @board = Board.find_by(id: params[:id]) 先生がfindで検索していたのでとりあえず合わせる
    @board = Board.find(params[:id])
  end

  def edit
    # @board = Board.find_by(id: params[:id])
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
     redirect_to @board, notice: "投稿を編集しました"
    # createの時と一緒、@boardで詳細に飛ぶ
     else
    render :edit
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_url, notice: "投稿を削除しました。"
  end

  private
  def board_params
    params.require(:board).permit(:title, :body)
  end

  # ↑ストロングパラメーターというやつ。確か期待する値のみが返ってくるように制限するやつだった気がする
  #【説明】requireメソッドがデータのオブジェクト名を定め、permitメソッドで保存処理のできるキーを指定する。
  #これらをあらかじめ設定することで、悪意のあるリクエストがあった際、permitメソッドで許可されていない項目については変更されない。


  # 最初の内は、とりあえずコントローラの中身を書いて、後から重複している箇所をberfore_actionで精査する感じで良いと思った。
  # 一気に書こうとする必要はない
  # only: [:show, :edit, :update, :destroy]これらアクションの実行前に実行されるメソッド。さっきこれ書いていない状態で色々できちゃったけど大丈夫なんだろうか

  # エイリアスやモジュールみたいな役割？find(params[:id])は
  #複数のアクションで使われるので、あらかじめbefore_actionとして書いておく

end