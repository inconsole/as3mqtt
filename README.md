# as3mqtt
as3mqtt

1:install mqtt server
example:
  mosquitto ip:127.0.0.1 port:1883
  
2: create mqtt demo project (As3 project)

3:
include libs/as3Logger.swc

4:
include source path  third/src 

5: test


--------------------------
python_mqtt_client.py


#coding=utf-8
import paho.mqtt.publish as publish
import json

publish.single('root_message','hello_for_python_client', hostname = '127.0.0.1')

json_msg = json.dumps({'name':'zhangsan','pwd':'12345','icon':''},encoding='utf-8')

publish.single('a-b',json_msg, hostname = '127.0.0.1')
