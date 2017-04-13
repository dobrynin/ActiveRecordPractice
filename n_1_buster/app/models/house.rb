class House < ActiveRecord::Base
  has_many(
    :gardeners,
    class_name: "Gardener",
    foreign_key: :house_id,
    primary_key: :id
  )

  has_many(
    :plants,
    through: :gardeners,
    source: :plants
  )

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    seeds = []
    plants_with_seeds = plants.includes(:seeds)
    plants_with_seeds.each do |plant_with_seeds|
      seeds << plant_with_seeds.seeds
    end

    seeds
  end
end


# posts_with_counts = self
#       .posts
#       .select("posts.*, COUNT(*) AS comments_count") # more in a sec
#       .joins(:comments)
#       .group("posts.id")
#
#
#
# posts_with_counts.map do |post|
#   # `#comments_count` will access the column we `select`ed in the
#   # query.
#   [post.title, post.comments_count]
