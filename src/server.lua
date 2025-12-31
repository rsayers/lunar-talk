local S = {}
function S:dialect()
   return "LunarTalk"
end

function S:version()
   return "0.0.1"
end

function S:colors() end

function S:logo() end

function S:saveImage() end

function S:systemStats() end

function S:themes() end

function S:icons() end

function S:packageNames() end

function S:packageTree() end

function S:packageNamed(packagename) end

function S:packageClasses(packagename, extended, category) end

function S:classTree(root, depth, onlyNames) end

function S:classTree2(root, depth) end

function S:classNames() end

function S:classNamed(classname) end

function S:superclasses(classname) end

function S:subclasses(classname) end

function S:instanceVariables(classname) end

function S:classVariables(classname) end

function S:variables(classname) end

function S:categories(classname) end

function S:usedCategories(classname) end

function S:allCategories() end

function S:usualCategories(meta) end

function S:selectors(classname, sorted) end

function S:methods(classname, sorted, basic, modified) end

function S:method(classname, selector) end

function S:methodHistory(classname, selector) end

function S:autocompletions(classname, source, position) end

function S:searchClassNames(text) end

function S:searchPackageNames(text) end

function S:search(text, ignoreCase, condition, type) end

function S:selectorInSource(source, position) end

function S:senders(selector, basic) end

function S:accessors(classname, variable, type, sorted, basic, modified) end

function S:sendersCount(selector) end

function S:localSenders(selector, classname, basic) end

function S:classReferences(classname, basic) end

function S:stringReferences(string, basic) end

function S:implementors(selector, basic) end

function S:localImplementors(selector, classname, basic) end

function S:methodsMatching(pattern, basic) end

function S:methodTemplate() end

function S:classTemplate(pack) end

function S:methodsInCategory(classname, category, sorted, basic) end

function S:modifiedMethodCount(classname) end

function S:debuggers() end

function S:createDebugger(id) end

function S:debuggerFrames(id) end

function S:debuggerFrame(id, index) end

function S:frameBindings(id, index) end

function S:stepIntoDebugger(id, index) end

function S:stepOverDebugger(id, index) end

function S:stepThroughDebugger(id, index) end

function S:runToCursorDebugger(id, index, position) end

function S:restartDebugger(id, index, update) end

function S:resumeDebugger(id) end

function S:terminateDebugger(id) end

function S:deleteDebugger(id) end

function S:workspaces() end

function S:createWorkspace() end

function S:workspace(id) end

function S:saveWorkspace(workspace) end

function S:deleteWorkspace(id) end

function S:workspaceBindings(id) end

function S:usesChanges() end

function S:lastChanges() end

function S:postChange(change, description) end

function S:postCommand(command, description) end

function S:downloadChanges(changes) end

function S:uploadChangeset(changeset) end

function S:updateChanges(changes) end

function S:compressChanges(changes) end

function S:extensions(elementType) end

function S:commandDefinitions(elementType) end

function S:createPackage(packagename) end

function S:removePackage(packagename) end

function S:renamePackage(packagename, newName) end

function S:defineClass(classname, superclassname, packagename, definition) end

function S:commentClass(classname, comment) end

function S:removeClass(classname) end

function S:renameClass(classname, newName, renameReferences) end

function S:addInstanceVariable(classname, variable) end

function S:addClassVariable(classname, variable) end

function S:renameInstanceVariable(classname, variable, newName) end

function S:renameClassVariable(classname, variable, newName) end

function S:removeInstanceVariable(classname, variable) end

function S:removeClassVariable(classname, variable) end

function S:moveInstanceVariableUp(classname, variable) end

function S:moveInstanceVariableDown(classname, variable, target) end

function S:renameCategory(classname, category, newName) end

function S:removeCategory(classname, category) end

function S:compileMethod(classname, packagename, category, source) end

function S:removeMethod(classname, selector) end

function S:classifyMethod(classname, selector, category) end

function S:renameSelector(classname, selector, newSelector) end

function S:addClassCategory(packagename, category) end

function S:renameClassCategory(packagename, category, newName) end

function S:removeClassCategory(packagename, category) end

function S:evaluateExpression(expression, sync, pin, context, assignee) end

function S:issueEvaluation(evaluation) end

function S:pauseEvaluation(id) end

function S:cancelEvaluation(id) end

function S:evaluation(id) end

function S:evaluations() end

function S:debugExpression(expression, context) end

function S:profileExpression(expression, context) end

function S:objects() end

function S:objectWithId(id) end

function S:unpinObject(id) end

function S:unpinAllObjects() end

function S:objectNamedSlots(id, path) end

function S:objectIndexedSlots(id, path) end

function S:objectInstanceVariables(id, path) end

function S:objectViews(id, path) end

function S:objectSlot(id, path) end

function S:pinObjectSlot(id, path) end

function S:testRuns() end

function S:runTestSuite(suite) end

function S:runTest(classname, selector) end

function S:runTestClass(classname) end

function S:runTestPackage(packagename) end

function S:testRunStatus(id) end

function S:testRunResults(id) end

function S:runTestRun(id) end

function S:stopTestRun(id) end

function S:deleteTestRun(id) end

function S:debugTest(id, classname, selector) end

function S:profilerTreeResults(id) end

function S:profilerRankingResults(id) end

function S:deleteProfiler(id) end

function S:nativeDebugger(id) end

function S:nativeDebuggerFrames(id) end

function S:nativeDebuggerRegisters(id) end

function S:nativeDebuggerSpaces(id) end

function S:nativeDebuggerFrame(id, index) end

function S:resumeNativeDebugger(id) end

function S:suspendNativeDebugger(id) end

function S:pinNativeDebuggerRegister(id, register) end

return S
