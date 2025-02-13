Return-Path: <linux-pm+bounces-22011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA56A33E71
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 12:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF717A502D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794F2147F7;
	Thu, 13 Feb 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZiIdOqi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA3211A06;
	Thu, 13 Feb 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447429; cv=none; b=I39Tmja93qJJXzowY43jsRhgqbMcK68SDL0C+/cXKmWV6SOOHxZzlIl+2UKFF88UY/dVtI5dONFd2PKKBlnqjhszauo/L9qKFp8/Qr+iaag7IyyuoQqhwNCscAEttfsFYIgfzPBNwadaydW9IoppcXMtm6lW9dVkAIYqkPEHiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447429; c=relaxed/simple;
	bh=Y6v7Cbp+Xf4wQubXKdSMUI+Vl4c6tYrKjSLTH9HgeYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmS9AufCO07Za71mVJx+uSUb91zOm8WDvtb3a2Um2l8y/8omMYo6ZhZUkWZ4QkYye8F8qehscF+E7fa8mkrG9Jko/zRyxRp4ULfYgJc2TAXnvqoMH2Ve4q0R+qHP3V8kDaCGcAaKXa6SnVHustJECymvjHmH+8koh4glLYUfRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZiIdOqi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739447427; x=1770983427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y6v7Cbp+Xf4wQubXKdSMUI+Vl4c6tYrKjSLTH9HgeYc=;
  b=IZiIdOqiVBAx+HDaHOxDsN2Yl9LkMDf3mbjoyNfI3tlKrTHRij3Xtvjr
   JiTerH3DKrFydUDnFOCWl2uf5SOeaH5I7SSPhxFklgmcw5VoXv7g6MQP1
   pYtv/4geW5mGttgzUpy9uGILAX606DrJqP6Riz3/snzFoGylENcv33R1o
   WBJsJW6b+p8LJBCIv9GGhREubbh38WitgZ8dbpFiUFv5+bUC4FobJbILP
   kpUuefZer90QOf1fvf29xjbFC8Oa175gQoKqcBWo7WKxOzogw85emQcSS
   dlWK5bHj525L/sZvPcZL923reozc+csK5O69SEVWvH8d3jtNsFZ78wdrX
   A==;
X-CSE-ConnectionGUID: 7Ixf/dvjSGyn4j3HAXKvGg==
X-CSE-MsgGUID: 0uvZLy1fRSeWEbKFtFNEMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="65497230"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="65497230"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:50:26 -0800
X-CSE-ConnectionGUID: syf8Snt2TKa3BUIKH1lLEQ==
X-CSE-MsgGUID: cKdFBmusQS+ECOdshtp8ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113299312"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Feb 2025 03:50:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiXja-0016zp-09;
	Thu, 13 Feb 2025 11:50:22 +0000
Date: Thu, 13 Feb 2025 19:49:41 +0800
From: kernel test robot <lkp@intel.com>
To: David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Arcari <darcari@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>,
	Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] intel_idle: introduce 'no_native' module parameter
Message-ID: <202502131953.d3fHaDCE-lkp@intel.com>
References: <20250211132741.99944-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211132741.99944-1-darcari@redhat.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on acpi/next]
[also build test ERROR on amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.14-rc2 next-20250213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Arcari/intel_idle-introduce-no_native-module-parameter/20250211-213031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git next
patch link:    https://lore.kernel.org/r/20250211132741.99944-1-darcari%40redhat.com
patch subject: [PATCH v3] intel_idle: introduce 'no_native' module parameter
config: i386-buildonly-randconfig-002-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131953.d3fHaDCE-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131953.d3fHaDCE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131953.d3fHaDCE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/idle/intel_idle.c:48:
   In file included from include/trace/events/power.h:12:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/idle/intel_idle.c:2289:20: error: use of undeclared identifier 'no_acpi'; did you mean 'no_action'?
    2289 |         if (no_native && !no_acpi) {
         |                           ^~~~~~~
         |                           no_action
   include/linux/interrupt.h:138:20: note: 'no_action' declared here
     138 | extern irqreturn_t no_action(int cpl, void *dev_id);
         |                    ^
>> drivers/idle/intel_idle.c:2289:20: warning: address of function 'no_action' will always evaluate to 'true' [-Wpointer-bool-conversion]
    2289 |         if (no_native && !no_acpi) {
         |                          ~^~~~~~~
   drivers/idle/intel_idle.c:2289:20: note: prefix with the address-of operator to silence this warning
    2289 |         if (no_native && !no_acpi) {
         |                           ^
         |                           &
   2 warnings and 1 error generated.


vim +2289 drivers/idle/intel_idle.c

  2248	
  2249	static int __init intel_idle_init(void)
  2250	{
  2251		const struct x86_cpu_id *id;
  2252		unsigned int eax, ebx, ecx;
  2253		int retval;
  2254	
  2255		/* Do not load intel_idle at all for now if idle= is passed */
  2256		if (boot_option_idle_override != IDLE_NO_OVERRIDE)
  2257			return -ENODEV;
  2258	
  2259		if (max_cstate == 0) {
  2260			pr_debug("disabled\n");
  2261			return -EPERM;
  2262		}
  2263	
  2264		id = x86_match_cpu(intel_idle_ids);
  2265		if (id) {
  2266			if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
  2267				pr_debug("Please enable MWAIT in BIOS SETUP\n");
  2268				return -ENODEV;
  2269			}
  2270		} else {
  2271			id = x86_match_cpu(intel_mwait_ids);
  2272			if (!id)
  2273				return -ENODEV;
  2274		}
  2275	
  2276		if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
  2277			return -ENODEV;
  2278	
  2279		cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
  2280	
  2281		if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
  2282		    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
  2283		    !mwait_substates)
  2284				return -ENODEV;
  2285	
  2286		pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
  2287	
  2288		icpu = (const struct idle_cpu *)id->driver_data;
> 2289		if (no_native && !no_acpi) {
  2290			if (icpu) {
  2291				pr_debug("ignoring native cpu idle states\n");
  2292				icpu = NULL;
  2293			}
  2294		}
  2295		if (icpu) {
  2296			if (icpu->state_table)
  2297				cpuidle_state_table = icpu->state_table;
  2298			else if (!intel_idle_acpi_cst_extract())
  2299				return -ENODEV;
  2300	
  2301			auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
  2302			if (icpu->disable_promotion_to_c1e)
  2303				c1e_promotion = C1E_PROMOTION_DISABLE;
  2304			if (icpu->use_acpi || force_use_acpi)
  2305				intel_idle_acpi_cst_extract();
  2306		} else if (!intel_idle_acpi_cst_extract()) {
  2307			return -ENODEV;
  2308		}
  2309	
  2310		pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
  2311			 boot_cpu_data.x86_model);
  2312	
  2313		intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
  2314		if (!intel_idle_cpuidle_devices)
  2315			return -ENOMEM;
  2316	
  2317		intel_idle_cpuidle_driver_init(&intel_idle_driver);
  2318	
  2319		retval = cpuidle_register_driver(&intel_idle_driver);
  2320		if (retval) {
  2321			struct cpuidle_driver *drv = cpuidle_get_driver();
  2322			printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
  2323			       drv ? drv->name : "none");
  2324			goto init_driver_fail;
  2325		}
  2326	
  2327		retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
  2328					   intel_idle_cpu_online, NULL);
  2329		if (retval < 0)
  2330			goto hp_setup_fail;
  2331	
  2332		pr_debug("Local APIC timer is reliable in %s\n",
  2333			 boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
  2334	
  2335		return 0;
  2336	
  2337	hp_setup_fail:
  2338		intel_idle_cpuidle_devices_uninit();
  2339		cpuidle_unregister_driver(&intel_idle_driver);
  2340	init_driver_fail:
  2341		free_percpu(intel_idle_cpuidle_devices);
  2342		return retval;
  2343	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

