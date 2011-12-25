class OptionActionsController < ApplicationController

  before_filter :get_portfolio
  
  # GET portfolios/1/option_actions
  # GET portfolios/1/option_actions.xml
  def index
    @option_actions = @portfolio.option_actions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @option_actions }
    end
  end

  # GET portfolios/1/option_actions/new
  # GET portfolios/1/option_actions/new.xml
  def new
    @option_action = @portfolio.option_actions.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @option_action }
    end
  end

  # GET portfolios/1/option_actions/1/edit
  def edit
    @option_action = @portfolio.option_actions.find(params[:id])
  end

  # POST portfolios/1/option_actions
  # POST portfolios/1/option_actions.xml
  def create
    @option_action = @portfolio.option_actions.new(params[:option_action])

    respond_to do |format|
      if @option_action.save
        format.html { redirect_to(portfolio_option_actions_url(@portfolio), :notice => 'Option action was successfully created.') }
        format.xml  { render :xml => @option_action, :status => :created, :location => [@portfolio, @option_action] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @option_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT portfolios/1/option_actions/1
  # PUT portfolios/1/option_actions/1.xml
  def update
    @option_action = @portfolio.option_actions.find(params[:id])

    respond_to do |format|
      if @option_action.update_attributes(params[:option_action])
        format.html { redirect_to(portfolio_option_actions_url(@portfolio), :notice => 'Option action was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @option_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE portfolios/1/option_actions/1
  # DELETE portfolios/1/option_actions/1.xml
  def destroy
    @option_action = @portfolio.option_actions.find(params[:id])
    @option_action.destroy

    respond_to do |format|
      format.html { redirect_to portfolio_option_actions_url(@portfolio) }
      format.xml  { head :ok }
    end
  end
  
  private

  def get_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
  end
end
