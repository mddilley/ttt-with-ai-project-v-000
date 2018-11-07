class GameMenu

  attr_accessor :player_one, :player_two, :mode

  def initialize

  end

  def run_game
    #binding.pry
    if mode == "0"
      zero_player
    elsif mode == "1"
      one_player
    elsif mode == "2"
      two_player
    elsif mode == "wargames"
      wargames
    end
  end

  def zero_player
    computer_game = Game.new(Players::Computer.new(player_one), Players::Computer.new(player_two))
    computer_game.play
  end

  def one_player
    Game.new(Players::Human.new(player_one), Players::Computer.new(player_two)).play

  end

  def two_player
    two_player_game = Game.new(Players::Human.new(player_one), Players::Human.new(player_two))
    two_player_game.play
  end

  def wargames
    win_count = 0
    100.times {
      wopr_game = Game.new(Players::Computer.new(player_one), Players::Computer.new(player_two))
      wopr_game.play
      win_count += 1 if wopr_game.won?
    }
    puts "#{win_count}"
  end

  def game_mode #prompts for game mode, validates input, and returns choice
    puts "Would you like to play a 0, 1, or 2 player game?"
    puts "At risk of the world, enter wargames!"
    @mode = gets.strip.to_s
    #binding.pry
    if @mode == "0" || @mode == "1" || @mode == "2" || @mode == "wargames"

    else
      puts "Invalid input, please try again"
      game_mode
    end
  end

  def select_player #prompts for player token, validates input, runs game using choice
    puts "Player one, would you like to play as X or O?"
    @player_one = gets.strip
    if @player_one == "X"
      @player_two = "O"
    elsif player_one == "O"
      @player_two = "X"
    else
      puts "Invalid input, please try again"
      select_player
    end
    #binding.pry
  end

  def play_again?
    puts "Would you like to play again or quit?"
    input = gets.strip
    if input == "again"
      select_player
    elsif  input == "quit"
      return
    else
      puts "Please enter 'again' or 'quit'"
      play_again?
    end
  end

  def play
    select_player
    game_mode
    run_game
    one_player
    play_again?
  end

end
