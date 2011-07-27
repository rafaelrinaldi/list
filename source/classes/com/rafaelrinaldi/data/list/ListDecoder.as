package com.rafaelrinaldi.data.list
{
	import com.rafaelrinaldi.string.toBoolean;
	import com.rafaelrinaldi.string.toNative;

	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	/**
	 * 
	 * List decoder class.
	 * 
	 * @see http://misc.rafaelrinaldi.com/github/list/list.xml
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 14, 2011
	 *
	 */
	 
	public class ListDecoder
	{
		/**
		 * Decode XML data.
		 * @param p_data Data to be decoded.
		 * @return A <code>List</code> instance with decoded data.
		 */
		public static function decode( p_data : XML ) : List
		{
			if(p_data == null) return null;

			// Creating the list.			
			var list : List = new List;
			
			var node : XML, child : XML;
			var group : String;
			
			list.id = p_data.attribute("id");
			
			if(p_data.hasOwnProperty("@allowOverride")) {
				list.allowOverride = toBoolean(p_data.attribute("allowOverride"));
			}
			
			// Parsing restrictions.
			for each(node in p_data.child("restrict").children()) {
				
				if(ApplicationDomain.currentDomain.hasDefinition(node.text())) {
					
					const type : * = getDefinitionByName(node.text());
					
					list.restrict.push(type);
					 
				}
				
			}
			
			// Parsing single items.
			for each(node in p_data.child("item")) {
				
				list.add(node.attribute("id"), toNative(node.text()));
				
			}
			
			// Parsing group items.
			for each(node in p_data.child("group")) {
				
				group = node.attribute("id");
				
				if(node.hasOwnProperty("@allowOverride")) {
					list.group(group).allowOverride = toBoolean(node.attribute("allowOverride"));
				}
				
				for each(child in node.children()) {
					
					list.group(group).add(child.attribute("id"), toNative(child.text()));
					
				}
				
				
			}
			
			return list;
		}
	}
}