class VisitorsController < ApplicationController
  include ApplicationHelper

  def new
    @visitor = Visitor.new
  end

  def create
    @visitor = Visitor.new(secure_params)
    input_email = secure_params[:email].downcase

    if @visitor.valid?
      mailchimp = Gibbon::Request.new(api_key: Rails.application.credentials[Rails.env.to_sym][:mailchimp_api_key], symbolize_keys: true)
      list_id = Rails.application.credentials[Rails.env.to_sym][:mailchimp_list_id]

      # check for 2x subscribers (why you do this?) https://stackoverflow.com/questions/50194825/check-if-member-exists-using-mailchimp-3-0-api-and-gibbon-rails?rq=1

      begin
        member_id = Digest::MD5.hexdigest(input_email)
        member_status = mailchimp.lists(list_id).members(member_id).retrieve.body[:status]
        
        if member_status == "subscribed"
          flash[:notice] = "You are already subscribed!"
          redirect_to root_path
        elsif member_status == "unsubscribed"
          flash[:danger] = "You already unsubscribed!"
          redirect_to root_path
        end

      rescue 
        result = mailchimp.lists(list_id).members.create(
          body: {
            email_address: input_email,
            status: 'subscribed'
          })

        Rails.logger.info("Subscribed #{input_email} to MailChimp") if result
        flash[:notice] = "Thank you for signing up #{input_email}!"
        redirect_to root_path
      end
    else
      render 'new'
    end
  end

  private

  def secure_params
    params.require(:visitor).permit(:email)
  end

end
