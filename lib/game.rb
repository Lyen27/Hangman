require_relative 'state'
require 'msgpack'
class Game
  attr_accessor :state
  def initialize
    @state = State.new
  end

  def start_loop
    while !state.win?
      state.render_state
      state.check_guess(state.get_guess)
      if state.hang_man == []
        state.render_state
        puts "Que pena, você perdeu,a palavra era #{state.word}"
        return
      end
    end
    state.render_state
    puts 'Parabéns, você adivinhou a palavra!'
  end

  def start
    start_loop
    while state.play_again? == 's'
      @state = State.new 
      start_loop
    end
  end
end

game = Game.new
game.start