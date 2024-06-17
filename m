Return-Path: <linux-pm+bounces-9337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618D90B302
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE4B1F2627D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990821BDDC;
	Mon, 17 Jun 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rsc3o/oY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754391BF2B;
	Mon, 17 Jun 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632920; cv=none; b=i6aB0f/DIdE9m4woZsPzB39ctrZm3YISqeW7prFEST1VGgslzKqM1v4cEhX4qW3HlHTzXUP7byftqliskE5CqWgR+LXbbKtivbO3naxQd5gUKwL2WzPQ8Yn18jENKou+MgK9/ri1HQn3gHcNViHlcFG9aDknUKOaDO3JhvEMfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632920; c=relaxed/simple;
	bh=+5sMLlQjXiSMPvX/MsyRTJLDa/2Lz5M1r4ucStNkDvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3Vj2OfvzN2hrRDPH15ZP7Ijenp7vbxxBWh0BDl5IcqLlWOrI/WLNCenWagn0X9au7sRyk1vbPmrJZYaA9sUCjDkTVZiqX2a8Org2kxxt8JVr2GZ8mleOw5dRBgV9je7YJohxfTeNy1QRVhVn2sI2SQNkJLcdao49NyfrmhK4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rsc3o/oY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718632918; x=1750168918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+5sMLlQjXiSMPvX/MsyRTJLDa/2Lz5M1r4ucStNkDvc=;
  b=Rsc3o/oYYGZNT8lyN0KYI6/hqTbwiBOgTfkI/WpDqNQRJofAqClV1GBm
   fTsPiDgNUF//piBwkUgAxkpXLubLAkdU+borJmK42sAJD5sh+jaZe8N8z
   JScAy7h2ipQj0oZ766Da7dV+yPZa4/GeefDXVpiihnTJkeslCpYDT2b2j
   exXEivj55avVzgm2EiIJ0tWSsym6LNp9YHNFBzUCmB5R6VI8+vpHmt9jf
   MOG4XUdoeR3cNYQH1076nI63A6klZ2c1M7NP5nxnSuzakD0TsXlN9kxlZ
   +vz7egyZky+nb3H6MSiRGmH+uU9SCS9bo6J07nfugm1ayTRsy5YmOhnHo
   Q==;
X-CSE-ConnectionGUID: dkz9inBET7qhuT3142bz2A==
X-CSE-MsgGUID: Ug0mVlf8SLG4yO6VkOGAJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26854368"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26854368"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 07:01:58 -0700
X-CSE-ConnectionGUID: cbI57oqLSgWWTV2s2HHveQ==
X-CSE-MsgGUID: xQJ3PNCfRoGXp2R8jjn5FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41304066"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jun 2024 07:01:54 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJCvf-0004MH-2e;
	Mon, 17 Jun 2024 14:01:51 +0000
Date: Mon, 17 Jun 2024 22:01:18 +0800
From: kernel test robot <lkp@intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel.sneddon@linux.intel.com,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 2/9] cpufreq: intel_pstate: Use topology_cpu_type()
 to get cpu-type
Message-ID: <202406172134.ICqkbkNm-lkp@intel.com>
References: <20240617-add-cpu-type-v1-2-b88998c01e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-add-cpu-type-v1-2-b88998c01e76@linux.intel.com>

Hi Pawan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 83a7eefedc9b56fe7bfeff13b6c7356688ffa670]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawan-Gupta/x86-cpu-topology-Add-x86_cpu_type-to-struct-cpuinfo_topology/20240617-172542
base:   83a7eefedc9b56fe7bfeff13b6c7356688ffa670
patch link:    https://lore.kernel.org/r/20240617-add-cpu-type-v1-2-b88998c01e76%40linux.intel.com
patch subject: [PATCH PATCH 2/9] cpufreq: intel_pstate: Use topology_cpu_type() to get cpu-type
config: i386-buildonly-randconfig-001-20240617 (https://download.01.org/0day-ci/archive/20240617/202406172134.ICqkbkNm-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406172134.ICqkbkNm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406172134.ICqkbkNm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cpufreq/intel_pstate.c: In function 'hwp_get_cpu_scaling':
>> drivers/cpufreq/intel_pstate.c:1959:25: error: 'X86_CPU_TYPE_INTEL_CORE' undeclared (first use in this function)
    1959 |         if (cpu_type == X86_CPU_TYPE_INTEL_CORE)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/intel_pstate.c:1959:25: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/cpufreq/intel_pstate.c:1963:25: error: 'X86_CPU_TYPE_INTEL_ATOM' undeclared (first use in this function)
    1963 |         if (cpu_type == X86_CPU_TYPE_INTEL_ATOM)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~


vim +/X86_CPU_TYPE_INTEL_CORE +1959 drivers/cpufreq/intel_pstate.c

  1953	
  1954	static int hwp_get_cpu_scaling(int cpu)
  1955	{
  1956		u8 cpu_type = topology_cpu_type(cpu);
  1957	
  1958		/* P-cores have a smaller perf level-to-freqency scaling factor. */
> 1959		if (cpu_type == X86_CPU_TYPE_INTEL_CORE)
  1960			return hybrid_scaling_factor;
  1961	
  1962		/* Use default core scaling for E-cores */
> 1963		if (cpu_type == X86_CPU_TYPE_INTEL_ATOM)
  1964			return core_get_scaling();
  1965	
  1966		/*
  1967		 * If reached here, this system is either non-hybrid (like Tiger
  1968		 * Lake) or hybrid-capable (like Alder Lake or Raptor Lake) with
  1969		 * no E cores (in which case CPUID for hybrid support is 0).
  1970		 *
  1971		 * The CPPC nominal_frequency field is 0 for non-hybrid systems,
  1972		 * so the default core scaling will be used for them.
  1973		 */
  1974		return intel_pstate_cppc_get_scaling(cpu);
  1975	}
  1976	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

