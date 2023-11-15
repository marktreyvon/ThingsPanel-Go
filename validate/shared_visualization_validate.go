package valid

type GetShareLinkValidate struct {
	Id        string `json:"id"  valid:"MaxSize(36)"`
	ShareType string `json:"share_type"  ` // 分享类型
}

type GetShareInfoValidate struct {
	Id        string `json:"id"  valid:"MaxSize(36)"`
	ShareType string `json:"share_type"  ` // 分享类型
}
