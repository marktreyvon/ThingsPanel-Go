CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
-- public.business definition

-- Drop table

-- DROP TABLE business;

CREATE TABLE business (
	id varchar(36) NOT NULL,
	"name" varchar(255) NULL,
	created_at int8 NULL,
	app_type varchar(255) NOT NULL DEFAULT ''::character varying, -- 应用类型
	app_id varchar(255) NOT NULL DEFAULT ''::character varying, -- app id
	app_secret varchar(255) NOT NULL DEFAULT ''::character varying, -- 密钥
	CONSTRAINT business_pkey PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.business.app_type IS '应用类型';
COMMENT ON COLUMN public.business.app_id IS 'app id';
COMMENT ON COLUMN public.business.app_secret IS '密钥';


-- public.casbin_rule definition

-- Drop table

-- DROP TABLE casbin_rule;

CREATE TABLE casbin_rule (
	id bigserial NOT NULL,
	ptype varchar(100) NULL,
	v0 varchar(100) NULL,
	v1 varchar(100) NULL,
	v2 varchar(100) NULL,
	v3 varchar(100) NULL,
	v4 varchar(100) NULL,
	v5 varchar(100) NULL,
	v6 varchar(25) NULL,
	v7 varchar(25) NULL,
	CONSTRAINT casbin_rule_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX idx_casbin_rule ON public.casbin_rule USING btree (ptype, v0, v1, v2, v3, v4, v5, v6, v7);


-- public.conditions_log definition

-- Drop table

-- DROP TABLE conditions_log;

CREATE TABLE conditions_log (
	id varchar(36) NOT NULL,
	device_id varchar(36) NOT NULL,
	operation_type varchar(2) NULL, -- 操作类型1-定时触发 2-手动控制
	instruct varchar(255) NULL, -- 指令
	sender varchar(99) NULL, -- 发送者
	send_result varchar(2) NULL, -- 发送结果1-成功 2-失败
	respond varchar(255) NULL, -- 设备反馈
	cteate_time varchar(50) NULL,
	remark varchar(255) NULL,
	protocol_type varchar(50) NULL, -- mqtt,tcp
	CONSTRAINT conditions_log_pk PRIMARY KEY (id)
);
CREATE INDEX conditions_log_cteate_time_idx_desc ON public.conditions_log USING btree (cteate_time DESC);

-- Column comments

COMMENT ON COLUMN public.conditions_log.operation_type IS '操作类型1-定时触发 2-手动控制';
COMMENT ON COLUMN public.conditions_log.instruct IS '指令';
COMMENT ON COLUMN public.conditions_log.sender IS '发送者';
COMMENT ON COLUMN public.conditions_log.send_result IS '发送结果1-成功 2-失败';
COMMENT ON COLUMN public.conditions_log.respond IS '设备反馈';
COMMENT ON COLUMN public.conditions_log.protocol_type IS 'mqtt,tcp';



-- public.data_transpond definition

-- Drop table

-- DROP TABLE data_transpond;

CREATE TABLE data_transpond (
	id varchar(36) NOT NULL,
	process_id varchar(36) NULL, -- 流程id
	process_type varchar(36) NULL, -- 流程类型
	"label" varchar(255) NULL, -- 标签
	disabled varchar(10) NULL, -- 状态
	info varchar(255) NULL,
	env varchar(999) NULL,
	customer_id varchar(36) NULL,
	created_at int8 NULL,
	role_type varchar(2) NULL,
	CONSTRAINT data_transpond_pk PRIMARY KEY (id)
);



-- Column comments

COMMENT ON COLUMN public.data_transpond.process_id IS '流程id';
COMMENT ON COLUMN public.data_transpond.process_type IS '流程类型';
COMMENT ON COLUMN public.data_transpond."label" IS '标签';
COMMENT ON COLUMN public.data_transpond.disabled IS '状态';
COMMENT ON COLUMN public.data_transpond.role_type IS '1-接入引擎 2-数据转发';


-- public.navigation definition

-- Drop table

-- DROP TABLE navigation;

CREATE TABLE navigation (
	id varchar(36) NOT NULL,
	"type" int4 NULL, -- 1:业务  2：自动化-控制策略 3：自动化-告警策略  4：可视化
	"name" varchar(255) NULL,
	"data" varchar(255) NULL,
	count int4 NULL DEFAULT 1, -- 数量
	CONSTRAINT navigation_pkey PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.navigation."type" IS '1:业务  2：自动化-控制策略 3：自动化-告警策略  4：可视化';
COMMENT ON COLUMN public.navigation.count IS '数量';

-- public.logo definition

-- Drop table

-- DROP TABLE logo;

CREATE TABLE logo (
	id varchar(36) NOT NULL,
	system_name varchar(255) NULL, -- 系统名称
	theme varchar(99) NULL, -- 主题
	logo_one varchar(255) NULL, -- 首页logo
	logo_two varchar(255) NULL, -- 缓冲logo
	logo_three varchar(255) NULL,
	custom_id varchar(99) NULL,
	remark varchar(255) NULL,
	CONSTRAINT logo_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.logo.system_name IS '系统名称';
COMMENT ON COLUMN public.logo.theme IS '主题';
COMMENT ON COLUMN public.logo.logo_one IS '首页logo';
COMMENT ON COLUMN public.logo.logo_two IS '缓冲logo';



-- public.operation_log definition

-- Drop table

-- DROP TABLE operation_log;

CREATE TABLE operation_log (
	id varchar(36) NOT NULL,
	"type" varchar(36) NULL,
	"describe" varchar(10000000) NULL,
	data_id varchar(36) NULL,
	created_at int8 NULL,
	detailed json NULL,
	CONSTRAINT operation_log_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE public.operation_log IS '操作日志';


-- public.resources definition

-- Drop table

-- DROP TABLE resources;

CREATE TABLE resources (
	id varchar(36) NOT NULL,
	cpu varchar(36) NULL,
	mem varchar(36) NULL,
	created_at varchar(36) NULL,
	CONSTRAINT "Resources_pkey" PRIMARY KEY (id)
);
CREATE INDEX resources_created_at_idx ON public.resources USING btree (created_at DESC);


-- public.tp_function definition

-- Drop table

-- DROP TABLE tp_function;

CREATE TABLE tp_function (
	id varchar(36) NOT NULL,
	function_name varchar(99) NOT NULL,
	menu_id varchar(36) NULL,
	CONSTRAINT tp_function_un UNIQUE (function_name)
);


-- public.tp_menu definition

-- Drop table

-- DROP TABLE tp_menu;

CREATE TABLE tp_menu (
	id varchar(36) NOT NULL,
	menu_name varchar(99) NOT NULL,
	parent_id varchar(36) NOT NULL DEFAULT 0,
	remark varchar(255) NULL,
	CONSTRAINT tp_menu_pk PRIMARY KEY (id)
);


-- public.tp_role definition

-- Drop table

-- DROP TABLE tp_role;

CREATE TABLE tp_role (
	id varchar(36) NOT NULL,
	role_name varchar(99) NOT NULL,
	parent_id varchar(36) NULL DEFAULT 0,
	role_describe varchar(255) NULL,
	CONSTRAINT tp_role_pk PRIMARY KEY (id),
	CONSTRAINT tp_role_un UNIQUE (role_name)
);


-- public.tp_role_menu definition

-- Drop table

-- DROP TABLE tp_role_menu;

CREATE TABLE tp_role_menu (
	role_id varchar(36) NOT NULL,
	menu_id varchar(30) NOT NULL,
	CONSTRAINT tp_role_menu_pk PRIMARY KEY (role_id, menu_id)
);


-- public.ts_kv definition

-- Drop table

-- DROP TABLE ts_kv;

CREATE TABLE ts_kv (
	entity_type varchar(255) NOT NULL,
	entity_id varchar(36) NOT NULL,
	"key" varchar(255) NOT NULL,
	ts int8 NOT NULL,
	bool_v varchar(5) NULL,
	str_v text NULL,
	long_v int8 NULL,
	dbl_v float8 NULL,
	CONSTRAINT ts_kv_pkey PRIMARY KEY (entity_type, entity_id, key, ts)
);
CREATE INDEX ts_kv_ts_idx ON public.ts_kv USING btree (ts DESC);
COMMENT ON TABLE public.ts_kv IS '数据管理表';


-- public.ts_kv_latest definition

-- Drop table

-- DROP TABLE ts_kv_latest;

CREATE TABLE ts_kv_latest (
	entity_type varchar(255) NOT NULL,
	entity_id varchar(36) NOT NULL,
	"key" varchar(255) NOT NULL,
	ts int8 NOT NULL,
	bool_v varchar(5) NULL,
	str_v varchar(10000000) NULL,
	long_v int8 NULL,
	dbl_v float8 NULL,
	CONSTRAINT ts_kv_latest_pkey PRIMARY KEY (entity_type, entity_id, key)
);
CREATE UNIQUE INDEX "INDEX_KEY" ON public.ts_kv_latest USING btree (entity_type, entity_id, key);
COMMENT ON TABLE public.ts_kv_latest IS '最新数据';



-- public.users definition

-- Drop table

-- DROP TABLE users;

CREATE TABLE users (
	id varchar(36) NOT NULL,
	created_at int8 NOT NULL DEFAULT 0,
	updated_at int8 NOT NULL DEFAULT 0,
	enabled varchar(5) NULL,
	additional_info varchar NULL,
	authority varchar(255) NULL,
	customer_id varchar(36) NULL,
	email varchar(255) NULL,
	"password" varchar(255) NULL,
	"name" varchar(255) NULL,
	first_name varchar(255) NULL,
	last_name varchar(255) NULL,
	search_text varchar(255) NULL,
	email_verified_at int8 NOT NULL DEFAULT 0,
	remember_token varchar(100) NULL,
	mobile varchar(20) NULL,
	remark varchar(100) NULL,
	is_admin int8 NULL DEFAULT 0,
	business_id varchar(36) NULL DEFAULT 0, -- 业务id
	wx_openid varchar(50) NULL DEFAULT ''::character varying, -- 微信openid
	wx_unionid varchar(50) NULL DEFAULT ''::character varying, -- 微信unionid
	CONSTRAINT users_pkey PRIMARY KEY (id)
);
CREATE INDEX "INDEX_WX_OPENID" ON public.users USING btree (wx_openid);
COMMENT ON TABLE public.users IS '后台用户';

-- Column comments

COMMENT ON COLUMN public.users.business_id IS '业务id';
COMMENT ON COLUMN public.users.wx_openid IS '微信openid';
COMMENT ON COLUMN public.users.wx_unionid IS '微信unionid';


-- public.asset definition

-- Drop table

-- DROP TABLE asset;

CREATE TABLE asset (
	id varchar(36) NOT NULL,
	additional_info varchar NULL,
	customer_id varchar(36) NULL, -- 客户ID
	"name" varchar(255) NULL, -- 名称
	"label" varchar(255) NULL, -- 标签
	search_text varchar(255) NULL,
	"type" varchar(255) NULL, -- 类型
	parent_id varchar(36) NULL, -- 父级ID
	tier int4 NOT NULL DEFAULT 1, -- 层级
	business_id varchar(36) NULL, -- 业务ID
	CONSTRAINT asset_pkey PRIMARY KEY (id),
	CONSTRAINT asset_fk FOREIGN KEY (business_id) REFERENCES business(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX asset_parent_id_idx ON public.asset USING btree (parent_id);
COMMENT ON TABLE public.asset IS '资产';

-- Column comments

COMMENT ON COLUMN public.asset.customer_id IS '客户ID';
COMMENT ON COLUMN public.asset."name" IS '名称';
COMMENT ON COLUMN public.asset."label" IS '标签';
COMMENT ON COLUMN public.asset."type" IS '类型';
COMMENT ON COLUMN public.asset.parent_id IS '父级ID';
COMMENT ON COLUMN public.asset.tier IS '层级';
COMMENT ON COLUMN public.asset.business_id IS '业务ID';


-- public.device definition

-- Drop table

-- DROP TABLE device;

CREATE TABLE device (
	id varchar(36) NOT NULL,
	asset_id varchar(36) NULL, -- 资产id
	"token" varchar(255) NULL, -- 安全key
	additional_info varchar NULL, -- 存储基本配置
	customer_id varchar(36) NULL, -- 所属客户
	"type" varchar(255) NULL, -- 插件类型
	"name" varchar(255) NULL, -- 插件名
	"label" varchar(255) NULL,
	search_text varchar(255) NULL,
	"extension" varchar(50) NULL, -- 插件( 目录名)
	protocol varchar(50) NULL,
	port varchar(50) NULL,
	publish varchar(255) NULL,
	subscribe varchar(255) NULL,
	username varchar(255) NULL,
	"password" varchar(255) NULL,
	"location" varchar(255) NULL, -- 设备位置
	d_id varchar(255) NULL, -- 设备唯一标志
	CONSTRAINT device_pkey PRIMARY KEY (id),
	CONSTRAINT device_fk FOREIGN KEY (asset_id) REFERENCES asset(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX device_token_idx ON public.device USING btree (token);
COMMENT ON TABLE public.device IS '设备';

-- Column comments

COMMENT ON COLUMN public.device.asset_id IS '资产id';
COMMENT ON COLUMN public.device."token" IS '安全key';
COMMENT ON COLUMN public.device.additional_info IS '存储基本配置';
COMMENT ON COLUMN public.device.customer_id IS '所属客户';
COMMENT ON COLUMN public.device."type" IS '插件类型';
COMMENT ON COLUMN public.device."name" IS '插件名';
COMMENT ON COLUMN public.device."extension" IS '插件( 目录名)';
COMMENT ON COLUMN public.device."location" IS '设备位置';
COMMENT ON COLUMN public.device.d_id IS '设备唯一标志';



CREATE TABLE device_model (
	id varchar(36) NOT NULL,
	model_name varchar(255) NULL,
	flag int NULL,
	chart_data json NULL,
	model_type int NULL,
	"describe" varchar(255) NULL,
	"version" varchar(36) NULL,
	author varchar(36) NULL,
	sort int NULL,
	issued int NULL,
	remark varchar(255) NULL
);

-- Column comments

COMMENT ON COLUMN public.device_model.model_name IS '插件名称';
COMMENT ON COLUMN public.device_model.model_type IS '插件类型';
COMMENT ON COLUMN public.device_model."describe" IS '描述';
COMMENT ON COLUMN public.device_model."version" IS '版本';
ALTER TABLE public.device_model ADD created_at int8 NULL;
ALTER TABLE public.device_model ADD CONSTRAINT device_model_pk PRIMARY KEY (id);
ALTER TABLE public.device_model ALTER COLUMN model_type TYPE varchar(36) USING model_type::varchar;


CREATE TABLE tp_dict (
	id varchar(36) NOT NULL,
	dict_code varchar(36) NULL,
	dict_value varchar(99) NULL,
	"describe" varchar(99) NULL,
	created_at int8 NULL,
	CONSTRAINT tp_dict_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_dict.dict_code IS '字典编码';
COMMENT ON COLUMN public.tp_dict.dict_value IS '值';
COMMENT ON COLUMN public.tp_dict."describe" IS '描述';

ALTER TABLE public.device DROP COLUMN "extension";
ALTER TABLE public.device ADD chart_option json NULL DEFAULT '{}';

COMMENT ON COLUMN public.device.chart_option IS '图表配置';


CREATE TABLE object_model (
	id varchar(36) NOT NULL,
	sort int4 NULL,
	object_describe varchar(255) NULL,
	object_name varchar(99) NOT NULL,
	object_type varchar(36) NOT NULL,
	object_data json NULL,
	created_at int8 NULL,
	remark varchar(255) NULL,
	CONSTRAINT object_model_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.object_model.object_name IS '物模型名称';
COMMENT ON COLUMN public.object_model.object_type IS '物模型类型';
COMMENT ON COLUMN public.object_model.object_data IS '物模型json';

ALTER TABLE public.device ADD device_type varchar(2) NOT NULL DEFAULT 1;
COMMENT ON COLUMN public.device.device_type IS '1-直连设备 2-网关设备 3-网关子设备';
ALTER TABLE public.device ADD parent_id varchar(36) NULL;
ALTER TABLE public.device ADD sub_protocol varchar(10) NULL;
COMMENT ON COLUMN public.device.sub_protocol IS 'modbus(TCP RTU)';
ALTER TABLE public.device ADD protocol_config json NULL DEFAULT '{}'::json;

CREATE TABLE public.tp_dashboard (
	id varchar(36) NOT NULL,
	relation_id varchar(36) NOT NULL,
	json_data json NULL DEFAULT '{}'::json,
	dashboard_name varchar(99) NULL,
	create_at int8 NULL,
	sort int NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_dashboard_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_dashboard.sort IS '排序';

-- init sql
--24小时分区
SELECT create_hypertable('ts_kv', 'ts',chunk_time_interval => 86400000000);

INSERT INTO "users" ("id", "created_at", "updated_at", "enabled", "additional_info", "authority", "customer_id", "email", "password", "name", "first_name", "last_name", "search_text", "email_verified_at", "remember_token", "mobile", "remark", "is_admin", "business_id", "wx_openid", "wx_unionid") VALUES

('9212e9fb-a89c-4e35-9509-0a15df64f45a',	1606099326,	1623490224,	'1',	NULL,	'SYS_ADMIN',	NULL,	'super@super.cn',	'$2a$04$aGFaew.rkRmOUiOZ/3ZncO/HN1BuJc8Dcm1MNuU3HhbUVUgKIx7jG',	'Admin',	NULL,	NULL,	NULL,	0,	NULL,	'18618000000',	NULL,	0,	'',	'',	'');

INSERT INTO logo
(id, system_name, theme, logo_one, logo_two, logo_three, custom_id, remark)
VALUES('1d625cec-bf5b-2ad1-b135-a23b5fad05bf', 'ThingsPanel', 'blue', './files/init-images/logo-one.svg', './files/init-images/logo-two.gif', './files/init-images/logo-three.png', '', '');
INSERT INTO tp_menu (id,menu_name,parent_id,remark) VALUES
	 ('1','homepage','0',NULL),
	 ('2','buisness','0',NULL),
	 ('3','dashboard','0',NULL),
	 ('4','automation','0',NULL),
	 ('5','alert_message','0',NULL),
	 ('6','system_log','0',NULL),
	 ('7','product_management','0',NULL),
	 ('9','data_management','0',NULL),
	 ('10','application_management','0',NULL),
	 ('11','user_management','0',NULL),
	 ('12','system_setup','0',NULL),
	 ('13','logs','6',NULL),
	 ('14','equipment_log','6',NULL),
	 ('15','firmware_upgrade','7',NULL),
	 ('8','data_switching','0',NULL);

ALTER TABLE public.tp_function ADD "path" varchar(255) NULL;
COMMENT ON COLUMN public.tp_function."path" IS '页面路径';
ALTER TABLE public.tp_function ADD name varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.name IS '页面名称';
ALTER TABLE public.tp_function ADD component varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.component IS '组件路径';
ALTER TABLE public.tp_function ADD title varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.title IS '页面标题';
ALTER TABLE public.tp_function ADD icon varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.icon IS '页面标题';
ALTER TABLE public.tp_function ADD "type" varchar(2) NULL;
COMMENT ON COLUMN public.tp_function."type" IS '类型0-目录 1-菜单 2-页面 3-按钮';
ALTER TABLE public.tp_function ADD function_code varchar(255) NULL;
COMMENT ON COLUMN public.tp_function.function_code IS '编码';
ALTER TABLE public.tp_function ADD parent_id varchar(36) NULL;

COMMENT ON COLUMN public.tp_function.icon IS '页面图表';
ALTER TABLE public.tp_function DROP CONSTRAINT tp_function_un;
ALTER TABLE public.tp_function ADD CONSTRAINT tp_function_pk PRIMARY KEY (id);
ALTER TABLE public.tp_function ADD sort int4 NULL;

INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('c17a3b9e-bd1f-2f10-4c65-d2ae7030087b', '', NULL, '/alarm/list', 'Alarm', '/pages/alarm/AlarmIndex.vue', 'COMMON.WARNINFO', 'flaticon2-warning', '1', '', '0', 950);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('a59eefbf-de02-a348-30af-d7f16053f884', '', NULL, '', 'system_log', '', 'COMMON.SYSTEMLOG', 'flaticon-open-box', '0', '', '0', 940);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('39936c5b-14fd-588f-60be-77f422aa2d32', '', NULL, '', 'ProductManagment', '', 'COMMON.PRODUCTMANAGEMENT', 'menu-icon flaticon2-list', '0', '', '0', 930);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('7c0c8fbb-6ba1-2323-511d-859c7923f954', '', NULL, '/log/list', 'LogList', '/pages/log/LogEquipmentIndex.vue', 'COMMON.OPERATIONLOG', 'flaticon2-paper', '1', '', 'a59eefbf-de02-a348-30af-d7f16053f884', 999);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('52a23456-775c-b731-7adf-a0fd3cddf649', '', NULL, '', 'BusinessAddButton', '', 'COMMON.NEWBUSINESS', '', '3', 'business:add', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 999);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('77d7133a-6434-bd51-232b-6b7fd862e50f', '', NULL, '', 'BusinessEdit', '', 'COMMON.EDITASSETSNAME', '', '3', 'business:edit', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 998);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('fd332720-1d06-9ba2-cf32-226cb2f54461', '', NULL, '', 'BusinessDel', '', 'COMMON.DELETE', '', '3', 'business:del', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 997);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b143ccd9-eb65-655a-a41f-4311da5ed8c0', '', NULL, '/equipment/index', 'Equipment', '/pages/equipment/EquipmentIndex.vue', 'COMMON.EQUIPMENTLOG', 'flaticon-interface-3', '1', '', 'a59eefbf-de02-a348-30af-d7f16053f884', 998);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('67b97839-919f-0976-2c79-c921adbec66e', '', NULL, '/strategy/alarmlist', 'AlarmStrategy', '/pages/automation/alarm/AlarmStrategy.vue', 'COMMON.ALARMSTRATEGY', '', '2', '', 'dce69d1d-8297-c5a4-1502-ace84dfe0209', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('8508677d-27ea-1158-c382-2bcf2b630346', '', NULL, '/strategy/strlist', 'ControlStrategy', '/pages/automation/control/ControlStrategy.vue', 'COMMON.CONTROLSTRATRGY', '', '2', '', 'dce69d1d-8297-c5a4-1502-ace84dfe0209', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('ec7a22ed-919d-7959-6737-145198f6172f', '', NULL, '/market', 'Market', '/pages/plugin/index.vue', 'COMMON.MARKET', 'flaticon2-supermarket', '1', '', '0', 910);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b4ad8251-ebdb-4c40-096a-eb74c59f7815', '', NULL, '', 'AddUser', '', 'COMMON.AddUSER', '', '3', 'sys:user:add', '2a1744d7-8440-c0a5-940a-9386ddfb1d0b', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('3f4348b0-f39d-ec42-14b4-623cbeadb12f', '', NULL, '/transpond/index', 'Transpond', '/pages/transpond/TranspondIndex.vue', 'COMMON.TRANSPOND', 'flaticon-upload-1', '1', '', '7cac14a0-0ff2-57d9-5465-597760bd2cb1', 998);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('3786391a-6e8f-659d-1500-d2c3f82d6933', '', NULL, '/system/index', 'SystemSetup', '/pages/system/index.vue', 'COMMON.SYSTEMSETUP', 'flaticon-upload-1', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 999);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('2a1744d7-8440-c0a5-940a-9386ddfb1d0b', '', NULL, '/users/user', 'User', '/pages/users/UserIndex.vue', 'COMMON.USERS', 'flaticon2-user', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 998);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('7ce628ae-d494-d71c-9eb0-148e6bf47665', '', NULL, '/management/index', 'Management', '/pages/management/index.vue', 'COMMON.MANAGEMENT', 'flaticon-upload-1', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 997);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('a53dba0c-3388-0f49-35f3-6e56ff9acc68', '', NULL, '', 'DeviceManagment', '', 'COMMON.DEVICE', '', '3', 'business:device', '83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', 996);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('6dab000b-7ced-a5ce-5fb0-5427f3bb8073', '', NULL, '/chart/list', 'ChartList', '/pages/chart/List.vue', 'COMMON.VISUALIZATION', 'flaticon2-laptop', '1', '', '0', 970);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('539b8e97-b791-3260-8b23-1beca9497b19', '', NULL, '', 'AddPermission', '', 'COMMON.PERMISSIONADD', '', '3', 'sys:permission:add', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('17f776f0-be0c-a216-a03a-00944865e8d7', '', NULL, '', 'EditPermission', '', 'COMMON.EDIT', '', '3', 'sys:permission:edit', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('4231ea2c-a2fb-bd9c-8966-c7d654289deb', '', NULL, '/permission/index', 'PermissionManagement', '/pages/system/permissions/Index.vue', 'COMMON.PERMISSIONMANAGEMENT', 'flaticon-upload-1', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 996);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('363116a3-1c00-b875-1386-415ea0839849', '', NULL, '/list/device', 'device', '/pages/device/DeviceIndex.vue', 'COMMON.DEVICE', '', '2', '', 'a53dba0c-3388-0f49-35f3-6e56ff9acc68', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b37757aa-3665-3d9d-994f-54e6ad37aff7', '', NULL, '', 'EditRole', '', 'COMMON.EDIT', '', '3', 'sys:role:edit', '7ce628ae-d494-d71c-9eb0-148e6bf47665', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b9d3b307-917d-1914-6acc-0c2494a7c69c', '', NULL, '/product/list', 'ProductList', '/pages/product/managment/index.vue', 'COMMON.PRODUCTLIST', 'menu-icon flaticon2-list', '1', '', '39936c5b-14fd-588f-60be-77f422aa2d32', 999);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('d8613453-278c-289c-6e18-ee58f6eb540b', '', NULL, '', 'DeletePermission', '', 'COMMON.DELETE', '', '3', 'sys:permission:del', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('1988db79-dcb6-f8e5-4984-90e131efa526', '', NULL, '', 'SearchPermission', '', 'COMMON.SEARCH', '', '3', 'sys:permission:search', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('a8ebb8af-adab-90fa-a553-49667370fc5f', '', NULL, '/access_engine/index', 'AccessEngine', '/pages/access-engine/AccessEngineIndex.vue', 'COMMON.NETWORKCOMPONENTS', 'flaticon-upload-1', '1', '', '7cac14a0-0ff2-57d9-5465-597760bd2cb1', 999);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('9c4d044d-19c4-1b6c-c9d3-4d78e01ecb58', '', NULL, '/editpassword', 'EditPassword', '/pages/users/EditPassword.vue', 'COMMON.CHANGEPASSWORD', '', '3', 'sys:user:editpassword', '2a1744d7-8440-c0a5-940a-9386ddfb1d0b', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('59b4f53f-2e55-dc2b-a643-4a7fa62291a8', '', NULL, '', 'DelUser', '', 'COMMON.DELETE', '', '3', 'sys:user:del', '2a1744d7-8440-c0a5-940a-9386ddfb1d0b', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('5938f5ba-5970-759a-04c9-3595fd637c10', '', NULL, '', 'DelRole', '', 'COMMON.DELETE', '', '3', 'sys:role:del', '7ce628ae-d494-d71c-9eb0-148e6bf47665', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('065e4a85-aa03-4f59-0b00-8a7df1b03d87', '', NULL, '', 'AssignPermission', '', 'COMMON.PERMISSIONMANAGEMENT', '', '3', 'sys:role:assign', '7ce628ae-d494-d71c-9eb0-148e6bf47665', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('4f2791e5-3c13-7249-c25f-77f6f787f574', '', NULL, '', 'SystemManagement', '', 'COMMON.SYSTEMMANAGEMENT', 'flaticon2-gear', '0', '', '0', 900);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('dce69d1d-8297-c5a4-1502-ace84dfe0209', '', NULL, '/strategy/list', 'StrategyList', '/pages/automation/AutomationIndex.vue', 'COMMON.AUTOMATION', 'flaticon2-hourglass', '1', '', '0', 960);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('8ab87ef0-2e7b-c161-0e6b-0f59840e747f', '', NULL, '/device/watch', 'DeviceWatch', '/pages/device-watch/index.vue', '设备监控', 'flaticon2-rhombus', '1', '', '0', 990);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('c7a4dbd4-3e40-7c48-819a-c4d447833dc3', '', NULL, '/visual/display', 'VisualDisplay', '/pages/visual/display/index.vue', 'COMMON.VISUALIZATIONSCREEN', '', '2', '', '6dab000b-7ced-a5ce-5fb0-5427f3bb8073', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b7c0d632-776b-c374-f1cb-e857215ede00', '', NULL, '/product/batch/list', 'BatchList', '/pages/product/managment/batch/index.vue', 'COMMON.BATCHLIST', '', '2', '', '39936c5b-14fd-588f-60be-77f422aa2d32', 998);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('7cac14a0-0ff2-57d9-5465-597760bd2cb1', '', NULL, '', 'RuleEngine', '', 'COMMON.RULEENGINE', 'flaticon2-gift-1', '0', '', '0', 920);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('83e18dcd-c6c8-eca2-2859-11dd6c6e7c6d', '', NULL, '/list', 'BusinessList', '/pages/business/BusinessIndex.vue', '设备管理', 'flaticon2-rhombus', '1', '', '0', 999);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('1bc93bad-41d3-ca37-638b-f79a29c1388b', '', NULL, '/data/index', 'Datas', '/pages/datas/DataIndex.vue', 'COMMON.DATAS', 'menu-icon flaticon2-list', '1', '', '0', 980);
-- INSERT INTO public.tp_function
-- (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
-- VALUES('2a7d5d94-62b5-c1c3-240b-cfeed8d92ec1', '', NULL, '/test123', 'Test123', '/pages/test123/index.vue', '设备地图', 'flaticon2-gear', '1', '', '0', 989);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('6455296b-bce4-bd6a-8047-3788ff95f107', '', NULL, '', 'DelDevicePlugin', '', '删除设备插件', '', '3', 'plugin:device:del', 'ec7a22ed-919d-7959-6737-145198f6172f', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('39da5b03-2560-fc4f-d8ca-10374a6655eb', '', NULL, '', 'DelDevice', '', '删除设备', '', '3', 'device:del', 'a53dba0c-3388-0f49-35f3-6e56ff9acc68', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('9805e606-1c3e-565f-1380-d05eb1aeb0a9', '', NULL, '/device/watch/device_detail', 'DeviceDetail', '/pages/device-watch/device-detail/index.vue', 'COMMON.DEVICE_CHART', '', '2', '', '8ab87ef0-2e7b-c161-0e6b-0f59840e747f', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('7c7ef553-5342-f38e-6c07-222290f1c32d', '', NULL, '', 'DelProtocolPlugin', '', '删除协议插件', '', '3', 'plugin:protocol:del', 'ec7a22ed-919d-7959-6737-145198f6172f', 990);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('8a2f3c67-0fe3-c18e-f17e-27b2b108e3c1', '', NULL, '', 'DelVisual', '', '删除可视化', '', '3', 'visual:del', '6dab000b-7ced-a5ce-5fb0-5427f3bb8073', 0);

INSERT INTO public.tp_role
(id, role_name, parent_id, role_describe)
VALUES('5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '系统管理员', '', '');

INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1391, 'g', 'super@super.cn', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '', '', '', '', '', '');

INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1651, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '52a23456-775c-b731-7adf-a0fd3cddf649', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1652, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '77d7133a-6434-bd51-232b-6b7fd862e50f', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1653, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'fd332720-1d06-9ba2-cf32-226cb2f54461', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1654, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'a53dba0c-3388-0f49-35f3-6e56ff9acc68', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1655, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '363116a3-1c00-b875-1386-415ea0839849', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1656, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '1bc93bad-41d3-ca37-638b-f79a29c1388b', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1657, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '6dab000b-7ced-a5ce-5fb0-5427f3bb8073', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1658, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'c41bc15c-17d0-89d2-8f7d-5d32d7f2fc64', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1659, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '9805e606-1c3e-565f-1380-d05eb1aeb0a9', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1660, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'dce69d1d-8297-c5a4-1502-ace84dfe0209', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1661, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '67b97839-919f-0976-2c79-c921adbec66e', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1662, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '8508677d-27ea-1158-c382-2bcf2b630346', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1663, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'c17a3b9e-bd1f-2f10-4c65-d2ae7030087b', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1664, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'a59eefbf-de02-a348-30af-d7f16053f884', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1665, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '7c0c8fbb-6ba1-2323-511d-859c7923f954', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1666, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'b143ccd9-eb65-655a-a41f-4311da5ed8c0', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1667, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '7cac14a0-0ff2-57d9-5465-597760bd2cb1', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1668, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'a8ebb8af-adab-90fa-a553-49667370fc5f', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1669, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '3f4348b0-f39d-ec42-14b4-623cbeadb12f', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1670, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'ec7a22ed-919d-7959-6737-145198f6172f', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1671, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '4f2791e5-3c13-7249-c25f-77f6f787f574', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1672, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '3786391a-6e8f-659d-1500-d2c3f82d6933', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1673, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '2a1744d7-8440-c0a5-940a-9386ddfb1d0b', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1674, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '7ce628ae-d494-d71c-9eb0-148e6bf47665', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1675, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'b37757aa-3665-3d9d-994f-54e6ad37aff7', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1676, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '5938f5ba-5970-759a-04c9-3595fd637c10', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1677, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '065e4a85-aa03-4f59-0b00-8a7df1b03d87', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1678, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '4231ea2c-a2fb-bd9c-8966-c7d654289deb', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1679, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '1988db79-dcb6-f8e5-4984-90e131efa526', 'allow', '', '', '', '', '');


INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('643f254a-0ac2-2616-c730-32c60dac7117', 'other_type', '1', '', 1663225360);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('fd55cc73-427e-7dfc-121e-1e4f73b55e65', 'chart_type', '1', '传感器', 1663226829);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('05fecef3-a1b1-4041-decf-59230f304fce', 'chart_type', '2', '控制器', 1663226845);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('9d855e7b-c949-034f-4b96-f18ac03e0eb6', 'chart_type', '3', '照明', 1663226870);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('c8bdaf38-d4da-5d29-4bf6-7e47ba497c88', 'chart_type', '4', '电力', 1663226875);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('e197fbb7-b3b6-f33d-7c63-6d9fb1d60876', 'chart_type', '5', '摄像头', 1663226918);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('4257cff7-ddf4-9977-a3ad-48630f5dc614', 'chart_type', '6', '其他', 1663226925);

INSERT INTO public.device_model
(id, model_name, flag, chart_data, model_type, "describe", "version", author, sort, issued, remark, created_at)
VALUES('49e25564-d0f5-6926-fae7-4d58726248c3', '开关', 0, '{"info":{"pluginName":"开关","pluginCategory":"2","author":"thingspanel","version":"v1.0.0","description":"设备字段：switch（int 1-开 0-关）；别名：开关"},"tsl":{"properties":[{"dataType":"integer","dataRange":"0-999","stepLength":0.1,"unit":"-","title":"开关","name":"switch"}],"option":{"classify":"custom","catValue":"relay"}},"chart":[{"componentName":"单控开关","type":"switch","series":[{"type":"switch","value":false,"id":1,"mapping":{"value":"switch","on":"1","off":"0","attr":{"dataType":"integer","dataRange":"0-999","stepLength":0.1,"unit":"-","title":"开关","name":"switch"}}}],"disabled":false,"name":"开关","controlType":"control","id":"QruyPTrD0AeN"}],"publish":{"isPub":false}}'::json, '2', '', 'v1.0.0', 'thingspanel', 0, 0, '', 1671700085);
INSERT INTO public.device_model
(id, model_name, flag, chart_data, model_type, "describe", "version", author, sort, issued, remark, created_at)
VALUES('5867753e-cb2d-32dc-a76d-7942d7ebcffc', '温湿度传感器', 0, '{"info":{"pluginName":"温湿度传感器","pluginCategory":"1","author":"thingspanel","version":"v1.0.0","description":"标准温湿度传感器"},"tsl":{"properties":[{"dataType":"float","dataRange":"0-999","stepLength":0.1,"unit":"%rh","name":"humidity","title":"湿度"},{"dataType":"float","dataRange":"0-999","stepLength":0.1,"unit":"℃","name":"temperature","title":"温度"}],"option":{"classify":"custom","catValue":"ambient_sensor"}},"chart":[{"series":[{"type":"gauge","progress":{"show":true,"width":18},"axisLine":{"lineStyle":{"width":2}},"axisTick":{"show":false},"splitLine":{"show":false,"length":5,"lineStyle":{"width":2,"color":"#999"}},"axisLabel":{"distance":10,"color":"#fff","fontSize":14},"anchor":{"show":true,"showAbove":true,"size":25,"itemStyle":{"borderWidth":10}},"title":{"show":false},"detail":{"fontSize":30,"offsetCenter":[0,"70%"],"color":"#fff"},"data":[{"value":0,"name":""}]}],"simulator":{"funcArr":["return +(Math.random() * 60).toFixed(2);"],"interval":5000},"name":"当前温度","mapping":["temperature"],"controlType":"dashboard","style":{"backgroundColor":"#2d3d86","opacity":1},"id":"bHEwRZGNTTYk"},{"series":[{"type":"gauge","progress":{"show":true,"width":18},"axisLine":{"lineStyle":{"width":2}},"axisTick":{"show":false},"splitLine":{"show":false,"length":5,"lineStyle":{"width":2,"color":"#999"}},"axisLabel":{"distance":10,"color":"#fff","fontSize":14},"anchor":{"show":true,"showAbove":true,"size":25,"itemStyle":{"borderWidth":10}},"title":{"show":false},"detail":{"fontSize":30,"offsetCenter":[0,"70%"],"color":"#fff"},"data":[{"value":0,"name":""}]}],"simulator":{"funcArr":["return +(Math.random() * 60).toFixed(2);"],"interval":5000},"name":"当前湿度","mapping":["humidity"],"controlType":"dashboard","style":{"backgroundColor":"#2d3d86","opacity":1},"id":"ap4aakzNhLEa"},{"xAxis":{"type":"category","axisLine":{"lineStyle":{"color":"#fff"}},"data":[""]},"yAxis":{"type":"value","axisLine":{"lineStyle":{"color":"#fff"}}},"series":[{"data":[0],"type":"line"}],"name":"温湿度历史数据","mapping":["humidity","temperature"],"controlType":"history","id":"qm9DsAYTktbN"}],"publish":{"isPub":false}}'::json, '1', '', 'v1.0.0', 'thingspanel', 0, 0, '', 1665748873);


ALTER TABLE public.device ADD sub_device_addr varchar(36) NULL;
COMMENT ON COLUMN public.device.sub_device_addr IS '子设备地址';

INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('341efc2c-7704-7795-a53c-ecec34534832', 'GATEWAY_PROTOCOL', 'MQTT', 'MQTT协议', 1665998514);

CREATE TABLE public.tp_script (
	id varchar(36) NOT NULL,
	protocol_type varchar(99) NULL,
	script_name varchar(99) NULL,
	company varchar(99) NULL,
	product_name varchar(99) NULL,
	script_content text NULL,
	created_at int8 NULL,
	script_type varchar(99) NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_script_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_script.protocol_type IS '协议类型';
COMMENT ON COLUMN public.tp_script.script_name IS '脚本名称';
COMMENT ON COLUMN public.tp_script.company IS '公司';
COMMENT ON COLUMN public.tp_script.product_name IS '产品名称';
COMMENT ON COLUMN public.tp_script.script_content IS '下行脚本';
COMMENT ON COLUMN public.tp_script.created_at IS '创建时间';
COMMENT ON COLUMN public.tp_script.script_type IS '脚本类型';
ALTER TABLE public.tp_script ALTER COLUMN script_type SET DEFAULT 'javascript';
ALTER TABLE public.tp_script ADD script_content_b text NULL;
COMMENT ON COLUMN public.tp_script.script_content_b IS '上行脚本';
ALTER TABLE public.tp_script RENAME COLUMN script_content TO script_content_a;

ALTER TABLE public.device ADD script_id varchar(36) NULL;
COMMENT ON COLUMN public.device.script_id IS '脚本id';

CREATE TABLE public.tp_product (
	id varchar(36) NOT NULL,
	name varchar(99) NOT NULL,
	serial_number varchar(99) NOT NULL,
	protocol_type varchar(36) NOT NULL,
	auth_type varchar(36) NOT NULL,
	plugin json NOT NULL DEFAULT '{}'::json,
	"describe" varchar(255) NULL,
	created_time int8 NULL,
	remark varchar(255) NULL,
	CONSTRAINT t_product_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_product."name" IS '产品名称';
COMMENT ON COLUMN public.tp_product.serial_number IS '产品编号';
COMMENT ON COLUMN public.tp_product.protocol_type IS '协议类型';
COMMENT ON COLUMN public.tp_product.auth_type IS '认证方式';
COMMENT ON COLUMN public.tp_product.plugin IS '插件';
COMMENT ON COLUMN public.tp_product."describe" IS '描述';
COMMENT ON COLUMN public.tp_product.created_time IS '创建时间';

CREATE TABLE public.tp_batch (
	id varchar(36) NOT NULL,
	batch_number varchar(36) NOT NULL,
	product_id varchar(36) NOT NULL,
	device_number int NOT NULL,
	generate_flag varchar NOT NULL DEFAULT 0,
	"describe" varchar(255) NULL,
	created_time int8 NULL,
	remark varchar(255) NULL,
	CONSTRAINT t_batch_pk PRIMARY KEY (id),
	CONSTRAINT t_batch_un UNIQUE (batch_number,product_id),
	CONSTRAINT t_batch_fk FOREIGN KEY (product_id) REFERENCES public.tp_product(id) ON DELETE RESTRICT
);

-- Column comments

COMMENT ON COLUMN public.tp_batch.batch_number IS '批次编号';
COMMENT ON COLUMN public.tp_batch.product_id IS '产品id';
COMMENT ON COLUMN public.tp_batch.device_number IS '设备数量';
COMMENT ON COLUMN public.tp_batch.generate_flag IS '0-未生成 1-已生成';

CREATE TABLE public.tp_generate_device (
	id varchar(36) NOT NULL,
	batch_id varchar(36) NOT NULL,
	"token" varchar(36) NOT NULL,
	"password" varchar(36) NULL,
	activate_flag varchar(36) NOT NULL DEFAULT 0,
	activate_date varchar(36) NULL,
	device_id varchar(36) NULL,
	created_time int8 NULL,
	remark varchar(255) NULL,
	CONSTRAINT t_generate_device_pk PRIMARY KEY (id),
	CONSTRAINT t_generate_device_fk FOREIGN KEY (batch_id) REFERENCES public.tp_batch(id) ON DELETE CASCADE
);

-- Column comments

COMMENT ON COLUMN public.tp_generate_device.activate_flag IS '0-未激活 1-已激活';
COMMENT ON COLUMN public.tp_generate_device.activate_date IS '激活日期';

ALTER TABLE public.tp_batch ADD access_address varchar(36) NULL;
COMMENT ON COLUMN public.tp_batch.access_address IS '接入地址';

ALTER TABLE public.tp_product ADD device_model_id varchar(36) NULL;
COMMENT ON COLUMN public.tp_product.device_model_id IS '插件id';

CREATE TABLE public.tp_protocol_plugin (
	id varchar(36) NOT NULL,
	"name" varchar(99) NOT NULL,
	protocol_type varchar(36) NOT NULL,
	access_address varchar(255) NOT NULL,
	http_address varchar(255) NULL,
	sub_topic_prefix varchar(99) NULL,
	created_at int8 NULL,
	description varchar(255) NULL,
	CONSTRAINT tp_protocol_plugin_pk PRIMARY KEY (id)
);

-- Column comments
ALTER TABLE public.tp_protocol_plugin ADD device_type varchar(36) NULL;
COMMENT ON COLUMN public.tp_protocol_plugin.device_type IS '设备类型1-设备 2-网关';

COMMENT ON COLUMN public.tp_protocol_plugin.sub_topic_prefix IS '订阅主题前缀';
ALTER TABLE public.tp_protocol_plugin ADD CONSTRAINT tp_protocol_plugin_un UNIQUE (protocol_type,device_type);



INSERT INTO public.tp_protocol_plugin
(id, "name", protocol_type, access_address, http_address, sub_topic_prefix, created_at, description, device_type)
VALUES('c8a13166-e010-24e4-0565-e87feea162bb', 'MODBUS_TCP协议', 'MODBUS_TCP', '服务ip:502', '127.0.0.1:503', 'plugin/modbus/', 1668759820, '请参考文档对接设备,(应用管理->接入协议)docker部署将http服务器地址的ip改为172.19.0.8', '2');
INSERT INTO public.tp_protocol_plugin
(id, "name", protocol_type, access_address, http_address, sub_topic_prefix, created_at, description, device_type)
VALUES('2a95000c-9c29-7aae-58b0-5202daf1546a', 'MODBUS_RTU协议', 'MODBUS_RTU', '服务ip:502', '127.0.0.1:503', 'plugin/modbus/', 1668759841, '请参考文档对接设备,(应用管理->接入协议)docker部署将http服务器地址的ip改为172.19.0.8', '2');



-- 0.4.5
ALTER TABLE public.tp_dict ADD CONSTRAINT tp_dict_un UNIQUE (dict_code,dict_value);
ALTER TABLE public.ts_kv_latest ADD CONSTRAINT ts_kv_latest_fk FOREIGN KEY (entity_id) REFERENCES public.device(id) ON DELETE CASCADE;
ALTER TABLE public.conditions_log ADD CONSTRAINT conditions_log_fk FOREIGN KEY (device_id) REFERENCES public.device(id);
ALTER TABLE public.tp_function ADD CONSTRAINT tp_function_fk FOREIGN KEY (menu_id) REFERENCES public.tp_menu(id);

INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('19cd0e88-fe7b-a225-a0d6-77bd73757821', 'DRIECT_ATTACHED_PROTOCOL', 'mqtt', 'MQTT协议', 1669281205);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('8881ffe7-7c2b-43c2-13f3-7227dafa46ba', 'DRIECT_ATTACHED_PROTOCOL', 'video_address', '视频地址接入', 1669281289);
ALTER TABLE public.device ADD created_at int8 NULL;


ALTER TABLE public.tp_script ADD device_type varchar(36) NOT NULL DEFAULT 1;
COMMENT ON COLUMN public.tp_script.device_type IS '设备类型';

ALTER TABLE public.conditions_log DROP CONSTRAINT conditions_log_fk;
ALTER TABLE public.conditions_log ADD CONSTRAINT conditions_log_fk FOREIGN KEY (device_id) REFERENCES public.device(id) ON DELETE CASCADE;

ALTER TABLE public.tp_dashboard ALTER COLUMN relation_id DROP NOT NULL;

INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('8881ffe7-7c2b-43c2-13f3-7227dafa46bv', 'GATEWAY_PROTOCOL', 'MODBUS_TCP', 'MODBUS_TCP协议', 1669281289);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('8881ffe7-7c2b-43c2-13f3-7227dafa46bs', 'GATEWAY_PROTOCOL', 'MODBUS_RTU', 'MODBUS_RTU协议', 1669281289);

INSERT INTO public.tp_protocol_plugin
(id, "name", protocol_type, access_address, http_address, sub_topic_prefix, created_at, description, device_type)
VALUES('de497b74-1bb6-2fc8-237b-75199304ba78', '自定义TCP协议', 'raw-tcp', '服务ip:7654', '127.0.0.1:8098', 'plugin/tcp/', 1670812659, 'docker部署不包含tcp协议插件服务,可根据文档自行部署', '2');
INSERT INTO public.tp_protocol_plugin
(id, "name", protocol_type, access_address, http_address, sub_topic_prefix, created_at, description, device_type)
VALUES('aea3b83a-284d-5738-6d0f-94fc73220c33', '官方TCP协议', 'tcp', '服务ip:7653', '127.0.0.1:8000', 'plugin/tcp/', 1670813735, 'docker部署不包含tcp协议插件服务,可根据文档自行部署', '1');
INSERT INTO public.tp_protocol_plugin
(id, "name", protocol_type, access_address, http_address, sub_topic_prefix, created_at, description, device_type)
VALUES('95b7c0b6-5c5b-4b45-c9ea-5bebda5a48ec', '官方TCP协议', 'tcp', '服务ip:7653', '127.0.0.1:8000', 'plugin/tcp/', 1670813749, 'docker部署不包含tcp协议插件服务,可根据文档自行部署', '2');
INSERT INTO public.tp_protocol_plugin
(id, "name", protocol_type, access_address, http_address, sub_topic_prefix, created_at, description, device_type)
VALUES('95c957bc-a53b-6445-e882-1973bb546b12', '自定义TCP协议', 'raw-tcp', '服务ip:7654', '127.0.0.1:8098', 'plugin/tcp/', 1670809899, 'docker部署不包含tcp协议插件服务,可根据文档自行部署', '1');

INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('fad00d07-63c7-2685-1ee7-3e92d0142c88', 'DRIECT_ATTACHED_PROTOCOL', 'raw-tcp', '自定义TCP协议', 1670809899);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('9663bb03-4881-1965-5cf5-17341a4db761', 'GATEWAY_PROTOCOL', 'raw-tcp', '自定义TCP协议', 1670812659);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('b9249215-09a2-0298-02c2-0d9085fc40d2', 'DRIECT_ATTACHED_PROTOCOL', 'tcp', '官方TCP协议', 1670813735);
INSERT INTO public.tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('25074e80-b7ca-99a3-e1f7-2fec7ec31b24', 'GATEWAY_PROTOCOL', 'tcp', '官方TCP协议', 1670813749);

CREATE INDEX operation_log_created_at_idx ON public.operation_log (created_at DESC);
CREATE INDEX ts_kv_entity_id_idx ON public.ts_kv (entity_id,ts DESC);

--v0.4.6
ALTER TABLE public.logo DROP COLUMN custom_id;
ALTER TABLE public.logo ADD home_background varchar(255) NULL;
COMMENT ON COLUMN public.logo.home_background IS '首页背景';

ALTER TABLE public.tp_protocol_plugin ADD additional_info varchar(1000) NULL;
COMMENT ON COLUMN public.tp_protocol_plugin.additional_info IS '附加信息';


INSERT INTO tp_dict
(id, dict_code, dict_value, "describe", created_at)
VALUES('9aa72824-e26b-2723-426a-ec8bcff091e9', 'GATEWAY_PROTOCOL', 'WVP_01', 'GB28181', 1673933847);

INSERT INTO tp_protocol_plugin
(id, "name", protocol_type, access_address, http_address, sub_topic_prefix, created_at, description, device_type, additional_info)
VALUES('1cd08053-f08a-8bda-2c22-c0b2582ce0b4', 'GB28181', 'WVP_01', '127.0.0.1:18080', 'http://127.0.0.1:18080||admin||admin', '-', 1673933847, '使用GB28181协议需要自行搭建wvp服务，然后按照http服务器地址样例修改（地址供平台后端调用）；协议类型必须以WVP_开头', '2', '[{"key":"域名称","value":""},{"key":"连接地址","value":""},{"key":"端口","value":""},{"key":"密码","value":""}]');

INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('2a7d5d94-62b5-c1c3-240b-cfeed8d92ec1', '', NULL, '/test123', 'Test123', '/pages/test123/index.vue', 'MENU.DEVICE_MAP', 'flaticon2-gear', '1', '', '0', 989);

UPDATE tp_function
SET function_name='', menu_id=NULL, "path"='/device_map', "name"='DeviceMap', component='/pages/device-map/index.vue', title='MENU.DEVICE_MAP', icon='flaticon2-gear', "type"='1', function_code='', parent_id='0', sort=989
WHERE id='2a7d5d94-62b5-c1c3-240b-cfeed8d92ec1';

--v0.4.7
CREATE TABLE public.tp_automation (
	id varchar(36) NOT NULL,
	tenant_id varchar(36) NULL,
	automation_name varchar(99) NOT NULL,
	automation_described varchar(999) NULL,
	update_time int8 NULL,
	created_at int8 NOT NULL,
	created_by varchar(36) NULL,
	priority int NULL DEFAULT 50,
	enabled varchar(1) NOT NULL DEFAULT 0,
	remark varchar(255) NULL,
	CONSTRAINT tp_automation_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_automation.automation_name IS '自动化名称';
COMMENT ON COLUMN public.tp_automation.automation_described IS '自动化描述';
COMMENT ON COLUMN public.tp_automation.priority IS '优先级';
COMMENT ON COLUMN public.tp_automation.enabled IS '启用状态0-未开启 1-已开启';

CREATE TABLE public.tp_automation_condition (
	id varchar(36) NOT NULL,
	automation_id varchar(36) NOT NULL,
	group_number int NULL,
	condition_type varchar(2) NOT NULL,
	device_id varchar(36) NULL,
	time_condition_type varchar(2) NULL,
	device_condition_type varchar(2) NULL,
	v1 varchar(99) NULL,
	v2 varchar(99) NULL,
	v3 varchar(99) NULL,
	v4 varchar(99) NULL,
	v5 varchar(99) NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_automation_condition_pk PRIMARY KEY (id),
	CONSTRAINT tp_automation_condition_fk FOREIGN KEY (automation_id) REFERENCES public.tp_automation(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT tp_automation_condition_fk_1 FOREIGN KEY (device_id) REFERENCES public.device(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Column comments

COMMENT ON COLUMN public.tp_automation_condition.group_number IS '小组编号';
COMMENT ON COLUMN public.tp_automation_condition.condition_type IS '条件类型1-设备条件 2-时间条件';
COMMENT ON COLUMN public.tp_automation_condition.time_condition_type IS '时间条件类型0-时间范围 1-单次 2-重复';
COMMENT ON COLUMN public.tp_automation_condition.device_condition_type IS '设备条件类型';

CREATE TABLE public.tp_automation_action (
	id varchar(36) NOT NULL,
	automation_id varchar(36) NOT NULL,
	action_type varchar(2) NOT NULL,
	device_id varchar(36) NULL,
	warning_strategy_id varchar(36) NULL,
	scenario_strategy_id varchar(36) NULL,
	additional_info varchar(999) NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_automation_action_pk PRIMARY KEY (id),
	CONSTRAINT tp_automation_action_fk FOREIGN KEY (automation_id) REFERENCES public.tp_automation(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Column comments

COMMENT ON COLUMN public.tp_automation_action.action_type IS '动作类型1-设备输出 2-触发告警 3-激活场景';
COMMENT ON COLUMN public.tp_automation_action.additional_info IS '附加信息device_model1-设定属性 2-调动服务;instruct指令';

CREATE TABLE public.tp_warning_strategy (
	id varchar(36) NOT NULL,
	warning_strategy_name varchar(99) NOT NULL,
	warning_level varchar(2) NOT NULL,
	repeat_count int NULL,
	trigger_count int NULL,
	inform_way varchar(99) NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_warning_strategy_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_warning_strategy.warning_level IS '告警级别';
COMMENT ON COLUMN public.tp_warning_strategy.repeat_count IS '重复次数';
COMMENT ON COLUMN public.tp_warning_strategy.trigger_count IS '已触发次数';
COMMENT ON COLUMN public.tp_warning_strategy.inform_way IS '通知方式';

CREATE TABLE public.tp_scenario_strategy (
	id varchar(36) NOT NULL,
	tenant_id varchar(36) NULL,
	scenario_name varchar(99) NOT NULL,
	scenario_description varchar(999) NULL,
	created_at int8 NOT NULL,
	created_by varchar(36) NULL,
	update_time int8 NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_scenario_strategy_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_scenario_strategy.scenario_name IS '场景名称';
COMMENT ON COLUMN public.tp_scenario_strategy.scenario_description IS '场景描述';

CREATE TABLE public.tp_scenario_action (
	id varchar(36) NOT NULL,
	scenario_strategy_id varchar(36) NOT NULL,
	action_type varchar(2) NOT NULL DEFAULT 1,
	device_id varchar(36) NULL,
	device_model varchar(2) NULL,
	instruct varchar(999) NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_scenario_action_pk PRIMARY KEY (id),
	CONSTRAINT tp_scenario_action_fk FOREIGN KEY (scenario_strategy_id) REFERENCES public.tp_scenario_strategy(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT tp_scenario_action_fk_1 FOREIGN KEY (device_id) REFERENCES public.device(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Column comments

COMMENT ON COLUMN public.tp_scenario_action.action_type IS '动作类型 1-设备输出';
COMMENT ON COLUMN public.tp_scenario_action.device_model IS '模型类型1-设定属性 2-调动服务';
COMMENT ON COLUMN public.tp_scenario_action.instruct IS '指令';

CREATE TABLE public.tp_automation_log (
	id varchar(36) NOT NULL,
	automation_id varchar(36) NOT NULL,
	trigger_time int8 NULL,
	process_description varchar(999) NULL,
	process_result varchar(2) NULL, -- 执行状态 1-成功 2-失败
	remark varchar(255) NULL,
	CONSTRAINT tp_automation_log_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_automation_log.process_result IS '执行状态 1-成功 2-失败';


-- public.tp_automation_log foreign keys

ALTER TABLE public.tp_automation_log ADD CONSTRAINT tp_automation_log_fk FOREIGN KEY (automation_id) REFERENCES public.tp_automation(id) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE public.tp_automation_log_detail (
	id varchar(36) NOT NULL,
	automation_log_id varchar(36) NOT NULL,
	action_type varchar(2) NULL,
	process_description varchar(999) NULL,
	process_result varchar(2) NULL,
	remark varchar(255) NULL,
	target_id varchar(36) NULL,
	CONSTRAINT automation_log_detail_pk PRIMARY KEY (id),
	CONSTRAINT automation_log_detail_fk FOREIGN KEY (automation_log_id) REFERENCES public.tp_automation_log(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Column comments

COMMENT ON COLUMN public.tp_automation_log_detail.action_type IS '动作类型 1-设备输出 2-触发告警 3-激活场景';
COMMENT ON COLUMN public.tp_automation_log_detail.process_result IS '执行状态 1-成功 2-失败';
COMMENT ON COLUMN public.tp_automation_log_detail.target_id IS '设备id|告警id|场景id';

CREATE TABLE public.tp_warning_information (
	id varchar(36) NOT NULL,
	tenant_id varchar(36) NULL,
	warning_name varchar(99) NOT NULL,
	warning_level varchar(2) NULL,
	warning_description varchar(99) NULL,
	warning_content varchar(999) NULL,
	processing_result varchar(1) NULL,
	processing_instructions varchar(255) NULL,
	processing_time varchar(50) NULL,
	processing_people_id varchar(36) NULL,
	created_at int8 NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_warning_information_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_warning_information.warning_level IS '告警级别';
COMMENT ON COLUMN public.tp_warning_information.warning_description IS '告警描述';
COMMENT ON COLUMN public.tp_warning_information.warning_content IS '告警内容';
COMMENT ON COLUMN public.tp_warning_information.processing_result IS '处理结果 0-未处理 1-已处理 2-已忽略';
COMMENT ON COLUMN public.tp_warning_information.processing_instructions IS '处理说明';
COMMENT ON COLUMN public.tp_warning_information.processing_time IS '处理时间';
COMMENT ON COLUMN public.tp_warning_information.processing_people_id IS '处理人';
COMMENT ON COLUMN public.tp_warning_information.remark IS '备注';

CREATE TABLE public.tp_scenario_log (
	id varchar(36) NOT NULL,
	scenario_strategy_id varchar(36) NOT NULL,
	process_description varchar(99) NULL,
	trigger_time varchar(99) NULL,
	process_result varchar(2) NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_scenario_log_pk PRIMARY KEY (id),
	CONSTRAINT tp_scenario_log_fk FOREIGN KEY (scenario_strategy_id) REFERENCES public.tp_scenario_strategy(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Column comments

COMMENT ON COLUMN public.tp_scenario_log.process_description IS '过程描述';
COMMENT ON COLUMN public.tp_scenario_log.process_result IS '执行状态 1-成功 2-失败';

ALTER TABLE public.tp_automation_log ALTER COLUMN trigger_time TYPE varchar(99) USING trigger_time::varchar;

CREATE TABLE public.tp_scenario_log_detail (
	id varchar(36) NOT NULL,
	scenario_log_id varchar(36) NOT NULL,
	action_type varchar(2) NULL,
	process_description varchar(99) NULL,
	process_result varchar(1) NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_scenario_log_detail_pk PRIMARY KEY (id),
	CONSTRAINT tp_scenario_log_detail_fk FOREIGN KEY (scenario_log_id) REFERENCES public.tp_scenario_log(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Column comments

COMMENT ON COLUMN public.tp_scenario_log_detail.action_type IS '动作类型 1-设备输出';
COMMENT ON COLUMN public.tp_scenario_log_detail.process_result IS '执行状态 1-成功 2-失败';

ALTER TABLE public.tp_scenario_log_detail ADD target_id varchar(36) NULL;
COMMENT ON COLUMN public.tp_scenario_log_detail.target_id IS '设备id|告警id';

ALTER TABLE public.tp_warning_strategy ADD warning_description varchar(999) NULL;
COMMENT ON COLUMN public.tp_warning_strategy.warning_description IS '告警描述';

ALTER TABLE public.tp_automation_action ADD CONSTRAINT tp_automation_action_ss_fk FOREIGN KEY (scenario_strategy_id) REFERENCES public.tp_scenario_strategy(id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE public.tp_automation_action ADD CONSTRAINT tp_automation_action_d_fk FOREIGN KEY (device_id) REFERENCES public.device(id) ON DELETE RESTRICT ON UPDATE CASCADE;

delete from public.tp_function where id in ('67b97839-919f-0976-2c79-c921adbec66e','dce69d1d-8297-c5a4-1502-ace84dfe0209','8508677d-27ea-1158-c382-2bcf2b630346');
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b29d5b40-b635-e34d-ee5f-5cf161348a62', '', NULL, '', 'Automation', '', '自动化', 'flaticon2-hourglass', '0', '', '0', 960);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('dce69d1d-8297-c5a4-1502-ace84dfe0209', '', NULL, '/strategy/list', 'StrategyList', '/pages/automation/control/ControlStrategy.vue', '场景联动', 'flaticon2-hourglass', '1', '', 'b29d5b40-b635-e34d-ee5f-5cf161348a62', 960);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('2649ac04-2935-0bb1-8a18-1278b9682a5d', '', NULL, '/strategy/scenelist', 'Scene', '/pages/automation/scene/index.vue', '场景管理', 'flaticon-upload-1', '1', 'strategy:scene:list', 'b29d5b40-b635-e34d-ee5f-5cf161348a62', 950);

delete from public.casbin_rule where id in (1661,1662);
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1661, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', 'b29d5b40-b635-e34d-ee5f-5cf161348a62', 'allow', '', '', '', '', '');
INSERT INTO public.casbin_rule
(id, ptype, v0, v1, v2, v3, v4, v5, v6, v7)
VALUES(1662, 'p', '5b0969cb-ed0b-c664-1fab-d0ba90c39e04', '2649ac04-2935-0bb1-8a18-1278b9682a5d', 'allow', '', '', '', '', '');

-- v0.4.8
ALTER TABLE public.tp_generate_device ADD device_code varchar(99) NULL;
COMMENT ON COLUMN public.tp_generate_device.device_code IS '设备编码';

CREATE TABLE public.tp_ota (
	id varchar(36) NOT NULL,
	package_name varchar(100) NOT NULL,
	package_version varchar(20) NOT NULL,
	package_module varchar(50) NULL,
	product_id varchar(36) NOT NULL,
	signature_algorithm varchar(50) NOT NULL,
	package_url varchar(255) NULL,
	description varchar(255) NULL,
	additional_info varchar(500) NULL,
	created_at int8 NOT NULL,
	remark varchar(255) NULL,
	CONSTRAINT tp_ota_pk PRIMARY KEY (id),
	CONSTRAINT tp_ota_fk FOREIGN KEY (product_id) REFERENCES public.tp_product(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Column comments


CREATE TABLE tp_ota_task (
  id VARCHAR(36) PRIMARY KEY,
  task_name VARCHAR(100) NOT NULL,
  upgrade_time_type VARCHAR(1) NOT NULL,
  start_time VARCHAR(50),
  end_time VARCHAR(50),
  device_count int NOT NULL,
  task_status  VARCHAR(1) NOT NULL,
  description VARCHAR(500),
  created_at int8 NOT NULL,
  remark  VARCHAR(255)
);


CREATE TABLE tp_ota_device (
    id VARCHAR(36) PRIMARY KEY,
    device_id  VARCHAR(36)  NOT NULL,
    current_version  VARCHAR(50)  ,
    target_version VARCHAR(50)  NOT NULL,
    upgrade_progress  VARCHAR(10)  ,
    status_update_time  VARCHAR(50) ,
    upgrade_status  VARCHAR(50) ,
    status_detail  VARCHAR(255)  ,
	remark  VARCHAR(255)  
);



ALTER TABLE public.tp_ota_task ADD ota_id varchar(36) NOT NULL;
ALTER TABLE public.tp_ota_task ADD CONSTRAINT tp_ota_task_fk FOREIGN KEY (ota_id) REFERENCES public.tp_ota(id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE public.device ADD product_id varchar(36) NULL;

ALTER TABLE public.tp_ota_device ADD ota_task_id varchar(36) NOT NULL;
COMMENT ON COLUMN public.tp_ota_device.ota_task_id IS '任务id';

ALTER TABLE public.tp_ota ADD sign varchar(99) NULL;



ALTER TABLE public.device ADD current_version varchar(99) NULL;
COMMENT ON COLUMN public.device.current_version IS '当前固件版本号';
ALTER TABLE public.tp_ota ADD file_size varchar(20) NULL;
COMMENT ON COLUMN public.tp_ota.file_size IS '文件大小';

INSERT INTO public.tp_function
(id, function_name, menu_id, "path", name, component, title, icon, "type", function_code, parent_id, sort)
VALUES('1f72f372-20fc-3f56-9ae7-1227739e11e8', '', NULL, '/product/batch/pre-registration', 'PreRegistration', '/pages/product/managment/batch/pre-registration/index.vue', '预注册管理', '', '2', '', '39936c5b-14fd-588f-60be-77f422aa2d32', 9);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('2a06205c-1df2-1d7b-cdaf-236e62d53a62', '', NULL, '/product/ota', 'OTA', '/pages/product/firmware', 'MENU.FIRMWAREUPGRADE', 'menu-icon flaticon2-list', '1', '', '39936c5b-14fd-588f-60be-77f422aa2d32', 987);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('86587a5e-5941-0773-566e-4d31973532b2', '', NULL, '/product/ota/task/list', 'OTATask', '/pages/product/firmware/task', '任务列表', '', '2', '', '39936c5b-14fd-588f-60be-77f422aa2d32', 0);
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('1c90da46-9fc0-32b5-360d-e98ecb33cf0b', '', NULL, '/product/ota/task_detail', 'TaskDetail', '/pages/product/firmware/task/TaskDetail.vue', '任务详情', '', '2', '', '39936c5b-14fd-588f-60be-77f422aa2d32', 0);
DELETE FROM public.tp_function
WHERE id='b29d5b40-b635-e34d-ee5f-5cf161348a62';
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort)
VALUES('b29d5b40-b635-e34d-ee5f-5cf161348a62', '', NULL, '', 'Automation', '', 'MENU.AUTOMATION', 'flaticon2-hourglass', '0', '', '0', 960);
ALTER TABLE public.tp_generate_device RENAME COLUMN activate_flag TO add_flag;
ALTER TABLE public.tp_generate_device RENAME COLUMN activate_date TO add_date;
COMMENT ON COLUMN public.tp_generate_device.add_date IS '添加日期';
COMMENT ON COLUMN public.tp_generate_device.add_flag IS '0-未添加 1-已添加';

--0.5.0
ALTER TABLE public.users
DROP COLUMN search_text,
DROP COLUMN first_name,
DROP COLUMN last_name,
DROP COLUMN remember_token,
DROP COLUMN email_verified_at,
DROP COLUMN is_admin,
DROP COLUMN business_id,
DROP COLUMN wx_openid,
DROP COLUMN wx_unionid,
ADD COLUMN tenant_id varchar(36) NULL;
CREATE INDEX users_tenant_id_idx ON public.users (tenant_id);

ALTER TABLE public.business ADD tenant_id varchar(36) NULL;
ALTER TABLE public.asset ADD tenant_id varchar(36) NULL;
ALTER TABLE public.tp_role ADD tenant_id varchar(36) NULL;
ALTER TABLE public.conditions_log ADD tenant_id varchar(36) NULL;
ALTER TABLE public.device ADD tenant_id varchar(36) NULL;
ALTER TABLE public.operation_log ADD tenant_id varchar(36) NULL;
ALTER TABLE public.tp_function ADD COLUMN tenant_id varchar(36) NULL;
ALTER TABLE public.tp_function ADD COLUMN sys_flag varchar(2) NULL;
ALTER TABLE public.tp_generate_device ADD COLUMN tenant_id varchar(36) NULL;
ALTER TABLE public.tp_ota ADD COLUMN tenant_id varchar(36) NULL;
ALTER TABLE public.tp_product ADD COLUMN tenant_id varchar(36) NULL;
ALTER TABLE public.tp_script ADD COLUMN tenant_id varchar(36) NULL;
ALTER TABLE public.ts_kv ADD COLUMN tenant_id varchar(36) NULL;
ALTER TABLE public.ts_kv_latest ADD COLUMN tenant_id varchar(36) NULL;

COMMENT ON COLUMN public.tp_function.sys_flag IS '系统管理员菜单标志';
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, sys_flag)
VALUES('229de465-24a1-467d-d3a2-d146db43bffa', '', NULL, '/tenant', 'TenantManagment', '/pages/system/tenant', '租户管理', '', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 0, NULL);

UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='', "name"='AddPermission', component='', title='COMMON.PERMISSIONADD', icon='', "type"='3', function_code='sys:permission:add', parent_id='4231ea2c-a2fb-bd9c-8966-c7d654289deb', sort=0, sys_flag='1'
WHERE id='539b8e97-b791-3260-8b23-1beca9497b19';
UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='/permission/index', "name"='PermissionManagement', component='/pages/system/permissions/Index.vue', title='COMMON.PERMISSIONMANAGEMENT', icon='flaticon-upload-1', "type"='1', function_code='', parent_id='4f2791e5-3c13-7249-c25f-77f6f787f574', sort=950, sys_flag='1'
WHERE id='4231ea2c-a2fb-bd9c-8966-c7d654289deb';
UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='', "name"='SystemManagement', component='', title='COMMON.SYSTEMMANAGEMENT', icon='flaticon2-gear', "type"='0', function_code='', parent_id='0', sort=900, sys_flag='2'
WHERE id='4f2791e5-3c13-7249-c25f-77f6f787f574';
UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='', "name"='EditPermission', component='', title='COMMON.EDIT', icon='', "type"='3', function_code='sys:permission:edit', parent_id='4231ea2c-a2fb-bd9c-8966-c7d654289deb', sort=0, sys_flag='1'
WHERE id='17f776f0-be0c-a216-a03a-00944865e8d7';
UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='', "name"='DeletePermission', component='', title='COMMON.DELETE', icon='', "type"='3', function_code='sys:permission:del', parent_id='4231ea2c-a2fb-bd9c-8966-c7d654289deb', sort=0, sys_flag='1'
WHERE id='d8613453-278c-289c-6e18-ee58f6eb540b';
UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='', "name"='SearchPermission', component='', title='COMMON.SEARCH', icon='', "type"='3', function_code='sys:permission:search', parent_id='4231ea2c-a2fb-bd9c-8966-c7d654289deb', sort=0, sys_flag='1'
WHERE id='1988db79-dcb6-f8e5-4984-90e131efa526';
UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='/system/index', "name"='SystemSetup', component='/pages/system/index.vue', title='COMMON.SYSTEMSETUP', icon='flaticon-upload-1', "type"='1', function_code='', parent_id='4f2791e5-3c13-7249-c25f-77f6f787f574', sort=990, sys_flag='1'
WHERE id='3786391a-6e8f-659d-1500-d2c3f82d6933';

UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='/market', "name"='Market', component='/pages/plugin/index.vue', title='COMMON.MARKET', icon='flaticon2-supermarket', "type"='0', function_code='', parent_id='0', sort=910, sys_flag='2'
WHERE id='ec7a22ed-919d-7959-6737-145198f6172f';
UPDATE public.tp_function
SET function_name='', menu_id=NULL, "path"='/tenant', "name"='TenantManagment', component='/pages/system/tenant', title='租户管理', icon='flaticon2-user', "type"='1', function_code='', parent_id='4f2791e5-3c13-7249-c25f-77f6f787f574', sort=965, sys_flag='1'
WHERE id='229de465-24a1-467d-d3a2-d146db43bffa';
INSERT INTO public.tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, sys_flag)
VALUES('a89634a6-1912-1f24-612b-10ae60a65197', '', NULL, '/protocol/list', 'ProtocolManagment', '/pages/system/protocol', '协议插件', 'flaticon2-supermarket', '1', '', 'ec7a22ed-919d-7959-6737-145198f6172f', 980, '1');

ALTER TABLE public.device_model ADD COLUMN tenant_id varchar(36) NULL;

INSERT INTO tp_function
(id, function_name, menu_id, "path", name, component, title, icon, "type", function_code, parent_id, sort, sys_flag)
VALUES('fe29af27-9ae9-7baf-4e34-8051e1b8dd65', '', NULL, '/transpondNew/index', 'TranspondNew', '/pages/transpondNew/index.vue', 'MENU.TRANSPONDNEW', 'flaticon-upload-1', '1', '', '7cac14a0-0ff2-57d9-5465-597760bd2cb1', 997, NULL);
UPDATE public.tp_function SET sys_flag='1' WHERE id='7c7ef553-5342-f38e-6c07-222290f1c32d';

-- 设备命令历史记录
CREATE TABLE "public"."device_command_history" (
  "id" varchar(36) COLLATE "pg_catalog"."default",
  "device_id" varchar(36) COLLATE "pg_catalog"."default",
  "command_identify" varchar(50) COLLATE "pg_catalog"."default",
  "command_name" varchar(255) COLLATE "pg_catalog"."default",
  "desc" text COLLATE "pg_catalog"."default",
  "data" text COLLATE "pg_catalog"."default",
  "send_time" int4,
  "send_status" int4
);

-- 设备事件历史记录
CREATE TABLE "public"."device_event_history" (
  "id" varchar(36) COLLATE "pg_catalog"."default",
  "event_identify" varchar(50) COLLATE "pg_catalog"."default",
  "event_name" varchar(50) COLLATE "pg_catalog"."default",
  "report_time" int4,
  "data" text COLLATE "pg_catalog"."default",
  "desc" text COLLATE "pg_catalog"."default",
  "device_id" varchar(36) COLLATE "pg_catalog"."default"
);

-- 数据转发相关
CREATE TABLE "public"."tp_data_transpond" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "desc" varchar COLLATE "pg_catalog"."default",
  "status" int4 NOT NULL,
  "tenant_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "script" text COLLATE "pg_catalog"."default",
  "create_time" int4,
  "name" varchar COLLATE "pg_catalog"."default",
  "warning_strategy_id" varchar(36) COLLATE "pg_catalog"."default",
  "warning_switch" int4
);

CREATE TABLE "public"."tp_data_transpond_detail" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "data_transpond_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "message_type" int4 NOT NULL,
  "device_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "business_id" varchar(36) COLLATE "pg_catalog"."default",
  "asset_group_id" varchar(36) COLLATE "pg_catalog"."default"
);


CREATE TABLE "public"."tp_data_transpond_target" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "data_transpond_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "data_type" int2 NOT NULL,
  "target" varchar COLLATE "pg_catalog"."default" NOT NULL
);

--可视化插件相关
CREATE TABLE "public"."tp_vis_plugin" (
  id VARCHAR(36) PRIMARY KEY,
  tenant_id VARCHAR(36) NOT NULL,
  plugin_name VARCHAR(150) NOT NULL,
  plugin_description VARCHAR(150),
  create_at int8 NULL,
  remark VARCHAR(255)
);

-- Column comments

COMMENT ON COLUMN public.tp_vis_plugin.plugin_name IS '可视化插件名称';
COMMENT ON COLUMN public.tp_vis_plugin.plugin_description IS '插件描述';


CREATE TABLE "public"."tp_vis_files" (
  id VARCHAR(36) PRIMARY KEY,
  vis_plugin_id VARCHAR(36) NOT NULL,
  file_name VARCHAR(150),
  file_url VARCHAR(150),
  file_size VARCHAR(20),
  create_at int8 NULL,
  remark VARCHAR(255)
);

COMMENT ON COLUMN public.tp_vis_files.vis_plugin_id IS '可视化插件id';

ALTER TABLE public.tp_ota_device ADD retry_count int8 NULL;


-- 通知组相关
CREATE TABLE "public"."tp_notification_groups" (
  "id" varchar(36) COLLATE "pg_catalog"."default",
  "group_name" varchar(255) COLLATE "pg_catalog"."default",
  "notification_type" int4,
  "status" int4,
  "notification_config" text COLLATE "pg_catalog"."default",
  "desc" varchar(255) COLLATE "pg_catalog"."default",
  "tenant_id" varchar(36) COLLATE "pg_catalog"."default",
  "create_time" int4
)
;
ALTER TABLE "public"."tp_notification_groups" OWNER TO "postgres";
COMMENT ON COLUMN "public"."tp_notification_groups"."id" IS 'uuid';
COMMENT ON COLUMN "public"."tp_notification_groups"."group_name" IS '通知组名称';
COMMENT ON COLUMN "public"."tp_notification_groups"."notification_type" IS '通知类型';
COMMENT ON COLUMN "public"."tp_notification_groups"."status" IS '通知状态';
COMMENT ON COLUMN "public"."tp_notification_groups"."notification_config" IS '通知配置';
COMMENT ON COLUMN "public"."tp_notification_groups"."desc" IS '通知组描述';
COMMENT ON COLUMN "public"."tp_notification_groups"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."tp_notification_groups"."create_time" IS '创建时间';

CREATE TABLE "public"."tp_notification_members" (
  "id" varchar(36) COLLATE "pg_catalog"."default",
  "tp_notification_groups_id" varchar(36) COLLATE "pg_catalog"."default",
  "users_id" varchar(36) COLLATE "pg_catalog"."default",
  "is_email" int4,
  "is_phone" int4,
  "is_message" int4,
  "remark" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."tp_notification_members" OWNER TO "postgres";
COMMENT ON COLUMN "public"."tp_notification_members"."id" IS 'uuid';
COMMENT ON COLUMN "public"."tp_notification_members"."tp_notification_groups_id" IS '关联tp_notification_groups表id';
COMMENT ON COLUMN "public"."tp_notification_members"."users_id" IS '关联users表id';


CREATE TABLE "public"."tp_notification_history" (
  "id" varchar(36) COLLATE "pg_catalog"."default",
  "send_time" int4,
  "send_content" text COLLATE "pg_catalog"."default",
  "send_target" varchar(255) COLLATE "pg_catalog"."default",
  "send_result" int2,
  "notification_type" int2,
  "tenant_id" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."tp_notification_history" OWNER TO "postgres";
COMMENT ON COLUMN "public"."tp_notification_history"."id" IS 'Uuid
';
COMMENT ON COLUMN "public"."tp_notification_history"."send_time" IS '时间戳
';
COMMENT ON COLUMN "public"."tp_notification_history"."send_content" IS '发送内容';
COMMENT ON COLUMN "public"."tp_notification_history"."send_target" IS '发送目标';
COMMENT ON COLUMN "public"."tp_notification_history"."send_result" IS '发送结果（1成功 2失败）';
COMMENT ON COLUMN "public"."tp_notification_history"."notification_type" IS '通知类型';
COMMENT ON COLUMN "public"."tp_notification_history"."tenant_id" IS '租户ID';



CREATE TABLE "public"."third_party_cloud_services_config" (
  "id" varchar(36) COLLATE "pg_catalog"."default",
  "notice_type" int4,
  "config" varchar(255) COLLATE "pg_catalog"."default",
  "status" int4
)
;
ALTER TABLE "public"."third_party_cloud_services_config" OWNER TO "postgres";
COMMENT ON COLUMN "public"."third_party_cloud_services_config"."id" IS 'Uuid
';
COMMENT ON COLUMN "public"."third_party_cloud_services_config"."notice_type" IS '通知类型（1:短信 2:邮件 3:电话）';
COMMENT ON COLUMN "public"."third_party_cloud_services_config"."config" IS '配置信息';
COMMENT ON COLUMN "public"."third_party_cloud_services_config"."status" IS '开关（1：启用 2：关闭）';

INSERT INTO public.users
(id, created_at, updated_at, enabled, additional_info, authority, customer_id, email, "password", "name", mobile, remark, tenant_id)
VALUES('33b2336c-9e9a-86e5-101e-4864e6b7724b', 1684309245, 1684309245, '1', '', 'TENANT_ADMIN', '', 'tenant@tenant.cn', '$2a$04$.O6d.vy.yOcYrqaQ2zkpAuApP4aDISxGdzlXol3NAR4vmZKex6jam', '租户', '13211111111', '', 'e481b0c0');

ALTER TABLE public.tp_dashboard ADD tenant_id varchar(36) NULL;
ALTER TABLE public.data_transpond ADD tenant_id varchar(36) NULL;
ALTER TABLE public.navigation ADD tenant_id varchar(36) NULL;
DELETE FROM public.tp_function
WHERE id='3f4348b0-f39d-ec42-14b4-623cbeadb12f';

-- 0.5.0.1
INSERT INTO public.tp_function (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag) VALUES('e9a36fd0-fe8a-896b-713c-c809cef6128e', '', NULL, '', 'Alarm', '', '告警', 'flaticon2-warning', '0', '', '0', 950, '', '');
UPDATE public.tp_function SET function_name='', menu_id=NULL, "path"='/alarm/list', "name"='AlarmInformation', component='/pages/alarm/AlarmIndex.vue', title='COMMON.WARNINFO', icon='flaticon2-warning', "type"='1', function_code='', parent_id='e9a36fd0-fe8a-896b-713c-c809cef6128e', sort=999, tenant_id='', sys_flag='' WHERE id='c17a3b9e-bd1f-2f10-4c65-d2ae7030087b';
UPDATE public.tp_function SET function_name='', menu_id=NULL, "path"='/notice/index', "name"='Notice', component='/pages/notice/index', title='COMMON.NOTICE', icon='flaticon-upload-1', "type"='1', function_code='', parent_id='e9a36fd0-fe8a-896b-713c-c809cef6128e', sort=980, tenant_id='', sys_flag='' WHERE id='7b30818a-4c58-ae4a-9c13-4a00cf3b61c2';

--- add
CREATE TABLE public.tp_local_vis_plugin (
	id varchar(36) NOT NULL,
	tenant_id varchar(36) NOT NULL,
	plugin_url varchar(500) NOT NULL,
	create_at int8 NULL,
	remark varchar(255) NULL
);

-- public.tp_data_services_config definition

-- Drop table

-- DROP TABLE public.tp_data_services_config;

-- public.tp_data_services_config definition

-- Drop table

-- DROP TABLE public.tp_data_services_config;

CREATE TABLE public.tp_data_services_config (
	id varchar(36) NOT NULL,
	"name" varchar(50) NULL, -- 名称
	app_key varchar(500) NULL, -- key
	secret_key varchar(500) NULL, -- 密钥
	signature_mode varchar(50) NULL, -- 签名方式：MD5 or SHA256
	ip_whitelist varchar(500) NULL, -- ip白名单
	data_sql varchar(5000) NULL, -- sql语句
	api_flag varchar(2) NULL, -- 支持接口标志 0-http接口 1-http和ws接口
	time_interval int8 NULL, --  ws接口推送数据间隔（s）
	enable_flag varchar(1) NULL, -- 启停标志
	description varchar(500) NULL, -- 描述
	created_at int8 NULL,
	remark varchar(500) NULL,
	CONSTRAINT tp_data_services_config_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.tp_data_services_config."name" IS '名称';
COMMENT ON COLUMN public.tp_data_services_config.app_key IS 'key';
COMMENT ON COLUMN public.tp_data_services_config.secret_key IS '密钥';
COMMENT ON COLUMN public.tp_data_services_config.signature_mode IS '签名方式：MD5 or SHA256';
COMMENT ON COLUMN public.tp_data_services_config.ip_whitelist IS 'ip白名单';
COMMENT ON COLUMN public.tp_data_services_config.data_sql IS 'sql语句';
COMMENT ON COLUMN public.tp_data_services_config.api_flag IS '支持接口标志 0-http接口 1-http和ws接口';
COMMENT ON COLUMN public.tp_data_services_config.time_interval IS '	ws接口推送数据间隔（s）';
COMMENT ON COLUMN public.tp_data_services_config.enable_flag IS '启停标志';
COMMENT ON COLUMN public.tp_data_services_config.description IS '描述';
ALTER TABLE public.tp_function ADD "describe" varchar(500) NULL;
COMMENT ON COLUMN public.tp_function."describe" IS '描述';
UPDATE tp_function
SET function_name='', menu_id=NULL, "path"='', name='RuleEngine', component='', title='COMMON.RULEENGINE', icon='flaticon2-gift-1', "type"='0', function_code='', parent_id='0', sort=920, tenant_id='', sys_flag='2', "describe"='规则引擎目录'
WHERE id='7cac14a0-0ff2-57d9-5465-597760bd2cb1';
UPDATE tp_function
SET function_name='', menu_id=NULL, "path"='/access_engine/index', name='AccessEngine', component='/pages/access-engine/AccessEngineIndex.vue', title='COMMON.NETWORKCOMPONENTS', icon='flaticon-upload-1', "type"='1', function_code='', parent_id='7cac14a0-0ff2-57d9-5465-597760bd2cb1', sort=999, tenant_id='', sys_flag='1', "describe"='规则引擎菜单'
WHERE id='a8ebb8af-adab-90fa-a553-49667370fc5f';


-- ----------------------------
-- Table structure for tp_api
-- ----------------------------
DROP TABLE IF EXISTS "public"."tp_api";
CREATE TABLE "public"."tp_api" (
                                   "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                   "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                   "url" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
                                   "api_type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
                                   "service_type" varchar(2) COLLATE "pg_catalog"."default",
                                   "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."tp_api"."name" IS '接口名称';
COMMENT ON COLUMN "public"."tp_api"."url" IS '接口地址';
COMMENT ON COLUMN "public"."tp_api"."api_type" IS '接口类型(http socket)';
COMMENT ON COLUMN "public"."tp_api"."service_type" IS '服务类型(1-OpenApi)';
COMMENT ON COLUMN "public"."tp_api"."remark" IS '描述';
COMMENT ON TABLE "public"."tp_api" IS 'api接口表';

ALTER TABLE "public"."tp_api" ADD CONSTRAINT "tp_api_pk" PRIMARY KEY ("id");


-- ----------------------------
-- Table structure for tp_openapi_auth
-- ----------------------------
DROP TABLE IF EXISTS "public"."tp_openapi_auth";
CREATE TABLE "public"."tp_openapi_auth" (
                                            "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                            "tenant_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                            "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                            "app_key" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
                                            "secret_key" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
                                            "signature_mode" varchar(50) COLLATE "pg_catalog"."default",
                                            "ip_whitelist" varchar(500) COLLATE "pg_catalog"."default",
                                            "device_access_scope" varchar(2) COLLATE "pg_catalog"."default",
                                            "api_access_scope" varchar(2) COLLATE "pg_catalog"."default",
                                            "description" varchar(500) COLLATE "pg_catalog"."default",
                                            "created_at" int8,
                                            "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."tp_openapi_auth"."tenant_id" IS '租户id';
COMMENT ON COLUMN "public"."tp_openapi_auth"."name" IS '名称';
COMMENT ON COLUMN "public"."tp_openapi_auth"."app_key" IS 'keyy';
COMMENT ON COLUMN "public"."tp_openapi_auth"."secret_key" IS '密钥';
COMMENT ON COLUMN "public"."tp_openapi_auth"."signature_mode" IS '签名方式 MD5 SHA256';
COMMENT ON COLUMN "public"."tp_openapi_auth"."ip_whitelist" IS 'ip白名单';
COMMENT ON COLUMN "public"."tp_openapi_auth"."device_access_scope" IS '设备访问范围';
COMMENT ON COLUMN "public"."tp_openapi_auth"."api_access_scope" IS '接口访问范围';
COMMENT ON COLUMN "public"."tp_openapi_auth"."description" IS '描述';
COMMENT ON COLUMN "public"."tp_openapi_auth"."remark" IS '备注';

-- ----------------------------
-- Primary Key structure for table tp_openapi_auth
-- ----------------------------
ALTER TABLE "public"."tp_openapi_auth" ADD CONSTRAINT "tp_openapi_auth_pk" PRIMARY KEY ("id");


-- ----------------------------
-- Table structure for tp_r_openapi_auth_api
-- ----------------------------
DROP TABLE IF EXISTS "public"."tp_r_openapi_auth_api";
CREATE TABLE "public"."tp_r_openapi_auth_api" (
                                                  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "tp_openapi_auth_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "tp_api_id" varchar(36) COLLATE "pg_catalog"."default"
)
;
COMMENT ON TABLE "public"."tp_r_openapi_auth_api" IS 'OpenApi授权和接口关系表';

-- ----------------------------
-- Primary Key structure for table tp_r_openapi_auth_api
-- ----------------------------
ALTER TABLE "public"."tp_r_openapi_auth_api" ADD CONSTRAINT "tp_r_openapi_auth_api_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table tp_r_openapi_auth_api
-- ----------------------------
ALTER TABLE "public"."tp_r_openapi_auth_api" ADD CONSTRAINT "tp_r_openapi_auth_api_tp_openapi_auth_id_fk" FOREIGN KEY ("tp_openapi_auth_id") REFERENCES "public"."tp_openapi_auth" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
-- ----------------------------
-- Uniques structure for table tp_r_openapi_auth_api
-- ----------------------------
ALTER TABLE "public"."tp_r_openapi_auth_api"
    ADD CONSTRAINT "open_auth_id_api_id_pk" UNIQUE ("tp_openapi_auth_id", "tp_api_id");

COMMENT ON CONSTRAINT "open_auth_id_api_id_pk" ON "public"."tp_r_openapi_auth_api" IS 'auth_id_api_id联合唯一';


-- ----------------------------
-- Table structure for tp_r_openapi_auth_device
-- ----------------------------
DROP TABLE IF EXISTS "public"."tp_r_openapi_auth_device";
CREATE TABLE "public"."tp_r_openapi_auth_device" (
                                                     "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                                     "tp_openapi_auth_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                                     "device_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON TABLE "public"."tp_r_openapi_auth_device" IS 'OpenApi授权和设备关系表';

-- ----------------------------
-- Primary Key structure for table tp_r_openapi_auth_device
-- ----------------------------
ALTER TABLE "public"."tp_r_openapi_auth_device" ADD CONSTRAINT "tp_r_openapi_auth_device_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table tp_r_openapi_auth_device
-- ----------------------------
ALTER TABLE "public"."tp_r_openapi_auth_device" ADD CONSTRAINT "tp_r_openapi_auth_api_tp_openapi_auth_id_fk" FOREIGN KEY ("tp_openapi_auth_id") REFERENCES "public"."tp_openapi_auth" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
-- ----------------------------
-- Uniques structure for table tp_r_openapi_auth_device
-- ----------------------------
ALTER TABLE "public"."tp_r_openapi_auth_device" ADD CONSTRAINT "open_auth_id_device_id_pk" UNIQUE ("tp_openapi_auth_id", "device_id");
COMMENT ON CONSTRAINT "open_auth_id_device_id_pk" ON "public"."tp_r_openapi_auth_device" IS 'auth_id_device_id联合唯一';


INSERT INTO public.tp_function (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe") VALUES('bcbb4d09-7918-6b6c-4721-cfd41fa7dca0', '', NULL, '/noticeList/index', 'NoticeList', '/pages/noticeList/index', 'COMMON.NOTICERECORD', 'flaticon-upload-1', '1', '', 'e9a36fd0-fe8a-896b-713c-c809cef6128e', 979, '', '0', '');

INSERT INTO public.tp_function (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe") VALUES('e21c59aa-cb88-84f6-bbec-784cc263ad0b', '', NULL, '', 'DataService', '', '数据服务', 'flaticon-open-box', '0', '', '0', 915, '', '2', '数据服务目录');
INSERT INTO public.tp_function (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe") VALUES('b8eb4f39-fa5e-292f-894d-34877a7424b0', '', NULL, '/dataService/dataSetService/index', 'DataSetService', '/pages/dataService/dataSetService/index', 'MENU.DATASETSERVICE', 'flaticon-upload-1', '1', '', 'e21c59aa-cb88-84f6-bbec-784cc263ad0b', 965, '', '1', '');
INSERT INTO public.tp_function (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe") VALUES('77fb6c53-23b6-c6e5-6f10-3eb7823f187c', '', NULL, '/noticeservices/index', ' NoticeService', '/pages/system/noticeservices/index', 'COMMON.NOTICESERVICES', 'flaticon-upload-1', '1', '', '4f2791e5-3c13-7249-c25f-77f6f787f574', 999, '', '1', '');
INSERT INTO public.tp_function (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe") VALUES('813dfcd3-7090-75a5-eb73-6e7035c6e74a', '', NULL, '/datagateway/index', 'DataGateway', '/pages/datagateway/index.vue', '数据网关', 'flatixon2-gear', '1', '', 'e21c59aa-cb88-84f6-bbec-784cc263ad0b', 996, '', '0', '');

COMMENT ON TABLE public.asset IS '分组';
COMMENT ON TABLE public.conditions_log IS '属性下发日志';
COMMENT ON TABLE public.data_transpond IS '数据转发';
COMMENT ON TABLE public.device_command_history IS '设备历史命令下发数据';
COMMENT ON TABLE public.device_event_history IS '设备历史事件上报命令';
COMMENT ON TABLE public.device_model IS '设备插件';
COMMENT ON TABLE public.logo IS '主题和logo表';
COMMENT ON TABLE public.resources IS '系统历史cpu和内存资源';
COMMENT ON TABLE public.third_party_cloud_services_config IS '通知类系统配置';
COMMENT ON TABLE public.tp_automation IS '自动化配置';
COMMENT ON TABLE public.tp_automation_action IS '自动化配置动作表';
COMMENT ON TABLE public.tp_automation_condition IS '自动化配置条件表';
COMMENT ON TABLE public.tp_automation_log IS '自动化日志';
COMMENT ON TABLE public.tp_automation_log_detail IS '自动化日志详情';
COMMENT ON TABLE public.tp_batch IS '产品批次';
COMMENT ON TABLE public.tp_dashboard IS '可视化插件';
COMMENT ON TABLE public.tp_data_services_config IS '数据服务配置';
COMMENT ON TABLE public.tp_data_transpond IS '数据转发';
COMMENT ON TABLE public.tp_data_transpond_target IS '数据转发目标';
COMMENT ON TABLE public.tp_dict IS '字典表';
COMMENT ON TABLE public.tp_function IS '功能表';
COMMENT ON TABLE public.tp_generate_device IS '产品批次生成的设备';
COMMENT ON TABLE public.tp_local_vis_plugin IS '本地可视化插件';
COMMENT ON TABLE public.tp_menu IS '菜单表';
COMMENT ON TABLE public.tp_notification_groups IS '通知组';
COMMENT ON TABLE public.tp_notification_history IS '通知历史消息';
COMMENT ON TABLE public.tp_notification_members IS '通知组和成员联系表';
COMMENT ON TABLE public.tp_openapi_auth IS 'openapi授权表';
COMMENT ON TABLE public.tp_ota IS '固件升级';
COMMENT ON TABLE public.tp_ota_device IS '固件升级设备表';
COMMENT ON TABLE public.tp_ota_task IS '固件升级任务表';
COMMENT ON TABLE public.tp_product IS '产品管理表';
COMMENT ON TABLE public.tp_protocol_plugin IS '协议插件配置';
COMMENT ON TABLE public.tp_role IS '角色表';
COMMENT ON TABLE public.tp_role_menu IS '角色菜单关系';
COMMENT ON TABLE public.tp_scenario_action IS '场景动作表';
COMMENT ON TABLE public.tp_scenario_log IS '场景日志表';
COMMENT ON TABLE public.tp_scenario_log_detail IS '场景日志详情表';
COMMENT ON TABLE public.tp_scenario_strategy IS '场景策略表';
COMMENT ON TABLE public.tp_script IS '设备脚本表';
COMMENT ON TABLE public.tp_vis_files IS '可视化文件表';
COMMENT ON TABLE public.tp_vis_plugin IS '可视化插件表';
COMMENT ON TABLE public.tp_warning_information IS '告警信息表';
COMMENT ON TABLE public.tp_warning_strategy IS '告警策略表';
COMMENT ON TABLE public.ts_kv IS '设备属性历史数据表';
COMMENT ON TABLE public.ts_kv_latest IS '设备属性当前值表';
COMMENT ON TABLE public.users IS '用户表';

-- Column comments

COMMENT ON COLUMN public.tp_ota.package_name IS '升级包名称';
COMMENT ON COLUMN public.tp_ota.package_version IS '升级包版本';
COMMENT ON COLUMN public.tp_ota.package_module IS '升级包模块';
COMMENT ON COLUMN public.tp_ota.product_id IS '产品id';
COMMENT ON COLUMN public.tp_ota.signature_algorithm IS '签名算法';
COMMENT ON COLUMN public.tp_ota.package_url IS '升级包url';
COMMENT ON COLUMN public.tp_ota.description IS '描述';
COMMENT ON COLUMN public.tp_ota.additional_info IS '其他配置';
COMMENT ON COLUMN public.tp_ota.created_at IS '创建时间';
COMMENT ON COLUMN public.tp_ota.sign IS '签名';
COMMENT ON COLUMN public.tp_ota.file_size IS '文件大小';
-- Column comments

COMMENT ON COLUMN public.tp_ota_task.task_name IS '任务名称';
COMMENT ON COLUMN public.tp_ota_task.upgrade_time_type IS '升级时间类型 0-立即升级 1-定时升级';
COMMENT ON COLUMN public.tp_ota_task.start_time IS '开始时间';
COMMENT ON COLUMN public.tp_ota_task.end_time IS '结束时间';
COMMENT ON COLUMN public.tp_ota_task.device_count IS '设备数量';
COMMENT ON COLUMN public.tp_ota_task.task_status IS '任务状态 0-待升级 1-升级中 2-已完成';
COMMENT ON COLUMN public.tp_ota_task.description IS '描述';
COMMENT ON COLUMN public.tp_ota_task.created_at IS '创建时间';
COMMENT ON COLUMN public.tp_ota_task.ota_id IS 'ota表id';

-- Column comments

COMMENT ON COLUMN public.tp_ota_device.device_id IS '设备id';
COMMENT ON COLUMN public.tp_ota_device.current_version IS '当前版本';
COMMENT ON COLUMN public.tp_ota_device.target_version IS '目标版本';
COMMENT ON COLUMN public.tp_ota_device.upgrade_progress IS '升级进度';
COMMENT ON COLUMN public.tp_ota_device.status_update_time IS '状态修改时间';
COMMENT ON COLUMN public.tp_ota_device.upgrade_status IS '状态 0-待推送 1-已推送 2-升级中 3-升级成功 4-升级失败 5-已取消';
COMMENT ON COLUMN public.tp_ota_device.status_detail IS '状态详情';
COMMENT ON COLUMN public.tp_ota_device.retry_count IS '推送次数';

-- Column comments

COMMENT ON COLUMN public.tp_protocol_plugin."name" IS '插件名称';
COMMENT ON COLUMN public.tp_protocol_plugin.protocol_type IS '插件类型';
COMMENT ON COLUMN public.tp_protocol_plugin.http_address IS 'http地址';
COMMENT ON COLUMN public.tp_protocol_plugin.sub_topic_prefix IS '订阅主题前缀';
COMMENT ON COLUMN public.tp_protocol_plugin.created_at IS '创建时间';
COMMENT ON COLUMN public.tp_protocol_plugin.description IS '描述';
COMMENT ON COLUMN public.tp_protocol_plugin.device_type IS '设备类型1-设备 2-网关';
COMMENT ON COLUMN public.tp_protocol_plugin.additional_info IS '附加信息';

COMMENT ON COLUMN public.tp_vis_files.file_name IS '名称';
COMMENT ON COLUMN public.tp_vis_files.file_url IS 'url地址';
COMMENT ON COLUMN public.tp_vis_files.file_size IS '文件大小';

COMMENT ON COLUMN public.tp_vis_plugin.tenant_id IS '租户id';

COMMENT ON COLUMN public.tp_local_vis_plugin.tenant_id IS '租户id';
COMMENT ON COLUMN public.tp_local_vis_plugin.create_at IS '创建时间';
COMMENT ON COLUMN public.tp_product.tenant_id IS '租户id';

INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('824a7f35-c49b-4b47-e303-5db484e186db', '通过设备id查询设备历史数据', '/openapi/v1/kv/device/history', 'http', '1', '');
INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('c4f32994-9369-d599-26ac-ac05f433c10d', '多设备离线在线状态', '/openapi/v1/device/status', 'http', '1', '');
INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('6ff0eb5d-de39-1bbf-6664-65efc6264916', '单个设备当前属性查询', '/openapi/v1/kv/current/symbol', 'http', '1', '');
INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('08e91176-a481-11f7-903b-0a01e160a25a', '单个设备命令下发', '/openapi/v1/device/command/send', 'http', '1', '');
INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('3baf3a11-d3c0-b97f-56b9-1616e9202845', '告警信息列表', '/openapi/v1/warning/view', 'http', '1', '');
INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('24d60ed1-9723-f930-a7bd-8f8e0fbbe695', '单个设备事件列表', '/openapi/v1/device/event/history/list', 'http', '1', '');
INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('24d60ed1-9723-f930-a7bd-8f8e0fbbe691', '单个设备命令列表', '/openapi/v1/device/command/history/list', 'http', '1', '');
INSERT INTO public.tp_api (id, "name", url, api_type, service_type, remark) VALUES('24d60ed1-9723-f930-a7bd-8f8e0fbbe692', '设备总数、当前在线数', '/openapi/v1/device/deviceCountOnlineCount', 'http', '1', '');

ALTER TABLE public.device ADD CONSTRAINT device_un UNIQUE ("token");
CREATE INDEX device_search_text_idx ON public.device (search_text);
DROP INDEX public.device_token_idx;
DROP INDEX public."INDEX_KEY";
CREATE INDEX ts_kv_latest_tenant_id_idx ON public.ts_kv_latest (tenant_id);
CREATE INDEX tp_data_transpond_detail_device_id_idx ON public.tp_data_transpond_detail (device_id);

ALTER TABLE public.device_command_history ADD user_id varchar(36) NULL;
COMMENT ON COLUMN public.device_command_history.user_id IS '用户id';

ALTER TABLE public.conditions_log ADD user_id varchar(36) NULL;
COMMENT ON COLUMN public.device_command_history.user_id IS '操作用户id';

delete from public.tp_function where id = '1bc93bad-41d3-ca37-638b-f79a29c1388b';
delete from public.tp_function where id = 'b143ccd9-eb65-655a-a41f-4311da5ed8c0';
delete from public.casbin_rule where v1='1bc93bad-41d3-ca37-638b-f79a29c1388b';
delete from public.casbin_rule where v1='b143ccd9-eb65-655a-a41f-4311da5ed8c0';

ALTER TABLE public.tp_role DROP CONSTRAINT tp_role_un;

-- 产品编号/租户ID 唯一索引
ALTER TABLE public.tp_product ADD CONSTRAINT tp_product_unique_serial_tenant UNIQUE (serial_number, tenant_id);

-- 修改操作日志菜单
UPDATE public.tp_function SET function_name='', menu_id=NULL, "path"='/log/list', "name"='LogList', component='/pages/log/LogIndex.vue', title='COMMON.OPERATIONLOG', icon='flaticon2-paper', "type"='1', function_code='', parent_id='a59eefbf-de02-a348-30af-d7f16053f884', sort=999, tenant_id=NULL, sys_flag=NULL, "describe"=NULL WHERE id='7c0c8fbb-6ba1-2323-511d-859c7923f954';


-- ----------------------------
-- Table structure for tp_console
-- ----------------------------
DROP TABLE IF EXISTS "public"."tp_console";
CREATE TABLE "public"."tp_console" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(500) COLLATE "pg_catalog"."default",
  "created_at" int8,
  "created_by" varchar(36) COLLATE "pg_catalog"."default",
  "update_at" int8,
  "data" json,
  "config" json,
  "template" json,
  "code" varchar(255) COLLATE "pg_catalog"."default",
  "tenant_id" varchar(36) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."tp_console" OWNER TO "postgres";
COMMENT ON COLUMN "public"."tp_console"."id" IS 'ID';
COMMENT ON COLUMN "public"."tp_console"."name" IS '看板名称';
COMMENT ON COLUMN "public"."tp_console"."created_at" IS '创建时间';
COMMENT ON COLUMN "public"."tp_console"."created_by" IS '创建人ID';
COMMENT ON COLUMN "public"."tp_console"."update_at" IS '更新时间';
COMMENT ON COLUMN "public"."tp_console"."data" IS '看板数据-用来映射图表和设备
';
COMMENT ON COLUMN "public"."tp_console"."config" IS '看板配置-存储看板背景颜色及其他配置
';
COMMENT ON COLUMN "public"."tp_console"."template" IS '看板模版-用来存储模版
';
COMMENT ON COLUMN "public"."tp_console"."code" IS '通过模版编号去第三方会获取模版';
COMMENT ON COLUMN "public"."tp_console"."tenant_id" IS '租户ID';

-- ----------------------------
-- Primary Key structure for table tp_console
-- ----------------------------
ALTER TABLE "public"."tp_console" ADD CONSTRAINT "tp_console_pkey" PRIMARY KEY ("id");

UPDATE device_model
SET model_name='开关', flag=0, chart_data='{"info":{"pluginName":"开关","pluginCategory":"2","author":"thingspanel","version":"v1.0.0","description":"设备字段：switch（int 1-开 0-关）；别名：开关"},"tsl":{"properties":[{"dataType":"integer","dataRange":"0-999","stepLength":0.1,"unit":"-","title":"开关","name":"switch"}],"option":{"classify":"custom","catValue":"relay"}},"chart":[{"componentName":"单控开关","type":"switch","series":[{"type":"switch","value":false,"id":1,"mapping":{"value":"switch","on":"1","off":"0","attr":{"dataType":"integer","dataRange":"0-999","stepLength":0.1,"unit":"-","title":"开关","name":"switch"}}}],"disabled":false,"name":"开关","controlType":"control","id":"QruyPTrD0AeN"}],"publish":{"isPub":false}}'::json, model_type='2', "describe"='', "version"='v1.0.0', author='thingspanel', sort=0, issued=0, remark='', created_at=1671700085, tenant_id='e481b0c0'
WHERE id='49e25564-d0f5-6926-fae7-4d58726248c3';
UPDATE device_model
SET model_name='温湿度传感器', flag=0, chart_data='{"info":{"pluginName":"温湿度传感器","pluginCategory":"1","author":"thingspanel","version":"v1.0.0","description":"标准温湿度传感器"},"tsl":{"properties":[{"dataType":"float","dataRange":"0-999","stepLength":0.1,"unit":"%rh","name":"humidity","title":"湿度"},{"dataType":"float","dataRange":"0-999","stepLength":0.1,"unit":"℃","name":"temperature","title":"温度"}],"option":{"classify":"custom","catValue":"ambient_sensor"}},"chart":[{"series":[{"type":"gauge","progress":{"show":true,"width":18},"axisLine":{"lineStyle":{"width":2}},"axisTick":{"show":false},"splitLine":{"show":false,"length":5,"lineStyle":{"width":2,"color":"#999"}},"axisLabel":{"distance":10,"color":"#fff","fontSize":14},"anchor":{"show":true,"showAbove":true,"size":25,"itemStyle":{"borderWidth":10}},"title":{"show":false},"detail":{"fontSize":30,"offsetCenter":[0,"70%"],"color":"#fff"},"data":[{"value":0,"name":""}]}],"simulator":{"funcArr":["return +(Math.random() * 60).toFixed(2);"],"interval":5000},"name":"当前温度","mapping":["temperature"],"controlType":"dashboard","style":{"backgroundColor":"#2d3d86","opacity":1},"id":"bHEwRZGNTTYk"},{"series":[{"type":"gauge","progress":{"show":true,"width":18},"axisLine":{"lineStyle":{"width":2}},"axisTick":{"show":false},"splitLine":{"show":false,"length":5,"lineStyle":{"width":2,"color":"#999"}},"axisLabel":{"distance":10,"color":"#fff","fontSize":14},"anchor":{"show":true,"showAbove":true,"size":25,"itemStyle":{"borderWidth":10}},"title":{"show":false},"detail":{"fontSize":30,"offsetCenter":[0,"70%"],"color":"#fff"},"data":[{"value":0,"name":""}]}],"simulator":{"funcArr":["return +(Math.random() * 60).toFixed(2);"],"interval":5000},"name":"当前湿度","mapping":["humidity"],"controlType":"dashboard","style":{"backgroundColor":"#2d3d86","opacity":1},"id":"ap4aakzNhLEa"},{"xAxis":{"type":"category","axisLine":{"lineStyle":{"color":"#fff"}},"data":[""]},"yAxis":{"type":"value","axisLine":{"lineStyle":{"color":"#fff"}}},"series":[{"data":[0],"type":"line"}],"name":"温湿度历史数据","mapping":["humidity","temperature"],"controlType":"history","id":"qm9DsAYTktbN"}],"publish":{"isPub":false}}'::json, model_type='1', "describe"='', "version"='v1.0.0', author='thingspanel', sort=0, issued=0, remark='', created_at=1665748873, tenant_id='e481b0c0'
WHERE id='5867753e-cb2d-32dc-a76d-7942d7ebcffc';

INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe")
VALUES('2b1e1c45-d033-8ed7-d69e-ec5dfc93549b', '', NULL, '/console', 'Console', '/pages/console/index.vue', '看板', 'flaticon2-laptop', '1', '', '6dab000b-7ced-a5ce-5fb0-5427f3bb8073', 999, '', '0', '');
INSERT INTO tp_function
(id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe")
VALUES('2a214487-f01f-c7ca-88f3-dce54e7d25f1', '', NULL, '/console/dashboard', 'Dashboard', '/pages/console/Dashboard.vue', '看板', '', '2', '', '2b1e1c45-d033-8ed7-d69e-ec5dfc93549b', 0, '', '0', '');


-- 分享功能对应表结构
CREATE TABLE public.shared_visualization (
	dashboard_id varchar(36) NOT NULL,
	share_id varchar NOT NULL,
	device_list json NOT NULL DEFAULT '{}'::json,
	created_at int8 NULL,
	CONSTRAINT shared_visualization_pkey PRIMARY KEY (dashboard_id)
);

ALTER TABLE public.tp_dashboard ADD share_id varchar(36) NULL;
COMMENT ON COLUMN public.tp_dashboard.share_id IS '分享id';

-- 0.5.4.1
INSERT INTO public.tp_function (id, function_name, menu_id, "path", "name", component, title, icon, "type", function_code, parent_id, sort, tenant_id, sys_flag, "describe") VALUES('80393021-d9b4-4747-00f0-daab3a7aecbb', '', NULL, '/visual_editor', 'VisualEditor', '/pages/chart/List.vue', '大屏', 'flaticon2-laptop', '1', '', '6dab000b-7ced-a5ce-5fb0-5427f3bb8073', 980, '', '0', '');



CREATE TABLE "public"."tp_data_cleanup_config" (
  "id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
  "cleanup_type" int4 NOT NULL,
  "retention_days" int4,
  "last_cleanup_time" int8,
  "last_cleanup_data_time" int8,
  "remark" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."tp_data_cleanup_config" OWNER TO "postgres";
COMMENT ON COLUMN "public"."tp_data_cleanup_config"."id" IS 'uuid';
COMMENT ON COLUMN "public"."tp_data_cleanup_config"."cleanup_type" IS '清理类型 1-设备数据 2-操作日志  int';
COMMENT ON COLUMN "public"."tp_data_cleanup_config"."retention_days" IS '数据保留时间（天）';
COMMENT ON COLUMN "public"."tp_data_cleanup_config"."last_cleanup_time" IS '上次清理时间';
COMMENT ON COLUMN "public"."tp_data_cleanup_config"."last_cleanup_data_time" IS '上次清理的数据时间节点（实际清理的数据时间点）';
COMMENT ON COLUMN "public"."tp_data_cleanup_config"."remark" IS '备注';

-- ----------------------------
-- Records of tp_data_cleanup_config
-- ----------------------------

INSERT INTO "public"."tp_data_cleanup_config" ("id", "cleanup_type", "retention_days", "last_cleanup_time", "last_cleanup_data_time", "remark") VALUES ('a', 1, 30, 0, 0, '');
INSERT INTO "public"."tp_data_cleanup_config" ("id", "cleanup_type", "retention_days", "last_cleanup_time", "last_cleanup_data_time", "remark") VALUES ('b', 2, 30, 0, 0, '');


-- 添加可视化分享列：分享类型
ALTER TABLE public.shared_visualization ADD share_type varchar NULL;
COMMENT ON COLUMN public.shared_visualization.share_type IS '分享类型';

-- 添加可视化看板列：分享类型
ALTER TABLE public.tp_console ADD share_id varchar(36) NULL;
COMMENT ON COLUMN public.tp_console.share_id IS '分享id';