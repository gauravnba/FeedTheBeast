package
{
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.*;
	
	public class InputManager 
	{
		// Constants
		public static const NUM_KEYS:int = 128; 
		
		private static const KEY_UP:int = 0;
		private static const KEY_JUST_UP:int = 1;
		private static const KEY_DOWN:int = 2;
		private static const KEY_JUST_DOWN:int = 3;
		
		private static const MOUSE_UP:int = 0;
		private static const MOUSE_JUST_UP:int = 1;
		private static const MOUSE_DOWN:int = 2;
		private static const MOUSE_JUST_DOWN:int = 3;
		
		// Member variables
		public var keys:Array;
		public var mouseDown:int;
		public var mouseX:int;
		public var mouseY:int;
		
		public function InputManager()
		{
			keys = new Array(NUM_KEYS);
			for (var i:int = 0; i < NUM_KEYS; i++)
			{
				keys[i] = KEY_UP;
			}
			
			mouseDown = MOUSE_UP;
			mouseX = 0;
			mouseY = 0;
		}
		
		public function handleKeyDown(event:KeyboardEvent)
		{
			if (event.keyCode >= 0 && 
				event.keyCode < NUM_KEYS)
			{
				keys[event.keyCode] = KEY_JUST_DOWN;
			}
		}
		
		public function handleKeyUp(event:KeyboardEvent)
		{
			if (event.keyCode >= 0 && 
				event.keyCode < NUM_KEYS)
			{
				keys[event.keyCode] = KEY_JUST_UP;
			}
		}
		
		public function handleMouseDown(event:MouseEvent)
		{
			mouseDown = MOUSE_JUST_DOWN;
			mouseX = event.stageX;
			mouseY = event.stageY;
		}
		
		public function handleMouseUp(event:MouseEvent)
		{
			mouseDown = MOUSE_JUST_UP;
			mouseX = event.stageX;
			mouseY = event.stageY;
		}
		
		public function handleMouseMove(event:MouseEvent)
		{
			mouseX = event.stageX;
			mouseY = event.stageY;
		}
		
		public function isKeyDown(key:int):Boolean
		{
			return (keys[key] >= KEY_DOWN);
		}
		
		public function isKeyUp(key:int):Boolean
		{
			return (keys[key] < KEY_DOWN);
		}
		
		public function isKeyJustDown(key:int):Boolean
		{
			return (keys[key] == KEY_JUST_DOWN);
		}

		public function isKeyJustUp(key:int):Boolean
		{
			return (keys[key] == KEY_JUST_UP);
		}
		
		public function isMouseDown():Boolean
		{
			if (mouseDown >= MOUSE_DOWN)
				return true;
			else 
				return false;
		}
		
		public function isMouseUp():Boolean
		{
			if (mouseDown <= MOUSE_JUST_UP)
				return true;
			else 
				return false;
		}
		
		public function isMouseJustDown():Boolean
		{
			return (mouseDown == MOUSE_JUST_DOWN);
		}
		
		public function isMouseJustUp():Boolean
		{
			return (mouseDown == MOUSE_JUST_UP);
		}
		
		public function getMouseX():int 
		{
			return mouseX;
		}
		
		public function getMouseY():int 
		{
			return mouseY;
		}
		
		public function update()
		{
			// Iterate through array and set keys that were
			// just down, or just up to down/up.
			for (var i:int = 0; i < NUM_KEYS; i++)
			{
				if (keys[i] < KEY_DOWN)
				{
					keys[i] = KEY_UP;
				}
				else 
				{
					keys[i] = KEY_DOWN;
				}
			}
			
			if (mouseDown < MOUSE_DOWN)
			{
				mouseDown = MOUSE_UP;
			}
			else 
			{
				mouseDown = MOUSE_DOWN;
			}
		}
	}
}