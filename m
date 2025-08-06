Return-Path: <linux-pm+bounces-32010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCE4B1C6F6
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 15:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A02718C09A6
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8E231845;
	Wed,  6 Aug 2025 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZspQgsEC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7CC8EB;
	Wed,  6 Aug 2025 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487955; cv=none; b=pnOl9pbRzjr6dReFUy6DL7WzxCyr5YJ020C+Dzm4i/1T4iiw+lMfjn+HSo4iCpqKadQaCPI3Npa3O8c36+HvRsFsx2IEQ1ECeM15AN62LuEZ4ZeiQDp0pqTdRKXGcHazbk3/Upqbdb5p1KtnEM3/lJmNuSN68+rBfojCqCUFrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487955; c=relaxed/simple;
	bh=W9p7lNlR9UDJHq46lD4UdctIx+KlNLY66BAzzSRyZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUJmmlUjJix0vEMFXm2mWQb5t/G2g4MqM1vcVe41WOPK8hl1SdqluABZA9Qx6y8cEDUw+Efwwx5YhRrsoMe5yVxNxAUDFQ+Vd4EWkQV76rwjGlBzLHb6JZIFL0eeZisnCtmkqmxOwYC/VhTqVBvd9WiFxpzqrwKcXt/+Oe04gMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZspQgsEC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754487953; x=1786023953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9p7lNlR9UDJHq46lD4UdctIx+KlNLY66BAzzSRyZyk=;
  b=ZspQgsECkstxPzzKyJAvuI4++16eQ+yW4rZWXJ9qq65hwvOy7j2S8w8f
   mPzp6pDVcP6z+orB6kylyzsggPRf1xyIG0E2m/UX2kjS66ZXVgic9cM8t
   rCvMG+tjGqJrXm4kTuHqBpaWpWyn7Tff5WHRIowya1783REhD5yWphDGc
   x+802qkS+nheDva6jHKDvtzoXczRl+nSQ87O3Mly+uO5qQuI6uF4cHswK
   98MyEIGYd6/uG8qZmejk17Ko+TT6EPlcCelgDJhknmNOXsJ/1WRzFXlds
   aU7m8bbPku0WzB9+PqfYHVKV09Xau2ZwN2GZrWdS9IpZSLGXP4qRQfXY8
   w==;
X-CSE-ConnectionGUID: DLcKlHwgRmGHVYy5rW9+ww==
X-CSE-MsgGUID: IHlZxTyZSqCKRpEAgNCvDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74264605"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74264605"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 06:45:53 -0700
X-CSE-ConnectionGUID: pGuvjIo4SRy6fG1YYkdKKw==
X-CSE-MsgGUID: bC/BIyiKTGusgbhlEwx5lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164791072"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Aug 2025 06:45:47 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujeSc-0001ji-0N;
	Wed, 06 Aug 2025 13:45:43 +0000
Date: Wed, 6 Aug 2025 21:45:27 +0800
From: kernel test robot <lkp@intel.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	beata.michalska@arm.com, sudeep.holla@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, yubowen8@huawei.com, linhongye@h-partners.com,
	zhenglifeng1@huawei.com
Subject: Re: [PATCH v3 3/3] arm64: topology: Setup AMU FIE for online CPUs
 only
Message-ID: <202508062127.qvRnTPvH-lkp@intel.com>
References: <20250805093330.3715444-4-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805093330.3715444-4-zhenglifeng1@huawei.com>

Hi Lifeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lifeng-Zheng/arm64-topology-Set-scale-freq-source-only-for-the-CPUs-that-have-not-been-set-before/20250806-101537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20250805093330.3715444-4-zhenglifeng1%40huawei.com
patch subject: [PATCH v3 3/3] arm64: topology: Setup AMU FIE for online CPUs only
config: arm64-randconfig-002-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062127.qvRnTPvH-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508062127.qvRnTPvH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062127.qvRnTPvH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/topology.c:409:34: error: call to undeclared function 'cpufreq_cpu_get_raw_no_check'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     409 |         struct cpufreq_policy *policy = cpufreq_cpu_get_raw_no_check(cpu);
         |                                         ^
   arch/arm64/kernel/topology.c:409:34: note: did you mean 'cpufreq_cpu_get_raw'?
   include/linux/cpufreq.h:212:38: note: 'cpufreq_cpu_get_raw' declared here
     212 | static inline struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
         |                                      ^
>> arch/arm64/kernel/topology.c:409:25: error: incompatible integer to pointer conversion initializing 'struct cpufreq_policy *' with an expression of type 'int' [-Wint-conversion]
     409 |         struct cpufreq_policy *policy = cpufreq_cpu_get_raw_no_check(cpu);
         |                                ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/cpufreq_cpu_get_raw_no_check +409 arch/arm64/kernel/topology.c

   406	
   407	static int cpuhp_topology_online(unsigned int cpu)
   408	{
 > 409		struct cpufreq_policy *policy = cpufreq_cpu_get_raw_no_check(cpu);
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
   425		if (!freq_counters_valid(cpu)) {
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

