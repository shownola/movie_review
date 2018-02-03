class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_movie
  before_action :authenticate_user!  

  
  
  def new
    @review = Review.new
  end


  def edit
  end

 
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.movie_id = @movie.id
      if @review.save
        redirect_to @movie
      else
        render 'new'
      end
  end

  
  def update
   if @review.update(review_params)
     flash[:success] = "Your review was updated successfully"
     redirect_to @review
   else
     render 'edit'
   end
  end

  
  def destroy
    @review.destroy
    flash[:success] = "You have successfully deleted your review"
    redirect_to reviews_url
  end

  private
  
    def set_review
      @review = Review.find(params[:id])
    end
    
    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
