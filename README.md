# Jasper Shop (Django 高併發購物網站)

由 Nginx, uWSGI, Celery 並架設在 Google Cloud Platform 機器，

全端模擬蝦皮購物 ([Shopee.tw](https://shopee.tw/)) 的 UI/UX 來完成一份由 Django 框架構成的購物網站。



其中包含了以下幾個主要的功能及特色：

* 會員系統<br>
　　```包括註冊、登入、帳號啟用、個人資料頁、頁面權限控制```
* 寄發驗證信<br>
　　```註冊成功時會發送信件請使用者透過不重複亂數產生的連結啟用帳號及補發驗證信的功能```
* 商品搜尋<br>
　　```透過替商品名稱做標籤分析，盡可能地簡化搜尋流程並精準化```
* 購物車<br>
　　```利用 Session 來暫存使用者購物車內商品資訊、數量```
* 限時特賣<br>
　　```讓後台人員可以輸入上下架時間、商品數量等等…後利用 Celery 來發 Tasks 並做相對應的處理```
* reCaptcha V3<br>
　　```在註冊及登入時利用 reCaptcha 來避免機器人或是惡意使用```
* 異步任務系統<br>
　　```除了限時特賣以外，也用在模擬使用者下訂單後的訂單狀態變化```

Django 因為框架本身有單線程的限制導致併發效能低下，

尤其是大量的 Input/Output 操作時更是常常堵塞，

所以藉由讓 uWSGI 搭配 Nginx 來處理 Django 發出的 Request 

來完成能接受多請求併發且低失敗率的網站，

最後透過 Siege 來進行壓力測試，提供 Django 原先框架單線程的效能及優化後的數據

實際比對測試數據來證明效能的改善。

## 目錄

- [Jasper Shop (Django 高併發購物網站)](#Jasper-Shop-(Django-高併發購物網站))
  * [目錄](#目錄)
  * [開發環境](#開發環境)
  * [網站展示](#網站展示)
    + [首頁](#首頁)
    + [註冊功能](#註冊功能)
    + [登入功能](#登入功能)
    + [搜尋功能](#搜尋功能)
    + [商品頁](#商品頁)
    + [購物車頁](#購物車頁)
    + [購買清單頁](#購買清單頁)
    + [限時特賣頁](#限時特賣頁)
    + [限時特賣商品頁](#限時特賣商品頁)
  * [高併發效能改善實例](#高併發效能改善實例)
    + [造訪靜態頁面](#造訪靜態頁面)
      - [Django 原生 (manage.py runserver)](#Django-原生-(manage.py-runserver))
      - [Nginx + uWSGI + Django](#Nginx-+-uWSGI-+-Django)
    + [模擬實際搶購商品](#模擬實際搶購商品)
      - [Django 原生 (manage.py runserver)](#Django-原生-(manage.py-runserver)1)
      - [Nginx + uWSGI + Django](#Nginx-+-uWSGI-+-Django1)
  * [結語](#結語)
  
開發環境
---

* [uBuntu 16.0.4 LTS](https://ubuntu.com/) 
* [Django (Version 2.2.5)](https://www.djangoproject.com/)
* [Nginx](https://www.nginx.com/)
* [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/)
* [Celery (Version 3.1.24)](http://www.celeryproject.org/) 
* [MySQL](https://www.mysql.com/)
* [Bootstrap 4](https://getbootstrap.com/)
* [CloudFlare](https://www.cloudflare.com/zh-tw/)
* [Google Cloud Platform](https://cloud.google.com/)
* [Siege (Version 3.0.8)](https://github.com/JoeDog/siege)

網站展示
---
### 首頁

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Index1.jpg)

### 註冊功能

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/register1.jpg)

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Register2.jpg)

### 登入功能

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Login1.jpg)

### 搜尋功能

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Search1.jpg)

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Search2.jpg)

### 商品頁

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Product1.jpg)

### 購物車頁

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Cart1.jpg)

### 購買清單頁

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/Purchase1.jpg)

### 限時特賣頁

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/SpecialSale1.jpg)

### 限時特賣商品頁

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/SpecialProduct1.jpg)

高併發效能改善實例
---

以 Google Cloud Platform 提供的 n1-standard-1 (1 個 vCPU，3.75 GB 記憶體) 為實驗機器

模擬 1000 個用戶、每個用戶 10 次請求、請求延遲 0 秒

分為以下兩個情境：

### 造訪靜態頁面 


```
無連結資料庫，純粹的靜態頁面
```

#### Django 原生 (manage.py runserver)

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/StaticPage1.jpg)

```
伺服器用了 408 秒 只跑了 6951 次的請求就崩潰，且有 1245 次的請求是失敗的

每秒平均請求次數只有 17 次/秒
```

#### Nginx + uWSGI + Django

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/StaticPage2.jpg)

```
伺服器只用了 7 秒就將 10000 次請求處理完成，且沒有任何請求失敗

每秒平均請求次數為 1344 次/秒，處理效率為原生框架的 79 倍
```

---


### 模擬實際搶購商品

```
資料庫實際參與，包含購買商品實際會處理到的商業邏輯，例如：產生訂單、更新商品數量、檢查使用者權限
```

#### Django 原生 (manage.py runserver)

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/BuyItem1.jpg)

```
伺服器用了 392 秒 只跑了 3543 次的請求就崩潰，且有 1591 次的請求是失敗的

每秒平均請求次數只有 9 次/秒
```

#### Nginx + uWSGI + Django

![image](https://github.com/JasperSui/Django-JasperShop/blob/master/DemoImage/BuyItem2.jpg)

```
伺服器只用了 135 秒就將 10000 次請求處理完成，且沒有任何請求失敗

每秒平均請求次數為 73.91 次/秒，處理效率為原生框架的 8 倍
```


## 結語

若是沒有使用 Nginx 和 uWSGI 來協助 Django 對靜態對象及其他對象來做分流，

是無法發揮 Django 真正的效能的，效能實在是差了太多了，

光是 1 核 CPU 的差距就能這麼大，那多核下的表現一定也會更加亮眼

除了最基本的分配靜態對象給 uWSGI 處理，WebSocket 的傳送也可以透過 Nginx 來處理，

可以達成實時處理一些事情的功能，像是最基本的聊天系統。

這次利用模擬蝦皮商城的介面來練習簡易切版，以及自行模擬他們的商業邏輯

後端的部分可以說是一兩天就完成了，其他時間就是在切他們的版面…


