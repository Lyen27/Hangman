require_relative 'state'
require_relative 'input'
class Game
  attr_accessor :state
  include Input
  def initialize
    @play_saved_game = play_saved_game?
    if File.exist?('save.msgpack') && @play_saved_game == 's' 
        f = File.open('save.msgpack','r')
        data = MessagePack.load(f.read)
        f.close
        @state = State.new(data['hang_man'],data['rope'],data['themes'],data['theme'],data['word'],data['secret_word'],data['mistakes'])
    else
      @play_saved_game = 'n'
      @state = State.new
    end
  end

  def start_loop
     if @play_saved_game != 's'
        state.get_random_word
     end
     @play_saved_game = 'n'
     while !state.win?
      clear_display
      state.render_state
      return if state.check_guess(state.get_guess) == nil
      if state.hang_man == []
        clear_display
        state.render_state
        puts "Que pena, você perdeu,a palavra era #{state.word}"
        return
      end
    end
    clear_display
    state.render_state
    puts 'Parabéns, você adivinhou a palavra!'
  end

  def start
    start_loop
    while play_again? == 's'
      clear_display
      @state = State.new 
      start_loop
    end
  end
end
system('clear')
game = Game.new
game.start