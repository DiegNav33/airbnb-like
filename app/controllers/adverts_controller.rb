class AdvertsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index

    if params[:query].present?
      query = params[:query]
      @adverts = Advert.where("city ILIKE :query OR state ILIKE :query OR country ILIKE :query", query: "%#{query}%")

    elsif params[:category].present?
      @adverts = Advert.where(category_id: params[:category])

    else
      @adverts = Advert.all
    end
  end

  def new
    @user = current_user
    @advert = Advert.new(user_id: @user.id)
  end

  def create
    @user = current_user
    @advert = @user.adverts.build(advert_params)
    if @advert.save
      redirect_to advert_path(@advert), notice: "Advert successfully created", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
    @advert = Advert.find(params[:id])
    @review = Review.new(advert_id: @advert)
    @reviews = @advert.reviews
    if @reviews.any?
      @average_rating = @reviews.average(:rating).to_f
    else
      @average_rating = nil
    end
  end

  def edit
    @advert = Advert.find(params[:id])
  end

  def update
    @advert = Advert.find(params[:id])

    #Keep the existing images et add the new ones if exists
    if params[:advert][:images].present?
      @advert.images.attach(params[:advert][:images]) #Add new images
    end

    #Delete all the images in the params hash to avoid the reboot  of it
    params[:advert].delete(:images)
    if @advert.update(advert_params)
      redirect_to advert_path(@advert), notice: "Advert successfully updated", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @advert = Advert.find(params[:id])
    @advert.destroy
    redirect_to root_path, notice: "Advert successfully deleted", status: :see_other
  end

  private

  def advert_params
    params.require(:advert).permit(:title, :description, :price, :max_guests, :min_nights, :bedrooms, :beds, :bathrooms, :check_in, :check_out, :smoking, :party, :address, :city, :state, :postal_code, :country, :category_id, amenity_ids: [], images: [])
  end
end
