package com.rafaelrinaldi.data.list
{
	import avmplus.getQualifiedClassName;
	/**
	 * 
	 * List encoder.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 14, 2011
	 *
	 */
	public class ListEncoder
	{
		/**
		 * Encode the data from a <code>List</code> instance into <code>XML</code> data.
		 * @param p_data Data to be encoded.
		 * @return Encoded data.
		 */
		public static function encode( p_data : List ) : XML
		{
			var item : ListItem;
			var list : List;
			
			var raw : String = "<list id='" + p_data.id + "' allowOverride='" + p_data.allowOverride + "'>";
			
			// Adding restrictions.
			
			raw += "<restrict>";
			
			p_data.restrict.forEach(function( p_restriction : Class, ...rest ) : void {
				raw += "<item>" + getQualifiedClassName(p_restriction).replace(/::/g, ".") + "</item>";
			});
			
			raw += "</restrict>";
			
			// Adding single items.
			
			for each(item in p_data.items) {
				raw += "<item id='" + item.id + "'>" + item.value + "</item>";
			}
			
			// Adding group items.
			
			for each(list in p_data.groups) {
				
				raw += "<group id='" + list.id + "' allowOverride='" + list.allowOverride + "'>";
				
				for each(item in list.items) {
					
					raw += "<item id='" + item.id + "'>"+ item.value +"</item>";
					
				}
				
				raw += "</group>";
			}
			
			raw += "</list>";
			 
			return new XML(raw);
		}
	}
}
