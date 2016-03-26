class CommentsController < ApplicationController
  # before_action :require_login, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    resource = if params[:question_id]
      Question.find(params[:question_id])
    else
      Answer.find(params[:answer_id])
    end

    comment = resource.comments.build comment_params.merge(user: current_user)

    if comment.save
      flash[:success] = "Comment is created."
      redirect_to redirect_url_after_create resource
    else
      flash[:error] = "Comment can't be created."
      redirect_to redirect_url_after_create resource
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:response)
  end

  def redirect_url_after_create resource
    resource.is_a?(Answer) ? question_path(resource.question) : resource
  end

end