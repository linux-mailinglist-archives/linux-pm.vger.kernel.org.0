Return-Path: <linux-pm+bounces-22224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF35A38A6B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688DC3A499F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F6228C87;
	Mon, 17 Feb 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIWaS7QY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3615666D;
	Mon, 17 Feb 2025 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812389; cv=none; b=VdNSkvAtiNqVk41Di7DAKyxfyVVXOBatxKaG9OIA4Jl/o6Iq/i9HL2Y7BUvdxPmAyR2kTp8u1oXY2zgXznEQVoFOXfZ93VjciW9XC9Jdh8OGwLTfs+YhNAvbUJbQXIvb+fT9zczht0YMq4CK36zfSFnooKANSd2s5tQshmQMNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812389; c=relaxed/simple;
	bh=3lWesCkplc+7D1TnzAGo7WBSdfHQJbWlOLbUrY+d2gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPdJX5D8iamxUjFrhAx/Y4T6gbWs6VrBT6jtbP5Jy2g2iHjI/L5982VauPjFxD6S9ykLEa98cjwypW7jm8b9w+viiI2p1oXgW3qW1qZryGE4gJXGBLUN3c6D14juw2UEKRmdfRWUCLwuakKO+wFGtvgyHoOiQ6kzocDu3vyA4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIWaS7QY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739812387; x=1771348387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3lWesCkplc+7D1TnzAGo7WBSdfHQJbWlOLbUrY+d2gA=;
  b=FIWaS7QYbne3+3u0Hczt8OUffqnEgeTns6fGakhg/HH3mUwMPbGdsL5h
   9ZgZfbmE416xfm/Akv22UKOjaHlNhxXWkF3BQOjYV8E/hhGxXbLCrhyIs
   gdS6ItghtYWiN7epKi50zgu0hc/hTQKr+2rjH8jLuFL3NElswtCesCLZz
   392CsgdlOmus5OMvxx0ppFM42oK9q7jNizTRc5kY/WfbRqY4Q7fWRo2NS
   7RBgBl6Tujt9BMTFuU2NXT0RFdxLi/8Wk9JpMMEwOYkvnc4k+BE3U/j4f
   sEp3P9zYJRj3x1fyhqdNSHBZdF6t6d0IEweb0RVuRh9ExpQFn+j50I6KB
   Q==;
X-CSE-ConnectionGUID: IkS7lH7PS1CzrmdOOfzTDA==
X-CSE-MsgGUID: PxCA5iovRnaz23+Tn5+2Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39694671"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="39694671"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 09:13:06 -0800
X-CSE-ConnectionGUID: yYjSLLRgSPywq10YkdoXzA==
X-CSE-MsgGUID: gYiqN45KQKWy1wwSNas2ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="114104777"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2025 09:13:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk4g0-001DNj-2n;
	Mon, 17 Feb 2025 17:13:00 +0000
Date: Tue, 18 Feb 2025 01:12:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <linux-kernel@vger.kernel.org>,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 11/17] cpufreq/amd-pstate: Replace all AMD_CPPC_*
 macros with masks
Message-ID: <202502180139.g2a2yoPe-lkp@intel.com>
References: <20250215005244.1212285-12-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-12-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge tip/x86/core linus/master v6.14-rc3 next-20250217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/cpufreq-amd-pstate-Show-a-warning-when-a-CPU-fails-to-setup/20250215-085903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250215005244.1212285-12-superm1%40kernel.org
patch subject: [PATCH v2 11/17] cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
config: i386-randconfig-063-20250216 (https://download.01.org/0day-ci/archive/20250218/202502180139.g2a2yoPe-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250218/202502180139.g2a2yoPe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502180139.g2a2yoPe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate-ut.c:145:19: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     145 |                         highest_perf = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1);
         |                                        ^
   1 error generated.


vim +/FIELD_GET +145 drivers/cpufreq/amd-pstate-ut.c

   105	
   106	/*
   107	 * check if performance values are reasonable.
   108	 * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
   109	 */
   110	static int amd_pstate_ut_check_perf(u32 index)
   111	{
   112		int cpu = 0, ret = 0;
   113		u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
   114		u64 cap1 = 0;
   115		struct cppc_perf_caps cppc_perf;
   116		struct amd_cpudata *cpudata = NULL;
   117		union perf_cached cur_perf;
   118	
   119		for_each_possible_cpu(cpu) {
   120			struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
   121	
   122			policy = cpufreq_cpu_get(cpu);
   123			if (!policy)
   124				continue;
   125			cpudata = policy->driver_data;
   126	
   127			if (get_shared_mem()) {
   128				ret = cppc_get_perf_caps(cpu, &cppc_perf);
   129				if (ret) {
   130					pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
   131					return ret;
   132				}
   133	
   134				highest_perf = cppc_perf.highest_perf;
   135				nominal_perf = cppc_perf.nominal_perf;
   136				lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
   137				lowest_perf = cppc_perf.lowest_perf;
   138			} else {
   139				ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
   140				if (ret) {
   141					pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
   142					return ret;
   143				}
   144	
 > 145				highest_perf = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1);
   146				nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
   147				lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
   148				lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
   149			}
   150	
   151			cur_perf = READ_ONCE(cpudata->perf);
   152			if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
   153				pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
   154					__func__, cpu, highest_perf, cpudata->perf.highest_perf);
   155				return -EINVAL;
   156			}
   157			if (nominal_perf != cur_perf.nominal_perf ||
   158			   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
   159			   (lowest_perf != cur_perf.lowest_perf)) {
   160				pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
   161					__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
   162					lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
   163					lowest_perf, cpudata->perf.lowest_perf);
   164				return -EINVAL;
   165			}
   166	
   167			if (!((highest_perf >= nominal_perf) &&
   168				(nominal_perf > lowest_nonlinear_perf) &&
   169				(lowest_nonlinear_perf >= lowest_perf) &&
   170				(lowest_perf > 0))) {
   171				pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
   172					__func__, cpu, highest_perf, nominal_perf,
   173					lowest_nonlinear_perf, lowest_perf);
   174				return -EINVAL;
   175			}
   176		}
   177	
   178		return 0;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

