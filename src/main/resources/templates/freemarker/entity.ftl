package ${corePackageName}.entity;

import java.util.Date;

import com.midea.mdp.core.annotation.persistence.MdpEntity;
import com.midea.mdp.core.annotation.persistence.MdpGeneratedValue;
import com.midea.mdp.core.annotation.persistence.MdpGenerationType;
import com.midea.mdp.core.annotation.persistence.MdpId;
import com.midea.mdp.core.annotation.persistence.MdpTable;
import com.midea.mdp.core.annotation.persistence.MdpTransient;
import com.midea.mdp.extend.entity.BaseEntity;

/**
*
* <pre>
* ${tableComment}
* </pre>
*
* @author ${author}
* @version 1.00.00
* 创建时间:${.now}
*
* <pre>
* 修改记录
*    修改后版本:     修改人：  修改日期:     修改内容:
* </pre>
*/
@MdpEntity
@MdpTable(name = "${tableName}")
public class ${classsName} extends BaseEntity {
    private static final Long serialVersionUID = ${currentTimeMillis}L;
    <#list tabledef as field>
    <#if (field.code == "version")>
    private Long ${field.code} = 0L; //${field.name}
    <#elseif (field.isPk == "true")>
    private Long ${field.code} ; //${field.name}
    <#else>
    private ${field.filedType} ${field.code}; //${field.name}
    </#if>
    </#list>

    <#list tabledef as field>
    <#if (field.code == "version" ||  field.isPk == "true")>
    <#if field.isPk == "true">
    @MdpId
    @MdpGeneratedValue(strategy = MdpGenerationType.DISTRIBUTED)
    </#if>
    public java.lang.Long get${field.code?cap_first}() {
        return ${field.code};
    }
    <#else>
    public ${field.filedType} get${field.code?cap_first}(){
        return ${field.code};
    }
    </#if>
    <#if field.code == "version">
    public void setVersion(java.lang.Long version) {
        if (version == null){
            this.version = 0L;
        }else{
            this.version = version;
        }
    }
    <#elseif (field.isPk == "true")>
    public void set${field.code?cap_first}(Long ${field.code}){
        this.${field.code} = ${field.code};
    }
    <#else>
    public void set${field.code?cap_first}(${field.filedType} ${field.code}){
         this.${field.code} = ${field.code};
    }
    </#if>
    </#list>
}
