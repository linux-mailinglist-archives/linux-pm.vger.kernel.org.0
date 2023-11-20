Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1C7F1F2A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Nov 2023 22:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjKTV2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Nov 2023 16:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjKTV2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Nov 2023 16:28:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9B99;
        Mon, 20 Nov 2023 13:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700515693; x=1732051693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QOZ009XPlc8q/cW8PvOmx+Fl7NzUUd/iH64JSXsiqKo=;
  b=J12vOeiJoAxK9mMlm/qT0vui9lC1amwW0gsHePt24Lwo5+VSqYnv2RyM
   uVhvlaM+RGehG/25bYsMZIhxyB8353vvCmaY28bEbWp2MeQwqjhNsOGDt
   l1eaYTpN0Ep+lTETcXitRlfUHkPYecvUpGDOMFU8IwQZcJk03ypU5Yu+Z
   aXV9LP9KIvg2Qb3pihkXGs3BQsXyWT73yH/abeJg5y6yN6I2/pVklvDLI
   uzHi1pdZoXieNhHmlGUgn6rSz+CKJ7tG8tGEV0dU3r+WKtUll5a/NG7XH
   JxvfMZq8uEQm89Uv5YKKMqu8WEfUOSUdhoX18qiB9dYaPODIqOtgOKHDg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4823352"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4823352"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="7688812"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2023 13:28:11 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5BoO-0006wS-09;
        Mon, 20 Nov 2023 21:28:08 +0000
Date:   Tue, 21 Nov 2023 05:27:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 12/27] drivers/acpi/thermal_lib.c:46:5:
 warning: no previous prototype for function 'acpi_active_trip_temp'
Message-ID: <202311210522.8Y0cnwJ2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f437a8d1debff5412e36a1c9454adee193b31950
commit: 932d2c2fd0b1e8242ba7bcb7b8c2553e663e174f [12/27] ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231121/202311210522.8Y0cnwJ2-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210522.8Y0cnwJ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210522.8Y0cnwJ2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/thermal_lib.c:46:5: warning: no previous prototype for function 'acpi_active_trip_temp' [-Wmissing-prototypes]
   int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
   ^
   static 
>> drivers/acpi/thermal_lib.c:56:5: warning: no previous prototype for function 'acpi_passive_trip_temp' [-Wmissing-prototypes]
   int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
   ^
   static 
>> drivers/acpi/thermal_lib.c:61:5: warning: no previous prototype for function 'acpi_hot_trip_temp' [-Wmissing-prototypes]
   int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:61:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
   ^
   static 
>> drivers/acpi/thermal_lib.c:66:5: warning: no previous prototype for function 'acpi_critical_trip_temp' [-Wmissing-prototypes]
   int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:66:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
   ^
   static 
   4 warnings generated.


vim +/acpi_active_trip_temp +46 drivers/acpi/thermal_lib.c

    45	
  > 46	int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
    47	{
    48		char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
    49	
    50		if (id < 0 || id > 9)
    51			return -EINVAL;
    52	
    53		return acpi_trip_temp(adev, obj_name, ret_temp);
    54	}
    55	
  > 56	int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
    57	{
    58		return acpi_trip_temp(adev, "_PSV", ret_temp);
    59	}
    60	
  > 61	int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
    62	{
    63		return acpi_trip_temp(adev, "_HOT", ret_temp);
    64	}
    65	
  > 66	int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
    67	{
    68		return acpi_trip_temp(adev, "_CRT", ret_temp);
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
