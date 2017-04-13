class Artist < ActiveRecord::Base
  has_many(
    :albums,
    class_name: "Album",
    foreign_key: :artist_id,
    primary_key: :id
  )

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    tracks_count = {}

    albums_with_counts = self
    .albums
    .select("albums.title, COUNT(*) AS tracks_count")
    .joins(:tracks)
    .group("albums.title")

    albums_with_counts.each do |album|
      tracks_count[album.title] = album.tracks_count
    end
  end
end
