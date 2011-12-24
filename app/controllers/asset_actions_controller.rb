class AssetActionsController < ApplicationController

  before_filter :get_portfolio
  
  # GET /asset_actions
  # GET /asset_actions.json
  def index
    @asset_actions = @portfolio.asset_actions.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_actions }
    end
  end

  # GET /asset_actions/new
  # GET /asset_actions/new.json
  def new
    @asset_action = @portfolio.asset_actions.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_action }
    end
  end

  # GET /asset_actions/1/edit
  def edit
    @asset_action = @portfolio.asset_actions.find(params[:id])
  end

  # POST /asset_actions
  # POST /asset_actions.json
  def create
    @asset_action = @portfolio.asset_actions.new(params[:asset_action])

    respond_to do |format|
      if @asset_action.save
        format.html { redirect_to portfolio_asset_actions_url, notice: 'Asset action was successfully created.' }
        format.json { render json: @asset_action, status: :created, location: @asset_action }
      else
        format.html { render action: "new" }
        format.json { render json: @asset_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asset_actions/1
  # PUT /asset_actions/1.json
  def update
    @asset_action = @portfolio.asset_actions.find(params[:id])

    respond_to do |format|
      if @asset_action.update_attributes(params[:asset_action])
        format.html { redirect_to portfolio_asset_actions_url, notice: 'Asset action was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_actions/1
  # DELETE /asset_actions/1.json
  def destroy
    @asset_action = @portfolio.asset_actions.find(params[:id])
    @asset_action.destroy

    respond_to do |format|
      format.html { redirect_to portfolio_asset_actions_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def get_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id]) 
  end
end
