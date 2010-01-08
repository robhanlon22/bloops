require 'bloops'

n_bloops = (ARGV.shift or 1).to_i

b = Bloops.new
c = [Bloops::SINE] * 20 + [Bloops::NOISE] * 3 + [Bloops::SQUARE]
n = [[0.5, "g a b 16:c d"],
     [0.05, "4:f# 3:f#"],
     [0.05, "32:g" * 100],
     [0.4, "16:d3 5:e3"]]

bloops = n_bloops.times.inject([]) do |m, i|
  the_b = b.dup
  the_b.tempo = rand(300)
  m << the_b
end

loop do
  bloops.each do |i|
    if i.stopped?
      break b = i
    else
      b = nil
    end
  end

  next unless b

  b.clear
  r = rand
  n.inject(0) do |m, i|
    if r >= m and r <= m += i.first
      w = c[rand(c.size)]
      s = b.sound(w)
      s.attack = rand / 2 + 0.5
      s.decay = 0.5
      s.sustain = 0.5
      s.lpf = 0.2
      s.repeat = rand / 100 * 2
      w == Bloops::SQUARE and str = i.last or str = '- ' + i.last
      break b.tune(s, i.last)
    end
    m
  end
  b.play

  sleep 0.1
end
