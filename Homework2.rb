class User
  attr_accessor :name, :email, :password

  def initialize(name, email, password)
    @name, @email, @password = name, email, password
  end

  def enter_room(room)
    room.users << self unless room.users.include?(self)
  end

  def send_message(room, content)
    room.broadcast(Message.new(self, room, content))
  end

  def acknowledge_message(message)
    puts "#{name} acknowledged: #{message.content}"
  end
end

class Room
  attr_accessor :name, :description, :users

  def initialize(name, description)
    @name, @description, @users = name, description, []
  end

  def broadcast(message)
    puts "#{message.user.name} in #{name}: #{message.content}"
    users.each { |user| user.acknowledge_message(message) unless user == message.user }
  end
end

class Message
  attr_accessor :user, :room, :content

  def initialize(user, room, content)
    @user, @room, @content = user, room, content
  end
end

user1 = User.new("Kanat", "kanat.thon@bumail.net", "kanat0428")
user2 = User.new("Jakkrit", "jakkrit.sukl@bumail.net", "pete0626")
room1 = Room.new("AIE312", "AIE312 chat room")

user1.enter_room(room1)
user2.enter_room(room1)

user1.send_message(room1, "Hey Nitkul! How was your weekend? Did you do anything fun?")
user2.send_message(room1, "Hi Nasaree! It was great! I went to the market with my parents. What about you?")
user1.send_message(room1, "That sounds great! I just relaxed at home and caught up on some shows.")
user2.send_message(room1, "Nice! Any recommendations? I'm looking for something new to watch.")
