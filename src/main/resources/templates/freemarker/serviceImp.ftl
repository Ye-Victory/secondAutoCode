package ${corePackageName}.service;

import ${corePackageName}.dao.${classsName}Dao;
import ${corePackageName}.entity.${classsName};
import com.midea.common.util.CmhaStringUtil;
import com.midea.common.constant.ConstantSys;
import com.midea.common.util.CustomResultDataUtils;
import com.midea.common.util.ImportExcelPOI;
import com.midea.mdp.core.annotation.context.EntityStatement;
import com.midea.mdp.core.base.service.IEntityStatement;
import com.midea.mdp.core.vo.PageMeta;
import com.midea.mdp.extend.comm.util.JsonUtil;
import com.midea.mdp.extend.comm.util.ObjectUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
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
@Service("${corePackageName}_service_${classsName}Service")
@com.midea.mdp.core.annotation.context.MsfService
@com.alibaba.dubbo.config.annotation.Service
public class ${entity}ServiceImpl implements ${entity}Service {
    @Resource
    private ${classsName}Dao ${classsName?uncap_first}Dao;
    @EntityStatement
    private IEntityStatement<${classsName}> ${classsName?uncap_first}Statement;

    /**
     * 查询列表
     *
     * @return
     */
    @Override
    public String queryListByParam(String data<#if (isTitleSearch=="true")>,String filter</#if>, Integer pageNo, Integer pageSize) throws Exception {
        Map<String, Object> params = JsonUtil.parseJsonStrJustepToMap(data);
        <#if (isTitleSearch=="true")>
        Map<String,Object> filterMap = JsonUtil.parseJsonStrToMap(filter);
        params.putAll(filterMap);
        </#if>
        //封装查询分页数据条件
        if (null != pageSize && 0 != pageSize) {
            params.put("pageMeta", PageMeta.createDefault(pageNo, pageSize, null, true));
        }
        List<Map<String, Object>> rst = this.${classsName?uncap_first}Dao.queryListByParam(params);
        return JsonUtil.arrayEntityToJsonStrJustep(rst, params);
    }

    /**
     * 修改或者保存对象数据
     *
     * @param jsonData
     * @return
     */
    @Override
    public Map<String, Object> saveOrUpdate(String jsonData) throws Exception {
        List<${classsName}> list = JsonUtil.parseJsonStrJustepToEntityArray(jsonData, ${classsName}.class);
        if (list != null && list.size() > 0){
            for (${classsName} ${classsName?uncap_first} : list){
                if (null != ${classsName?uncap_first} && null != ${classsName?uncap_first}.get${classsName}Id()) {
                    // 更新数据
                    if (null != ${classsName?uncap_first}.getCreationDate()) {
                        ObjectUtil.setForUpdateInfo(${classsName?uncap_first});
                        this.${classsName?uncap_first}Statement.update(${classsName?uncap_first}, false);
                    } else {// 创建数据
                        ${classsName?uncap_first}.set${classsName}Id(null);
                        ObjectUtil.setForCreationInfo(${classsName?uncap_first});
                        ObjectUtil.setForUpdateInfo(${classsName?uncap_first});
                        ${classsName?uncap_first}.setIsDelete(ConstantSys.NO_DELETE);//不删除标识
                        this.${classsName?uncap_first}Statement.create(${classsName?uncap_first});
                    }
                }
            }
        } else {
            return CustomResultDataUtils.createFailResultData("param not valid");
        }
        return CustomResultDataUtils.createSuccessResultData("");
    }

    /**
     * 根据主键id获取对象数据
     *
     * @param id
     * @return
     */
    @Override
    public String getById(String id) throws Exception {
        ${classsName} ${classsName?uncap_first} = ${classsName?uncap_first}Statement.find(id);
        return JsonUtil.entityToJsonStrJustep(${classsName?uncap_first});
    }

    /**
     * 根据id批量物理删除数据
     *
     * @param id
     * @return
     * @throws Exception
     */
    @Override
    public Map<String, Object> delete(String id) throws Exception {
        List<String> idList = CmhaStringUtil.stringToListByComma(id);
        if (idList != null && idList.size() > 0){
            for (String ${classsName?uncap_first}Id : idList){
                // 物理删除
                this.${classsName?uncap_first}Statement.delete(${classsName?uncap_first}Id);
            }
        }else{
            return CustomResultDataUtils.createFailResultData("param not valid");
        }
        return CustomResultDataUtils.createSuccessResultData("");
    }

    /**
     * 导入数据
     *
     * @param fileData
     * @return
     * @throws Exception
     */
    @Override
    public String import${entity}(Map<String, Object> fileData) throws Exception {
        ImportExcelPOI poi = new ImportExcelPOI();
        InputStream in = new ByteArrayInputStream((byte[]) fileData.get("fileData"));
        // 获取excel数据
        Map<String, Map<String, List>> rstMap = poi.readExcelAllMap(in);
        for (String name : rstMap.keySet()) {
            Map<String, List> rowMap = rstMap.get(name);
            for (String row : rowMap.keySet()) {
                List<String> cells = rowMap.get(row);
                // 第2行开始取数据
                if (Integer.parseInt(row) >= 1) {
                    // 获取订单编号
                    String orderNo = CmhaStringUtil.StringValue(cells.get(0));
                    // 创建数据
                    ${classsName} single = new ${classsName}();
                    single.setOrderNo(orderNo);
                    single.set${classsName}Id(null);
                    ObjectUtil.setForCreationInfo(single);
                    ObjectUtil.setForUpdateInfo(single);
                    single.setIsDelete(ConstantSys.NO_DELETE);
                    this.${classsName?uncap_first}Statement.create(single);
                }
            }
        }
        return JsonUtil.map2Json(CustomResultDataUtils.createSuccessResultData("导入成功"));
    }

    /**
     * 导出数据
     *
     * @param ids
     * @return
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> export${entity}(String ids) throws Exception {
        List<String> idList = CmhaStringUtil.stringToListByComma(ids);
        Map<String,Object> params = new HashMap<>();
        params.put("idList",idList);
        List<Map<String, Object>> rst = this.${classsName?uncap_first}Dao.export${entity}(params);
        return rst;
    }

}
