assimpPath = "%{wks.location}/dependencies/assimp"
assimpBuildPath = "%{assimpPath}/lib/%{cfg.buildcfg}"

if not os.isfile("code/assimp.vcxproj") or not os.isfile("contrib/zlib/zlibstatic.vcxproj") then
	printf "Generating Assimp Project Files..."
	os.execute "cmake -DBUILD_SHARED_LIBS=OFF -DASSIMP_NO_EXPORT=ON -DASSIMP_BUILD_ZLIB=ON CMakeLists.txt"
else
	printf "Skipping Assimp, files already created"
end

externalproject "assimp"
	kind "StaticLib"
	location "code"

externalproject "zlibstatic"
	kind "StaticLib"
	location "contrib/zlib"


IncludeDir["assimp"] = "%{assimpPath}/include"
LibraryDir["assimp"] = "%{assimpBuildPath}"
LibraryDir["zlib"] = "%{assimpPath}/contrib/zlib/%{cfg.buildcfg}"

Link["assimp_debug"] = "assimp-vc143-mtd"
Link["assimp_release"] = "assimp-vc143-mt"
Link["zlib_debug"] = "zlibstaticd.lib"
Link["zlib_release"] = "zlibstatic.lib"