class MainsController < ApplicationController
  def index
       # Article 디비에서 데이터를 가져와서 @articles에 저장
       @articles = Article.all
  end
end
