# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


hashtags = ['#NBAFinals', '#BostonBombing', "#TheBachelor"]
sm_array = ['grapevime', 'twitter', 'facebook']

primary_comments = Comment.create([
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  #{message: "This is a primary comment.", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  {message: "This is a primary comment. #{hashtags.sample}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  {message: "This is a primary comment. #{hashtags.sample}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  {message: "This is a primary comment. #{hashtags.sample} #{hashtags.sample}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  {message: "This is a primary comment. #{hashtags.sample} #{hashtags.sample}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  {message: "This is a primary comment. #{hashtags.sample} #{hashtags.sample} #{hashtags.sample}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
  {message: "This is a primary comment. #{hashtags.sample} #{hashtags.sample} #{hashtags.sample}", sm_type: sm_array.sample, popularity: Random.rand(9999999)}])

secondary_comments = []
primary_comments.each do |primary_comment|
  comment_array = primary_comment.comments.create([
    {message: "This is a secondary comment. ##{primary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a secondary comment. ##{primary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a secondary comment. ##{primary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)}])
  comment_array.each do |comment|
    comment.save
    secondary_comments << comment
  end
end

tertiary_comments = []
secondary_comments.each do |secondary_comment|
  comment_array = secondary_comment.comments.create([
    {message: "This is a tertiary comment. ##{secondary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a tertiary comment. ##{secondary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a tertiary comment. ##{secondary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)}])
  comment_array.each do |comment|
    comment.save
    tertiary_comments << comment
  end
end

quaternary_comments = []
tertiary_comments.each do |tertiary_comment|
  comment_array = tertiary_comment.comments.create([
    {message: "This is a quadernary comment. ##{tertiary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a quadernary comment. ##{tertiary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a quadernary comment. ##{tertiary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)}])
  comment_array.each do |comment|
    comment.save
    quaternary_comments << comment
  end
end

quinary_comments = []
quaternary_comments.each do |quaternary_comment|
  comment_array = quaternary_comment.comments.create([
    {message: "This is a quinary comment. ##{quaternary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a quinary comment. ##{quaternary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a quinary comment. ##{quaternary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)}])    
    comment_array.each do |comment|
      comment.save
      quinary_comments << comment
    end
end

senary_comments = []
quinary_comments.each do |quinary_comment|
  comment_array = quinary_comment.comments.create([
    {message: "This is a senary comment. ##{quinary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a senary comment. ##{quinary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a senary comment. ##{quinary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)}])
    comment_array.each do |comment|
      comment.save
      senary_comments << comment
    end
end

septenary_comments = []
senary_comments.each do |senary_comment|
  comment_array = senary_comment.comments.create([
    {message: "This is a septenary comment. ##{senary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a septenary comment. ##{senary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)},
    {message: "This is a septenary comment. ##{senary_comment.hashtags.first.tag}", sm_type: sm_array.sample, popularity: Random.rand(9999999)}])
    comment_array.each do |comment|
      comment.save
      septenary_comments << comment
    end
end