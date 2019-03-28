package ${corePackageName}.dao;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
*
* <pre>
* ${tableComment}
* </pre>
*
* @author ${author}
* @version 1.00.00
* 创建时间: ${.now}
*
* <pre>
* 修改记录
*    修改后版本:     修改人：  修改日期:     修改内容:
* </pre>
*/
@Repository("${entity}Dao")
public interface ${entity}Dao {
	/**
	 * 查询列表
	 * @return
	 */
	List<Map<String, Object>> queryListByParam(Map<String, Object> params);

	/**
	 * 导出数据
	 * @param params
	 * @return
     */
	List<Map<String,Object>> export${entity}(Map<String, Object> params);
}
