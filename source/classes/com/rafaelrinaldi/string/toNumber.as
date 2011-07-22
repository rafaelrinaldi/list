package com.rafaelrinaldi.string
{
	/**
	 * 
	 * Converts a <code>String</code> value into a <code>Number</code> value.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 15, 2011
	 *
	 */
	public function toNumber( p_string : String ) : Number
	{
		return (trim(p_string) == "" || p_string == null) ? 0 : Number(p_string);
	}
}
