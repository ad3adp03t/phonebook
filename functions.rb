require 'pg'
load "./local_env.rb" if File.exists?("./local_env.rb")


db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['db_name'],
	user: ENV['user'],
	password: ENV['password']
}

$db = PG::Connection.new(db_params)


def insert_contact(firstnm, lastnm, streetnm, zip_cty_st, phone, email)
	$db.exec("INSERT INTO phonedbtable (firstnm, lastnm, streetnm, zip_cty_st, phone, email) VALUES ('#{firstnm}', '#{lastnm}', '#{streetnm}', '#{zip_cty_st}', '#{phone}', '#{email}')")
end

def update_contact(firstnm, lastnm, streetnm, zip_cty_st, phone, email, id)
	query = "UPDATE phonedbtable
		SET firstnm='#{firstnm}',lastnm='#{lastnm}',streetnm='#{streetnm}',zip_cty_st='#{zip_cty_st}',phone='#{phone}', email='#{email}'WHERE id=#{id.to_i};"
	$db.exec(query)
end

def prep_query(info_hash)
	
	firstnm = info_hash[:firstnm]
	phone = info_hash[:phone]      
	if firstnm != '' && phone != ''
		"SELECT * FROM phonedbtable WHERE firstnm='#{firstnm}' AND phone='#{phone}'"
	elsif firstnm != ''
		"SELECT * FROM phonedbtable WHERE firstnm='#{firstnm}'"
	elsif phone != ''
		"SELECT * FROM phonedbtable WHERE phone='#{phone}'"
	else
		"SELECT * FROM phonedbtable"
	end
end

def response_obj(query)
	$db.exec(query)
end
def prep_html(response_obj)
	html = ''
	html << "<table>
	<tr>
	    <td>First Name</td>
	    <td>Last Name</td>
	    <td>Street Address</td>
	    <td>City, State & Zip</td>
	    <td>Phone Number</td>
	    <td>Email</td>
	  </tr>"


  response_obj.each do |row|
		html << "\t<tr>"
		row.each {|cell| html << "\t\t<td>#{cell[1]}</td>\n"}
		html << "\t</tr>"
	end
	
	html << "</table>"
	
	html
end


def full_search_table_render(form_input_hash)
	prep_html(response_obj(prep_query(form_input_hash)))
end

def delete_contact(id)
	"DELETE FROM phonedbtable WHERE ID = #{id}"
end

def check_if_exists(column, value)

end