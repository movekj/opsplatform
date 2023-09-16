export const TreeOperation = {
    copyCommand: "copy",
    deleteCommand: "delete",
    createCompany: "createCompany",
    createBu: "createBu",
    createAppGroup: "createAppGroup",
    createAppDir: "createAppDir",
    createService: "createService",
    createServiceEnv: "createServiceEnv",
    renameCommand: "rename",
    newNodeId: 99999999999999
}
export const TreeNodeType = {
    group: "group",
    company: "company",
    bu: "bu",
    appGroup: "app_group",
    appDir: "dir",
    service: "service",
    serviceEnv: "service_env",
}

export const TreeNodeTypeMap = {
}
TreeNodeTypeMap[TreeNodeType.group] = '集团'
TreeNodeTypeMap[TreeNodeType.company] = '公司'
TreeNodeTypeMap[TreeNodeType.bu] = '业务线'
TreeNodeTypeMap[TreeNodeType.appGroup] = '项目组'
TreeNodeTypeMap[TreeNodeType.appDir] = '目录'
TreeNodeTypeMap[TreeNodeType.service] = '服务'
TreeNodeTypeMap[TreeNodeType.serviceEnv] = '环境'



