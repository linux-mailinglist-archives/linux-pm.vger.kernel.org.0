Return-Path: <linux-pm+bounces-1030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B58107E0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 02:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D522928237E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 01:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD8ECE;
	Wed, 13 Dec 2023 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuWgsYjq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25751AD;
	Tue, 12 Dec 2023 17:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702432368; x=1733968368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ooWOO96PMnesatUTdbVVnvwmOIWOsYIyqsD//zdqSlQ=;
  b=HuWgsYjqUmaaeyJhQY8wmHVRzXXB65E0qoyOT8499g9jkd69V8YMYLsF
   XpEIIuurGEviEjH5+9m5x7mYzYWnKjrqKdFcrDxGDgdothkOPIhcKS/+v
   grvyCelLJeNMgRxYIsMJxST3/7Zub47oYbRu4iiQeb5TV4pjAuV8jgC1D
   ObCY65bQp0SDogyIg7WVNKLfN0ZROEbnsWVnLryv8hVvOfF20kRUWCbez
   eLn2SPRahCzibulHtt+1G6WxJHyDgp9QjntgWRAYe5NTH4Y2QHwdS75TV
   8cGksgU8jGQVp0MAV35etxnOc8s/kwbZdqWVQHzl4asOg42rfM758nF63
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461374968"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461374968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 17:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="15247229"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Dec 2023 17:52:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDEQV-000Jyv-0j;
	Wed, 13 Dec 2023 01:52:43 +0000
Date: Wed, 13 Dec 2023 09:52:26 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
	lukasz.luba@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rui.zhang@intel.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
Message-ID: <202312130936.rLIRgZBE-lkp@intel.com>
References: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212161047.1631077-1-daniel.lezcano@linaro.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.7-rc5 next-20231212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-debugfs-Add-thermal-debugfs-information-for-mitigation-episodes/20231213-001321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231212161047.1631077-1-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device debugfs information
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231213/202312130936.rLIRgZBE-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130936.rLIRgZBE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130936.rLIRgZBE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/thermal/thermal_core.c:27:
   In file included from drivers/thermal/thermal_core.h:16:
>> drivers/thermal/thermal_debugfs.h:10:74: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}
                                                                            ^
   drivers/thermal/thermal_debugfs.h:11:77: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *) {}
                                                                               ^
   drivers/thermal/thermal_debugfs.h:12:81: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                                                   ^
   drivers/thermal/thermal_debugfs.h:12:86: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                                                        ^
   4 warnings generated.
--
   In file included from drivers/thermal/thermal_helpers.c:22:
   In file included from drivers/thermal/thermal_core.h:16:
>> drivers/thermal/thermal_debugfs.h:10:74: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}
                                                                            ^
   drivers/thermal/thermal_debugfs.h:11:77: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *) {}
                                                                               ^
   drivers/thermal/thermal_debugfs.h:12:81: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                                                   ^
   drivers/thermal/thermal_debugfs.h:12:86: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                                                        ^
>> drivers/thermal/thermal_helpers.c:154:6: warning: no previous prototype for function 'thermal_set_delay_jiffies' [-Wmissing-prototypes]
   void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
        ^
   drivers/thermal/thermal_helpers.c:154:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
   ^
   static 
   5 warnings generated.
--
   In file included from drivers/thermal/tegra/soctherm.c:36:
   In file included from drivers/thermal/tegra/../thermal_core.h:16:
>> drivers/thermal/tegra/../thermal_debugfs.h:10:74: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}
                                                                            ^
   drivers/thermal/tegra/../thermal_debugfs.h:11:77: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *) {}
                                                                               ^
   drivers/thermal/tegra/../thermal_debugfs.h:12:81: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                                                   ^
   drivers/thermal/tegra/../thermal_debugfs.h:12:86: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                                                        ^
   4 warnings generated.


vim +10 drivers/thermal/thermal_debugfs.h

     2	
     3	#ifdef CONFIG_THERMAL_DEBUGFS
     4	void thermal_debug_init(void);
     5	void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
     6	void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
     7	void thermal_debug_cdev_transition(struct thermal_cooling_device *cdev, int state);
     8	#else
     9	static inline void thermal_debug_init(void) {}
  > 10	static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

