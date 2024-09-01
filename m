Return-Path: <linux-pm+bounces-13294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D649967409
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 02:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D111F21F80
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD117984;
	Sun,  1 Sep 2024 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aamsQhR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6D171A5;
	Sun,  1 Sep 2024 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725150988; cv=none; b=NKvlrepsYYwhsyV91J3C16wazxtde/bXRXkjfLxL0jVRTL+tCCdykKg2ec4LAJWStLO+t/+2n/VNhtFjwJ/ohApToVvUUfmiJPDjgJN5QjNGhdY+G9Dhdd3dZygHPGORKxx8GKzn537Zl2CLgn4nqSmFJaHYftDonRaj6gzqibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725150988; c=relaxed/simple;
	bh=UxR0OnIimHF9rR18Gme/OsJ2lxVmLqZOtPfpB1ch2mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKYIWww0uQ0PipENkN9OcyE+mvEYqj/s5s91NyCers0uPY5hyoaf6WRO3iYDpQwsLmgvAIAiB0GRvdspNzKA8EdFuXcSWxroaK4IExwOgP5hkrvOJIb5oPgOBQkbtCfMDoNqk3mrn7g9C/1MlnIhfJiNmNF01A8/XzXJFyYf4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aamsQhR7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725150986; x=1756686986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UxR0OnIimHF9rR18Gme/OsJ2lxVmLqZOtPfpB1ch2mY=;
  b=aamsQhR7amBGUCERISaTNasvDcWZVoBFcBpnEj3WLaX/CQAvidpBNnc1
   9g+Q5ZRnrr85/29qOQfF5usyKA5YgiGkiHlHoTbncfJYYByc5lF/ysiy4
   IOKC80EH135Y/hDf9kFD277bD7C3glff4GwvpB8aD6meSuVoEQnTcq/w4
   bIyIE0YYb7z6NI0VjZb46H1z+EItLpZavGJzjoejrNLfkij59pAapZ9dM
   DUwO9MpsR6558k2BVnidaIUyDvZHeiWEJLCoS63QZ5oXUvF2k6wKwyfOJ
   sssXqLGyZkxDVlZFKHT24kGDNUG1EsC9g56olHoZRziC8CY6Oqe27yMzH
   Q==;
X-CSE-ConnectionGUID: zkDllj3NSBOSa91J4FJxWA==
X-CSE-MsgGUID: G6flNnzRQJuJWzdazLNi+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="41259733"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="41259733"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 17:36:26 -0700
X-CSE-ConnectionGUID: Xo2xN503Q4qIGPvRzJqZng==
X-CSE-MsgGUID: OUY7ThFNSYCVyZ8AYjOv5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64063273"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 31 Aug 2024 17:36:24 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skYZp-0003Du-2p;
	Sun, 01 Sep 2024 00:36:21 +0000
Date: Sun, 1 Sep 2024 08:35:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v2] power: supply: max1720x: add read support for nvmem
Message-ID: <202409010834.TxoQkZvt-lkp@intel.com>
References: <20240831182145.11589-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831182145.11589-1-dima.fedrau@gmail.com>

Hi Dimitri,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau/power-supply-max1720x-add-read-support-for-nvmem/20240901-022223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240831182145.11589-1-dima.fedrau%40gmail.com
patch subject: [PATCH v2] power: supply: max1720x: add read support for nvmem
config: i386-buildonly-randconfig-001-20240901 (https://download.01.org/0day-ci/archive/20240901/202409010834.TxoQkZvt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409010834.TxoQkZvt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409010834.TxoQkZvt-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/power/supply/max1720x_battery.c:137:37: error: array type has incomplete element type 'struct nvmem_cell_info'
     137 | static const struct nvmem_cell_info max1720x_nvmem_cells[] = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/max1720x_battery.c: In function 'max1720x_probe_nvmem':
>> drivers/power/supply/max1720x_battery.c:404:16: error: variable 'nvmem_config' has initializer but incomplete type
     404 |         struct nvmem_config nvmem_config = {
         |                ^~~~~~~~~~~~
>> drivers/power/supply/max1720x_battery.c:405:18: error: 'struct nvmem_config' has no member named 'dev'
     405 |                 .dev = dev,
         |                  ^~~
>> drivers/power/supply/max1720x_battery.c:405:24: warning: excess elements in struct initializer
     405 |                 .dev = dev,
         |                        ^~~
   drivers/power/supply/max1720x_battery.c:405:24: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:406:18: error: 'struct nvmem_config' has no member named 'name'
     406 |                 .name = "max1720x_nvmem",
         |                  ^~~~
   drivers/power/supply/max1720x_battery.c:406:25: warning: excess elements in struct initializer
     406 |                 .name = "max1720x_nvmem",
         |                         ^~~~~~~~~~~~~~~~
   drivers/power/supply/max1720x_battery.c:406:25: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:407:18: error: 'struct nvmem_config' has no member named 'cells'
     407 |                 .cells = max1720x_nvmem_cells,
         |                  ^~~~~
   drivers/power/supply/max1720x_battery.c:407:26: warning: excess elements in struct initializer
     407 |                 .cells = max1720x_nvmem_cells,
         |                          ^~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/max1720x_battery.c:407:26: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:408:18: error: 'struct nvmem_config' has no member named 'ncells'
     408 |                 .ncells = ARRAY_SIZE(max1720x_nvmem_cells),
         |                  ^~~~~~
   In file included from include/linux/bitfield.h:10,
                    from drivers/power/supply/max1720x_battery.c:10:
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:243:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/power/supply/max1720x_battery.c:408:27: note: in expansion of macro 'ARRAY_SIZE'
     408 |                 .ncells = ARRAY_SIZE(max1720x_nvmem_cells),
         |                           ^~~~~~~~~~
   In file included from include/linux/string.h:6,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/power/supply/max1720x_battery.c:11:
   include/linux/array_size.h:11:25: warning: excess elements in struct initializer
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/power/supply/max1720x_battery.c:408:27: note: in expansion of macro 'ARRAY_SIZE'
     408 |                 .ncells = ARRAY_SIZE(max1720x_nvmem_cells),
         |                           ^~~~~~~~~~
   include/linux/array_size.h:11:25: note: (near initialization for 'nvmem_config')
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/power/supply/max1720x_battery.c:408:27: note: in expansion of macro 'ARRAY_SIZE'
     408 |                 .ncells = ARRAY_SIZE(max1720x_nvmem_cells),
         |                           ^~~~~~~~~~
>> drivers/power/supply/max1720x_battery.c:409:18: error: 'struct nvmem_config' has no member named 'read_only'
     409 |                 .read_only = true,
         |                  ^~~~~~~~~
   drivers/power/supply/max1720x_battery.c:409:30: warning: excess elements in struct initializer
     409 |                 .read_only = true,
         |                              ^~~~
   drivers/power/supply/max1720x_battery.c:409:30: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:410:18: error: 'struct nvmem_config' has no member named 'root_only'
     410 |                 .root_only = true,
         |                  ^~~~~~~~~
   drivers/power/supply/max1720x_battery.c:410:30: warning: excess elements in struct initializer
     410 |                 .root_only = true,
         |                              ^~~~
   drivers/power/supply/max1720x_battery.c:410:30: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:411:18: error: 'struct nvmem_config' has no member named 'reg_read'
     411 |                 .reg_read = max1720x_nvmem_reg_read,
         |                  ^~~~~~~~
   drivers/power/supply/max1720x_battery.c:411:29: warning: excess elements in struct initializer
     411 |                 .reg_read = max1720x_nvmem_reg_read,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/max1720x_battery.c:411:29: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:412:18: error: 'struct nvmem_config' has no member named 'size'
     412 |                 .size = ARRAY_SIZE(max1720x_nvmem_cells) * 2,
         |                  ^~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:243:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/power/supply/max1720x_battery.c:412:25: note: in expansion of macro 'ARRAY_SIZE'
     412 |                 .size = ARRAY_SIZE(max1720x_nvmem_cells) * 2,
         |                         ^~~~~~~~~~
   include/linux/array_size.h:11:25: warning: excess elements in struct initializer
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/power/supply/max1720x_battery.c:412:25: note: in expansion of macro 'ARRAY_SIZE'
     412 |                 .size = ARRAY_SIZE(max1720x_nvmem_cells) * 2,
         |                         ^~~~~~~~~~
   include/linux/array_size.h:11:25: note: (near initialization for 'nvmem_config')
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/power/supply/max1720x_battery.c:412:25: note: in expansion of macro 'ARRAY_SIZE'
     412 |                 .size = ARRAY_SIZE(max1720x_nvmem_cells) * 2,
         |                         ^~~~~~~~~~
>> drivers/power/supply/max1720x_battery.c:413:18: error: 'struct nvmem_config' has no member named 'word_size'
     413 |                 .word_size = 2,
         |                  ^~~~~~~~~
   drivers/power/supply/max1720x_battery.c:413:30: warning: excess elements in struct initializer
     413 |                 .word_size = 2,
         |                              ^
   drivers/power/supply/max1720x_battery.c:413:30: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:414:18: error: 'struct nvmem_config' has no member named 'stride'
     414 |                 .stride = 2,
         |                  ^~~~~~
   drivers/power/supply/max1720x_battery.c:414:27: warning: excess elements in struct initializer
     414 |                 .stride = 2,
         |                           ^
   drivers/power/supply/max1720x_battery.c:414:27: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:415:18: error: 'struct nvmem_config' has no member named 'priv'
     415 |                 .priv = info,
         |                  ^~~~
   drivers/power/supply/max1720x_battery.c:415:25: warning: excess elements in struct initializer
     415 |                 .priv = info,
         |                         ^~~~
   drivers/power/supply/max1720x_battery.c:415:25: note: (near initialization for 'nvmem_config')
>> drivers/power/supply/max1720x_battery.c:404:29: error: storage size of 'nvmem_config' isn't known
     404 |         struct nvmem_config nvmem_config = {
         |                             ^~~~~~~~~~~~
>> drivers/power/supply/max1720x_battery.c:453:17: error: implicit declaration of function 'devm_nvmem_register'; did you mean 'device_register'? [-Werror=implicit-function-declaration]
     453 |         nvmem = devm_nvmem_register(dev, &nvmem_config);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 device_register
>> drivers/power/supply/max1720x_battery.c:404:29: warning: unused variable 'nvmem_config' [-Wunused-variable]
     404 |         struct nvmem_config nvmem_config = {
         |                             ^~~~~~~~~~~~
   drivers/power/supply/max1720x_battery.c: At top level:
>> drivers/power/supply/max1720x_battery.c:137:37: warning: 'max1720x_nvmem_cells' defined but not used [-Wunused-variable]
     137 | static const struct nvmem_cell_info max1720x_nvmem_cells[] = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +137 drivers/power/supply/max1720x_battery.c

   136	
 > 137	static const struct nvmem_cell_info max1720x_nvmem_cells[] = {
   138		{ .name = "nXTable0",  .offset = 0,  .bytes = 2, },
   139		{ .name = "nXTable1",  .offset = 2,  .bytes = 2, },
   140		{ .name = "nXTable2",  .offset = 4,  .bytes = 2, },
   141		{ .name = "nXTable3",  .offset = 6,  .bytes = 2, },
   142		{ .name = "nXTable4",  .offset = 8,  .bytes = 2, },
   143		{ .name = "nXTable5",  .offset = 10, .bytes = 2, },
   144		{ .name = "nXTable6",  .offset = 12, .bytes = 2, },
   145		{ .name = "nXTable7",  .offset = 14, .bytes = 2, },
   146		{ .name = "nXTable8",  .offset = 16, .bytes = 2, },
   147		{ .name = "nXTable9",  .offset = 18, .bytes = 2, },
   148		{ .name = "nXTable10", .offset = 20, .bytes = 2, },
   149		{ .name = "nXTable11", .offset = 22, .bytes = 2, },
   150		{ .name = "nUser18C",  .offset = 24, .bytes = 2, },
   151		{ .name = "nUser18D",  .offset = 26, .bytes = 2, },
   152		{ .name = "nODSCTh",   .offset = 28, .bytes = 2, },
   153		{ .name = "nODSCCfg",  .offset = 30, .bytes = 2, },
   154	
   155		{ .name = "nOCVTable0",  .offset = 32, .bytes = 2, },
   156		{ .name = "nOCVTable1",  .offset = 34, .bytes = 2, },
   157		{ .name = "nOCVTable2",  .offset = 36, .bytes = 2, },
   158		{ .name = "nOCVTable3",  .offset = 38, .bytes = 2, },
   159		{ .name = "nOCVTable4",  .offset = 40, .bytes = 2, },
   160		{ .name = "nOCVTable5",  .offset = 42, .bytes = 2, },
   161		{ .name = "nOCVTable6",  .offset = 44, .bytes = 2, },
   162		{ .name = "nOCVTable7",  .offset = 46, .bytes = 2, },
   163		{ .name = "nOCVTable8",  .offset = 48, .bytes = 2, },
   164		{ .name = "nOCVTable9",  .offset = 50, .bytes = 2, },
   165		{ .name = "nOCVTable10", .offset = 52, .bytes = 2, },
   166		{ .name = "nOCVTable11", .offset = 54, .bytes = 2, },
   167		{ .name = "nIChgTerm",   .offset = 56, .bytes = 2, },
   168		{ .name = "nFilterCfg",  .offset = 58, .bytes = 2, },
   169		{ .name = "nVEmpty",     .offset = 60, .bytes = 2, },
   170		{ .name = "nLearnCfg",   .offset = 62, .bytes = 2, },
   171	
   172		{ .name = "nQRTable00",  .offset = 64, .bytes = 2, },
   173		{ .name = "nQRTable10",  .offset = 66, .bytes = 2, },
   174		{ .name = "nQRTable20",  .offset = 68, .bytes = 2, },
   175		{ .name = "nQRTable30",  .offset = 70, .bytes = 2, },
   176		{ .name = "nCycles",     .offset = 72, .bytes = 2, },
   177		{ .name = "nFullCapNom", .offset = 74, .bytes = 2, },
   178		{ .name = "nRComp0",     .offset = 76, .bytes = 2, },
   179		{ .name = "nTempCo",     .offset = 78, .bytes = 2, },
   180		{ .name = "nIAvgEmpty",  .offset = 80, .bytes = 2, },
   181		{ .name = "nFullCapRep", .offset = 82, .bytes = 2, },
   182		{ .name = "nVoltTemp",   .offset = 84, .bytes = 2, },
   183		{ .name = "nMaxMinCurr", .offset = 86, .bytes = 2, },
   184		{ .name = "nMaxMinVolt", .offset = 88, .bytes = 2, },
   185		{ .name = "nMaxMinTemp", .offset = 90, .bytes = 2, },
   186		{ .name = "nSOC",        .offset = 92, .bytes = 2, },
   187		{ .name = "nTimerH",     .offset = 94, .bytes = 2, },
   188	
   189		{ .name = "nConfig",    .offset = 96,  .bytes = 2, },
   190		{ .name = "nRippleCfg", .offset = 98,  .bytes = 2, },
   191		{ .name = "nMiscCfg",   .offset = 100, .bytes = 2, },
   192		{ .name = "nDesignCap", .offset = 102, .bytes = 2, },
   193		{ .name = "nHibCfg",    .offset = 104, .bytes = 2, },
   194		{ .name = "nPackCfg",   .offset = 106, .bytes = 2, },
   195		{ .name = "nRelaxCfg",  .offset = 108, .bytes = 2, },
   196		{ .name = "nConvgCfg",  .offset = 110, .bytes = 2, },
   197		{ .name = "nNVCfg0",    .offset = 112, .bytes = 2, },
   198		{ .name = "nNVCfg1",    .offset = 114, .bytes = 2, },
   199		{ .name = "nNVCfg2",    .offset = 116, .bytes = 2, },
   200		{ .name = "nSBSCfg",    .offset = 118, .bytes = 2, },
   201		{ .name = "nROMID0",    .offset = 120, .bytes = 2, },
   202		{ .name = "nROMID1",    .offset = 122, .bytes = 2, },
   203		{ .name = "nROMID2",    .offset = 124, .bytes = 2, },
   204		{ .name = "nROMID3",    .offset = 126, .bytes = 2, },
   205	
   206		{ .name = "nVAlrtTh",      .offset = 128, .bytes = 2, },
   207		{ .name = "nTAlrtTh",      .offset = 130, .bytes = 2, },
   208		{ .name = "nSAlrtTh",      .offset = 132, .bytes = 2, },
   209		{ .name = "nIAlrtTh",      .offset = 134, .bytes = 2, },
   210		{ .name = "nUser1C4",      .offset = 136, .bytes = 2, },
   211		{ .name = "nUser1C5",      .offset = 138, .bytes = 2, },
   212		{ .name = "nFullSOCThr",   .offset = 140, .bytes = 2, },
   213		{ .name = "nTTFCfg",       .offset = 142, .bytes = 2, },
   214		{ .name = "nCGain",        .offset = 144, .bytes = 2, },
   215		{ .name = "nTCurve",       .offset = 146, .bytes = 2, },
   216		{ .name = "nTGain",        .offset = 148, .bytes = 2, },
   217		{ .name = "nTOff",         .offset = 150, .bytes = 2, },
   218		{ .name = "nManfctrName0", .offset = 152, .bytes = 2, },
   219		{ .name = "nManfctrName1", .offset = 154, .bytes = 2, },
   220		{ .name = "nManfctrName2", .offset = 156, .bytes = 2, },
   221		{ .name = "nRSense",       .offset = 158, .bytes = 2, },
   222	
   223		{ .name = "nUser1D0",       .offset = 160, .bytes = 2, },
   224		{ .name = "nUser1D1",       .offset = 162, .bytes = 2, },
   225		{ .name = "nAgeFcCfg",      .offset = 164, .bytes = 2, },
   226		{ .name = "nDesignVoltage", .offset = 166, .bytes = 2, },
   227		{ .name = "nUser1D4",       .offset = 168, .bytes = 2, },
   228		{ .name = "nRFastVShdn",    .offset = 170, .bytes = 2, },
   229		{ .name = "nManfctrDate",   .offset = 172, .bytes = 2, },
   230		{ .name = "nFirstUsed",     .offset = 174, .bytes = 2, },
   231		{ .name = "nSerialNumber0", .offset = 176, .bytes = 2, },
   232		{ .name = "nSerialNumber1", .offset = 178, .bytes = 2, },
   233		{ .name = "nSerialNumber2", .offset = 180, .bytes = 2, },
   234		{ .name = "nDeviceName0",   .offset = 182, .bytes = 2, },
   235		{ .name = "nDeviceName1",   .offset = 184, .bytes = 2, },
   236		{ .name = "nDeviceName2",   .offset = 186, .bytes = 2, },
   237		{ .name = "nDeviceName3",   .offset = 188, .bytes = 2, },
   238		{ .name = "nDeviceName4",   .offset = 190, .bytes = 2, },
   239	};
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

