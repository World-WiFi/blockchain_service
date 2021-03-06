class V1::CampaignsController < ApplicationController
  before_action :advertiser, only: [:create]  
  before_action :deal_service
  before_action :check_exist_campaign, only: [:update, :destroy, :finish]

  def create
    deal_service.create_campaign(advertiser, params[:token_amount])
  end

  def show
    respond_with deal_service, serializer: V1::CampaignSerializer
  end

  def update
    deal_service.add_tokens(params[:token_amount])
  end

  def send_coins
    deal_service.send_coins(params.fetch(:token_distribution))
  end

  def destroy  
    deal_service.destroy
  end

  def finish
    deal_service.finish
  end

  private
    def advertiser
      Advertiser.find_by_profile_id!(params[:profile_id])
    end

    def deal_service
      DealService.new(params[:id] || params[:campaign_id])
    end

    def check_exist_campaign
      return head :not_found if deal_service.check_status == "not created"
    end
end
