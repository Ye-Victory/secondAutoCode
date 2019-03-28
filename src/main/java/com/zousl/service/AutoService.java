package com.zousl.service;

import com.zousl.mapper.AutoMapper;
import com.zousl.utils.StringUtils;
import com.zousl.vo.TableDef;
import com.zousl.vo.TableShchema;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ZOUSL1 on 2019-3-13.
 */
@Service
public class AutoService {

    @Autowired
    AutoMapper autoMapper;

    public List<String> getDataSource(String source) {
        Map<String,Object> params = new HashMap<>();
        params.put("source",source);
        return autoMapper.getDataSource(params);
    }

    public List<TableDef> getColumns(Map<String, Object> params, Boolean isXml) throws SQLException {
        List<TableDef> resultList = new ArrayList<>();
        toJavaBean(params, resultList, isXml);
        return resultList;
    }

    private void toJavaBean(Map<String, Object> params, List<TableDef> resultList, Boolean isXml) throws SQLException {
        List<TableShchema> rs = autoMapper.getColumns(params);
        for (TableShchema shchema : rs){
            TableDef vo = new TableDef();
            String code = shchema.getColumnName();
            String columnKey = shchema.getColumnKey();
            // 是否允许为空  yes 允许，no 不允许
            String ifNull = shchema.getIsNullable();
            String name = shchema.getColumnComment();
            String type = shchema.getDataType();
            if (null != columnKey && "PRI".equalsIgnoreCase(columnKey)) {//主键
                vo.setIsPk("true");
            } else {
                vo.setIsPk("false");
            }
            String fileType = "";
            String jdbcType = "";
            if ("VARCHAR".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "String";
                jdbcType = "VARCHAR";

            } else if ("CHAR".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "String";
                jdbcType = "VARCHAR";
            } else if ("INTEGER".equalsIgnoreCase(type.toUpperCase()) || "BIGINT".equals(type.toUpperCase())) {
                fileType = "Long";
                jdbcType = "BIGINT";
            } else if ("INT".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "Long";
                jdbcType = "INTEGER";
            } else if ("DECIMAL".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "Long";
                jdbcType = "BIGINT";
            } else if ("TINYINT".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "Integer";
                jdbcType = "INTEGER";
            } else if ("BLOB".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "Blob";
                jdbcType = "BLOB";
            } else if ("DATETIME".equalsIgnoreCase(type.toUpperCase()) || ("DATE".equals(type.toUpperCase()))) {
                fileType = "Date";
                jdbcType = "DATE";
            } else if ("TEXT".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "String";
                jdbcType = "VARCHAR";
            } else if ("LONGTEXT".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "String";
                jdbcType = "VARCHAR";
            } else if ("Double".equalsIgnoreCase(type.toUpperCase())) {
                fileType = "Double";
                jdbcType = "DOUBLE";
            }
            if(isXml){
                vo.setCode(code.toLowerCase());
            }else{
                vo.setCode(StringUtils.underlineToCamel2(code.toLowerCase()));
            }
            vo.setTableCode(code.toLowerCase());
            vo.setName(name.toUpperCase());
            vo.setType(type);
            vo.setFiledType(fileType);
            vo.setJdbcType(jdbcType);
            vo.setIfNull(ifNull);
            resultList.add(vo);
        }
    }
}
