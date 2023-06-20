class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds, except: [:created_at, :updated_at]
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, except: [:created_at, :updated_at], status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird, except: [:created_at, :updated_at]
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id
  def update
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(bird_params)
      render json: bird, except: [:created_at, :updated_at]
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird, except: [:created_at, :updated_at]
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  def destroy
    bird = Bird.find_by(id:params[:id])
    if bird
      bird.destroy
      # head :no_content
      render json: {success: "bird deleted successfully!"}, status: :no_content
    else
      render json: {error: "bird not found!"}, status: :not_found
    end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

end
