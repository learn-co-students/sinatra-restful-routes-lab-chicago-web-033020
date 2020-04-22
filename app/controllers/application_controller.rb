class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  # Index
  get "/recipes/?" do
    @recipes = Recipe.all 
    erb :index
  end

  # New
  get "/recipes/new" do
    erb :new
  end

  # Show
  get "/recipes/:id" do
    find_recipe
    erb :show
  end

  # Create
  post "/recipes" do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  # Edit
  get "/recipes/:id/edit" do
    find_recipe
    erb :edit
  end

  # Update

  patch "/recipes/:id" do
    find_recipe
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  # Delete

  delete "/recipes/:id" do
    find_recipe
    @recipe.delete
    redirect "/recipes"
  end
  private
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
