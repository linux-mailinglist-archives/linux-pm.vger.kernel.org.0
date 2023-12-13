Return-Path: <linux-pm+bounces-1039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E207810BE9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 08:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B199028155C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394561A5AC;
	Wed, 13 Dec 2023 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH4AfQ29"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C169BD;
	Tue, 12 Dec 2023 23:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702454283; x=1733990283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zhr6XmX/fHUnfrR1VEsNJngQs5Qv2/CPJI50nFNpUH8=;
  b=oH4AfQ29lAizwfO24kFObOzoJ/StZKwPT0F5Bx4g2zR2Y9/MppiaHuJw
   B2R3oIOKyGL8agHJb6w3ApO/sSwD+5PJMTmvlJl7t+F0eoVOg0E5tRlXk
   XwD3v3+5Th6SpQFPSTbGGe5lx9n1HtPWzFpQg2XguigB0O1/bDBEhbQ5y
   M1rlJhpvIVSe+OcOP6y9GYOFlwgB+odcWryi1ny86Un8Ff5XMRNEC4Ps/
   42s73QrddytGylxaZEvZFLXcYAYtPNwpvh21gwTA9MW/g8o3h2bTVTYsL
   NUuZmmt24tMgaqvc9wVBW9hmJdeXjrsemh0e7gg0jLUZwid+Wh7fomCyO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="13621432"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="13621432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802794304"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="802794304"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 23:57:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDK7m-000KEZ-06;
	Wed, 13 Dec 2023 07:57:57 +0000
Date: Wed, 13 Dec 2023 15:57:41 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
	lukasz.luba@arm.com
Cc: oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
Message-ID: <202312131518.2Fjrrxot-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-debugfs-Add-thermal-debugfs-information-for-mitigation-episodes/20231213-001321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231212161047.1631077-1-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device debugfs information
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231213/202312131518.2Fjrrxot-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131518.2Fjrrxot-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131518.2Fjrrxot-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/thermal/thermal_core.h:16:0,
                    from drivers/thermal/thermal_core.c:27:
   drivers/thermal/thermal_debugfs.h: In function 'thermal_debug_cdev_add':
>> drivers/thermal/thermal_debugfs.h:10:50: error: parameter name omitted
    static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}
                                                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_debugfs.h: In function 'thermal_debug_cdev_remove':
   drivers/thermal/thermal_debugfs.h:11:53: error: parameter name omitted
    static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *) {}
                                                        ^~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_debugfs.h: In function 'thermal_debug_cdev_transition':
   drivers/thermal/thermal_debugfs.h:12:57: error: parameter name omitted
    static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_debugfs.h:12:57: error: parameter name omitted


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

