Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36F7F2027
	for <lists+linux-pm@lfdr.de>; Mon, 20 Nov 2023 23:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjKTWWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Nov 2023 17:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjKTWVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Nov 2023 17:21:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709F97;
        Mon, 20 Nov 2023 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700518907; x=1732054907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sNIlOQYBsnz8Arkj044RtaI1xcSPw1WnuxuGcYJQAlk=;
  b=D90YX4A8HebaUF8fW8YQd/QZGIri8WaEGh4NOiPkFN+srONOLi5FViXu
   KgGc6/Q5kb/eMsiwSmhbxHS+nfHw2eaSLEmam3SSF4UBKJmOEiZkMq4WX
   n7f3cCAUHIwrID6rwbdxoyxNkjknr+a/Qbr+zLxfUvr2tpEZlOTXrWTAV
   qQeALbz3ATAKWavOGYkulOx0aKec+7aZVKA4GYHzp3g6Vl+ryGgvudvSS
   y0AYiN5EzKy5HX/opFFTEu8i0uuDmStJEVmP9LbP1adC/1oe4ige8gbxs
   mUrkgLg9EHYITH8tNfi6FG9H7sSOayLHr+FcgGLXL+LqTch7Op2D0Y0pc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371058712"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371058712"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857130428"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="857130428"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2023 14:21:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5CeF-0006zh-2s;
        Mon, 20 Nov 2023 22:21:43 +0000
Date:   Tue, 21 Nov 2023 06:20:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 13/27] thermal.c:undefined reference to
 `acpi_active_trip_temp'
Message-ID: <202311210507.hprTtxhv-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231121/202311210507.hprTtxhv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210507.hprTtxhv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210507.hprTtxhv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `acpi_thermal_adjust_trip':
>> thermal.c:(.text+0x5e6de6): undefined reference to `acpi_active_trip_temp'
>> ld: thermal.c:(.text+0x5e6e54): undefined reference to `acpi_passive_trip_temp'
   ld: vmlinux.o: in function `acpi_thermal_init_trip':
   thermal.c:(.text+0x5e7089): undefined reference to `acpi_active_trip_temp'
   ld: thermal.c:(.text+0x5e71f3): undefined reference to `acpi_passive_trip_temp'
   ld: vmlinux.o: in function `acpi_thermal_add':
>> thermal.c:(.text+0x5e73bf): undefined reference to `acpi_critical_trip_temp'
>> ld: thermal.c:(.text+0x5e73eb): undefined reference to `acpi_hot_trip_temp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
