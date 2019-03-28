package com.zousl.mapper;

import com.zousl.vo.TableShchema;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * Created by ZOUSL1 on 2019-3-13.
 */
@Mapper
public interface AutoMapper {
    List<String> getDataSource(Map<String, Object> params);

    List<TableShchema> getColumns(Map<String, Object> params);
}
