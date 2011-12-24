require 'spec_helper'

describe AssetActionsController do

  pending "TODO"

#  def valid_attributes
#    {:quantity => 15, :price_cents => 19087}
#  end

#  before(:all) do
#    @portfolio = mock(Portfolio)
#  end

#  describe "GET index" do
#    it "assigns all asset_actions as @asset_actions" do
#      asset_action = AssetAction.create! valid_attributes
#      get :index
#      assigns(:asset_actions).should eq([asset_action])
#    end
#  end

#  describe "GET new" do
#    it "assigns a new asset_action as @asset_action" do
#      get :new
#      assigns(:asset_action).should be_a_new(AssetAction)
#    end
#  end

#  describe "POST create" do
#    describe "with valid params" do
#      it "creates a new AssetAction" do
#        expect {
#          post :create, :asset_action => valid_attributes
#        }.to change(AssetAction, :count).by(1)
#      end

#      it "assigns a newly created asset_action as @asset_action" do
#        post :create, :asset_action => valid_attributes
#        assigns(:asset_action).should be_a(AssetAction)
#        assigns(:asset_action).should be_persisted
#      end

#      it "redirects to the created asset_action" do
#        post :create, :asset_action => valid_attributes
#        response.should redirect_to(AssetAction.last)
#      end
#    end

#    describe "with invalid params" do
#      it "assigns a newly created but unsaved asset_action as @asset_action" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        AssetAction.any_instance.stub(:save).and_return(false)
#        post :create, :asset_action => {}
#        assigns(:asset_action).should be_a_new(AssetAction)
#      end

#      it "re-renders the 'new' template" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        AssetAction.any_instance.stub(:save).and_return(false)
#        post :create, :asset_action => {}
#        response.should render_template("new")
#      end
#    end
#  end

#  describe "DELETE destroy" do
#    it "destroys the requested asset_action" do
#      asset_action = AssetAction.create! valid_attributes
#      expect {
#        delete :destroy, :id => asset_action.id
#      }.to change(AssetAction, :count).by(-1)
#    end

#    it "redirects to the asset_actions list" do
#      asset_action = AssetAction.create! valid_attributes
#      delete :destroy, :id => asset_action.id
#      response.should redirect_to(asset_actions_url)
#    end
#  end

end

