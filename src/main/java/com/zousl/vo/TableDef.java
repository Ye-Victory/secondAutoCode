package com.zousl.vo;

import lombok.Data;

@Data
public class TableDef {
	public String code;//字段
	public String tableCode;//数据库字段
	public String name;//中文名称
	public String type;//数据类型
	public String filedType;//在java中类型
	public String ifNull;//是否允许为空
	public String isPk;//主键标识
	public String jdbcType;
}
