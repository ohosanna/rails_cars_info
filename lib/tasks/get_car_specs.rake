# endcoding utf-8
#
####
#获取汽车之家网站汽车车型具体参数
#by hosanna 2015/11/18
#
# 获取汽车系列车型参数网址 http://car.autohome.com.cn/config/series/#{series_id}.html
# 获取指定ID车型同年份系列车型参数网址  "http://car.autohome.com.cn/config/spec/#{id}.html#pvareaid=102170"
####
desc "Fetch car specs form autohome.com.cn "
task :fetch_car_specs => :environment do
  require 'nokogiri'
  require 'open-uri'
  require 'net/http'
  require 'json'

  @nodata_series = []
  @missing_model = []
  @data_count = 0

  def get_page_content(id)
    #uri = URI.parse("http://car.autohome.com.cn/config/series/#{id}.html")
    uri = URI.parse("http://car.autohome.com.cn/config/spec/#{id}.html#pvareaid=102170")
    puts "向 #{uri} 发起请求"
    html = Net::HTTP.get_response(uri).body.force_encoding("gbk").encode!("utf-8")
    @doc = Nokogiri::HTML.parse html
    #通过判断参数配置菜单是否链接来确认该系列车型是否有数据
    #puts @doc.css('.nav-item:nth-child(2) span').first.nil?
    #判断该系列车型是否有数据
    #puts @doc.css('p[style="margin: 10px 0px; color: #D60000"]').first.nil?
    if @doc.css('p[style="margin: 10px 0px; color: #D60000"]').first.nil?
      # 需要的车辆信息在页面javascript的变量中，先提取所有script标签里的内容
      @content = {}
      scripts = ""
      @doc.css('script').each do |script|
          scripts << script.content
      end

      #通过正则表达式获取需要的内容
      /var[[:blank:]]+bag[[:blank:]]?\=[[:blank:]]?(?<bag>.*)$/ =~ scripts
      /var[[:blank:]]+keyLink[[:blank:]]?\=[[:blank:]]?(?<key_link>.*)$/ =~ scripts
      /var[[:blank:]]+option[[:blank:]]?\=[[:blank:]]?(?<option>.*)$/ =~ scripts
      /var[[:blank:]]+config[[:blank:]]?\=[[:blank:]]?(?<config>.*)$/ =~ scripts
      /var[[:blank:]]+color[[:blank:]]?\=[[:blank:]]?(?<color>.*)$/ =~ scripts
      /var[[:blank:]]+innerColor[[:blank:]]?\=[[:blank:]]?(?<inner_color>.*)$/ =~ scripts
      /var[[:blank:]]+specIDs[[:blank:]]?\=[[:blank:]]?\[(?<spec_ids>.*)\]/ =~ scripts

      #把从正则表达式的内容去掉行未的分号再按JSON数据解析
      #@content["key_link"] = JSON.parse(key_link.gsub(/;/,''))["result"]["items"]
      @content["config"] = JSON.parse(config.gsub(/;/,''))["result"]["paramtypeitems"]
      @content["option"] = JSON.parse(option.gsub(/;/,''))["result"]["configtypeitems"]
      #@content["bag"] = JSON.parse(bag.gsub(/;/,''))["result"]["bagtypeitems"]
      @content["color"] = JSON.parse(color.gsub(/;/,''))["result"]["specitems"]
      @content["inner_color"] = JSON.parse(inner_color.gsub(/;/,''))["result"]["specitems"]
      @content["spec_ids"] = spec_ids.split(',')
      return @content
    else
      @content = nil
    end
  end

  #根据字段返回指定顺序的值
  def get_spec_value(content, key, index)
    result = nil
    content.each do |c|
      if c.has_value?(key)
        result = c["valueitems"][index]["value"]
        break
      end
    end
    return result
  end

  def get_colors(content, spec_id)
    colors = nil
    unless content.empty?
      content.each do |c|
        if c["specid"].to_s == spec_id.to_s
          colors = c["coloritems"]
          break
        end
      end
    end
    return colors
  end

  def get_config(content, name)
    config = nil
    unless content.empty?
      content.each do |c|
        if c["name"] == name
          config = c["paramitems"]
          break
        end
      end
    end
    return config
  end

  def get_option(content, name)
    option = nil
    unless content.empty?
      content.each do |c|
        if c["name"] == name
          option = c["configitems"]
          break
        end
      end
    end
    return option
  end

  def get_car_specs(page_content)
    spec_ids = page_content["spec_ids"]
    spec_ids.each do |spec_id|
      @model = Model.find_by_autohome_id(spec_id)
      @data_count += 1
      spec_index = spec_ids.index(spec_id)
      base_spec = get_config(page_content["config"], "基本参数")
      vehicle_body = get_config(page_content["config"], "车身")
      engine = get_config(page_content["config"], "发动机")
      transmission = get_config(page_content["config"], "变速箱")
      steering = get_config(page_content["config"], "底盘转向")
      brake = get_config(page_content["config"], "车轮制动")
      safety = get_option(page_content["option"], "安全装备")
      console = get_option(page_content["option"], "操控配置")
      exterior = get_option(page_content["option"], "外部配置")
      interior = get_option(page_content["option"], "内部配置")
      seat = get_option(page_content["option"], "座椅配置")
      multimedium = get_option(page_content["option"], "多媒体配置")
      lamp = get_option(page_content["option"], "灯光配置")
      mirror = get_option(page_content["option"], "玻璃/后视镜")
      ac = get_option(page_content["option"], "空调/冰箱")
      h_tech_spec = get_option(page_content["option"], "高科技配置")

      if @model.nil?
        @missing_model.push(spec_id)
        puts "本地数据库无此车型(#{spec_id})"
      else
        puts "正在处理#{get_spec_value(base_spec, "车型名称", spec_index)}的数据"
        #基本参数
        unless base_spec.nil?
          @model.build_base_spec if @model.base_spec.nil?
          @model.base_spec.name = get_spec_value(base_spec, "车型名称", spec_index)
          @model.base_spec.price = get_spec_value(base_spec, "厂商指导价(元)", spec_index)
          @model.base_spec.factory = get_spec_value(base_spec, "厂商", spec_index)
          @model.base_spec.level = get_spec_value(base_spec, "级别", spec_index)
          @model.base_spec.engine = get_spec_value(base_spec, "发动机", spec_index)
          @model.base_spec.gearbox = get_spec_value(base_spec, "变速箱", spec_index)
          @model.gearbox_name = get_spec_value(base_spec, "变速箱", spec_index).gsub(/\d+挡/,'')
          #@model.update_attribute(:gearbox_name, get_spec_value(base_spec, "变速箱", spec_index).gsub(/\d+挡/,''))
          @model.base_spec.LWH = get_spec_value(base_spec, "长*宽*高(mm)", spec_index)
          @model.base_spec.body_structure = get_spec_value(base_spec, "车身结构", spec_index)
          @model.base_spec.max_speed = get_spec_value(base_spec, "最高车速(km/h)", spec_index)
          @model.base_spec.acceleration_time = get_spec_value(base_spec, "官方0-100km/h加速(s)", spec_index)
          @model.base_spec.real_acceleration_time = get_spec_value(base_spec, "实测0-100km/h加速(s)", spec_index)
          @model.base_spec.braking_time = get_spec_value(base_spec, "实测100-0km/h制动(m)", spec_index)
          @model.base_spec.fuel_consumption = get_spec_value(base_spec, "工信部综合油耗(L/100km)", spec_index)
          @model.base_spec.real_fuel_consumption = get_spec_value(base_spec, "实测油耗(L/100km)", spec_index)
          @model.base_spec.real_ground_clearance = get_spec_value(base_spec, "实测离地间隙(mm)", spec_index)
          @model.base_spec.warranty = get_spec_value(base_spec, "整车质保", spec_index)
        end

        #车身
        unless vehicle_body.nil?
          @model.build_vehicle_body if @model.vehicle_body.nil?
          @model.vehicle_body.length = get_spec_value(vehicle_body, "长度(mm)", spec_index)
          @model.vehicle_body.width = get_spec_value(vehicle_body, "宽度(mm)", spec_index)
          @model.vehicle_body.height = get_spec_value(vehicle_body, "高度(mm)", spec_index)
          @model.vehicle_body.wheelbase = get_spec_value(vehicle_body, "轴距(mm)", spec_index)
          @model.vehicle_body.front_track_width = get_spec_value(vehicle_body, "前轮距(mm)", spec_index)
          @model.vehicle_body.rear_track_width = get_spec_value(vehicle_body, "后轮距(mm)", spec_index)
          @model.vehicle_body.min_ground_clearance = get_spec_value(vehicle_body, "最小离地间隙(mm)", spec_index)
          @model.vehicle_body.curb_weight = get_spec_value(vehicle_body, "整备质量(kg)", spec_index)
          @model.vehicle_body.structure = get_spec_value(vehicle_body, "车身结构", spec_index)
          @model.structure = get_spec_value(vehicle_body, "车身结构", spec_index)
          #@model.update_attribute(:structure, @model.vehicle_body.structure)
          @model.vehicle_body.doors_num = get_spec_value(vehicle_body, "车门数(个)", spec_index)
          @model.vehicle_body.seats_num = get_spec_value(vehicle_body, "座位数(个)", spec_index)
          @model.vehicle_body.tank_capatity = get_spec_value(vehicle_body, "油箱容积(L)", spec_index)
          @model.vehicle_body.trunk_volume = get_spec_value(vehicle_body, "行李厢容积(L)", spec_index)
        end

        #发动机
        unless engine.nil?
          @model.build_engine if @model.engine.nil?
          @model.engine.name = get_spec_value(engine, "发动机型号", spec_index)
          @model.engine.displacement = get_spec_value(engine, "排量(mL)", spec_index)
          @model.displacement = get_spec_value(engine, "排量(L)", spec_index)
          #@model.update_attribute(:displacement,  get_spec_value(engine, "排量(L)", spec_index))
          @model.engine.intake_type = get_spec_value(engine, "进气形式", spec_index)
          @model.engine.cylinder_arrangement = get_spec_value(engine, "气缸排列形式", spec_index)
          @model.engine.cylinder_num = get_spec_value(engine, "气缸数(个)", spec_index)
          @model.engine.valve_num = get_spec_value(engine, "每缸气门数(个)", spec_index)
          @model.engine.compression_ratio = get_spec_value(engine, "压缩比", spec_index)
          @model.engine.valve_train = get_spec_value(engine, "配气机构", spec_index)
          @model.engine.cylinder_bore = get_spec_value(engine, "缸径(mm)", spec_index)
          @model.engine.piston_stroke = get_spec_value(engine, "行程(mm)", spec_index)
          @model.engine.max_hp = get_spec_value(engine, "最大马力(Ps)", spec_index)
          @model.engine.max_power = get_spec_value(engine, "最大功率(kW)", spec_index)
          @model.engine.max_power_speed = get_spec_value(engine, "最大功率转速(rpm)", spec_index)
          @model.engine.max_torque = get_spec_value(engine, "最大扭矩(N・m)", spec_index)
          @model.engine.max_torque_speed = get_spec_value(engine, "最大扭矩转速(rpm)", spec_index)
          @model.engine.unique_tech = get_spec_value(engine, "发动机特有技术", spec_index)
          @model.engine.fuel_type = get_spec_value(engine, "燃料形式", spec_index)
          @model.engine.fuel_grade = get_spec_value(engine, "燃油标号", spec_index)
          @model.engine.oil_supply = get_spec_value(engine, "供油方式", spec_index)
          @model.engine.cylinder_head_material = get_spec_value(engine, "缸盖材料", spec_index)
          @model.engine.cylinder_block_material = get_spec_value(engine, "缸体材料", spec_index)
          @model.engine.EPA = get_spec_value(engine, "环保标准", spec_index)
        end

        #变速箱
        unless transmission.nil?
          @model.build_transmission if @model.transmission.nil?
          @model.transmission.name = get_spec_value(transmission, "简称", spec_index)
          @model.transmission.trans_num = get_spec_value(transmission, "挡位个数", spec_index)
          @model.transmission.trans_type = get_spec_value(transmission, "变速箱类型", spec_index)

          #底盘转向
          @model.build_steering if @model.steering.nil?
          @model.steering.drivetrain = get_spec_value(steering, "驱动方式", spec_index)
          @model.steering.front_suspension_type = get_spec_value(steering, "前悬架类型", spec_index)
          @model.steering.rear_suspension_type = get_spec_value(steering, "后悬架类型", spec_index)
          @model.steering.power_type = get_spec_value(steering, "助力类型", spec_index)
          @model.steering.body_structure = get_spec_value(steering, "车体结构", spec_index)
        end

        #车轮制动
        unless brake.nil?
          @model.build_brake if @model.brake.nil?
          @model.brake.front_brake_type = get_spec_value(brake, "前制动器类型", spec_index)
          @model.brake.rear_brake_type = get_spec_value(brake, "后制动器类型", spec_index)
          @model.brake.parking_brake_type = get_spec_value(brake, "驻车制动类型", spec_index)
          @model.brake.front_tire_size = get_spec_value(brake, "前轮胎规格", spec_index)
          @model.brake.rear_tire_size = get_spec_value(brake, "后轮胎规格", spec_index)
          @model.brake.spare_tire_size = get_spec_value(brake, "备胎规格", spec_index)
        end

        #安全装备
        unless safety.nil?
          @model.build_safety if @model.safety.nil?
          @model.safety.driving_seet_airbag = get_spec_value(safety, "主/副驾驶座安全气囊", spec_index)
          @model.safety.side_airbag = get_spec_value(safety, "前/后排侧气囊", spec_index)
          @model.safety.head_airbag = get_spec_value(safety, "前/后排头部气囊(气帘)", spec_index)
          @model.safety.knee_airbag = get_spec_value(safety, "膝部气囊", spec_index)
          @model.safety.TPMS = get_spec_value(safety, "胎压监测装置", spec_index)
          @model.safety.zero = get_spec_value(safety, "零胎压继续行驶", spec_index)
          @model.safety.belt_warning = get_spec_value(safety, "安全带未系提示", spec_index)
          @model.safety.ISOFIX = get_spec_value(safety, "ISOFIX儿童座椅接口", spec_index)
          @model.safety.immobilizer = get_spec_value(safety, "发动机电子防盗", spec_index)
          @model.safety.internally_door_locking = get_spec_value(safety, "车内中控锁", spec_index)
          @model.safety.key_fob = get_spec_value(safety, "遥控钥匙", spec_index)
          @model.safety.keyless_start = get_spec_value(safety, "无钥匙启动系统", spec_index)
          @model.safety.keyless_entry = get_spec_value(safety, "无钥匙进入系统", spec_index)
        end

        #操控配置
        unless console.nil?
          @model.build_console if @model.console.nil?
          @model.console.ABS = get_spec_value(console, "ABS防抱死", spec_index)
          @model.console.EBD = get_spec_value(console, "制动力分配(EBD/CBC等)", spec_index)
          @model.console.EBA = get_spec_value(console, "刹车辅助(EBA/BAS/BA等)", spec_index)
          @model.console.ASR = get_spec_value(console, "牵引力控制(ASR/TCS/TRC等)", spec_index)
          @model.console.ESC = get_spec_value(console, "车身稳定控制(ESC/ESP/DSC等)", spec_index)
          @model.console.HAC = get_spec_value(console, "上坡辅助", spec_index)
          @model.console.auto_hold = get_spec_value(console, "自动驻车", spec_index)
          @model.console.HDC = get_spec_value(console, "陡坡缓降", spec_index)
          @model.console.variable_suspension = get_spec_value(console, "可变悬架", spec_index)
          @model.console.air_suspension = get_spec_value(console, "空气悬架", spec_index)
          @model.console.variable_gear_ratio = get_spec_value(console, "可变转向比", spec_index)
          @model.console.f_XDS = get_spec_value(console, "前桥限滑差速器/差速锁", spec_index)
          @model.console.central_diff_lock = get_spec_value(console, "中央差速器锁止功能", spec_index)
          @model.console.b_XDS = get_spec_value(console, "后桥限滑差速器/差速锁", spec_index)
        end

        #外部配置
        unless exterior.nil?
          @model.build_exterior if @model.exterior.nil?
          @model.exterior.power_sunroof = get_spec_value(exterior, "电动天窗", spec_index)
          @model.exterior.panoramic_sunroof = get_spec_value(exterior, "全景天窗", spec_index)
          @model.exterior.sport_appearance = get_spec_value(exterior, "运动外观套件", spec_index)
          @model.exterior.allowy_wheel = get_spec_value(exterior, "铝合金轮圈", spec_index)
          @model.exterior.electric_suction_door = get_spec_value(exterior, "电动吸合门", spec_index)
          @model.exterior.sliding_door = get_spec_value(exterior, "侧滑门", spec_index)
          @model.exterior.electric_trunk = get_spec_value(exterior, "电动后备厢", spec_index)
          @model.exterior.sensing_trunk = get_spec_value(exterior, "感应后备厢", spec_index)
          @model.exterior.roof_rack = get_spec_value(exterior, "车顶行李架", spec_index)
        end

        #内部配置
        unless interior.nil?
          @model.build_interior if @model.interior.nil?
          @model.interior.leather_steering = get_spec_value(interior, "真皮方向盘", spec_index)
          @model.interior.steering_adjestment = get_spec_value(interior, "方向盘调节", spec_index)
          @model.interior.steering_electric_adjestment = get_spec_value(interior, "方向盘电动调节", spec_index)
          @model.interior.MFL = get_spec_value(interior, "多功能方向盘", spec_index)
          @model.interior.paddle_shift = get_spec_value(interior, "方向盘换挡", spec_index)
          @model.interior.LHZ = get_spec_value(interior, "方向盘加热", spec_index)
          @model.interior.steering_memory = get_spec_value(interior, "方向盘记忆", spec_index)
          @model.interior.CCS = get_spec_value(interior, "定速巡航", spec_index)
          @model.interior.parking_radar = get_spec_value(interior, "前/后驻车雷达", spec_index)
          @model.interior.CCD = get_spec_value(interior, "倒车视频影像", spec_index)
          @model.interior.ECU_display = get_spec_value(interior, "行车电脑显示屏", spec_index)
          @model.interior.LED_dashboard = get_spec_value(interior, "全液晶仪表盘", spec_index)
          @model.interior.HUD = get_spec_value(interior, "HUD抬头数字显示", spec_index)
        end

        #座椅配置
        unless seat.nil?
          @model.build_seat if @model.seat.nil?
          @model.seat.material = get_spec_value(seat, "座椅材质", spec_index)
          @model.seat.sport_sytle = get_spec_value(seat, "运动风格座椅", spec_index)
          @model.seat.height_adjustment = get_spec_value(seat, "座椅高低调节", spec_index)
          @model.seat.lumbar_adjustment = get_spec_value(seat, "腰部支撑调节", spec_index)
          @model.seat.shoulder_adjustment = get_spec_value(seat, "肩部支撑调节", spec_index)
          @model.seat.electric_adjustment = get_spec_value(seat, "主/副驾驶座电动调节", spec_index)
          @model.seat.second_backrest_adjustment = get_spec_value(seat, "第二排靠背角度调节", spec_index)
          @model.seat.second_move = get_spec_value(seat, "第二排座椅移动", spec_index)
          @model.seat.backrow_electric_adjustment = get_spec_value(seat, "后排座椅电动调节", spec_index)
          @model.seat.memory = get_spec_value(seat, "电动座椅记忆", spec_index)
          @model.seat.heating = get_spec_value(seat, "前/后排座椅加热", spec_index)
          @model.seat.ventilation = get_spec_value(seat, "前/后排座椅通风", spec_index)
          @model.seat.massage = get_spec_value(seat, "前/后排座椅按摩", spec_index)
          @model.seat.third_seat = get_spec_value(seat, "第三排座椅", spec_index)
          @model.seat.rear_seat_down = get_spec_value(seat, "后排座椅放倒方式", spec_index)
          @model.seat.centre_armrest = get_spec_value(seat, "前/后中央扶手", spec_index)
          @model.seat.rear_cap_shelf = get_spec_value(seat, "后排杯架", spec_index)
        end

        #多媒体配置
        unless multimedium.nil?
          @model.build_multimedium if @model.multimedium.nil?
          @model.multimedium.GPS = get_spec_value(multimedium, "GPS导航系统", spec_index)
          @model.multimedium.LBS = get_spec_value(multimedium, "定位互动服务", spec_index)
          @model.multimedium.large_screen = get_spec_value(multimedium, "中控台彩色大屏", spec_index)
          @model.multimedium.bluetooth = get_spec_value(multimedium, "蓝牙/车载电话", spec_index)
          @model.multimedium.TV = get_spec_value(multimedium, "车载电视", spec_index)
          @model.multimedium.rear_LED = get_spec_value(multimedium, "后排液晶屏", spec_index)
          @model.multimedium.power = get_spec_value(multimedium, "220V/230V电源", spec_index)
          @model.multimedium.AUX = get_spec_value(multimedium, "外接音源接口", spec_index)
          @model.multimedium.WMA = get_spec_value(multimedium, "CD支持MP3/WMA", spec_index)
          @model.multimedium.meltimedia_system = get_spec_value(multimedium, "多媒体系统", spec_index)
          @model.multimedium.speaker_brand = get_spec_value(multimedium, "扬声器品牌", spec_index)
          @model.multimedium.speaker_num = get_spec_value(multimedium, "扬声器数量", spec_index)
        end

        #灯光配置
        unless lamp.nil?
          @model.build_lamp if @model.lamp.nil?
          @model.lamp.low_beam = get_spec_value(lamp, "近光灯", spec_index)
          @model.lamp.high_beam = get_spec_value(lamp, "远光灯", spec_index)
          @model.lamp.DRL = get_spec_value(lamp, "日间行车灯", spec_index)
          @model.lamp.adaptive_distance_light = get_spec_value(lamp, "自适应远近光", spec_index)
          @model.lamp.auto_headlamp = get_spec_value(lamp, "自动头灯", spec_index)
          @model.lamp.cornering_lamp = get_spec_value(lamp, "转向辅助灯", spec_index)
          @model.lamp.cornering_headlamp = get_spec_value(lamp, "转向头灯", spec_index)
          @model.lamp.front_fog_lamp = get_spec_value(lamp, "前雾灯", spec_index)
          @model.lamp.headling_adjustable = get_spec_value(lamp, "大灯高度可调", spec_index)
          @model.lamp.SRA = get_spec_value(lamp, "大灯清洗装置", spec_index)
          @model.lamp.ambient_lighting = get_spec_value(lamp, "车内氛围灯", spec_index)
        end

        #玻璃/后视镜
        unless mirror.nil?
          @model.build_mirror if @model.mirror.nil?
          @model.mirror.power_window = get_spec_value(mirror, "前/后电动车窗", spec_index)
          @model.mirror.anti_pinch = get_spec_value(mirror, "车窗防夹手功能", spec_index)
          @model.mirror.insulating_glass = get_spec_value(mirror, "防紫外线/隔热玻璃", spec_index)
          @model.mirror.power_adjustable = get_spec_value(mirror, "后视镜电动调节", spec_index)
          @model.mirror.heated = get_spec_value(mirror, "后视镜加热", spec_index)
          @model.mirror.anti_dazzling = get_spec_value(mirror, "内/外后视镜自动防眩目", spec_index)
          @model.mirror.electrically_folding = get_spec_value(mirror, "后视镜电动折叠", spec_index)
          @model.mirror.memory = get_spec_value(mirror, "后视镜记忆", spec_index)
          @model.mirror.rear_windshield_sunshade = get_spec_value(mirror, "后风挡遮阳帘", spec_index)
          @model.mirror.rear_side_sunshade = get_spec_value(mirror, "后排侧遮阳帘", spec_index)
          @model.mirror.rear_privacy_glass = get_spec_value(mirror, "后排侧隐私玻璃", spec_index)
          @model.mirror.sun_visor = get_spec_value(mirror, "遮阳板化妆镜", spec_index)
          @model.mirror.rear_wiper = get_spec_value(mirror, "后雨刷", spec_index)
          @model.mirror.sensing_wiper = get_spec_value(mirror, "感应雨刷", spec_index)
        end

        #空调/冰箱
        unless ac.nil?
          @model.build_ac if @model.ac.nil?
          @model.ac.control_mode = get_spec_value(ac, "空调控制方式", spec_index)
          @model.ac.rear_control = get_spec_value(ac, "后排独立空调", spec_index)
          @model.ac.rear_air_outlet = get_spec_value(ac, "后座出风口", spec_index)
          @model.ac.temperature_zoning = get_spec_value(ac, "温度分区控制", spec_index)
          @model.ac.pollen_filter = get_spec_value(ac, "车内空气调节/花粉过滤", spec_index)
          @model.ac.cooler = get_spec_value(ac, "车载冰箱", spec_index)
        end

        #高科技配置
        unless h_tech_spec.nil?
          @model.build_h_tech_spec if @model.h_tech_spec.nil?
          @model.h_tech_spec.auto_parking = get_spec_value(h_tech_spec, "自动泊车入位", spec_index)
          @model.h_tech_spec.start_stop = get_spec_value(h_tech_spec, "发动机启停技术", spec_index)
          @model.h_tech_spec.BLIS = get_spec_value(h_tech_spec, "并线辅助", spec_index)
          @model.h_tech_spec.LDWS = get_spec_value(h_tech_spec, "车道偏离预警系统", spec_index)
          @model.h_tech_spec.active_safety = get_spec_value(h_tech_spec, "主动刹车/主动安全系统", spec_index)
          @model.h_tech_spec.active_dynamic_steering = get_spec_value(h_tech_spec, "整体主动转向系统", spec_index)
          @model.h_tech_spec.night_vision = get_spec_value(h_tech_spec, "夜视系统", spec_index)
          @model.h_tech_spec.splitview = get_spec_value(h_tech_spec, "中控液晶屏分屏显示", spec_index)
          @model.h_tech_spec.ACC = get_spec_value(h_tech_spec, "自适应巡航", spec_index)
          @model.h_tech_spec.pancam = get_spec_value(h_tech_spec, "全景摄像头", spec_index)
        end

        #外观颜色
        @model.exterior_colors.delete_all
        exterior_colors = get_colors(page_content["color"], spec_id)

        unless exterior_colors.nil?
          exterior_colors.each do |c|
            @color = ExteriorColor.find_by_autohome_id(c["id"])
            if @color.nil?
              @new_color = ExteriorColor.new
              @new_color.autohome_id = c["id"]
              @new_color.name = c["name"]
              @new_color.value = c["value"]

              @new_color.save
              @model.exterior_colors << @new_color
            else
              @model.exterior_colors << @color
            end
          end
        end

        #内饰颜色
        @model.interior_colors.delete_all
        interior_colors = get_colors(page_content["inner_color"], spec_id)

        unless interior_colors.nil?
          interior_colors.each do |c|
            @color = InteriorColor.find_by_autohome_id(c["id"])
            if @color.nil?
              @new_color = InteriorColor.new
              @new_color.autohome_id = c["id"]
              @new_color.name = c["name"]
              @new_color.values = c["values"].join(",")

              @new_color.save
              @model.interior_colors << @new_color
            else
              @model.interior_colors << @color
            end
          end
        end
        @model.save
      end
    end
  end

  #3170, 2745, 2767, 884
  #@series = Series.where(autohome_id: [2123,2027, 884, 983])
  @series = Series.all

  @series.each do |series|
    years = series.models.pluck(:produce_year).uniq
    years.each do |year|
      spec = series.models.find_by_produce_year(year)
      @page_content = get_page_content(spec.autohome_id)
      #@page_content = get_page_content(series.autohome_id)
      if @page_content.nil?
        @nodata_series.push(series.autohome_id)
        puts "#{series.autohome_id}系列#{year}年款车型没有数据"
      else
        puts "正在处理#{series.autohome_id}系列#{year}年款车型的数据"
        get_car_specs(@page_content)
        #get_spec_value(@page_content, "厂商", 0) unless @page_content.nil?
      end
    end
  end

  puts "_____________________________________"
  puts "共处理了#{@data_count}个车型的数据"
  puts "其中本地数据库没有的车型#{@missing_model.count}个：#{@missing_model.to_s}"
  puts "无数据车系有#{@nodata_series.to_s}"

end
