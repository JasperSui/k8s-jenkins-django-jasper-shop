from django import template
import random
register = template.Library()

@register.filter(name='ToCurrency')
def ToCurrency(value):
    result = ''
    counter = 0
    for v in str(value)[::-1]:
        result += v
        if (counter+1) % 3 == 0 and (counter+2) <= len(str(value)):
            result += ','
        counter += 1
    return result[::-1]

@register.filter(name='GetRandomInt')
def GetRandomIntBetweenXandY(value):
    return random.randint(1, 5000)

@register.filter(name='GetRandomProvince')
def GetRandomProvince(value):

    province_list = ['基隆市', '嘉義市', '台北市', '嘉義縣', '新北市', '台南市', '桃園縣', '高雄市', '新竹市', '屏東縣', '新竹縣', '台東縣',
                     '苗栗縣', '花蓮縣', '台中市', '宜蘭縣', '彰化縣', '澎湖縣', '南投縣', '金門縣', '雲林縣', '連江縣']
    
    return province_list[random.randint(0, len(province_list)-1)]

@register.filter(name='GetRandomDistrict')
def GetRandomDistrict(value):

    district_list = ['中正區','大同區','中山區','松山區','大安區','萬華區','信義區','士林區','北投區','內湖區','南港區','文山區',
                     '板橋區','新莊區','中和區','永和區','土城區','樹林區','三峽區','鶯歌區','三重區','蘆洲區','五股區','泰山區',
                     '林口區','八里區','淡水區','三芝區','石門區','金山區','萬里區','汐止區','瑞芳區','貢寮區','平溪區','雙溪區',
                     '新店區','深坑區','石碇區','坪林區','烏來區','桃園區','中壢區','平鎮區','八德區','楊梅區','蘆竹區','大溪區',
                     '龍潭區','龜山區','大園區','觀音區','新屋區','復興區','中區','東區','南區','西區','北區','北屯區','西屯區',
                     '太平區','大里區','霧峰區','烏日區','豐原區','后里區','石岡區','東勢區','新社區','潭子區','大雅區','神岡區',
                     '沙鹿區','龍井區','梧棲區','清水區','大甲區','外埔區','大安區','和平區','中西區','東區','南區','北區','安平區',
                     '安南區','永康區','歸仁區','新化區','左鎮區','玉井區','楠西區','南化區','仁德區','關廟區','龍崎區','官田區',
                     '麻豆區','佳里區','西港區','七股區','將軍區','學甲區','北門區','新營區','後壁區','白河區','東山區','六甲區',
                     '下營區','柳營區','鹽水區','善化區','大內區','山上區','新市區','安定區','楠梓區','左營區','鼓山區','三民區',
                     '鹽埕區','前金區','新興區','苓雅區','前鎮區','旗津區','小港區','鳳山區','大寮區','鳥松區','林園區','仁武區',
                     '大樹區','大社區','岡山區','路竹區','橋頭區','梓官區','彌陀區','永安區','燕巢區','田寮區','阿蓮區','茄萣區',
                     '湖內區','旗山區','美濃區','內門區','杉林區','甲仙區','六龜區','茂林區','桃源區','那瑪夏區',
                     '大肚區','南屯區']

    return district_list[random.randint(0, len(district_list)-1)]


