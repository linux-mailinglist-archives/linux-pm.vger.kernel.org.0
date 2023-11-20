Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40D67F1FCF
	for <lists+linux-pm@lfdr.de>; Mon, 20 Nov 2023 22:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKTV63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Nov 2023 16:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKTV63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Nov 2023 16:58:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3733ECB;
        Mon, 20 Nov 2023 13:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700517505; x=1732053505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RUVd5dQlPkTNx/mYNqXBDe31H3anIGZCPPAlDc79GMA=;
  b=Rj4a0FedPOSf68a/sz+ZE/CvilwAaqGqDjPsjM6wO9b4GV3s2XYxFUFp
   UKa1U/2c/pPxtCHrOmRUgYTvB01FT+E0AQ1x108JISKUxgWUibeYIlDWP
   Jtoin/V4IrBtpzdJFnX4xd+rxkL1X2YeRkrJiXmoYEOtjvXazhuTfmCBe
   7clh+GpjWYESd/kBsQS7+CJHLpK/ToNB1PKlzvWvciLPsJ8E174Zro+vm
   L9vHCfQMEAMR13WYKiQgTeKyjmpimIYUJo7WciHfw8+KKCLyCOclS8l69
   5CzLxnOQMipNaC+gc3l0UdLlY878o2h9mRa3Bm78ODFlH5p7MAsByNUz9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="477920169"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="477920169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="7850310"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Nov 2023 13:58:23 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5CHX-0006xu-2D;
        Mon, 20 Nov 2023 21:58:19 +0000
Date:   Tue, 21 Nov 2023 05:57:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 13/27] thermal.c:undefined reference to
 `acpi_passive_trip_temp'
Message-ID: <202311210503.P7Q5J2On-lkp@intel.com>
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
commit: d967ccd25df78cb5bd789ce9799d4463ea77eb5b [13/27] ACPI: thermal: Use library functions to obtain trip point temperature values
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231121/202311210503.P7Q5J2On-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210503.P7Q5J2On-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210503.P7Q5J2On-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/thermal.o: in function `get_active_temp':
   thermal.c:(.text+0x22): undefined reference to `acpi_active_trip_temp'
   ld: drivers/acpi/thermal.o: in function `acpi_thermal_init_trip':
>> thermal.c:(.text+0x356): undefined reference to `acpi_passive_trip_temp'
   ld: drivers/acpi/thermal.o: in function `acpi_thermal_adjust_trip':
   thermal.c:(.text+0x872): undefined reference to `acpi_passive_trip_temp'
   ld: drivers/acpi/thermal.o: in function `acpi_thermal_add':
>> thermal.c:(.text+0xaec): undefined reference to `acpi_hot_trip_temp'
>> ld: thermal.c:(.text+0xd79): undefined reference to `acpi_critical_trip_temp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
