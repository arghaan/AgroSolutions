

AddShopCategory = {}; 
local modDirectory = g_currentModDirectory or ""
local modName = g_currentModName or "unknown"

function AddShopCategory:ownCategory()
	
    self.modDirectory = modDirectory
    self.modName = modName

	local categoryXMLFile = XMLFile.load("storeCategoriesXML", Utils.getFilename("xml/storeCategories.xml", self.modDirectory))

	categoryXMLFile:iterate("categories.category", function (_, key)
		self:loadCategoryFromXML(categoryXMLFile, key, "")
	end)
	categoryXMLFile:delete()
end; 

function AddShopCategory:loadCategoryFromXML(xmlFile, key)
	local name = xmlFile:getString(key .. "#name")
	local title = xmlFile:getString(key .. "#title")
	local imageFilename = xmlFile:getString(key .. "#image")
	local type = xmlFile:getString(key .. "#type")
	local orderId = xmlFile:getInt(key .. "#orderId")

	if title ~= nil and title:sub(1, 6) == "$l10n_" then
		title = g_i18n:getText(title:sub(7))
	end

	g_storeManager:addCategory(name, title,imageFilename , type, AddShopCategory:getFullImagePath(imageFilename, self.modName), orderId)
end

addModEventListener(AddShopCategory);

function AddShopCategory:getFullImagePath(imagePath)
	if imagePath:sub(0, 1) == "$" then
		return "";
	else
		return self.modDirectory .. "";
	end; 
end;

function loadMapData()
AddShopCategory:ownCategory()
end

StoreManager.loadMapData = Utils.appendedFunction(StoreManager.loadMapData, loadMapData)


