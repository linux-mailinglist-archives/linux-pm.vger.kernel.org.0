Return-Path: <linux-pm+bounces-7612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE598BEE8B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 23:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43C9B20BCE
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A071B4B;
	Tue,  7 May 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXyyqppP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9218733E;
	Tue,  7 May 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115836; cv=none; b=S2Xom2y/XN9jocpoy2DzUKnV5fENPC7AHA9oTEUKYdV6WRrTsFYgzpa3mzmvsTthh4UR0WgA/xaoJ5Ncew5KIhR1CmbwoAz8rudw4a0YwzJ5jZc8jd0uFIfrgh2owfHiS4lKM+YbaVxrBRy1t5CNj2mn7+yMHGqxUu6tU+Qel2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115836; c=relaxed/simple;
	bh=uZ71m/kwDwRcripH7bKNsl6xLu8fmn/hVKonljdgE9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAH8hdfZ6VhwvoJzQ+YxSlqkKXwbjq9QYGBQ00JwYG/1btvxZ5XQPywmt9L8csIaHq59Dkhm7FbydyvEI8KiH7ClOoOeT0BXAYfVKoDu32xelIbOAgj446OU8+k5stgN4wvj2E35/W4wvVGDIps0B59U5pMRJxoMzrnKAyJ1bT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXyyqppP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715115834; x=1746651834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZ71m/kwDwRcripH7bKNsl6xLu8fmn/hVKonljdgE9U=;
  b=EXyyqppPHYi1Qnooq1wGzDj5YEfxHuTgAQXBOFwY4UKzP1ja84weDhGE
   hdljMbASp6tpMLRFwKDM0LUr2jhqX+DFopORBPdfLkDXq1mW8+KbakJxZ
   ynttMFnS082hXMHU0VUuEl30WWsVTTQIOM4cVqy5/FC7MbQd4WbMF1UAo
   ucdZ7+ESoXu7R71dJh23oduPkPmf94lhurzV+YDufHsJ3snzykVHZtPvK
   1d586bO2dN6NzjTkFWsYmZTaMhZFn3CS1AFtxliuoL5qShThzKTT0cObZ
   j7iBqjV3se0iftIRkOUbL2d3vlXH9YqfT0MOeNngHRpW3dHtQCHmfiZTx
   g==;
X-CSE-ConnectionGUID: YeIt3wINSe+aiw7IYxgnxA==
X-CSE-MsgGUID: 39ifkPcMQt2HtrqVaSkq3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21501920"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21501920"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 14:03:53 -0700
X-CSE-ConnectionGUID: 14eykIzKTU+9AHBltx9qaA==
X-CSE-MsgGUID: eA/kVNQTRA2X46TcXvJQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33465546"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 May 2024 14:03:49 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4RyV-0002dE-0S;
	Tue, 07 May 2024 21:03:47 +0000
Date: Wed, 8 May 2024 05:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
	Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
	Ray.Huang@amd.com, gautham.shenoy@amd.com, Borislav.Petkov@amd.com
Cc: oe-kbuild-all@lists.linux.dev, Alexander.Deucher@amd.com,
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] cpufreq: amd-pstate: optimiza the initial
 frequency values verification
Message-ID: <202405080431.BPU6Yg9s-lkp@intel.com>
References: <0049ad44052b051cf57d1059bf71b7ce227a5f21.1715065568.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0049ad44052b051cf57d1059bf71b7ce227a5f21.1715065568.git.perry.yuan@amd.com>

Hi Perry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge next-20240507]
[cannot apply to tip/x86/core linus/master v6.9-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Perry-Yuan/cpufreq-amd-pstate-optimiza-the-initial-frequency-values-verification/20240507-151930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/0049ad44052b051cf57d1059bf71b7ce227a5f21.1715065568.git.perry.yuan%40amd.com
patch subject: [PATCH 01/11] cpufreq: amd-pstate: optimiza the initial frequency values verification
config: x86_64-randconfig-102-20240507 (https://download.01.org/0day-ci/archive/20240508/202405080431.BPU6Yg9s-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080431.BPU6Yg9s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080431.BPU6Yg9s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_cpu_init':
>> drivers/cpufreq/amd-pstate.c:899:33: warning: variable 'nominal_freq' set but not used [-Wunused-but-set-variable]
     899 |         int min_freq, max_freq, nominal_freq, ret;
         |                                 ^~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_epp_cpu_init':
   drivers/cpufreq/amd-pstate.c:1350:33: warning: variable 'nominal_freq' set but not used [-Wunused-but-set-variable]
    1350 |         int min_freq, max_freq, nominal_freq, ret;
         |                                 ^~~~~~~~~~~~


vim +/nominal_freq +899 drivers/cpufreq/amd-pstate.c

5547c0ebfc2efd Perry Yuan        2024-04-25  896  
ec437d71db77a1 Huang Rui         2021-12-24  897  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
ec437d71db77a1 Huang Rui         2021-12-24  898  {
5c3fd1edaa8b4c Perry Yuan        2024-04-30 @899  	int min_freq, max_freq, nominal_freq, ret;
ec437d71db77a1 Huang Rui         2021-12-24  900  	struct device *dev;
ec437d71db77a1 Huang Rui         2021-12-24  901  	struct amd_cpudata *cpudata;
ec437d71db77a1 Huang Rui         2021-12-24  902  
919f4557696939 Wyes Karny        2022-11-17  903  	/*
919f4557696939 Wyes Karny        2022-11-17  904  	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
919f4557696939 Wyes Karny        2022-11-17  905  	 * which is ideal for initialization process.
919f4557696939 Wyes Karny        2022-11-17  906  	 */
919f4557696939 Wyes Karny        2022-11-17  907  	amd_perf_ctl_reset(policy->cpu);
ec437d71db77a1 Huang Rui         2021-12-24  908  	dev = get_cpu_device(policy->cpu);
ec437d71db77a1 Huang Rui         2021-12-24  909  	if (!dev)
ec437d71db77a1 Huang Rui         2021-12-24  910  		return -ENODEV;
ec437d71db77a1 Huang Rui         2021-12-24  911  
ec437d71db77a1 Huang Rui         2021-12-24  912  	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
ec437d71db77a1 Huang Rui         2021-12-24  913  	if (!cpudata)
ec437d71db77a1 Huang Rui         2021-12-24  914  		return -ENOMEM;
ec437d71db77a1 Huang Rui         2021-12-24  915  
ec437d71db77a1 Huang Rui         2021-12-24  916  	cpudata->cpu = policy->cpu;
ec437d71db77a1 Huang Rui         2021-12-24  917  
f3a052391822b7 Meng Li           2024-01-19  918  	amd_pstate_init_prefcore(cpudata);
f3a052391822b7 Meng Li           2024-01-19  919  
ec437d71db77a1 Huang Rui         2021-12-24  920  	ret = amd_pstate_init_perf(cpudata);
ec437d71db77a1 Huang Rui         2021-12-24  921  	if (ret)
41271016dfa4a0 Huang Rui         2021-12-24  922  		goto free_cpudata1;
ec437d71db77a1 Huang Rui         2021-12-24  923  
5547c0ebfc2efd Perry Yuan        2024-04-25  924  	ret = amd_pstate_init_freq(cpudata);
5547c0ebfc2efd Perry Yuan        2024-04-25  925  	if (ret)
5547c0ebfc2efd Perry Yuan        2024-04-25  926  		goto free_cpudata1;
5547c0ebfc2efd Perry Yuan        2024-04-25  927  
3cbbe8871a2fb8 Gautham R. Shenoy 2024-04-25  928  	min_freq = READ_ONCE(cpudata->min_freq);
3cbbe8871a2fb8 Gautham R. Shenoy 2024-04-25  929  	max_freq = READ_ONCE(cpudata->max_freq);
3cbbe8871a2fb8 Gautham R. Shenoy 2024-04-25  930  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
ec437d71db77a1 Huang Rui         2021-12-24  931  
069a2bb8c48c43 Perry Yuan        2024-04-25  932  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
069a2bb8c48c43 Perry Yuan        2024-04-25  933  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
ec437d71db77a1 Huang Rui         2021-12-24  934  
ec437d71db77a1 Huang Rui         2021-12-24  935  	policy->min = min_freq;
ec437d71db77a1 Huang Rui         2021-12-24  936  	policy->max = max_freq;
ec437d71db77a1 Huang Rui         2021-12-24  937  
ec437d71db77a1 Huang Rui         2021-12-24  938  	policy->cpuinfo.min_freq = min_freq;
ec437d71db77a1 Huang Rui         2021-12-24  939  	policy->cpuinfo.max_freq = max_freq;
ec437d71db77a1 Huang Rui         2021-12-24  940  
ec437d71db77a1 Huang Rui         2021-12-24  941  	/* It will be updated by governor */
ec437d71db77a1 Huang Rui         2021-12-24  942  	policy->cur = policy->cpuinfo.min_freq;
ec437d71db77a1 Huang Rui         2021-12-24  943  
e059c184da47e9 Huang Rui         2021-12-24  944  	if (boot_cpu_has(X86_FEATURE_CPPC))
1d215f0319c206 Huang Rui         2021-12-24  945  		policy->fast_switch_possible = true;
1d215f0319c206 Huang Rui         2021-12-24  946  
41271016dfa4a0 Huang Rui         2021-12-24  947  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
41271016dfa4a0 Huang Rui         2021-12-24  948  				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
41271016dfa4a0 Huang Rui         2021-12-24  949  	if (ret < 0) {
41271016dfa4a0 Huang Rui         2021-12-24  950  		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
41271016dfa4a0 Huang Rui         2021-12-24  951  		goto free_cpudata1;
41271016dfa4a0 Huang Rui         2021-12-24  952  	}
41271016dfa4a0 Huang Rui         2021-12-24  953  
41271016dfa4a0 Huang Rui         2021-12-24  954  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
41271016dfa4a0 Huang Rui         2021-12-24  955  				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
41271016dfa4a0 Huang Rui         2021-12-24  956  	if (ret < 0) {
41271016dfa4a0 Huang Rui         2021-12-24  957  		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
41271016dfa4a0 Huang Rui         2021-12-24  958  		goto free_cpudata2;
41271016dfa4a0 Huang Rui         2021-12-24  959  	}
41271016dfa4a0 Huang Rui         2021-12-24  960  
febab20caebac9 Wyes Karny        2023-11-17  961  	cpudata->max_limit_freq = max_freq;
febab20caebac9 Wyes Karny        2023-11-17  962  	cpudata->min_limit_freq = min_freq;
ec437d71db77a1 Huang Rui         2021-12-24  963  
ec437d71db77a1 Huang Rui         2021-12-24  964  	policy->driver_data = cpudata;
ec437d71db77a1 Huang Rui         2021-12-24  965  
41271016dfa4a0 Huang Rui         2021-12-24  966  	amd_pstate_boost_init(cpudata);
abd61c08ef349a Perry Yuan        2023-01-31  967  	if (!current_pstate_driver->adjust_perf)
abd61c08ef349a Perry Yuan        2023-01-31  968  		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
41271016dfa4a0 Huang Rui         2021-12-24  969  
ec437d71db77a1 Huang Rui         2021-12-24  970  	return 0;
ec437d71db77a1 Huang Rui         2021-12-24  971  
41271016dfa4a0 Huang Rui         2021-12-24  972  free_cpudata2:
41271016dfa4a0 Huang Rui         2021-12-24  973  	freq_qos_remove_request(&cpudata->req[0]);
41271016dfa4a0 Huang Rui         2021-12-24  974  free_cpudata1:
ec437d71db77a1 Huang Rui         2021-12-24  975  	kfree(cpudata);
ec437d71db77a1 Huang Rui         2021-12-24  976  	return ret;
ec437d71db77a1 Huang Rui         2021-12-24  977  }
ec437d71db77a1 Huang Rui         2021-12-24  978  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

