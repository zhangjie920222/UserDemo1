package gnnt.demo.user.dao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import gnnt.demo.user.dao.TestDao;
@Repository("testDao")
public class TestDaoImpl implements TestDao{
    @Autowired
	private JdbcTemplate jdbcTemplate;
	@Override
	public void testUser() {
		// TODO Auto-generated method stub
		jdbcTemplate.execute("update e_order set title='22' where id='1030' ");
	}
}
