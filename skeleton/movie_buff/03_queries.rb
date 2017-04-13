def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  Movie.select(:title, :id)
    .joins(:actors)
    .where(actors: { name: those_actors })
    .group(:id)
    .having('COUNT(actors.*) = ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.select('(yr / 10) * 10 AS decade')
    .group('decade')
    .order('AVG(score) desc')
    .first.decade
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery
  Actor.select(:name)
    .joins(:movies)
    .where(movies: {title: Actor.find_by(name: name).movies.select(:title)})
    .where.not(name: name).distinct
    .map(&:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.select(:name)
    .joins('LEFT OUTER JOIN castings ON actors.id = castings.actor_id')
    .where('castings.actor_id IS NULL')
    .distinct.count
end

def starring(whazzername)
  whazzername = "%#{whazzername.chars.join('%')}%"
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.
  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"
  Movie.select(:id, :title)
    .joins(:actors)
    .where('actors.name ILIKE ?', whazzername)


end

def longest_career
  Actor.select('actors.id, actors.name, (max(yr) - min(yr)) AS career')
    .joins(:movies)
    .group('actors.id')
    .order('career desc')
    .limit(3)
    .order(:name)
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.

end
