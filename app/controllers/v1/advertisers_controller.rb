class V1::AdvertisersController < ApplicationController
  include Tokenized

  before_action :advertiser, only: [:show]

  def create_wallet
  	respond_with WalletService.create(params[:profile_id], "Advertiser"), serializer: V1::ProfileSerializer, 
  				       location: v1_advertisers_path
  end

  def update_wallet
  	respond_with WalletService.update(params[:profile_id], "Advertiser")
  end

  def show
    respond_with advertiser, serializer: V1::AdvertiserSerializer,
                 location: v1_advertiser_path
  end

  private

    def profile_params
      params.require(:profile_params).permit(:root, :referrer_profile_id)
    end

    def advertiser
      Advertiser.find_by_profile_id!(params[:profile_id])
    end

    def token_service
      priv_key = advertiser.ethereum_wallet.private_hex
      TokenService.new(priv_key)
    end
end
