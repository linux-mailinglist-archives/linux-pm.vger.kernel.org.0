Return-Path: <linux-pm+bounces-43877-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLoMINw3q2mkbAEAu9opvQ
	(envelope-from <linux-pm+bounces-43877-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:23:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF45227796
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 187F1304606F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8509943CED7;
	Fri,  6 Mar 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2igWcDu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2C31B830;
	Fri,  6 Mar 2026 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828633; cv=none; b=tw+sASTE0AjFfvj94ExNrPLKwNLE8Gr/UBAgMp9K0mvY8eYCJVt7fOUHCO+hL6l1oPhb+220DenpGgw7eTJSutbr+e+Yfz72TZyR33g82qYPtWvAvJmgLq/ngnXNLtKZ5hRLqdIneiT5juLvS1FooR9NbalXt8aVo3OxJ+Fg08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828633; c=relaxed/simple;
	bh=enRpREDLJQ2WdpmAT0RahcTiH9UVBCBVCKB6WpDUnRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBJTn66lvyg0Gs+UUtQDDSg5+XvxFgwhcokbSYfrF0B/o9tva1TBmZXucEg4GQt4UoQp9IHvuyUj1ZdpIPRXsXOdjGLse+LpzwM6H+ojr0HuXKUt8+rHlAFdB/n1iTPSLVeZ69L/XUN16xre9zbsjPL0qRsXhxtHkYMbZZE9a9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2igWcDu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772828632; x=1804364632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=enRpREDLJQ2WdpmAT0RahcTiH9UVBCBVCKB6WpDUnRs=;
  b=h2igWcDu/d8AdfG1tTQ2SL2ZsXe1V8ZVn9VU1GazEdV8mFz7Mi8OV03R
   nAZAS4uOObq61A+L0kFSenBqADUAxBRBGTSkETpVu5ttY+cITP6/gkp0W
   V2jZEdQjDe3otUA7Vw5vVT5sGXzvVdVWQFF6dmyr1aMu/5gw9w2Jfs2zH
   ge7p00nMJbnJEynfsiuquHZOoVGQZVnVp8YhYXY8AmnJyph01UVeruwj7
   UX7k5+60GzPOchIGKti7Nvq3U3xxkWItIvV3AgKlHIu6TMl2uPSMPSjCQ
   gPSQ9FoTbMri7Spc55/wssSQAY9jPqLLmN4c72zUcwNsuPB7/uprbWGTk
   A==;
X-CSE-ConnectionGUID: tOIiLSzKSuG8mYY/0pxz1A==
X-CSE-MsgGUID: zWNgtnkdSce9eLMeZOhb0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73912146"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73912146"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 12:23:51 -0800
X-CSE-ConnectionGUID: 0smXMhmoRK6VwxKaCKYvTA==
X-CSE-MsgGUID: kNn4qMNTTDSPVwteu2WRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="217306901"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2026 12:23:48 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vybi5-000000001Lx-0W9V;
	Fri, 06 Mar 2026 20:23:45 +0000
Date: Sat, 7 Mar 2026 04:22:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 5/9] amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
Message-ID: <202603070431.ykswVnpp-lkp@intel.com>
References: <20260306095753.17155-6-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306095753.17155-6-gautham.shenoy@amd.com>
X-Rspamd-Queue-Id: 5DF45227796
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-43877-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,git-scm.com:url]
X-Rspamd-Action: no action

Hi Gautham,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge tip/x86/core amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.0-rc2 next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gautham-R-Shenoy/amd-pstate-Fix-memory-leak-in-amd_pstate_epp_cpu_init/20260306-180651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260306095753.17155-6-gautham.shenoy%40amd.com
patch subject: [PATCH 5/9] amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
config: i386-defconfig (https://download.01.org/0day-ci/archive/20260307/202603070431.ykswVnpp-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070431.ykswVnpp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070431.ykswVnpp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:497:48: warning: shift count >= width of type [-Wshift-count-overflow]
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:38: note: expanded from macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ~~~~~~~~~~~~~~~~^~~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
>> drivers/cpufreq/amd-pstate.c:497:48: warning: shift count >= width of type [-Wshift-count-overflow]
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:38: note: expanded from macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ~~~~~~~~~~~~~~~~^~~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
>> drivers/cpufreq/amd-pstate.c:497:48: warning: shift count >= width of type [-Wshift-count-overflow]
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:38: note: expanded from macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ~~~~~~~~~~~~~~~~^~~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
>> drivers/cpufreq/amd-pstate.c:497:48: warning: shift count >= width of type [-Wshift-count-overflow]
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:38: note: expanded from macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ~~~~~~~~~~~~~~~~^~~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
>> drivers/cpufreq/amd-pstate.c:497:48: warning: shift count >= width of type [-Wshift-count-overflow]
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:38: note: expanded from macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ~~~~~~~~~~~~~~~~^~~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
>> drivers/cpufreq/amd-pstate.c:497:48: warning: shift count >= width of type [-Wshift-count-overflow]
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:38: note: expanded from macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ~~~~~~~~~~~~~~~~^~~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   6 warnings generated.


vim +497 drivers/cpufreq/amd-pstate.c

   457	
   458	static int msr_init_perf(struct amd_cpudata *cpudata)
   459	{
   460		union perf_cached perf = READ_ONCE(cpudata->perf);
   461		u64 cap1, numerator, cppc_req;
   462		u8 min_perf;
   463	
   464		int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
   465					     &cap1);
   466		if (ret)
   467			return ret;
   468	
   469		ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
   470		if (ret)
   471			return ret;
   472	
   473		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
   474		if (ret)
   475			return ret;
   476	
   477		WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
   478		min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
   479	
   480		/*
   481		 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
   482		 * indication that the min_perf value is the one specified through the BIOS option
   483		 */
   484		cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
   485	
   486		if (!cppc_req)
   487			perf.bios_min_perf = min_perf;
   488	
   489		perf.highest_perf = numerator;
   490		perf.max_limit_perf = numerator;
   491		perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
   492		perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
   493		perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
   494		perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
   495		WRITE_ONCE(cpudata->perf, perf);
   496		WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
 > 497		WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
   498	
   499		return 0;
   500	}
   501	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

