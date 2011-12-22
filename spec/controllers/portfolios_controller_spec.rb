require 'spec_helper'

describe PortfoliosController do

  def valid_attributes
    {
      :name => "MyPortfolio",
      :number_of_stocks => 100,
      :cash_cents => 15000000,
      :strategy_multiplier => 1,
    }
  end

  before :each do
    @user = Factory(:user)
    sign_in @user
  end

  def should_be_redirect_if_not_signed_in(&block)
      sign_out @user
      yield
      response.should redirect_to(root_url)
  end

  describe "GET index" do
    it "assigns all portfolios as @portfolios" do
      portfolio = Portfolio.create! valid_attributes
      get :index
      assigns(:portfolios).should eq([portfolio])
    end
  end

  describe "GET show" do
    it "assigns the requested portfolio as @portfolio" do
      portfolio = Portfolio.create! valid_attributes
      get :show, :id => portfolio.id
      assigns(:portfolio).should eq(portfolio)
    end
  end

  describe "GET new" do
    it "assigns a new portfolio as @portfolio" do
      get :new
      assigns(:portfolio).should be_a_new(Portfolio)
    end

    it 'should be redirect if not signed in' do
      should_be_redirect_if_not_signed_in {get :new}
    end
  end

  describe "GET edit" do
    it "assigns the requested portfolio as @portfolio" do
      portfolio = Portfolio.create! valid_attributes
      get :edit, :id => portfolio.id
      assigns(:portfolio).should eq(portfolio)
    end

    it 'should be redirect if not signed in' do
      portfolio = Portfolio.create! valid_attributes
      should_be_redirect_if_not_signed_in {get :edit, :id => portfolio.id}
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Portfolio" do
        expect {
          post :create, :portfolio => valid_attributes
        }.to change(Portfolio, :count).by(1)
      end

      it "assigns a newly created portfolio as @portfolio" do
        post :create, :portfolio => valid_attributes
        assigns(:portfolio).should be_a(Portfolio)
        assigns(:portfolio).should be_persisted
      end

      it "redirects to the created portfolio" do
        post :create, :portfolio => valid_attributes
        response.should redirect_to(Portfolio.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved portfolio as @portfolio" do
        # Trigger the behavior that occurs when invalid params are submitted
        Portfolio.any_instance.stub(:save).and_return(false)
        post :create, :portfolio => {}
        assigns(:portfolio).should be_a_new(Portfolio)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Portfolio.any_instance.stub(:save).and_return(false)
        post :create, :portfolio => {}
        response.should render_template("new")
      end

      it 'should be redirect if not signed in' do
        should_be_redirect_if_not_signed_in {post :create, :portfolio => {}}
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested portfolio" do
        portfolio = Portfolio.create! valid_attributes
        # Assuming there are no other portfolios in the database, this
        # specifies that the Portfolio created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Portfolio.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => portfolio.id, :portfolio => {'these' => 'params'}
      end

      it "assigns the requested portfolio as @portfolio" do
        portfolio = Portfolio.create! valid_attributes
        put :update, :id => portfolio.id, :portfolio => valid_attributes
        assigns(:portfolio).should eq(portfolio)
      end

      it "redirects to the portfolio" do
        portfolio = Portfolio.create! valid_attributes
        put :update, :id => portfolio.id, :portfolio => valid_attributes
        response.should redirect_to(portfolio)
      end
    end

    describe "with invalid params" do
      it "assigns the portfolio as @portfolio" do
        portfolio = Portfolio.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Portfolio.any_instance.stub(:save).and_return(false)
        put :update, :id => portfolio.id, :portfolio => {}
        assigns(:portfolio).should eq(portfolio)
      end

      it "re-renders the 'edit' template" do
        portfolio = Portfolio.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Portfolio.any_instance.stub(:save).and_return(false)
        put :update, :id => portfolio.id, :portfolio => {}
        response.should render_template("edit")
      end

      it 'should be redirect if not signed in' do
        portfolio = Portfolio.create! valid_attributes
        should_be_redirect_if_not_signed_in {put :update, :id => portfolio.id, :portfolio => {}}
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested portfolio" do
      portfolio = Portfolio.create! valid_attributes
      expect {
        delete :destroy, :id => portfolio.id
      }.to change(Portfolio, :count).by(-1)
    end

    it "redirects to the portfolios list" do
      portfolio = Portfolio.create! valid_attributes
      delete :destroy, :id => portfolio.id
      response.should redirect_to(portfolios_url)
    end

    it 'should be redirect if not signed in' do
      portfolio = Portfolio.create! valid_attributes
      should_be_redirect_if_not_signed_in {delete :destroy, :id => portfolio.id}
    end
  end

end

