# bench
An easy-to-use CC package manager.

## installation
To install bench, just run this command on any CC computer:

`pastebin run kM6uhwTz install bench`

## repositories
Repositories are JSON files following a specific structure, containing data about packages. Adding repositories will allow you to install packages from the given repositories. By default, every bench installation will include the [main](https://github.com/apemanzilla-cc/bench/blob/master/repos/main.json) repository, which contains `bench` istelf and a few related packages.

## repository format
Repositories must be JSON files, following the structure described below.

Here is a simple example repository:

```json
{
  "name": "example",
  "description": "this is an example repository!",
  "packages": [
    {
      "name": "example-package",
      "description": "this is an example package!",
      "version": 1.0,
      "download": {
        "main.lua": "https://raw.githubusercontent.com/apemanzilla-cc/bench/master/src/hello.lua"
      },
      "depends": ["main/hellolib"],
      "launch": "example.lua",
      "tags": ["example"]
    }
  ]
}
```

### 1 - name (string, required)
The `name` attribute in a repository specifies the display name that will be used. This allows you to choose which package to install if multiple repositories have packages with the same name.

Since you cannot add two repositories with the same name, please choose unique names for your repositories, such as your username.

### 2 - description (string, required)
The `description` attribute in a repository is a short, human-readable description of the repository and its contents. It is currently not used, but will be in future versions.

### 3 - packages (array, required)
The `packages` attribute contains package objects, which are described below. This is a list of packages that can be installed from the repository.

#### 3.1 - name (string, required)
The `name` attribute in a package specifies the display name of a package. It is used a lot throughout bench, so try to choose a good name for your package! Also, avoid changing package names between versions, or removing them. It may cause problems or unexpected behavior.

#### 3.2 - description (string, required)
The `description` attribute in a repository is a short, human-readable description of the package and what it's used for. It is currently not used, but will be in future versions.

#### 3.3 - version (number, required)
The `version` attribute should be incremented in your repository file every time the package is updated. It doesn't matter how much you increment it by, as long as it's greater than it was before. This lets bench users update your package via `bench upgrade`

#### 3.4 - download (object, optional)
The `download` attribute is a set of filenames mapped to URIs to download packages. Supported protocols for URIs are currently : `http://[url]`, `https://[url]`, `pastebin://[pastebin_id]`, and `file://[path]`. The `file://` protocol will use files locally on your computer, and is therefore not recommended for anything except development and testing.

#### 3.5 - depends (array, optional)
The `depends` attribute specifies packages that must be downloaded for your package to be used. This should be an array of strings - package names. If the package names are unqualified (eg `package` instead of `repo/package`) then it is assumed that the packages are in the same repository as the package that depends upon them.

#### 3.6 - launch (string, optional)
The `launch` attribute specifies which file from the package to use when running the package. If omitted, the package will not be launchable, so `bench launch package` and `bench launcher package` will fail. `require` will still be usable to load files from the package, however.

#### 3.7 - install_location (string, optional)
The `install_location` attribute specifies where package data should be downloaded and saved. Do NOT use this attribute unless you know exactly what you are trying to do - bench will handle it automatically!

#### 3.8 - tags (array, optional)
The `tags` attribute specifies search tags to use. It is not currently used, but will be in the future.

#### 3.9 - setup and cleanup (string, optional)
The `setup` and `cleanup` attributes specify files to run when the package is being installed or removed, respectively. During installation, if the setup script fails, the installation will also fail and be reverted. This does not happen during cleanup.

This program uses a minified version of Jeffrey Friedl's [JSON API](http://regex.info/blog/lua/json), which is licensed under the [Creative Commons license with attribution](https://creativecommons.org/licenses/by/3.0/us/)
