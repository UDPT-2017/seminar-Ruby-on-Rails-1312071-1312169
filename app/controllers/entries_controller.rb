class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]


  def new
    @entry = Entry.new
    if session[:errors] && session[:errors] == 0
      session[:errors] = nil
    else
      session[:errors] = 1
    end
  end
def create
    @entry = current_user.entries.build entry_params
    if @entry.save
      flash[:success] = t ".entry_created"
      session[:create_errors] = Hash.new
      redirect_to root_url
    else
      session[:create_errors] = @entry.errors.full_messages
      session[:errors] = 0
      redirect_to new_entry_url
    end
  end

  private
  def entry_params
    params.require(:entry).permit :title, :picture
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t ".log_in"
      redirect_to login_url
    end
  end
end