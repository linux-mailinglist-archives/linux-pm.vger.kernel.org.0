Return-Path: <linux-pm+bounces-7764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCAA8C45E9
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA81C214FA
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C39208D4;
	Mon, 13 May 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxxhERDL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394F20310;
	Mon, 13 May 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620972; cv=none; b=oWsqUTaVR8O2K52UQOCrOgRYTAv+/HcJq4iglaaNw5I4PbJ+cs1//aTjYo12U4zBG5rfuN/EQatUHLubL2ulwPhYIQHhq9TYKuh0KVFicGclop9eOx9CpI152VPr9yZjRxgxqhcmIW8jC0OQX1Cia9KfplC1fJ1Arxi9OEpQKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620972; c=relaxed/simple;
	bh=tyn7cuWnJ6Md4cnRgbwQWBGpdzeCwPyjaPP8SzCMlOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR0Vf7WWqcWTH0Lm+a0pcwfmgWL+Z5akupV3CMo5dER2wtnIge0EyawRI33w8/QafmUaFgLsy69Rj1JmXsL1z2sPq5Pm1cQs0PKRzFNEJ53E9zfz36fAHj+SlBulHNVjXlGaUvD7CNbOQRuUw78L/fNW40xK3T51j3Pluvdpki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxxhERDL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715620970; x=1747156970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tyn7cuWnJ6Md4cnRgbwQWBGpdzeCwPyjaPP8SzCMlOI=;
  b=lxxhERDLnkJBgD5mGWDKJ9k2raOmnxPsWrHTt+IVNZQcnkI0YCWVKzom
   PL8GBIh2ebDHeepe+fSP0g9qkQx2dizw3XE0LHCxP7Dxl4bqCpWkN35hD
   BUmUffUBFdoW4m5JStGVVeKR3BM3c8jyOGdtd+eH/A/2m6AKlvCQKY2Mf
   M/z6biV23lcS+3w1LDTIayzuLyxx7G9R8ljtcQ1oon3TffHcCqxI0J8rC
   l+8klW75Li9WYiOJ/jC324Ym5i+umcfVdMc4+h4iuENT5Uk/P/lrBwNh6
   V6e9kfrypnGF3ipF9rKiYhUDV+AFGT7d2OGZFZPYmOkcdMk+imwQJrjbr
   w==;
X-CSE-ConnectionGUID: 1fUyRp+PSHmXROSYpbLo0A==
X-CSE-MsgGUID: 2l/YLp5VQFS4HlZFfRO+TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11515361"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11515361"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 10:22:48 -0700
X-CSE-ConnectionGUID: svXuqNxNRXyAQU2rJ9v06Q==
X-CSE-MsgGUID: 5OviWa7LTgyubePSx02tYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35156592"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 May 2024 10:22:45 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6ZNq-000AUP-1M;
	Mon, 13 May 2024 17:22:42 +0000
Date: Tue, 14 May 2024 01:21:46 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>, Mario.Limonciello@amd.com,
	gautham.shenoy@amd.com, Ray.Huang@amd.com, Borislav.Petkov@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rafael.j.wysocki@intel.com, Alexander.Deucher@amd.com,
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] cpufreq: amd-pstate: add debug message while
 CPPC is supported and disabled by SBIOS
Message-ID: <202405140103.onvXHkqE-lkp@intel.com>
References: <94ad4bca2d8e44a5e53082959220a184c0222e1e.1715356532.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ad4bca2d8e44a5e53082959220a184c0222e1e.1715356532.git.perry.yuan@amd.com>

Hi Perry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge next-20240513]
[cannot apply to tip/x86/core linus/master v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Perry-Yuan/cpufreq-amd-pstate-optimize-the-initial-frequency-values-verification/20240513-101217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/94ad4bca2d8e44a5e53082959220a184c0222e1e.1715356532.git.perry.yuan%40amd.com
patch subject: [PATCH v2 04/10] cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS
config: i386-randconfig-013-20240513 (https://download.01.org/0day-ci/archive/20240514/202405140103.onvXHkqE-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405140103.onvXHkqE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405140103.onvXHkqE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:1727:26: warning: overlapping comparisons always evaluate to false [-Wtautological-overlap-compare]
    1727 |                                 (c->x86_model > 0x1f && c->x86_model < 0x1f)) {
         |                                  ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1727 drivers/cpufreq/amd-pstate.c

  1703	
  1704	/**
  1705	 * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
  1706	 * show the debug message that helps to check if the CPU has CPPC support for loading issue.
  1707	 */
  1708	static bool amd_cppc_supported(void)
  1709	{
  1710		struct cpuinfo_x86 *c = &cpu_data(0);
  1711	
  1712		if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
  1713			pr_debug_once("CPPC feature is not supported by the processor\n");
  1714			return false;
  1715		}
  1716	
  1717		/*
  1718		 * If the CPPC flag is disabled in the BIOS for processors that support MSR-based CPPC
  1719		 * the AMD Pstate driver may not function correctly.
  1720		 */
  1721		if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
  1722			if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
  1723				if (c->x86_model > 0x60 && c->x86_model < 0xaf)
  1724					goto warn;
  1725			} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
  1726				if ((c->x86_model > 0x00 && c->x86_model < 0x0F) || (c->x86_model > 0x2f && c->x86_model < 0xaf) ||
> 1727					(c->x86_model > 0x1f && c->x86_model < 0x1f)) {
  1728					goto warn;
  1729				}
  1730			} else {
  1731				goto warn;
  1732			}
  1733		}
  1734	
  1735		return true;
  1736	
  1737	warn:
  1738		pr_debug_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
  1739						"Please enable it if your BIOS supports the CPPC option.\n");
  1740		return false;
  1741	}
  1742	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

