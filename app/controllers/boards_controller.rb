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
end

private
def board_params
  params.require(:board).permit(:title, :body)
end

=begin ↑ストロングパラメーターというやつ
確か期待する値のみが返ってくるように制限するやつ
requireメソッドがデータのオブジェクト名を定め、permitメソッドで保存処理のできるキーを指定する。
これらをあらかじめ設定することで、悪意のあるリクエストがあった際、permitメソッドで許可されていない項目については変更されない。
=end
