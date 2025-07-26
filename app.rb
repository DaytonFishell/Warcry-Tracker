require 'sinatra'

class Fighter
  attr_accessor :name, :hp, :max_hp, :activated, :items

  def initialize(name, hp)
    @name = name
    @hp = hp
    @max_hp = hp
    @activated = false
    @items = []
  end

  def damage(amount)
    @hp -= amount
    @hp = 0 if @hp < 0
  end

  def heal(amount)
    @hp += amount
    @hp = @max_hp if @hp > @max_hp
  end
end

class Tracker
  attr_reader :fighters

  def initialize
    @fighters = []
  end

  def add_fighter(name, hp)
    @fighters << Fighter.new(name, hp)
  end

  def find_fighter(name)
    @fighters.find { |f| f.name.downcase == name.downcase }
  end

  def damage(name, amount)
    f = find_fighter(name)
    return unless f
    f.damage(amount)
  end

  def heal(name, amount)
    f = find_fighter(name)
    return unless f
    f.heal(amount)
  end

  def activate(name)
    f = find_fighter(name)
    return unless f
    f.activated = true
  end

  def deactivate(name)
    f = find_fighter(name)
    return unless f
    f.activated = false
  end

  def new_round
    @fighters.each { |f| f.activated = false }
  end

  def give_item(name, item)
    f = find_fighter(name)
    return unless f
    f.items << item
  end

  def take_item(name, item)
    f = find_fighter(name)
    return unless f
    f.items.delete(item)
  end
end

tracker = Tracker.new

get '/' do
  @fighters = tracker.fighters
  erb :index
end

post '/fighters' do
  tracker.add_fighter(params[:name], params[:hp].to_i)
  redirect '/'
end

post '/fighters/:name/damage' do
  tracker.damage(params[:name], params[:amount].to_i)
  redirect '/'
end

post '/fighters/:name/heal' do
  tracker.heal(params[:name], params[:amount].to_i)
  redirect '/'
end

post '/fighters/:name/activate' do
  tracker.activate(params[:name])
  redirect '/'
end

post '/fighters/:name/deactivate' do
  tracker.deactivate(params[:name])
  redirect '/'
end

post '/newround' do
  tracker.new_round
  redirect '/'
end

post '/fighters/:name/give' do
  tracker.give_item(params[:name], params[:item])
  redirect '/'
end

post '/fighters/:name/take' do
  tracker.take_item(params[:name], params[:item])
  redirect '/'
end
