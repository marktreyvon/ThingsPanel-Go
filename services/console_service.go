package services

import (
	"ThingsPanel-Go/initialize/psql"
	"ThingsPanel-Go/models"
	"ThingsPanel-Go/utils"
	uuid "ThingsPanel-Go/utils"
	"errors"
	"time"

	"github.com/beego/beego/v2/core/logs"
	"gorm.io/gorm"
)

type ConsoleService struct {
}

func (*ConsoleService) AddConsole(name, createdBy, data, config, template, tenantId string) error {
	id := uuid.GetUuid()
	if data == "" {
		data = "{}"
	}

	if config == "" {
		config = "{}"
	}

	if template == "" {
		template = "{}"
	}

	shortUUID := id[:8]
	save := models.Console{
		ID:        id,
		Name:      name,
		CreatedAt: time.Now().Unix(),
		CreatedBy: createdBy,
		UpdateAt:  time.Now().Unix(),
		Data:      data,
		Config:    config,
		Template:  template,
		Code:      shortUUID,
		TenantId:  tenantId,
	}
	result := psql.Mydb.Create(&save)
	return result.Error
}

func (*ConsoleService) EditConsole(id, name, data, config, template, tenant_id string) error {

	update := make(map[string]interface{})

	update["update_at"] = time.Now().Unix()
	// 只修改传过来的字段
	if name != "" {
		update["name"] = name
	}

	if data != "" {
		update["data"] = data
	}

	if config != "" {
		update["config"] = config
	}

	if template != "" {
		update["template"] = template
	}

	err := psql.Mydb.Model(&models.Console{}).Where("id = ? and tenant_id = ? ", id, tenant_id).Updates(update).Error
	return err
}

func (*ConsoleService) DeleteConsoleById(id, tenant_id string) error {
	err := psql.Mydb.Where("id = ? and tenant_id = ?", id, tenant_id).Delete(&models.Console{}).Error
	return err
}

func (*ConsoleService) GetConsoleList(name string, offset, pageSize int, tenantId string) (error, []models.Console, int64) {

	var nG []models.Console
	var count int64

	// 有name
	if name != "" {
		searchTerm := "%" + name + "%"
		tx := psql.Mydb.Model(&models.Console{})
		tx.Where("tenant_id = ? AND name like ?", tenantId, name)
		err := tx.Count(&count).Error
		if err != nil {
			logs.Error(err.Error())
			return err, nG, count
		}

		err = psql.Mydb.Limit(pageSize).Offset(offset).Where("name LIKE ? and tenant_id = ?", searchTerm, tenantId).Order("created_at desc").Find(&nG).Error
		return err, nG, count
	}

	// 无name
	tx := psql.Mydb.Model(&models.Console{})
	tx.Where("tenant_id = ? ", tenantId)
	err := tx.Count(&count).Error
	if err != nil {
		logs.Error(err.Error())
		return err, nG, count
	}
	err = psql.Mydb.Limit(pageSize).Offset(offset).Where("tenant_id = ?", tenantId).Order("created_at desc").Find(&nG).Error
	return err, nG, count

}

func (*ConsoleService) GetConsoleDetail(id string) (models.Console, error) {
	var data models.Console
	err := psql.Mydb.Where("id = ?", id).First(&data).Error
	return data, err
}

// 根据id保存对应的分享id
func (*ConsoleService) UpdateShareId(id string, shareId string) bool {
	result := psql.Mydb.Model(&models.Console{}).Where("id = ?", id).Update("share_id", shareId)
	if result.Error != nil {
		errors.Is(result.Error, gorm.ErrRecordNotFound)
		return false
	}
	return true
}


// 查询可视化对应的设备列表
func (*ConsoleService) GetDeviceListByID(id string) ([]string, error) {
	var console models.Console
	
	// 查询可视化对应的设备列表
	result := psql.Mydb.Where("id = ?", id).First(&console)
	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return nil, errors.New("visualization not found")
		}
		return nil, result.Error
	}

	deviceList, err := utils.GetDeviceListByConsoleData(console.Data)
	if err != nil {
		return nil, err
	}
	return deviceList, nil
}