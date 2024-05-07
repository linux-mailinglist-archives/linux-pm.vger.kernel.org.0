Return-Path: <linux-pm+bounces-7602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0408BEB70
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 20:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F934B294DD
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22516D30F;
	Tue,  7 May 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDEZVI/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02F15ECC6;
	Tue,  7 May 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105751; cv=none; b=iltsjZEE54yC7a+csgCw3MXPFPg95iZj3jqULJ1NKQvUApytnVOItDkGSLvfemrwnADIT98lA0jl4sHnGnsucZFqzTFTH9vHnS2Lxbr+4l8KVzxzxYTFQ6gqmdJ1SrAjZv3TlNX6shpUJWFBiMEV0ciH7uqACN8Zxe+KdtZIQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105751; c=relaxed/simple;
	bh=mf5UmPMNWI6z/l0QJkKwSomwSt9p6Keyb3TpKEP4LUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE6GzU2vqfKo6BtTjPKpdWYCHrTl4EQmvmGqGVFTEJI+wFpkZZP7OQ8fL7wCzRvfhFKbe8PS7MJpVa+dna6Wmb9KvLMHIW5j1+eU/D+GJT9p/6IhmxmlyoImYb1qOgN3B5Jtgj/JuL3QavOSnz6mY89V7oizspkZl1L44b+3FJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDEZVI/b; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715105749; x=1746641749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mf5UmPMNWI6z/l0QJkKwSomwSt9p6Keyb3TpKEP4LUc=;
  b=ZDEZVI/bYlZKvYfZ6BSa4qEN5jbxbuvrVD3wWE0LC+b+2UjKgxy6ms5M
   N8e2eCcsC6AgX8dYZdArZe1EdbdFIdyjA58g57eTZIxCIXLXXrmfpwG66
   +BdbNXlCYAdPd7IwMtJiUzpPCk8iKWwOeDXEiLNmubG50heeUf9sC3LGZ
   RUR8ApAUEKwsZTtuHiwEGqOhLNI7ni0akqcEeZR1Bl5Vu5RO1xXZO3UJw
   OSFTYkmYkHLUwlb12dbLvRcPWb67+Oiu0hotARELV1YYjvCuggEU0NHjj
   SeXUGmuQlW1m7NtfXqJ1kln6UkPQGmFoKHHAYpy8wPLf/knI0ddN4mOBD
   Q==;
X-CSE-ConnectionGUID: BsA16zYkTGWFlGFr9pcNNA==
X-CSE-MsgGUID: yLoa/AGmTlG8Qxxo1tWUlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11049798"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11049798"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:15:48 -0700
X-CSE-ConnectionGUID: zfCVuL4KQOuW0pBFkG9aDw==
X-CSE-MsgGUID: NBKi7VABT0ewefpDuLOBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33167004"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 May 2024 11:15:45 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4PLq-0002Xs-1r;
	Tue, 07 May 2024 18:15:42 +0000
Date: Wed, 8 May 2024 02:14:59 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
	Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
	Ray.Huang@amd.com, gautham.shenoy@amd.com, Borislav.Petkov@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] cpufreq: amd-pstate: implement heterogeneous core
 topology for highest performance initialization
Message-ID: <202405080122.4pEEcR2C-lkp@intel.com>
References: <731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan@amd.com>

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
patch link:    https://lore.kernel.org/r/731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan%40amd.com
patch subject: [PATCH 09/11] cpufreq: amd-pstate: implement heterogeneous core topology for highest performance initialization
config: x86_64-buildonly-randconfig-001-20240507 (https://download.01.org/0day-ci/archive/20240508/202405080122.4pEEcR2C-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080122.4pEEcR2C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080122.4pEEcR2C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:15:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:7:
   In file included from include/linux/spinlock.h:60:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:59:
   In file included from arch/x86/include/asm/cpufeature.h:5:
>> arch/x86/include/asm/processor.h:690:51: warning: non-void function does not return a value [-Wreturn-type]
     690 | static inline int amd_get_this_core_type(void)          { }
         |                                                           ^
   1 warning generated.
--
   In file included from drivers/usb/dwc2/hcd_ddma.c:12:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
>> arch/x86/include/asm/processor.h:690:51: warning: non-void function does not return a value [-Wreturn-type]
     690 | static inline int amd_get_this_core_type(void)          { }
         |                                                           ^
   drivers/usb/dwc2/hcd_ddma.c:555:16: warning: variable 'n_desc' set but not used [-Wunused-but-set-variable]
     555 |         u16 idx, inc, n_desc = 0, ntd_max = 0;
         |                       ^
   2 warnings generated.
--
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:15:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:7:
   In file included from include/linux/spinlock.h:60:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:59:
   In file included from arch/x86/include/asm/cpufeature.h:5:
>> arch/x86/include/asm/processor.h:690:51: warning: non-void function does not return a value [-Wreturn-type]
     690 | static inline int amd_get_this_core_type(void)          { }
         |                                                           ^
   1 warning generated.


vim +690 arch/x86/include/asm/processor.h

   680	
   681	#ifdef CONFIG_CPU_SUP_AMD
   682	extern u32 amd_get_highest_perf(void);
   683	extern void amd_clear_divider(void);
   684	extern void amd_check_microcode(void);
   685	extern int amd_get_this_core_type(void);
   686	#else
   687	static inline u32 amd_get_highest_perf(void)		{ return 0; }
   688	static inline void amd_clear_divider(void)		{ }
   689	static inline void amd_check_microcode(void)		{ }
 > 690	static inline int amd_get_this_core_type(void)		{ }
   691	#endif
   692	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

