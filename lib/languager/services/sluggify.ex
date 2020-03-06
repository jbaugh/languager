defmodule Languager.Services.Sluggify do
  import Ecto.Repo
  import Ecto.Query
  import Ecto.Changeset


  def sluggify(changeset, module), do: sluggify(changeset, module, :id)

  # Example: Languager.Sluggify.sluggify(Languager.User, 1)
  @spec sluggify(Changeset.t, module()) :: Changeset.t
  def sluggify(%{valid?: false} = changeset, _module, _base_val), do: changeset
  def sluggify(changeset, module, base_field) do
    # only generate slug if not there
    case get_field(changeset, :external_id) do
      nil -> put_change(changeset, :external_id, build_slug_with_base(changeset, module, base_field))
      _ -> changeset
    end
  end

  def build_slug_with_base(changeset, module, base_field) do
    case get_field(changeset, base_field) do
      nil -> generate_slug(module, "")
      base_val -> generate_slug(module, base_val)
    end
  end

  defp generate_slug(module, "") do
    hex_hash = :crypto.strong_rand_bytes(37) |> Base.encode16 |> binary_part(0, 6)
    hex_hash 
    |> String.downcase
    |> String.replace(" ", "-")
    |> String.replace(~r/[^0-9a-z\-]/, "")
    |> ensure_unique_slug(module, "")
  end
  defp generate_slug(module, base_val) do
    hex_hash = :crypto.strong_rand_bytes(37) |> Base.encode16 |> binary_part(0, 6)
    get_first_part_of_email(base_val) <> "-" <> hex_hash 
    |> String.downcase
    |> String.replace(" ", "-")
    |> String.replace(~r/[^0-9a-z\-]/, "")
    |> ensure_unique_slug(module, base_val)
  end

  defp get_first_part_of_email(str) do
    List.first(String.split(str, "@"))
  end

  # defp generate_mnemonic_slug(module) do
  #   Enum.join(Enum.take_random(adjectives(), 4), "") <> Enum.random(nouns())
  #   |> ensure_unique_slug(module)
  # end

  defp ensure_unique_slug(new_slug, module, base_val) do
    slug_exists = Languager.Repo.one from c in module, where: c.external_id == ^new_slug, select: c.id

    if slug_exists do
      generate_slug(module, base_val)
    else
      new_slug
    end
  end

  def letters do
    [
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
      "y", "z"
    ]
  end

  def valid_letters do
    [
      "a", "b", "c", "e", "f", "g", "h", "j", "k", "l",
      "m", "n", "p", "r", "s", "t", "w", "x", "y", "z"
    ]
  end

  def valid_chars do
    [
      "a", "b", "c", "e", "f", "g", "h", "j", "k", "l",
      "m", "n", "p", "r", "s", "t", "w", "x", "y", "z",
      "2", "3", "4", "6", "7"
    ]
  end

  # adverb (really, extremely, barely, almost)
  # descriptive_adjective (scary, big, scared, etc)
  # color
  # noun (animals, plants)
  # of _location
  # number?

  def nouns do
    [
      "Aardvark", "Accountant", "Acorn", "Adhesive", "Animal", "Ant", "Anteater", "Apple", "Arcade", "Asparagus", "Asteroid", "Baboon", "Ballerina", "Balloon", "Balloonist", "Bandit", "Bear", "Beaver", "Bison", "Blanket", "Book", "Buffalo", "Cat", "Chair", "Couch", "Cow", "Crow", "Cup", "Darter", "Dog", "Dolphin", "Eagle", "Elephant", "Ferret", "Fox", "Giraffe", "Goat", "Goldfish", "Gopher", "Gorilla", "Hippo", "Leaf", "Lion", "Llama", "Meower", "Monkey", "Orange", "Orangutan", "Pear", "Penguin", "Pillow", "Quail", "Rabbit", "Raccoon", "Rat", "Reindeer", "Rhino", "Robin", "Shelf", "Sloth", "Snake", "Snek", "Squirrel", "Stairs", "Talker", "Tapir", "Tarsier", "Termite", "Tetra", "Tiger", "Tortoise", "Toucan", "Tree", "Turtle", "Unau", "Urial", "Walrus", "Wanderer", "Weasley", "Whale", "Whosit", "Woofer", "Woose"
    ]
  end

  def colors do
    [
      "Amber", "Black", "Blue", "Bronze", "Coral", "Crimson", "Cyan", "Emerald", "Gold", "Gray", "Green", "Indigo", "Magenta", "Maroon", "Mauve", "Orange", "Pink", "Purple", "Red", "Ruby", "Scarlet", "Silver", "Tan", "Teal", "Violet", "White", "Yellow"
    ]
  end

  def adjectives do
    [
      "Abundant", "Acidic", "Aggressive", "Agreeable", "Alive", "Ambitious", "Ancient", "Angry", "Ashy", "Attractive", "Bald", "Beautiful", "Better", "Bewildered", "Big", "Bitter", "Black", "Blue", "Brave", "Breezy", "Brief", "Broad", "Brown", "Bumpy", "Calm", "Careful", "Chilly", "Chubby", "Clean", "Clever", "Clumsy", "Cold", "Colossal", "Cool", "Crashing", "Creamy", "Crooked", "Cuddly", "Curved", "Damaged", "Damp", "Dazzling", "Dead", "Deafening", "Deep", "Defeated", "Delicious", "Delightful", "Dirty", "Disgusting", "Drab", "Dry", "Eager", "Early", "Easy", "Echoing", "Elegant", "Embarrassed", "Faint", "Faithful", "Famous", "Fancy", "Fast", "Fat", "Fierce", "Fit", "Flabby", "Flaky", "Flat", "Fluffy", "Freezing", "Fresh", "Friendly", "Full", "Future", "Fuzzy", "Gentle", "Gifted", "Gigantic", "Glamorous", "Gorgeous", "Gray", "Greasy", "Great", "Green", "Grumpy", "Hallowed", "Handsome", "Happy", "Harsh", "Helpful", "Helpless", "High", "Hissing", "Hollow", "Hot", "Howling", "Huge", "Hundreds", "Icy", "Immense", "Important", "Incalculable", "Inexpensive", "Itchy", "Jealous", "Jolly", "Juicy", "Kind", "Large", "Late", "Laughing", "Lazy", "Lemon", "Limited", "Little", "Lively", "Long", "Loose", "Loud", "Low", "Magnificent", "Mammoth", "Mango", "Massive", "Mealy", "Melodic", "Melted", "Microscopic", "Miniature", "Modern", "Moldy", "Muscular", "Mushy", "Mysterious", "Narrow", "Nervous", "Nice", "Noisy", "Numerous", "Nutritious", "Nutty", "Obedient", "Obnoxious", "Odd", "Old", "Old Fashioned", "Orange", "Panicky", "Petite", "Pitiful", "Plain", "Plump", "Polite", "Poor", "Powerful", "Prehistoric", "Prickly", "Proud", "Puny", "Purple", "Purring", "Putrid", "Quaint", "Quick", "Quiet", "Rainbow", "Rancid", "Rapid", "Rapping", "Raspy", "Red", "Refined", "Repulsive", "Rhythmic", "Rich", "Ripe", "Rotten", "Rough", "Round", "Salmon", "Salty", "Savory", "Scarce", "Scary", "Scrawny", "Screeching", "Scruffy", "Shaggy", "Shallow", "Shapely", "Sharp", "Shiny", "Short", "Shrilling", "Shy", "Silly", "Skinny", "Slimy", "Slow", "Small", "Smart", "Sour", "Sparse", "Spicy", "Spoiled", "Square", "Squeaking", "Stale", "Steep", "Sticky", "Stocky", "Straight", "Strong", "Substantial", "Sweet", "Swift", "Tall", "Tangy", "Tart", "Tasteless", "Tasty", "Tawny", "Teeny", "Tender", "Thankful", "Thoughtless", "Thundering", "Tight", "Timid", "Tinkling", "Tiny", "Ugly", "Uneven", "Unimportant", "Uninterested", "Unkempt", "Unsightly", "Uptight", "Vast", "Victorious", "Wailing", "Warm", "Weak", "Wet", "Whining", "Whispering", "White", "Wide", "Wirey", "Witty", "Wonderful", "Wooden", "Worried", "Wrong", "Yellow", "Young", "Yummy", "Zealous"
    ]
  end
end