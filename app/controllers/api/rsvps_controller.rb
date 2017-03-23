class Api::RsvpsController < ApplicationController
  def create
    @rsvp = Rsvp.new(rsvp_params)
    if @rsvp.user.id != current_user.id
      render json: ['Invalid credentials'], status: 401
    elsif @rsvp.save
      head :no_content
    else
      render json: @rsvp.errors.full_messages, status: 400
    end
  end

  def update
    @rsvp = Rsvp.find_by_id(params[:id])
    if current_user.nil?
      render json: ['You must be logged in to edit rsvps'], status: 401
    elsif @rsvp.nil?
      render json: ['Rsvp not found'], status: 404
    elsif @rsvp.user_id == current_user.id ||
          @rsvp.group.organizer.id == current_user.id
      if @rsvp.update_attributes(rsvp_params)
        head :no_content
      else
        render json: @rsvp.errors.full_messages, status: 400
      end
    else
      render json: ['Invalid credentials'], status: 401
    end
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:event_id, :user_id, :going)
  end

end
