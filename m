Return-Path: <linux-pm+bounces-32419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29070B2770C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 05:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7365E32FF
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB241EB9E1;
	Fri, 15 Aug 2025 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3Abb0hL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F914A8B;
	Fri, 15 Aug 2025 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229684; cv=none; b=LIVwQFlTtdhq0XG8Fxe8YWLNuw9yUo2jDA9qHQc4cUifDOuG6d6Emj5OE6Xvxv88Z4lrfR+Hx4uAmnOBEn0sh63zgQssCpu+OcdLTlmLmMJcujMAtoXMqWwaYgb82I7TWpdm+i8fz2OKq3ONg9BRYk0qLJylgAreIXFWlXbIizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229684; c=relaxed/simple;
	bh=JEgTnVH/BV69PpBuDgQi6kkM93lGAGsa5M0gQm+th7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rcbok6c4I1UWaFmMCwCMIKNGWbCI85ELbesc7GjE6c/cjzc/lVILY1xyr4t3tDsxngWu/Uqmol5CIzS0iH8eylqsEiLaQEthczo4KlLVGbvzs8zlmUB8hpr26Z5vfCx0ZgQemGpIYXVtcIFlMhlbY+QJ9mjZ/6NlDMeYYFFj8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3Abb0hL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755229684; x=1786765684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JEgTnVH/BV69PpBuDgQi6kkM93lGAGsa5M0gQm+th7k=;
  b=J3Abb0hLomkxmIYH5aUN7krmlpNOL/2KEQrEr5UIuAAKqfkv77BRxAO9
   irymnnwTUNNqVwAw61sXfiORdFEW9amQIeaSTaBejwvb7FKk54n/brljv
   bdU2Xuu4pbmry4LXFSDST6Y4N/Zgr7TbTVGqd2vm/MvWu90RtpECYSRYB
   7cPFUU+glpHrFxgrMh3RFQdHDxR1x8cbI/bwrOPE7q7cAjn6QhswYGddo
   EcjLG294zbG4K80el2hO4gJEzHQMbTFWcix4WUasJO2KmRB0H99AGUPPl
   sz6D+bmvl4diFYqzoxI9o39fBibblyvb5c3BRr8mqd6jL+AizkcGRl6hx
   Q==;
X-CSE-ConnectionGUID: CIHLorH4S6OTBkiflkc6yg==
X-CSE-MsgGUID: 22iW8UdeRN28PDb5iy4A1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57466905"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57466905"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:48:03 -0700
X-CSE-ConnectionGUID: vGRT3hNERv619L2yTCUTnw==
X-CSE-MsgGUID: hTW5MDy3Sx6WZv1OySJ5/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166902366"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 20:47:58 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umlPu-000BWK-1k;
	Fri, 15 Aug 2025 03:47:48 +0000
Date: Fri, 15 Aug 2025 11:47:43 +0800
From: kernel test robot <lkp@intel.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	beata.michalska@arm.com, sudeep.holla@arm.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	vincent.guittot@linaro.org, yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
	linhongye@h-partners.com, zhenglifeng1@huawei.com
Subject: Re: [PATCH v4 3/3] arm64: topology: Setup AMU FIE for online CPUs
 only
Message-ID: <202508151158.Hm9U6le6-lkp@intel.com>
References: <20250814072853.3426386-4-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814072853.3426386-4-zhenglifeng1@huawei.com>

Hi Lifeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.17-rc1 next-20250814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lifeng-Zheng/arm64-topology-Set-scale-freq-source-only-for-the-CPUs-that-have-not-been-set-before/20250814-153732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20250814072853.3426386-4-zhenglifeng1%40huawei.com
patch subject: [PATCH v4 3/3] arm64: topology: Setup AMU FIE for online CPUs only
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20250815/202508151158.Hm9U6le6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151158.Hm9U6le6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151158.Hm9U6le6-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/topology.c: In function 'cpuhp_topology_online':
>> arch/arm64/kernel/topology.c:409:41: error: implicit declaration of function 'cpufreq_cpu_policy'; did you mean 'cpufreq_cpu_put'? [-Wimplicit-function-declaration]
     409 |         struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
         |                                         ^~~~~~~~~~~~~~~~~~
         |                                         cpufreq_cpu_put
   arch/arm64/kernel/topology.c:409:41: error: initialization of 'struct cpufreq_policy *' from 'int' makes pointer from integer without a cast [-Wint-conversion]


vim +409 arch/arm64/kernel/topology.c

   406	
   407	static int cpuhp_topology_online(unsigned int cpu)
   408	{
 > 409		struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
   410	
   411		/*
   412		 * If the online CPUs are not all AMU FIE CPUs or the new one is already
   413		 * an AMU FIE one, no need to set it.
   414		 */
   415		if (!policy || !cpumask_available(amu_fie_cpus) ||
   416		    !cpumask_subset(policy->cpus, amu_fie_cpus) ||
   417		    cpumask_test_cpu(cpu, amu_fie_cpus))
   418			return 0;
   419	
   420		/*
   421		 * If the new online CPU cannot pass this check, all the CPUs related to
   422		 * the same policy should be clear from amu_fie_cpus mask, otherwise they
   423		 * may use different source of the freq scale.
   424		 */
   425		if (WARN_ON(!freq_counters_valid(cpu))) {
   426			topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH,
   427							 policy->related_cpus);
   428			cpumask_andnot(amu_fie_cpus, amu_fie_cpus, policy->related_cpus);
   429			return 0;
   430		}
   431	
   432		cpumask_set_cpu(cpu, amu_fie_cpus);
   433	
   434		topology_set_scale_freq_source(&amu_sfd, cpumask_of(cpu));
   435	
   436		pr_debug("CPU[%u]: counter will be used for FIE.", cpu);
   437	
   438		return 0;
   439	}
   440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

