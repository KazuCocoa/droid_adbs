module DroidAdbs
  class Apkanalyzer
    # Read https://developer.android.com/studio/command-line/apkanalyzer for more details

    attr_reader :apk_path

    def initialize(apk_path)
      raise RuntimeError, "should set path to aapt, android-sdks/build-tools/xxxx" if `which apkanalyzer`.empty?

      @apk_path = apk_path
    end

    # @return [String] package name
    #
    # @example
    #
    #     manifest_package_id #=> "io.appium.android.apis"
    #
    def manifest_package_id
      `#{command_manifest} application-id #{@apk_path}`.strip
    end

    # @param [String] out_path A path to output the result
    # @return [Integer] A number of file size
    #
    #
    def manifest_print(out_path = './manifest_print.xml')
      result = `#{command_manifest} print #{@apk_path}`.strip
      File.write out_path, result
    end

    # @return [String] A number of version name by string
    #
    # @example
    #
    #     manifest_version_name #=> "1.0"
    #
    def manifest_version_name
      `#{command_manifest} version-name #{@apk_path}`.strip
    end

    # @return [String] A number of version code by string
    #
    # @example
    #
    #     manifest_version_code #=> "1"
    #
    def manifest_version_code
      `#{command_manifest} version-code #{@apk_path}`.strip
    end

    # @return [String] A number of min sdk by string
    #
    # @example
    #
    #     manifest_min_sdk #=> "16"
    #
    def manifest_min_sdk
      `#{command_manifest} min-sdk #{@apk_path}`.strip
    end

    # @return [String] A number of target sdk by string
    #
    # @example
    #
    #     manifest_target_sdk #=> "22"
    #
    def manifest_target_sdk
      `#{command_manifest} target-sdk #{@apk_path}`.strip
    end

    # @return [[String]] A list of permissions
    #
    # @example
    #
    #     manifest_permissions #=> ["android.permission.INTERNET", "android.permission.SYSTEM_ALERT_WINDOW", "android.permission.READ_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE", "android.permission.READ_PHONE_STATE"]
    #
    def manifest_permissions
      `#{command_manifest} permissions #{@apk_path}`.strip.split("\n")
    end

    # @return [Bool] Debuggable or not
    #
    # @example
    #
    #     manifest_debuggable #=> true
    #
    def manifest_debuggable
      result = `#{command_manifest} debuggable #{@apk_path}`.strip
      return true if result == "true"
      false
    end

    # Prints the application Id, version code and version name.
    #
    # @example
    #
    #     apk_summary #=> ["com.vodqareactnative", "1", "1.0"]
    #
    def apk_summary
      `#{command_apk} summary #{@apk_path}`.strip.split("\t")
    end

    # Prints the file size of the APK.
    # 7_414_686 (byte)
    def apk_file_size
      `#{command_apk} file-size #{@apk_path}`.strip
    end

    # Prints an estimate of the download size of the APK.
    #
    # @example
    #
    #     apk_download_size #=> 7313000
    #
    def apk_download_size
      `#{command_apk} download-size #{@apk_path}`.strip
    end

    # Prints features used by the APK.
    #
    # @example
    #
    #     apk_features #=> "android.hardware.faketouch implied: default feature for all apps"
    #
    def apk_features
      puts `#{command_apk} features #{@apk_path}`.strip
    end

    # Compares the sizes of two APKs.
    def apk_compare_print(with)
      puts `#{command_apk} features #{@apk_path} #{with}`.strip
    end

    # Lists all files in the zip.
    #
    # @example
    #
    #   file_list #=> "android.hardware.faketouch implied: default feature for all apps"
    #
    def file_list
      `apkanalyzer files list #{@apk_path}`.strip.split("\n")
    end

    # Prints a list of dex files in the APK
    def dex_list
      `#{command_dex} list #{@apk_path}`.strip.split("\n")
    end

    # Prints number of references in dex files
    def dex_references(options = "")
      `#{command_dex} references #{options} #{@apk_path}`.strip
    end

    # Prints the class tree from DEX.
    # P,C,M,F: indicates packages, classes methods, fields
    # x,k,r,d: indicates removed, kept, referenced and defined nodes
    def dex_packages(options = "")
      `#{command_dex} packages #{options} #{@apk_path}`.strip
    end

    # Prints the bytecode of a class or method in smali format
    def dex_code
      `#{command_dex} code #{@apk_path}`.strip
    end

    # Prints a list of packages in resources table
    def resources_packages
      `#{command_resources} packages #{@apk_path}`.strip
    end

    # Prints a list of configurations for the specified type.
    # @param [String] type The type is a resource type such as string.
    # @param [String] package Include the --package option if you want to specify the resource table package name,
    #                         otherwise the first defined package will be used.
    #
    def resources_configs(type, package = "")
      `#{command_resources} configs --type #{type} #{package} #{@apk_path}`.strip
    end

    # Prints the value of the resource specified by config, name, and type.
    # @param [String] config
    # @param [String] name
    # @param [String] type The type option is the type of the resource, such as string.
    # @param [String] package Include the --package option if you want to specify the resource table package name,
    #                         otherwise the first defined package will be used.
    #
    # @example
    #
    #     resources_value "default", "revision_hash", "string"
    #
    def resources_value(config, name, type, package = "")
      `#{command_resources} value --config #{config} --name #{name} --type #{type} #{package} #{@apk_path}`.strip
    end

    # Prints the human-readable form of a binary XML file. Include the file option to specify the path to the file.
    def resources_xml(xml_file)
      `#{command_resources} xml --file #{xml_file} #{@apk_path}`.strip
    end

    private

    def command_manifest
      'apkanalyzer manifest'
    end

    def command_apk
      'apkanalyzer apk'
    end

    def command_dex
      'apkanalyzer dex'
    end

    def command_resources
      'apkanalyzer resources'
    end

  end # class Apkanalyzer
end # module DroidAdbs
