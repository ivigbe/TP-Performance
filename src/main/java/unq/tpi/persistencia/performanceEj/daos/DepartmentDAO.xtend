package unq.tpi.persistencia.performanceEj.daos

import java.util.List
import unq.tpi.persistencia.performanceEj.model.Department
import unq.tpi.persistencia.util.SessionManager

class DepartmentDAO {

	def getByName(String name) {
		val session = SessionManager.getSession()
		session.createQuery("from Department where name = :name").setParameter("name", name).
			uniqueResult() as Department
		}

		def getByNameWithJoin(String name) {
			val session = SessionManager.getSession()
			session.createQuery(
				"from Department depto 
				join fetch depto.employees 
			where depto.name = :name"
			).setParameter("name", name).uniqueResult() as Department
		}

		def getByCode(String num) {
			val session = SessionManager.getSession()
			session.get(Department, num) as Department
		}

		def getDepartmentByCode(String num) {
			
			val session = SessionManager.session
			session.createQuery("from Department dept join fetch dept.employees as e join fetch e.titles join fetch e.salaries as s where s.to = '9999-01-01' and dept.code = :c").setParameter("c", num).
			uniqueResult() as Department
		}

		def getAll() {
			val session = SessionManager.getSession()
			session.createCriteria(Department).list() as List<Department>
		}

	}
