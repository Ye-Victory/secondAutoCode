<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${corePackageName}.dao.${entity}Dao">

	<select id="queryListByParam" parameterType="hashmap" resultType="map">
        select <#list tabledef as field><#if (tabledef?size-field_index==1)>${field.code}<#else>${field.code},</#if></#list>
        from ${tableName} where is_delete=0

	<#list dataTabledef as field>
        <if test="null != ${field.code} and ${field.code} != ''"> and ${field.tableCode} like MY_STR_ADD('%', ${r'#{'}${field.code}${r'}'}, '%')</if>
	</#list>

        <if test="null != startDate and startDate != '' "><![CDATA[ and create_date >= ${r'#{startDate}'}]]></if>
        <if test="null != endDate and endDate != '' "><![CDATA[ and create_date <= ${r'#{endDate}'}]]></if>
        order by ${tablePk} desc
	</select>

	<select id="export${entity}" parameterType="hashmap" resultType="java.util.LinkedHashMap">
        select <#list tabledef as field><#if (tabledef?size-field_index==1)>${field.code}<#else>${field.code},</#if></#list>
        from ${tableName}
        WHERE
        1 = 1
        <if test="null != idList and idList.size > 0">
            AND ${tablePk} IN
            <foreach item="item" index="index" open="(" close=")" separator="," collection="idList">
			${r'#{item}'}
            </foreach>
        </if>
		order by ${tablePk} desc
	</select>

</mapper>