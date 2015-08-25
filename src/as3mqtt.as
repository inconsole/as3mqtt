package
{
	import flash.display.Sprite;
	
	 import com.godpaper.as3.configs.LoggerConfig;
	 import com.godpaper.as3.utils.LogUtil;
	 import com.godpaper.mqtt.as3.core.MQTTEvent;
	 import com.godpaper.mqtt.as3.impl.MQTTSocket;
	 
	 //import flash.system.Security;
	 import mx.logging.ILogger;
	 import mx.logging.LogEventLevel;
	 
	 import flash.text.TextField;
	
	public class as3mqtt extends Sprite
	{
		
		public var message:TextField;
		
		private var mqttSocket:MQTTSocket;
		private static const MY_HOST:String="127.0.0.1"; //You'd better change it to your private ip address! //test.mosquitto.org//16.157.65.23(Ubuntu)//15.185.106.72(hp cs instance)
		private static const MY_PORT:Number=1883; //Socket port.
		//as3Logger
		//		LoggerConfig.filters = ["MQTTClient_AS3"];
		LoggerConfig.filters = ["com.godpaper.mqtt.as3.impl.*"];
		LoggerConfig.level = LogEventLevel.DEBUG;
		private static const LOG:ILogger = LogUtil.getLogger(MQTTClient_AS3);
		
		public function as3mqtt()
		{
			
			message = new TextField();
			message.text="我是初始化文本";
			message.background = true;
			//message.backgroundColor=900100;
			message.x=0;
			message.y=0;
			message.width=500;
			message.height=40;
			message.textColor=364877;
			addChild(message);
			
			
			//Creating a Socket
			this.mqttSocket=new MQTTSocket(MY_HOST, MY_PORT, "", "","mqtt","as3mqtt");
			//Notice: You need to define a cross domain policy file at your remote server root document, or have a policy file server on the target. 
			//Security.allowDomain("*");
			//			Security.loadPolicyFile("http://www.lookbackon.com/crossdomain.xml");  
			//event listeners
			mqttSocket.addEventListener(MQTTEvent.CONNECT, onConnect); //dispatched when the connection is established
			mqttSocket.addEventListener(MQTTEvent.CLOSE, onClose); //dispatched when the connection is closed
			mqttSocket.addEventListener(MQTTEvent.ERROR, onError); //dispatched when an error occurs
			mqttSocket.addEventListener(MQTTEvent.MESSGE, onMessage); //dispatched when socket can be read
            mqttSocket.addEventListener(MQTTEvent.PUBLISH,onPublish);

			//try to connect
			mqttSocket.connect();
		}
		
        private function onPublish(event:MQTTEvent):void {
            message.text="onPublish:" +  event.message;
                            
            LOG.info("-->MQTT onPublish: {0}",event.message);
        }

		private function onConnect(event:MQTTEvent):void
		{
			message.text="onConnect:" +  event.message;
			
			LOG.info("MQTT connect: {0}",event.message);
			//mqttSocket.close();
			
			mqttSocket.subscribe(Vector.<String>(["a-b","root_message"]), Vector.<int>([1,2]), 1);
			mqttSocket.publish("a-b","11232134adfasdfqwe1231",1);
			mqttSocket.unsubscribe(Vector.<String>(["a-b","root_message"]), 1);
			
			mqttSocket.publish("a-b","11232134adfasdfqwe1231",1);
		}
		
		//
		private function onClose(event:MQTTEvent):void
		{
			message.text="onClose:" +  event.message;
			
			LOG.info("MQTT close: {0}",event.message);
			mqttSocket.connect();
		}
		
		//
		private function onError(event:MQTTEvent):void
		{
			message.text="onError:" + event.message;
			LOG.info("MQTT Error: {0}",event.message);
		}
		
		
		//
		private function onMessage(event:MQTTEvent):void
		{
			message.text="onMessage:" + event.message;
			
			LOG.info("MQTT message: {0}",event.message);
		}
		
	}
}
