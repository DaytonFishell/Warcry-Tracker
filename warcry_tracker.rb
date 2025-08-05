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

  def status
    status = "#{@name}: #{@hp}/#{@max_hp} HP"
    status += " [ACTIVATED]" if @activated
    status += " Items: #{@items.join(', ')}" unless @items.empty?
    status
  end
end

class Tracker
  def initialize
    @fighters = []
  end

  def add_fighter(name, hp)
    @fighters << Fighter.new(name, hp)
  end

  def find_fighter(name)
    @fighters.find { |f| f.name.downcase == name.downcase }
  end

  def list
    puts "Fighters:"
    @fighters.each { |f| puts f.status }
  end

  def damage(name, amount)
    f = find_fighter(name)
    return puts "Fighter not found" unless f
    f.damage(amount)
  end

  def heal(name, amount)
    f = find_fighter(name)
    return puts "Fighter not found" unless f
    f.heal(amount)
  end

  def activate(name)
    f = find_fighter(name)
    return puts "Fighter not found" unless f
    f.activated = true
  end

  def deactivate(name)
    f = find_fighter(name)
    return puts "Fighter not found" unless f
    f.activated = false
  end

  def new_round
    @fighters.each { |f| f.activated = false }
    puts "New battle round started. All fighters are ready."
  end

  def give_item(name, item)
    f = find_fighter(name)
    return puts "Fighter not found" unless f
    f.items << item
  end

  def take_item(name, item)
    f = find_fighter(name)
    return puts "Fighter not found" unless f
    f.items.delete(item)
  end
end

tracker = Tracker.new
puts "Warcry Tracker"
loop do
  print "> "
  input = gets
  break if input.nil?
  cmd, *args = input.strip.split(/\s+/)
  case cmd
  when 'add'
    name = args[0]
    hp = args[1].to_i
    tracker.add_fighter(name, hp)
  when 'list'
    tracker.list
  when 'damage'
    name = args[0]
    amount = args[1].to_i
    tracker.damage(name, amount)
  when 'heal'
    name = args[0]
    amount = args[1].to_i
    tracker.heal(name, amount)
  when 'activate'
    tracker.activate(args[0])
  when 'deactivate'
    tracker.deactivate(args[0])
  when 'newround'
    tracker.new_round
  when 'give'
    name = args[0]
    item = args[1]
    tracker.give_item(name, item)
  when 'take'
    name = args[0]
    item = args[1]
    tracker.take_item(name, item)
  when 'quit', 'exit'
    break
  else
    puts "Commands: add NAME HP, list, damage NAME AMOUNT, heal NAME AMOUNT, " \
         "activate NAME, deactivate NAME, newround, give NAME ITEM, take NAME ITEM, quit"
  end
end
