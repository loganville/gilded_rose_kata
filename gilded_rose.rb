def update_quality_concert_pass(item)
  if item.sell_in < 6
    increase_quality(item, 3)
  elsif item.sell_in < 11
    increase_quality(item, 2)
  else
    increase_quality(item)
  end
end

def decrease_quality(item)
  if item.quality > 0
    if item.name != 'Sulfuras, Hand of Ragnaros'
      item.quality -= 1
    end
  end
end

def decrease_sell_in(item)
  if item.name != 'Sulfuras, Hand of Ragnaros'
    item.sell_in -= 1
  end
end

def quality_is_not_maxed(item)
  item.quality < 50
end

def increase_quality(item, amount = 1)
  if quality_is_not_maxed(item)
    item.quality += amount
  end
end

def item_expired(item)
  item.sell_in < 0
end

def is_brie(item)
  item.name == 'Aged Brie'
end

def is_concert_pass(item)
  item.name == 'Backstage passes to a TAFKAL80ETC concert'
end

def set_to_worthless(item)
  item.quality = 0
end

def update_quality(items)
  items.each do |item|

    if is_brie(item)
      increase_quality(item)
    elsif is_concert_pass(item)
      update_quality_concert_pass(item)
    else
      decrease_quality(item)
    end

    decrease_sell_in(item)

    if item_expired(item)
      if is_brie(item)
        increase_quality(item)
      elsif is_concert_pass(item)
        set_to_worthless(item)
      else
        decrease_quality(item)
      end
    end

  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

