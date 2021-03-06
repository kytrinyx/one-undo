class Critter < Struct.new(:name, :qualifier, :aside)
  def article
    if name[0] =~ /[aeiouAEIOU]/
      "an"
    else
      "a"
    end
  end
end

class Song
  DATA = [
    ["horse", nil, "She's dead, of course!"],
    ["cow",   nil, "I don't know how she swallowed a cow!"],
    ["goat",  nil, "Just opened her throat and swallowed a goat!"],
    ["dog",   nil, "What a hog, to swallow a dog!"],
    ["cat",   nil, "Imagine that, to swallow a cat!"],
    ["bird",  nil, "How absurd to swallow a bird!"],
    [
      "spider",
      "that wriggled and jiggled and tickled inside her",
      "It wriggled and jiggled and tickled inside her.",
    ],
    ["fly",   nil, "I don't know why she swallowed the fly. Perhaps she'll die."],
  ]

  attr_reader :critters
  def initialize(data = DATA)
    @critters = data.map {|row| Critter.new(*row)}
  end

  def lyrics
    (1..critters.size).map {|i| verse(i)}.join("\n")
  end

  private

  def verse(i)
    incident(critters.last(i).first) + recap(i)
  end

  def incident(critter)
    "I know an old lady who swallowed %s %s.\n%s\n" % [
      critter.article,
      critter.name,
      critter.aside,
    ]
  end

  def recap(i)
    case i
    when 1, critters.size
      ""
    else
      "%s\n" % [
        chain(i), critters.last.aside
      ].join("\n")
    end
  end

  def chain(i)
    critters.last(i).each_cons(2).map {|pair|
      motivation(*pair)
    }.join("\n")
  end

  def motivation(predator, prey)
    "She swallowed the %s to catch the %s." % [
      predator.name,
      [
        prey.name, prey.qualifier
      ].compact.join(" ")
    ]
  end
end
