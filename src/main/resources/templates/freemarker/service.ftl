package ${corePackageName}.service;

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
public interface ${entity}Service {
    /**
     * 查询列表
     * @return
     */
    public String queryListByParam(String data<#if (isTitleSearch=="true")>,String filter</#if>, Integer pageNo, Integer pageSize) throws Exception;
    /**
     * 修改或者保存对象数据
     * @param jsonData
     * @return
     */
    Map<String, Object> saveOrUpdate(String jsonData) throws Exception;
    /**
     * 根据主键id获取对象数据
     * @param id
     * @return
     */
    public String getById(String id) throws Exception;
    /**
     * 根据id逻辑删除数据
     * @param id
     * @return
     * @throws Exception
     */
    public Map<String, Object> delete(String id) throws Exception;

    /**
     * 导入数据
     * @param fileData
     * @return
     * @throws Exception
     */
    public String import${entity}(Map<String, Object> fileData) throws Exception;

    /**
     * 导出数据
     * @param ids
     * @return
     * @throws Exception
     */
    public List<Map<String,Object>> export${entity}(String ids) throws Exception;
}
