package com.zousl.vo;

import lombok.Data;

/**
 * Created by ZOUSL1 on 2019-3-13.
 */
@Data
public class TableShchema {
    // 字段名称
    private String columnName;
    // 字段类型
    private String dataType;
    // 字段备注
    private String columnComment;
    // 是否允许为空  yes 允许，no 不允许
    private String isNullable;
    // 是否是主键
    private String columnKey;
}
