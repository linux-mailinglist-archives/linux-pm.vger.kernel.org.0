Return-Path: <linux-pm+bounces-23072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58BA47E6F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BC73B2EA0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6AE22DFB0;
	Thu, 27 Feb 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agm56xQo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CC22CBC9;
	Thu, 27 Feb 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661219; cv=none; b=XJ9PRyMQJ6MKr1ibQ0v0KfeqadL5CQpOuBJfg25MwGRr+w9uSINbYTix0fJjUk3sAbI9uI5V5Q0QwdwvCqG6zhHoqciafve7vZA7E4OTcY2jdJag8K6yTj6lIvEv0Oc2aJ5suSxnPz6bxK6Dpt4u/OWJtfNmJm+UtXmMFuvvBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661219; c=relaxed/simple;
	bh=2mFz4lpVNmQKP/Q1EhCFSSIbsnnObvCiZrlUAld3VxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm0unelpzh8HtvhquEeXWnr1mGuIt1Az8bFupiBuV0ijkzDyrRk7cGvYcNfM/AY5o686t0oWxez1ysVgw5BSCSHmFIIx4Im59hUnemzZakoAcUbxHXjJihPTgCjz+w6k85tbCoq0m3hrMEIhBU+tgFskjSY4n1VUsLrQdvE8A3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agm56xQo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740661218; x=1772197218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2mFz4lpVNmQKP/Q1EhCFSSIbsnnObvCiZrlUAld3VxM=;
  b=agm56xQoaNqM4Wlu/3Gr7ZktDBTyV9LZM6hXy+lH+O0bBStxjL+7JyNw
   prevDDEhDXIHEe1YLvEOWPwJzIAEVqIzaQEhCyCuygq/VJfHPUxp04tlj
   CgIBbDkcSDi/lwuXwSOTgo0dnnM1sOXp4xICpQqF4urmKX2oLHnQVafxg
   S9uP8+LcokHXdyDN/TnSLEzt6ZBZ2Yi/hlSJgoq6S/7q8GacSjOwciWOK
   jqpPcHOCEO4oHQv0FZRiPuLqNXKp3qWYcFd/d3+MAZXCYIQ0ZhMS3l4+m
   K7D4AxM8ZD+PKeCr03JJXY7NKmY0AAUoZ0YXTyJy6RBXb9KFp51cDm1+i
   Q==;
X-CSE-ConnectionGUID: UxpvQFazR5aKCM8/ujg+Hg==
X-CSE-MsgGUID: D2hMVgJFSU+rCdBMGObyUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45461991"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45461991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 05:00:17 -0800
X-CSE-ConnectionGUID: T5Qu8YulQMOuVgbweWlyow==
X-CSE-MsgGUID: do31TZN6TS2CfwKU86Q70g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116887772"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 27 Feb 2025 05:00:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tndUq-000DN4-02;
	Thu, 27 Feb 2025 13:00:12 +0000
Date: Thu, 27 Feb 2025 20:59:19 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <linux-kernel@vger.kernel.org>,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 04/19] cpufreq/amd-pstate: Move perf values into a
 union
Message-ID: <202502272001.nafS0qXq-lkp@intel.com>
References: <20250226074934.1667721-5-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226074934.1667721-5-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/bleeding-edge]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge tip/x86/core amd-pstate/linux-next linus/master v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/cpufreq-amd-pstate-Invalidate-cppc_req_cached-during-suspend/20250226-155545
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
patch link:    https://lore.kernel.org/r/20250226074934.1667721-5-superm1%40kernel.org
patch subject: [PATCH v5 04/19] cpufreq/amd-pstate: Move perf values into a union
config: i386-buildonly-randconfig-003-20250227 (https://download.01.org/0day-ci/archive/20250227/202502272001.nafS0qXq-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272001.nafS0qXq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272001.nafS0qXq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/amd-pstate.c:51:
   In file included from drivers/cpufreq/amd-pstate-trace.h:15:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cpufreq/amd-pstate.c:914:41: warning: variable 'nominal_freq' is uninitialized when used here [-Wuninitialized]
     914 |                 perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
         |                                                       ^~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:902:38: note: initialize the variable 'nominal_freq' to silence this warning
     902 |         u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
         |                                             ^
         |                                              = 0
   3 warnings generated.


vim +/nominal_freq +914 drivers/cpufreq/amd-pstate.c

   891	
   892	/*
   893	 * amd_pstate_init_freq: Initialize the nominal_freq and lowest_nonlinear_freq
   894	 *			 for the @cpudata object.
   895	 *
   896	 * Requires: all perf members of @cpudata to be initialized.
   897	 *
   898	 * Returns 0 on success, non-zero value on failure.
   899	 */
   900	static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
   901	{
   902		u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
   903		struct cppc_perf_caps cppc_perf;
   904		union perf_cached perf;
   905		int ret;
   906	
   907		ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
   908		if (ret)
   909			return ret;
   910		perf = READ_ONCE(cpudata->perf);
   911	
   912		if (quirks && quirks->lowest_freq) {
   913			min_freq = quirks->lowest_freq;
 > 914			perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
   915			WRITE_ONCE(cpudata->perf, perf);
   916		} else
   917			min_freq = cppc_perf.lowest_freq;
   918	
   919		if (quirks && quirks->nominal_freq)
   920			nominal_freq = quirks->nominal_freq;
   921		else
   922			nominal_freq = cppc_perf.nominal_freq;
   923	
   924		min_freq *= 1000;
   925		nominal_freq *= 1000;
   926	
   927		WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
   928	
   929		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
   930		lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
   931		WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
   932	
   933		/**
   934		 * Below values need to be initialized correctly, otherwise driver will fail to load
   935		 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
   936		 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
   937		 * Check _CPC in ACPI table objects if any values are incorrect
   938		 */
   939		if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
   940			pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
   941				min_freq, max_freq, nominal_freq);
   942			return -EINVAL;
   943		}
   944	
   945		if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
   946			pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
   947				lowest_nonlinear_freq, min_freq, nominal_freq);
   948			return -EINVAL;
   949		}
   950	
   951		return 0;
   952	}
   953	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

