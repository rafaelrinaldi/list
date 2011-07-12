package com.rafaelrinaldi.data.list
{
	import com.rafaelrinaldi.abstract.IDisposable;

	import flash.display.Bitmap;
	
	/**
	 * 
	 * List entry manager.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 8, 2011
	 *
	 */
	public class ListItem implements IDisposable
	{
		public var value : *;
		
		/**
		 * @param p_value Item value.
		 */
		public function ListItem( p_value : * = null )
		{
			if(p_value != null) value = p_value;
		}
		
		/**
		 * @param p_query Query to match (strict equality).
		 * @return "true" if the query matches something, "false" otherwise.
		 */
		public function match( p_query : * ) : Boolean
		{
			return value === p_query;
		}

		public function dispose() : void
		{
			if(value != null) {
				
				// Try to clean the value using most common method names for disposing.
				if(value.hasOwnProperty("dispose")) value.dispose();
				if(value.hasOwnProperty("kill")) value.kill();
				if(value.hasOwnProperty("flush")) value.flush();
				if(value.hasOwnProperty("destroy")) value.destroy();
				if(value is Bitmap) Bitmap(value).bitmapData.dispose();
				
				value = null;
				
			}
		}
		
		public function toString() : String
		{
			return "[object ListItem] " + value;
		}
	}
}
