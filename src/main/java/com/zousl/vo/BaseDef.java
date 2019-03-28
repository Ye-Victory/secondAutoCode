package com.zousl.vo;

import lombok.Data;

/**
 * Created by ZOUSL1 on 2019-3-18.
 */
@Data
public class BaseDef {
    private String packages;//包名称
    private String entity;//对象名称
    private String tableName;//表名称
    private String tableComment; //表注释
    private String author;//作者
    private String addButtonType;//添加按钮的模式

    private String isParent;//是否是父表 y 是  n 不是
}
