require 'spec_helper'

describe SettingsController do

  before :each do
    @user = Factory(:user)
    sign_in @user
  end

  def valid_attributes
    {
      :name => 'TestSettings',
      :multiplier => 100,
      :stock_fee => 0.8,
      :option_fee => 2.2,
      :supplement_cost => 1000,
      :asset_adjustment => 30,
      :points_to_rehedge => 50
    }
  end

  def should_be_redirect_if_not_signed_in(&block)
      sign_out @user
      yield
      response.should redirect_to(root_url)
  end

  describe "GET index" do
    it "assigns all settings as @settings" do
      setting = Setting.create! valid_attributes
      get :index
      assigns(:settings).should eq([setting])
    end
  end

  describe "GET show" do
    it "assigns the requested setting as @setting" do
      setting = Setting.create! valid_attributes
      get :show, :id => setting.id
      assigns(:setting).should eq(setting)
    end
  end

  describe "GET new" do
    it "assigns a new setting as @setting" do
      get :new
      assigns(:setting).should be_a_new(Setting)
    end

    it 'should be redirect if not signed in' do
      should_be_redirect_if_not_signed_in {get :new}
    end
  end

  describe "GET edit" do
    it "assigns the requested setting as @setting" do
      setting = Setting.create! valid_attributes
      get :edit, :id => setting.id
      assigns(:setting).should eq(setting)
    end

    it 'should be redirect if not signed in' do
      setting = Setting.create! valid_attributes
      should_be_redirect_if_not_signed_in {get :edit, :id => setting.id}
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Setting" do
        expect {
          post :create, :setting => valid_attributes
        }.to change(Setting, :count).by(1)
      end

      it "assigns a newly created setting as @setting" do
        post :create, :setting => valid_attributes
        assigns(:setting).should be_a(Setting)
        assigns(:setting).should be_persisted
      end

      it "redirects to the created setting" do
        post :create, :setting => valid_attributes
        response.should redirect_to(Setting.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved setting as @setting" do
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        post :create, :setting => {}
        assigns(:setting).should be_a_new(Setting)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        post :create, :setting => {}
        response.should render_template("new")
      end

      it 'should be redirect if not signed in' do
        should_be_redirect_if_not_signed_in {post :create, :setting => {}}
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested setting" do
        setting = Setting.create! valid_attributes
        # Assuming there are no other settings in the database, this
        # specifies that the Setting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Setting.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => setting.id, :setting => {'these' => 'params'}
      end

      it "assigns the requested setting as @setting" do
        setting = Setting.create! valid_attributes
        put :update, :id => setting.id, :setting => valid_attributes
        assigns(:setting).should eq(setting)
      end

      it "redirects to the setting" do
        setting = Setting.create! valid_attributes
        put :update, :id => setting.id, :setting => valid_attributes
        response.should redirect_to(setting)
      end
    end

    describe "with invalid params" do
      it "assigns the setting as @setting" do
        setting = Setting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        put :update, :id => setting.id, :setting => {}
        assigns(:setting).should eq(setting)
      end

      it "re-renders the 'edit' template" do
        setting = Setting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Setting.any_instance.stub(:save).and_return(false)
        put :update, :id => setting.id, :setting => {}
        response.should render_template("edit")
      end

      it 'should be redirect if not signed in' do
        setting = Setting.create! valid_attributes
        should_be_redirect_if_not_signed_in {put :update, :id => setting.id, :setting => {}}
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested setting" do
      setting = Setting.create! valid_attributes
      expect {
        delete :destroy, :id => setting.id
      }.to change(Setting, :count).by(-1)
    end

    it "redirects to the settings list" do
      setting = Setting.create! valid_attributes
      delete :destroy, :id => setting.id
      response.should redirect_to(settings_url)
    end

    it 'should be redirect if not signed in' do
      setting = Setting.create! valid_attributes
      should_be_redirect_if_not_signed_in {delete :destroy, :id => setting.id}
    end

  end

end

