class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  #フォームの入力内容が入る空のインスタンスを@boardに代入しておく
  def new
    @board = Board.new
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
