package gnnt.demo.user.util;

import org.springframework.jdbc.core.JdbcTemplate;

public class JdbcTemplateFactory {
	private static JdbcTemplate jdbcTemplate;
	public static JdbcTemplate getJdbcTemplate(){
		return jdbcTemplate;
	}
}
