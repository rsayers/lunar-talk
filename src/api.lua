local ez = require("ezserv")

local inspect = require("inspect")
local Api = {
   port = 8080,
}

function Api:init()
   --
end

function Api:dialect()
    return "LunarTalk"
end

function Api:version()
    return "0.1"
end

function Api:colors()
    return '{ "primary": "#133e7c", "secondary": "#ea00d9" }'
end

function Api:logo() end

function Api:saveImage() end

function Api:systemStats() end

function Api:themes() end

function Api:icons()
   return [[
[
	{
		"name": "class",
		"data": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABbUlEQVR4XqVTPU/DMBDtj4Af1Y+kXUjFVj5mWomhQwNIwABq/0CB1M5SPiQQSLACG0hAl2KTbO1SYChECBaWwxc1iZOmLYjhJPvO93z37l0CABLwDxtyJButaYWyWtZkXZXyd4UwB8/ow9hYgOQuz6sme9Mve9+0/QEH9pdreEYfxlIG02IBUpRpWtN2yGOQGDWMaU3LkUH8snOU96PJpPUKjfvnIZAcZX2vHRdAMZ+qK6JE79G+9Qmzy+ugLJYgX1qDzPySC+bFsR3M8QFUk3flnivkHAp6zb9vHl1DeeckqEK8FcR2AgDCHblM/H377HYkF2g4nQBAjCsKsHV683sAnDORWtDpBRQqVf++cXgF5fpxiMhQC0iIHkNiZqEIWnEV0nMTSMSRoEiGxvjwAsZdL+xzCeThMbpCMlBI1nghtVFItpPeYzOxUkYQT8oyJ2Qg5awQkJw8eplEf0gSMj1Ypg76lLo9NXEb/2o/iPb+vADectYAAAAASUVORK5CYII="
	},
	{
		"name": "classAbstract",
		"data": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABx0lEQVR4XmP4//8/w38SsIiIiImoqOhTBgYGFhAfQ4HnvHOivguu9vgvvPrQb8G1977zr34AsUFiIDkgmALFnhgGeM6+Fu638Oq7mn3Pfi24/On/iptfwRjEBon5zLnwTlpd96y4uLgYECxBMcBrwdWwsGU3P8y/gtCIjounr/6v6x37Uz+iuBnogjMCQAB3dsCCa2/RNc8/9/L/vDPP4Xzn4Jj/eRMW/7fOn/RZQlZxMjA80sEG+C683l0LdCJM4fIbX/5HFjf9900p+B9eUP/fJynv/5R91/47BkSA5UHe8Zh6dCLQgN1gA/wWXnuI7Ofq+Vv+J9T0wPktqw78L5m64v/c008hLgOqBQbsA2FhYWmIAfOvfUB2Osj2zo0ncIYFCINiBx6IoOhCN6Bjw3HiDQDF83wkL9Qs2Po/obobzm9euf9/+cy1iMC9AvEC3ABQINZgCUSf5Pz/Yfl1/70T88AxArcAqBakB24AKBpBCQgjGs++AAbcM1QxcABeewvSg5qQ5oIS0g28CQmkGZTYvOdcDYXpQ0nKIENgSRk5TOZDk7L/gqtvkTXjzkxA/4ECCRTS0Mz0ACTmO/OmCLp6krIyNgwABDzXSwA3G8oAAAAASUVORK5CYII="
	},
	{
		"name": "trait",
		"data": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACA0lEQVR4XqVTTW8SURTtj9Af1HQrCyVQYsEEqOJHi9aopOhGKEPLANE0pmVggGLSKtpY/RPduSlvpkNJYaySQqWdNYt7fXcKw6BVY1yc3HfPuefkvXnzJhBxAv8DvxDC5+LllFpOp5SSLrLSGa9GSinrKVZMk/bHgJRSnBZZ+bSgv+1Xux9x+/snE7QmjrRlJrsvDCAhu18xqt0dy/gzSMvulw17iLVtUSn1hubq8Qfc/FIdw7vOjhVCs8PjnG9dLYtSa7O/1X2Pb062Mbu7Cs7HbpycmcJJ7xQ6H7kws7uKWyfneo7PkmcUwD9Yvl3BwrENnQqGXz/E+cqCxcmdClCV2hvIPU0rgJ/JePFtDV+214HDrNTf3LgDHAOe64MZ0shjBaww+Uw4ymDiKG1iuL5RCqKvGDB74WsGRloGk/YAoZbXn7aWMKrHINqK4SJVPYYu+Tq45Bm0czTzrJnApCKPjiCwgriorfTDzQjcP4zgsDoKTnDknRg+jIBdi2rLffKMXWOiJp2GDhYg2JiD2YM5pOrX7kJAu4dB3s825k3uVuMBJFh+/BoJiT3J/Zy9Mnz12+DR/BwB9NQD4Kn7B70fvPUQ0EySFVwX/sokLLFcL8Se9K+qXnAo03hFdcM11QfExWvrPbv5t48pxiQxXltrxfdyhgm+Ji6t5S799TX+K34AA6/bwombrU0AAAAASUVORK5CYII="
	},
	{
		"name": "exception",
		"data": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACzklEQVR4XmWTSUwTYRzFB42gRqOReJKo8UCiaISwuIDoRSm00A1C0JMUFDVQ0QQiBkS20M5QKtACLVA0McoB8SJGIiTqQTx4MV48CJRCylJgFkYxafL85qusHn55/W+vM8kbBgCDDSzbtKcku6FDtBt9UpP2j4JoN/gku75dYtUnsWV/vWhJjxCbDR7JbpSX+x4GpXdOSB+fhxjqgKT0yIy3G3pQnRO+2YAcCzb9F8F9QxaGXBCGPYQeiCO9qC7MhqfyFv0tvndDcJGdZsPoqgk1EJt1HqHTJPODbVh60wZ+0EH52lWNneE78M1TiyWl99ZJ1AmhM18WbbouaqC8s2DTyYv9jVgcYDfA4dLpaEQd3I8FpX7N0R7VV40QmvWyZMuMYSRbVjvvvhkMvHgMysuQOu8YiD2DvItxWOirIf0QC321VHlXUVDgdA6G57RTge4SzPWWY+5pOdUfDjMi9+6mBvqzx8FdV6GJ8KHehPlnDyiBbjPIk3sZictcmXUVY6YzxKyrBLnnj9PjjYSFMRi4b8QMmc+6zJh1l0BsylqhBv6WfPhbC+BvMaG/WE2XtxrknokmO4Xwt/2j1QRy+5vh2Syfn83FNHuVkIfhexmwGJNgyU6CNvYIPY7cE4HvNUZMc9fW8HN54LmsSfIEmvaARRv01emgMFWvX9OcuMPU4El2AnykpjNFGwyYJzcCl+lglHgKbKbsq7oCb2WIyao0qof27cK5owfgJfVklYr2qT5SQbmROO0JGqQlVtMTqFfJE2WpmCi7gPGyFHwqSkT49m0YKUigPUp5KsYJgYZ0mbdq3OtRJrEUWPXofO1lebw0AWN340m6j6EsOQpj5nhSJ2BcoTQRgbo0WbBqPm+K8qqJaM1w8xb1r5mK5OCEORY/b8dQvOY4zFSkBJWZqPzzfx/TBpR48la1k7dkTEqsZkWB1F7BonYos637fwG5xZDZR1w5LAAAAABJRU5ErkJggg=="
	},
	{
		"name": "collection",
		"data": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABKElEQVR4XmP4//8/w38KMEWaUQywaT8saNm1q9GiZ9d0XIqtOncUW/bsmGDetUsVwwCznp2FQM2dxj2bRXAZ4Df3CK95784ki64d8zEMANo+wbx3uxchJ9v17pQ17965F8MAi56dkyx7trsTMsC6c5eURfeO/ZgGdO1cYtW9zYmQAcY9+0UsuneeUMndxg42wLJvh5BFz+6pQGdN1W5YxUNMyAMNqLbo3jXPrHefPjD0twgCBaZadu2Ybt25kZeIaGMEerfGHGzADn0kU3ctNu/c4UisFxQa5nNgCcTdBAPRuHWHpGX3zgOY0di9s9+8i7hotOjatQdbLBRadu/uwpeQzBu28QETUQooALEk5S2CZt0764H+m4Y79HcVmYNdulmV+pmJXAwA4iOzseUcPDoAAAAASUVORK5CYII="
	},
	{
		"name": "string",
		"data": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAeUlEQVR4XmP4//8/w38KMEWaaWcAEMgzM7GuYGZkOYOMgeJyRBnAxMhyDqjhPwizMLC4AOlvzAzMYUADuAgaAASSMM0gDBID0p9A4kR5AQhYgRrekG0AWAMDcwBIE9kGQF0iSKkBvEPfAC5Q4oEacAjIFxlCeYEUDACL/YOriOy23gAAAABJRU5ErkJggg=="
	},
	{
		"name": "magnitude",
		"data": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAyElEQVR4XmP4//8/w38KMEWasRqQ0NAvEFk1QQ8bji3p5iZoQHhNf1B4df8LrLhigilBA6IbJvGFV0/YF1bTt9ihoYGFrDAIquqXDKvuPxNW0z8FqIKRrEAMr+xVAxpyI6y6r4bsWAit7LMH+T2sujeYLAPCq/onAV1xPrShT4h0L1RNiAOGwePQ6j4zkr0QWdunHV7d9yCiuj+N5FgILe/gBzr7JDA9LCQUA1gNiKjuC4QmnLtAV9xEwTUTfChKyiA52mcmUjEAE7m3P3J0TRkAAAAASUVORK5CYII="
	}
]
]]
end

function Api:packageNames() end

function Api:packages(request)
   request.headers['Content-Type'] = 'application/json'
   return [[
[
    {
        "name": "Webside",
        "classes": [
            "WebsideAPI",
            "WebsideServer",
            "ManifestWebside"
        ],
        "methods": {
            "RBVariableNode": [
                "websideType"
            ],
            "RPackageTag": [
                "asWebsideJson"
            ],
            "Dictionary": [
                "asWebsideJson"
            ],
            "RBRefactoring": [
                "fromWebsideJson:",
                "websideType",
                "acceptsWebsideJson:",
                "classForWebsideJson:"
            ],
            "RBLiteralValueNode": [
                "asWebsideJson"
            ],
            "RBCascadeNode": [
                "asWebsideJson"
            ],
            "RBVariableRefactoring": [
                "fromWebsideJson:",
                "asWebsideJson"
            ],
            "RBPullUpInstanceVariableRefactoring": [
                "websideType"
            ],
            "Object": [
                "asWebsideJson"
            ],
            "RBMethodNode": [
                "asWebsideJson"
            ],
            "RBAddMethodChange": [
                "websideType"
            ],
            "RBReturnNode": [
                "asWebsideJson"
            ],
            "RBRemoveMethodChange": [
                "websideType"
            ],
            "RBAddClassChange": [
                "websideType"
            ],
            "RBRenameMethodRefactoring": [
                "websideType"
            ],
            "RBRefactoryProtocolChange": [
                "fromWebsideJson:",
                "asWebsideJson"
            ],
            "String": [
                "asWebsideJson"
            ],
            "RPackage": [
                "asWebsideJson"
            ],
            "RBMethodProtocolChange": [
                "websideType"
            ],
            "Context": [
                "asWebsideJson"
            ],
            "SyntaxErrorNotification": [
                "asWebsideJson"
            ],
            "RBAssignmentNode": [
                "asWebsideJson"
            ],
            "ClassDescription": [
                "asWebsideJson"
            ],
            "RBCommentChange": [
                "websideType"
            ],
            "RBRefactoryChange": [
                "fromWebsideJson:",
                "websideType",
                "acceptsWebsideJson:",
                "classForWebsideJson:"
            ],
            "RBRefactoryClassChange": [
                "fromWebsideJson:",
                "asWebsideJson"
            ],
            "CompiledMethod": [
                "asWebsideJson"
            ],
            "RBRenameVariableChange": [
                "fromWebsideJson:",
                "asWebsideJson"
            ],
            "RBMessageNode": [
                "asWebsideJson"
            ],
            "RBSequenceNode": [
                "asWebsideJson"
            ],
            "RBRefactoryDefinitionChange": [
                "asWebsideJson"
            ],
            "RBMethodRefactoring": [
                "fromWebsideJson:",
                "asWebsideJson"
            ],
            "RBLiteralArrayNode": [
                "asWebsideJson"
            ],
            "RGMethodDefinition": [
                "asWebsideJson"
            ],
            "RBRefactoryVariableChange": [
                "fromWebsideJson:",
                "asWebsideJson"
            ],
            "RBRenameClassChange": [
                "websideType"
            ],
            "RBNode": [
                "websideType"
            ],
            "Collection": [
                "asWebsideJson"
            ],
            "RBRemoveProtocolChange": [
                "websideType"
            ],
            "RBAddClassVariableChange": [
                "websideType"
            ],
            "RBRemoveClassChange": [
                "websideType"
            ],
            "RBRemoveInstanceVariableChange": [
                "websideType"
            ],
            "RBReplaceMethodRefactoring": [
                "acceptsWebsideJson:"
            ],
            "RBAddMethodRefactoring": [
                "websideType",
                "acceptsWebsideJson:"
            ],
            "RBPushDownInstanceVariableRefactoring": [
                "websideType"
            ],
            "RBAddInstanceVariableChange": [
                "websideType"
            ],
            "RBRenameInstanceVariableChange": [
                "websideType"
            ]
        },
        "categories": [
            "Manifest",
            "Base"
        ],
    }
    {
        "name": "Webside-Tests",
        "classes": [
            "WebsideAPITest"
        ],
        "methods": {},
        "categories": [
            {
                "name": "Extensions",
                "package": "Webside"
            },
            {
                "name": "Base",
                "package": "Webside"
            },
            {
                "name": "Manifest",
                "package": "Webside"
            }
        ],
    },
]
]]
end

function Api:packageNamed(packagename) end

function Api:packageClasses(packagename, extended, category) end

function Api:classTree(root, depth, onlyNames) end

function Api:classTree2(root, depth) end

function Api:classNames() end

function Api:classNamed(classname) end

function Api:superclasses(classname) end

function Api:subclasses(classname) end

function Api:instanceVariables(classname) end

function Api:classVariables(classname) end

function Api:variables(classname) end

function Api:categories(classname) end

function Api:usedCategories(classname) end

function Api:allCategories() end

function Api:usualCategories(meta) end

function Api:selectors(classname, sorted) end

function Api:methods(classname, sorted, basic, modified) end

function Api:method(classname, selector) end

function Api:methodHistory(classname, selector) end

function Api:autocompletions(classname, source, position) end

function Api:searchClassNames(text) end

function Api:searchPackageNames(text) end

function Api:search(text, ignoreCase, condition, type) end

function Api:selectorInSource(source, position) end

function Api:senders(selector, basic) end

function Api:accessors(classname, variable, type, sorted, basic, modified) end

function Api:sendersCount(selector) end

function Api:localSenders(selector, classname, basic) end

function Api:classReferences(classname, basic) end

function Api:stringReferences(string, basic) end

function Api:implementors(selector, basic) end

function Api:localImplementors(selector, classname, basic) end

function Api:methodsMatching(pattern, basic) end

function Api:methodTemplate() end

function Api:classTemplate(pack) end

function Api:methodsInCategory(classname, category, sorted, basic) end

function Api:modifiedMethodCount(classname) end

function Api:debuggers() end

function Api:createDebugger(id) end

function Api:debuggerFrames(id) end

function Api:debuggerFrame(id, index) end

function Api:frameBindings(id, index) end

function Api:stepIntoDebugger(id, index) end

function Api:stepOverDebugger(id, index) end

function Api:stepThroughDebugger(id, index) end

function Api:runToCursorDebugger(id, index, position) end

function Api:restartDebugger(id, index, update) end

function Api:resumeDebugger(id) end

function Api:terminateDebugger(id) end

function Api:deleteDebugger(id) end

function Api:workspaces() end

function Api:createWorkspace() end

function Api:workspace(id) end

function Api:saveWorkspace(workspace) end

function Api:deleteWorkspace(id) end

function Api:workspaceBindings(id) end

function Api:usesChanges() end

function Api:lastChanges() end

function Api:postChange(change, description) end

function Api:postCommand(command, description) end

function Api:downloadChanges(changes) end

function Api:uploadChangeset(changeset) end

function Api:updateChanges(changes) end

function Api:compressChanges(changes) end

function Api:extensions(elementType) end

function Api:commandDefinitions(elementType) end

function Api:createPackage(packagename) end

function Api:removePackage(packagename) end

function Api:renamePackage(packagename, newName) end

function Api:defineClass(classname, superclassname, packagename, definition) end

function Api:commentClass(classname, comment) end

function Api:removeClass(classname) end

function Api:renameClass(classname, newName, renameReferences) end

function Api:addInstanceVariable(classname, variable) end

function Api:addClassVariable(classname, variable) end

function Api:renameInstanceVariable(classname, variable, newName) end

function Api:renameClassVariable(classname, variable, newName) end

function Api:removeInstanceVariable(classname, variable) end

function Api:removeClassVariable(classname, variable) end

function Api:moveInstanceVariableUp(classname, variable) end

function Api:moveInstanceVariableDown(classname, variable, target) end

function Api:renameCategory(classname, category, newName) end

function Api:removeCategory(classname, category) end

function Api:compileMethod(classname, packagename, category, source) end

function Api:removeMethod(classname, selector) end

function Api:classifyMethod(classname, selector, category) end

function Api:renameSelector(classname, selector, newSelector) end

function Api:addClassCategory(packagename, category) end

function Api:renameClassCategory(packagename, category, newName) end

function Api:removeClassCategory(packagename, category) end

function Api:evaluateExpression(expression, sync, pin, context, assignee) end

function Api:issueEvaluation(evaluation) end

function Api:pauseEvaluation(id) end

function Api:cancelEvaluation(id) end

function Api:evaluation(id) end

function Api:evaluations() end

function Api:debugExpression(expression, context) end

function Api:profileExpression(expression, context) end

function Api:objects() end

function Api:objectWithId(id) end

function Api:unpinObject(id) end

function Api:unpinAllObjects() end

function Api:objectNamedSlots(id, path) end

function Api:objectIndexedSlots(id, path) end

function Api:objectInstanceVariables(id, path) end

function Api:objectViews(id, path) end

function Api:objectSlot(id, path) end

function Api:pinObjectSlot(id, path) end

function Api:testRuns() end

function Api:runTestSuite(suite) end

function Api:runTest(classname, selector) end

function Api:runTestClass(classname) end

function Api:runTestPackage(packagename) end

function Api:testRunStatus(id) end

function Api:testRunResults(id) end

function Api:runTestRun(id) end

function Api:stopTestRun(id) end

function Api:deleteTestRun(id) end

function Api:debugTest(id, classname, selector) end

function Api:profilerTreeResults(id) end

function Api:profilerRankingResults(id) end

function Api:deleteProfiler(id) end

function Api:nativeDebugger(id) end

function Api:nativeDebuggerFrames(id) end

function Api:nativeDebuggerRegisters(id) end

function Api:nativeDebuggerSpaces(id) end

function Api:nativeDebuggerFrame(id, index) end

function Api:resumeNativeDebugger(id) end

function Api:suspendNativeDebugger(id) end

function Api:pinNativeDebuggerRegister(id, register) end

function Api.handle(request)
   local response = {
      status = 200,
      headers = {},
   }
   response.headers["Content-Type"] = "text/plain; charset=UTF-8"

   local selector = request.path:sub(2)
   local handler = Api[selector]
   if handler ~= nil then
      response.body = handler(response)
    else
       print("selector: " .. tostring(selector) .. " not found")
      response.status = 404
      response.body = "Oops"
   end

   return response
end

function Api:start()
   local http = require("quinku")
   local settings = {
      ip = "0.0.0.0",
      port = 8080,
      handler = self.handle,
   }

   http.run(settings)
end

return Api
