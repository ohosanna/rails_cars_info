# endcoding utf-8
#
####
#获取汽车之家网站汽车品牌车型相关的数据
#by hosanna 2015/06/18
#
# 获取汽车品牌名地址 http://www.autohome.com.cn/ashx/AjaxIndexCarFind.ashx?type=1
# 获取某品牌系列名地址 http://www.autohome.com.cn/ashx/AjaxIndexCarFind.ashx?type=3&value=品牌id
# 获取某系列车型名地址 http://www.autohome.com.cn/ashx/AjaxIndexCarFind.ashx?type=5&value=系列id
####
desc "Fetch cars data form autohome.com.cn "
task :fetch_cars => :environment do
  require 'open-uri'
  require 'net/http'
  require 'json'

  def http_get(query)
    uri = URI.parse("http://www.autohome.com.cn/ashx/AjaxIndexCarFind.ashx")
    http = Net::HTTP.new(uri.host, uri.port)
    uri.query = query
    request =  Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)

    if res.code == "200"
      return JSON.parse(res.body.force_encoding("gbk").encode!("utf-8"))
    else
      puts "获取数据出错！错误代码（#{res.code}）"
    end
  end

  def get_cars_brands
    brands = http_get("type=1")["result"]["branditems"]
    return brands
  end

  def get_brand_factories(brand)
    query = "type=3&value=#{brand['id']}"
    factories = http_get(query)["result"]["factoryitems"]
    return factories
  end

  def get_factory_series(factory)
    return factory["seriesitems"]
  end

  def get_series_models(series)
    query = "type=5&value=#{series["id"]}"
    models = []
    yearitems = http_get(query)["result"]["yearitems"]
    yearitems.each do |item|
      item["specitems"].each do |sp|
        sp["year"] = item["name"]
        models.push(sp)
      end
    end

    return models
  end

  def save_data
    brands = get_cars_brands
    brands.each do |brand|
      puts "正在获取#{brand["name"]}的数据\n"
      @brand = Brand.new
      @brand.name = brand["name"]
      @brand.autohome_id = brand["id"]
      @brand.first_letter = brand["bfirstletter"]
      @brand.save

      factories = get_brand_factories(brand)
      factories.each do |factory|
        @factory = @brand.factories.new
        @factory.name = factory["name"]
        @factory.autohome_id = factory["id"]
        @factory.first_letter = factory["firstletter"]
        @factory.save

        series = get_factory_series(factory)
        series.each do |s|
          puts "正在获取#{s["name"]}系列的数据\n"
          @series = @factory.series.new
          @series.name = s["name"]
          @series.autohome_id = s["id"]
          @series.first_letter = s["firstletter"]
          @series.save

          models = get_series_models(s)
          models.each do |model|
            @model = @series.models.new
            @model.name = model["name"]
            @model.autohome_id = model["id"]
            @model.produce_year = /^\d+/.match(model["year"])
            @model.save
          end
        end

      end

    end
  end

  def save_brands
    puts "正在清除旧的汽车品牌数据\n"
    Brand.delete_all
    brands = get_cars_brands
    puts "正在保存汽车品牌数据\n"
    brands.each do |brand|
      @brand = Brand.new
      @brand.name = brand.name
      @brand.autohome_id = brand.id
      @brand.first_letter = brand.bfirstletter
      @brand.save
    end
  end

  def save_factories
    puts "正在清除旧的汽车品牌数据\n"
    Factory.delete_all
    @brands = Brand.all
    @brands.each do |brand|
      factories = get_brand_factories(b)
      factories.each do |factory|
        @factory = b.factories.new
        @factory.name = factory.name
        @factory.autohome_id = factory.id
        @factory.first_letter = factory.firstletter
      end
    end
  end

  save_data

  #puts get_series_models(get_factory_series(get_brand_factories(get_cars_brands[3])[0])[0])
  #puts get_factory_series(get_brand_factories(get_cars_brands[3])[0]).length
end
