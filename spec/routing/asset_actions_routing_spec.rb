require "spec_helper"

describe AssetActionsController do
  describe "routing" do
    before do
      @portfolio = mock_model(Portfolio)
      @portfolio_path = portfolio_path(@portfolio)
    end

    it "routes to #index" do
      get("#{@portfolio_path}/asset_actions").should route_to(:controller => "asset_actions",
                                                              :action => "index",
                                                              :portfolio_id => @portfolio.id.to_s)
    end

    it "routes to #new" do
      get("#{@portfolio_path}/asset_actions/new").should route_to(:controller => "asset_actions",
                                                              :action => "new",
                                                              :portfolio_id => @portfolio.id.to_s)
    end

    it "routes to #show" do
      get("#{@portfolio_path}/asset_actions/1").should route_to(:controller => "asset_actions",
                                                              :action => "show",
                                                              :portfolio_id => @portfolio.id.to_s,
                                                              :id => "1")
    end

    it "routes to #edit" do
      get("#{@portfolio_path}/asset_actions/1/edit").should route_to(:controller => "asset_actions",
                                                              :action => "edit",
                                                              :portfolio_id => @portfolio.id.to_s,
                                                              :id => "1")
    end

    it "routes to #create" do
      post("#{@portfolio_path}/asset_actions").should route_to(:controller => "asset_actions",
                                                              :action => "create",
                                                              :portfolio_id => @portfolio.id.to_s)
    end

    it "routes to #update" do
      put("#{@portfolio_path}/asset_actions/1").should route_to(:controller => "asset_actions",
                                                              :action => "update",
                                                              :portfolio_id => @portfolio.id.to_s,
                                                              :id => "1")
    end

    it "routes to #destroy" do
      delete("#{@portfolio_path}/asset_actions/1").should route_to(:controller => "asset_actions",
                                                              :action => "destroy",
                                                              :portfolio_id => @portfolio.id.to_s,
                                                              :id => "1")
    end

  end
end
