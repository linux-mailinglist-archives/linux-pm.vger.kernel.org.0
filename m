Return-Path: <linux-pm+bounces-8055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CEB8CC624
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1298B20EA8
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A7145B2D;
	Wed, 22 May 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5P1If5I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330B145B1F;
	Wed, 22 May 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401553; cv=none; b=dyYlRjOflgyAw7URvoD1BFTnurQpEBLcQZWEREVpZrT+j10rVtg1OsouaTgCP7p3mVddafFujMKSAvkvRZuBrr+v/AmucJzDC2gFPPDax1x2n+V0jdwTLQT3ZKfTlDaby4oO+q7S7waZoNzc31/pdgVg0wLsY+HjxPn146vhmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401553; c=relaxed/simple;
	bh=P8JmmA0EqNGVqZirp7HNAbnnpaWqE/5cpMWAbpIhSVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGKPK+e31YwvOQV1EjWn9NtlAlVNtoLYxWq2zv8OFISRbiIka1SWHgNjq847PAZfylE4/IhNOrC+KawBPlCwNo9bvPrEA77bQ1HPkdujPsfsvqelnvzSirGqPP0+XwOMh9s2tBKx8umpYrrQdjoXsWu3WANBlPwIkjrVaG2ewdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5P1If5I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716401551; x=1747937551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P8JmmA0EqNGVqZirp7HNAbnnpaWqE/5cpMWAbpIhSVs=;
  b=k5P1If5IffUmzPvaMxqYBfFMunx+0dU1ms+slGsdeaeqEMCK/CeyPp6S
   YTLTyPwiEH4VDsN3vfy7glQADx+XsyCutQzEiWNdz2/W9UJ63WmcUWq99
   ds974e9agZG2V7LX3LV784sgNo6IGbzqP1D/Ct2tRD5srh/zkkNEgQzA6
   f7125lJJw/SIeD7u/VWbNYaq6s8rJHzqq560NYQuDfi7tcCcNWnIdxkfT
   F88J+UGLzmB4No0+Cgx75txVOwKsb0opa9d/gf50RQsKeEdjsfcUIDxFs
   +CCqBR8e/vuAqnq3Woc47rg1t8RF9hNqsxS2LtKaVAmJITWD2dgBbPkjF
   g==;
X-CSE-ConnectionGUID: MdLxL76rTxi6L6QEjm7TVQ==
X-CSE-MsgGUID: iyLm5tBPQtycptlymDrwRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23812916"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23812916"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 11:12:31 -0700
X-CSE-ConnectionGUID: 5FNYXQyhRl+eTYgPJUt6yA==
X-CSE-MsgGUID: vSxxeIEkQUaBmK4vADCXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33378007"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 May 2024 11:12:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9qRr-0001q1-2m;
	Wed, 22 May 2024 18:12:23 +0000
Date: Thu, 23 May 2024 02:11:30 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaojian Du <Xiaojian.Du@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com, sandipan.das@amd.com,
	kai.huang@intel.com, perry.yuan@amd.com, x86@kernel.org,
	ray.huang@amd.com, rafael@kernel.org,
	Xiaojian Du <Xiaojian.Du@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/2] cpufreq: amd-pstate: change cpu freq transition
 delay for some models
Message-ID: <202405230126.Ww25ogId-lkp@intel.com>
References: <b2c8fb2da41f9fb21f095f67d99cbdbd0aa34091.1716356681.git.Xiaojian.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2c8fb2da41f9fb21f095f67d99cbdbd0aa34091.1716356681.git.Xiaojian.Du@amd.com>

Hi Xiaojian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master next-20240522]
[cannot apply to tip/x86/core tip/auto-latest v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaojian-Du/cpufreq-amd-pstate-change-cpu-freq-transition-delay-for-some-models/20240522-135241
base:   tip/master
patch link:    https://lore.kernel.org/r/b2c8fb2da41f9fb21f095f67d99cbdbd0aa34091.1716356681.git.Xiaojian.Du%40amd.com
patch subject: [PATCH v2 2/2] cpufreq: amd-pstate: change cpu freq transition delay for some models
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240523/202405230126.Ww25ogId-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405230126.Ww25ogId-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405230126.Ww25ogId-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_get_transition_delay_us':
>> drivers/cpufreq/amd-pstate.c:821:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     821 |         if (transition_delay_ns == CPUFREQ_ETERNAL)
         |            ^


vim +/else +821 drivers/cpufreq/amd-pstate.c

e571a5e2068ef5 Meng Li     2024-01-19  811  
5131a3ca3518d7 Perry Yuan  2024-04-30  812  /*
069a2bb8c48c43 Perry Yuan  2024-04-25  813   * Get pstate transition delay time from ACPI tables that firmware set
069a2bb8c48c43 Perry Yuan  2024-04-25  814   * instead of using hardcode value directly.
069a2bb8c48c43 Perry Yuan  2024-04-25  815   */
069a2bb8c48c43 Perry Yuan  2024-04-25  816  static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
069a2bb8c48c43 Perry Yuan  2024-04-25  817  {
069a2bb8c48c43 Perry Yuan  2024-04-25  818  	u32 transition_delay_ns;
069a2bb8c48c43 Perry Yuan  2024-04-25  819  
069a2bb8c48c43 Perry Yuan  2024-04-25  820  	transition_delay_ns = cppc_get_transition_latency(cpu);
069a2bb8c48c43 Perry Yuan  2024-04-25 @821  	if (transition_delay_ns == CPUFREQ_ETERNAL)
be020c2c1f8622 Xiaojian Du 2024-05-22  822  		if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
be020c2c1f8622 Xiaojian Du 2024-05-22  823  			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
be020c2c1f8622 Xiaojian Du 2024-05-22  824  		else
069a2bb8c48c43 Perry Yuan  2024-04-25  825  			return AMD_PSTATE_TRANSITION_DELAY;
069a2bb8c48c43 Perry Yuan  2024-04-25  826  
069a2bb8c48c43 Perry Yuan  2024-04-25  827  	return transition_delay_ns / NSEC_PER_USEC;
069a2bb8c48c43 Perry Yuan  2024-04-25  828  }
069a2bb8c48c43 Perry Yuan  2024-04-25  829  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

