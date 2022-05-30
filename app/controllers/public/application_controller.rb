class Public::ApplicationController  < ApplicationController
  # URLにadminが含まれないページはcustomerでログインしないと見れないよ、でもItemは見れる
  before_action :authenticate_customer!,except:  [:top,:about]
end