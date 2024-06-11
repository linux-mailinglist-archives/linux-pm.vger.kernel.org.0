Return-Path: <linux-pm+bounces-8975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9790466A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 23:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051101F21881
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D4152E05;
	Tue, 11 Jun 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7A72MhG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63514150991;
	Tue, 11 Jun 2024 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142674; cv=none; b=rLeJ/CjVOi1+SPjaCPwHTXDw3cROr431Tc0Blui9shUyL2Gg6M4rscnsUZJfZtrO2U0sAR8kRecC1eYsHV6fu+hTEdH3MHKX+BQopsy8C0FxPUaxIB2ahZ/7cJtq0R+Knq6ulw9ZOE+BSkNDjoKD5M91ZcDpKsJTSonNBefEBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142674; c=relaxed/simple;
	bh=42Iml4V95zjMoBT1V5V/Ymqx61gKN29WZ3TouJ7dEK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuH59xACuWyfx49KCGZZbvWCCR9NiyuXSjIiwkKMMzx9zxngvT8WMU8jvv6OtGZs3QJzfBx8U+vGc0dOHd3QsP7wtaKlrHiXxRfPR6lIVvxu+lj0mqu5/WKfUybgBkG7HZ85VKexHTHn9XD4b+3rR6A3G4dSKePpTx/Z+6HYnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7A72MhG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718142673; x=1749678673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=42Iml4V95zjMoBT1V5V/Ymqx61gKN29WZ3TouJ7dEK8=;
  b=j7A72MhGYnbn0KHIsKWWgL307I7gBqPWsWum3/dvj1TL0UwGyO18wFl5
   zs031GDn9rmLJhQ4nMDzfs3z0M8JHFqSfH88NDeM7N48e/vXHHHYHGsqz
   gqg0kp7CLHEJ8PK1Of2sZIEZAVbHYgkrKPsTu50Sb5DACarvAtS8BwXFp
   TNQkxdR2COs9T2xJXyAm1PB8pIAvy87QwQc496F0Udi8MLQGWJnLZrhVy
   Adc+NAx3mB6IsI22SIK02sgVuUj2o659MiQaur3gO9uPwuobgcZ8AvI9A
   S95rcyLD9kavf8CymAN661diVoqgiug09hjuiGPfE9q2szxQObIVJGjfR
   A==;
X-CSE-ConnectionGUID: Db5oPGMiR6aRAs7bheZEDQ==
X-CSE-MsgGUID: 6U7/dh7RQuK5czC7NCndTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18661307"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="18661307"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 14:51:12 -0700
X-CSE-ConnectionGUID: XcExuu34Qe6iRxYnIi5l5w==
X-CSE-MsgGUID: lmcuSoDFSzahsNTh2PtImw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="40281895"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Jun 2024 14:51:10 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH9OV-0000wG-0a;
	Tue, 11 Jun 2024 21:51:07 +0000
Date: Wed, 12 Jun 2024 05:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: PoShao Chen <poshao.chen@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, clive.lin@mediatek.com,
	ccj.yeh@mediatek.com, ching-hao.hsu@mediatek.com,
	poshao.chen@mediatek.com
Subject: Re: [PATCH] cpufreq: Fix per-policy boost behavior after CPU hotplug
Message-ID: <202406120519.mhrkBEkJ-lkp@intel.com>
References: <20240611115920.28665-1-poshao.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611115920.28665-1-poshao.chen@mediatek.com>

Hi PoShao,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc3 next-20240611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/PoShao-Chen/cpufreq-Fix-per-policy-boost-behavior-after-CPU-hotplug/20240611-200804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240611115920.28665-1-poshao.chen%40mediatek.com
patch subject: [PATCH] cpufreq: Fix per-policy boost behavior after CPU hotplug
config: sh-defconfig (https://download.01.org/0day-ci/archive/20240612/202406120519.mhrkBEkJ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240612/202406120519.mhrkBEkJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406120519.mhrkBEkJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/cpufreq/cpufreq.c: In function 'cpufreq_online':
   drivers/cpufreq/cpufreq.c:1515:41: warning: missing terminating " character
    1515 |                                 pr_info("%s: per-policy boost flag mirror the cpufreq_driver
         |                                         ^
   drivers/cpufreq/cpufreq.c:1516:48: warning: missing terminating " character
    1516 |                                         boost\n", __func__);
         |                                                ^
   drivers/cpufreq/cpufreq.c:1522:48: warning: missing terminating " character
    1522 |                                         pr_err("%s: per-policy boost flag mirror the cpufreq_driver
         |                                                ^
   drivers/cpufreq/cpufreq.c:1523:63: warning: missing terminating " character
    1523 |                                                 boost failed\n", __func__);
         |                                                               ^
>> drivers/cpufreq/cpufreq.c:3092:34: error: unterminated argument list invoking macro "pr_info"
    3092 | core_initcall(cpufreq_core_init);
         |                                  ^
>> drivers/cpufreq/cpufreq.c:1515:33: error: 'pr_info' undeclared (first use in this function); did you mean 'qc_info'?
    1515 |                                 pr_info("%s: per-policy boost flag mirror the cpufreq_driver
         |                                 ^~~~~~~
         |                                 qc_info
   drivers/cpufreq/cpufreq.c:1515:33: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/cpufreq/cpufreq.c:1515:40: error: expected ';' at end of input
    1515 |                                 pr_info("%s: per-policy boost flag mirror the cpufreq_driver
         |                                        ^
         |                                        ;
   ......
>> drivers/cpufreq/cpufreq.c:1515:33: error: expected declaration or statement at end of input
    1515 |                                 pr_info("%s: per-policy boost flag mirror the cpufreq_driver
         |                                 ^~~~~~~
>> drivers/cpufreq/cpufreq.c:1515:33: error: expected declaration or statement at end of input
>> drivers/cpufreq/cpufreq.c:1515:33: error: expected declaration or statement at end of input
>> drivers/cpufreq/cpufreq.c:1515:33: error: expected declaration or statement at end of input
>> drivers/cpufreq/cpufreq.c:1493:25: error: label 'out_destroy_policy' used but not defined
    1493 |                         goto out_destroy_policy;
         |                         ^~~~
>> drivers/cpufreq/cpufreq.c:1443:25: error: label 'out_offline_policy' used but not defined
    1443 |                         goto out_offline_policy;
         |                         ^~~~
>> drivers/cpufreq/cpufreq.c:1430:25: error: label 'out_free_policy' used but not defined
    1430 |                         goto out_free_policy;
         |                         ^~~~
>> drivers/cpufreq/cpufreq.c:1417:25: error: label 'out_exit_policy' used but not defined
    1417 |                         goto out_exit_policy;
         |                         ^~~~
>> drivers/cpufreq/cpufreq.c:1383:23: warning: unused variable 'flags' [-Wunused-variable]
    1383 |         unsigned long flags;
         |                       ^~~~~
   drivers/cpufreq/cpufreq.c: At top level:
>> drivers/cpufreq/cpufreq.c:82:21: warning: '__cpufreq_get' used but never defined
      82 | static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
         |                     ^~~~~~~~~~~~~
>> drivers/cpufreq/cpufreq.c:83:12: warning: 'cpufreq_init_governor' declared 'static' but never defined [-Wunused-function]
      83 | static int cpufreq_init_governor(struct cpufreq_policy *policy);
         |            ^~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/cpufreq.c:84:13: warning: 'cpufreq_exit_governor' declared 'static' but never defined [-Wunused-function]
      84 | static void cpufreq_exit_governor(struct cpufreq_policy *policy);
         |             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/cpufreq.c:85:13: warning: 'cpufreq_governor_limits' declared 'static' but never defined [-Wunused-function]
      85 | static void cpufreq_governor_limits(struct cpufreq_policy *policy);
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/cpufreq.c:86:12: warning: 'cpufreq_set_policy' used but never defined
      86 | static int cpufreq_set_policy(struct cpufreq_policy *policy,
         |            ^~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/cpufreq.c:89:13: warning: 'cpufreq_boost_supported' used but never defined
      89 | static bool cpufreq_boost_supported(void);
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/cpufreq.c:1379:12: warning: 'cpufreq_online' defined but not used [-Wunused-function]
    1379 | static int cpufreq_online(unsigned int cpu)
         |            ^~~~~~~~~~~~~~
>> drivers/cpufreq/cpufreq.c:1330:13: warning: 'cpufreq_policy_free' defined but not used [-Wunused-function]
    1330 | static void cpufreq_policy_free(struct cpufreq_policy *policy)
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/cpufreq.c:1115:12: warning: 'cpufreq_init_policy' defined but not used [-Wunused-function]
    1115 | static int cpufreq_init_policy(struct cpufreq_policy *policy)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/cpufreq.c:1077:12: warning: 'cpufreq_add_dev_interface' defined but not used [-Wunused-function]
    1077 | static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/cpufreq.c:1069:13: warning: 'remove_cpu_dev_symlink' defined but not used [-Wunused-function]
    1069 | static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/cpufreq/cpufreq.c:18:
   drivers/cpufreq/cpufreq.c:634:22: warning: 'boost' defined but not used [-Wunused-variable]
     634 | define_one_global_rw(boost);
         |                      ^~~~~
   include/linux/cpufreq.h:332:30: note: in definition of macro 'define_one_global_rw'
     332 | static struct kobj_attribute _name =            \
         |                              ^~~~~
   drivers/cpufreq/cpufreq.c:69:13: warning: 'cpufreq_suspended' defined but not used [-Wunused-variable]
      69 | static bool cpufreq_suspended;
         |             ^~~~~~~~~~~~~~~~~


vim +/pr_info +3092 drivers/cpufreq/cpufreq.c

5a01f2e8f3ac13 Venkatesh Pallipadi   2007-02-05  3069  
5a01f2e8f3ac13 Venkatesh Pallipadi   2007-02-05  3070  static int __init cpufreq_core_init(void)
5a01f2e8f3ac13 Venkatesh Pallipadi   2007-02-05  3071  {
8412b4563e5910 Quentin Perret        2020-06-29  3072  	struct cpufreq_governor *gov = cpufreq_default_governor();
2744a63c1aec32 Greg Kroah-Hartman    2023-03-13  3073  	struct device *dev_root;
8412b4563e5910 Quentin Perret        2020-06-29  3074  
a7b422cda5084d Konrad Rzeszutek Wilk 2012-03-13  3075  	if (cpufreq_disabled())
a7b422cda5084d Konrad Rzeszutek Wilk 2012-03-13  3076  		return -ENODEV;
a7b422cda5084d Konrad Rzeszutek Wilk 2012-03-13  3077  
2744a63c1aec32 Greg Kroah-Hartman    2023-03-13  3078  	dev_root = bus_get_dev_root(&cpu_subsys);
2744a63c1aec32 Greg Kroah-Hartman    2023-03-13  3079  	if (dev_root) {
2744a63c1aec32 Greg Kroah-Hartman    2023-03-13  3080  		cpufreq_global_kobject = kobject_create_and_add("cpufreq", &dev_root->kobj);
2744a63c1aec32 Greg Kroah-Hartman    2023-03-13  3081  		put_device(dev_root);
2744a63c1aec32 Greg Kroah-Hartman    2023-03-13  3082  	}
8aa84ad8d6c740 Thomas Renninger      2009-07-24  3083  	BUG_ON(!cpufreq_global_kobject);
8aa84ad8d6c740 Thomas Renninger      2009-07-24  3084  
8412b4563e5910 Quentin Perret        2020-06-29  3085  	if (!strlen(default_governor))
0faf84caee63a5 Justin Stitt          2023-09-13  3086  		strscpy(default_governor, gov->name, CPUFREQ_NAME_LEN);
8412b4563e5910 Quentin Perret        2020-06-29  3087  
5a01f2e8f3ac13 Venkatesh Pallipadi   2007-02-05  3088  	return 0;
5a01f2e8f3ac13 Venkatesh Pallipadi   2007-02-05  3089  }
d82f26925599ca Len Brown             2017-02-28  3090  module_param(off, int, 0444);
8412b4563e5910 Quentin Perret        2020-06-29  3091  module_param_string(default_governor, default_governor, CPUFREQ_NAME_LEN, 0444);
5a01f2e8f3ac13 Venkatesh Pallipadi   2007-02-05 @3092  core_initcall(cpufreq_core_init);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

