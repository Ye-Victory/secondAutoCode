package com.zousl.vo;

import lombok.Data;

/**
 * Created by ZOUSL1 on 2019-3-13.
 */
@Data
public class TableShchema {
    private String code;
    private String type;
    private String name;
    private String ifNull; // 是否允许为空  yes 允许，no 不允许
    private String columnKey;
}
