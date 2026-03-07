Return-Path: <linux-pm+bounces-43887-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M4llE7dsq2kodAEAu9opvQ
	(envelope-from <linux-pm+bounces-43887-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 01:09:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0F228E89
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 01:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A792E30387CC
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 00:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34BD1386DA;
	Sat,  7 Mar 2026 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BC3S/Tew"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DB3F9FB;
	Sat,  7 Mar 2026 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842160; cv=none; b=XkAl0d1vkVpu7Ru7wVEO6LUSG3bN7LFiz5XkS+GkqH7v5WZqDtm3F8ziIHiCsFhl330LjRntSZRm/6dc2nfcWbAq97m1Box+y7+1zwroOYFm4E1erotm0tqZdGlwBR6WZv3UA0ztLqfVueUGoMFXfuMUWxh1ASzRXb/dJwp0uEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842160; c=relaxed/simple;
	bh=6EnwgjcZi/98PZe5JyUTh90d6E1uap2pVEvFTsq5qTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3otu1w2+Hlss7JTcZydr7d0DhTBgEgotIhnZgiAOL9iMhMT11cgS+u0aJ3qiNigwyZuXviAilPSC/3AIR4FMGHXHsLTAm92tpxJeSHDuEgHB1WN+pq911eL0/qV1NL/Z5QvPLJYI9AkcL9jFKq6Qp2ma0afetWwSryJLv+Da8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BC3S/Tew; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772842158; x=1804378158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EnwgjcZi/98PZe5JyUTh90d6E1uap2pVEvFTsq5qTI=;
  b=BC3S/TewstBBBEwlrKZV6PF4Iy1+2C97ntWRPrYH+ySCE9A2c0T6OOV7
   rybZ/E98mPlM/dbEgrBSqE9DXTHq0eu1SHfisG7tL4l6AG1OvcXxCvikG
   I6gjkOhYd2Be5CWfBTiHFhPcKv6wY0yx/YMpKBAvtZGXXbNWyx0Q7QtRM
   cJbKWX0vmGYkBbWvk5C8XNnAVH7aFKI4XuT5fK6FbBw72mnlT3GR4HuBB
   ilHPTxn5NxUMHGGkumyeeX9V1Mx+zEVGaBOqNXlBYWrQbtRpLbamb7Z2L
   4EW0n4iC8edu8hbDc7a9C/u++x3uBXGiRhGjwenN/fL+VgErl6L9ovJU8
   Q==;
X-CSE-ConnectionGUID: gtjM8l5YTz+U4QX5t0NebA==
X-CSE-MsgGUID: OUuDkQWOReSiWDRJSJ84lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84667657"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="84667657"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 16:09:17 -0800
X-CSE-ConnectionGUID: UQrNeg7RQTmA3TGUqhxF2g==
X-CSE-MsgGUID: osfyBrIJS962XMGQ/RW5Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="218383274"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2026 16:09:14 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyfEF-000000001V3-3xh6;
	Sat, 07 Mar 2026 00:09:11 +0000
Date: Sat, 7 Mar 2026 08:08:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 5/9] amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
Message-ID: <202603070828.5EfEKi5Y-lkp@intel.com>
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
X-Rspamd-Queue-Id: 8AE0F228E89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-43887-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid]
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
config: i386-randconfig-r052-20260307 (https://download.01.org/0day-ci/archive/20260307/202603070828.5EfEKi5Y-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070828.5EfEKi5Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070828.5EfEKi5Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:372,
                    from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from drivers/cpufreq/amd-pstate.c:25:
   drivers/cpufreq/amd-pstate.c: In function 'msr_init_perf':
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |         ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:26: note: in expansion of macro '__bf_cast_unsigned'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |                          ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:177:17: note: in expansion of macro '__BF_FIELD_CHECK_REG'
     177 |                 __BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |         ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:26: note: in expansion of macro '__bf_cast_unsigned'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |                          ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:177:17: note: in expansion of macro '__BF_FIELD_CHECK_REG'
     177 |                 __BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      69 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      69 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:47: note: in expansion of macro '__bf_shf'
      71 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:47: note: in expansion of macro '__bf_shf'
      71 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/bitfield.h:98:52: note: in expansion of macro '__bf_shf'
      98 |                 (typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));     \
         |                                                    ^~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   include/linux/bitfield.h:98:52: note: in expansion of macro '__bf_shf'
      98 |                 (typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));     \
         |                                                    ^~~~~~~~
   include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +48 include/linux/bits.h

31299a5e021124 Vincent Mailhol 2025-03-26  35  
19408200c09485 Vincent Mailhol 2025-03-26  36  /*
19408200c09485 Vincent Mailhol 2025-03-26  37   * Generate a mask for the specified type @t. Additional checks are made to
19408200c09485 Vincent Mailhol 2025-03-26  38   * guarantee the value returned fits in that type, relying on
19408200c09485 Vincent Mailhol 2025-03-26  39   * -Wshift-count-overflow compiler check to detect incompatible arguments.
19408200c09485 Vincent Mailhol 2025-03-26  40   * For example, all these create build errors or warnings:
19408200c09485 Vincent Mailhol 2025-03-26  41   *
19408200c09485 Vincent Mailhol 2025-03-26  42   * - GENMASK(15, 20): wrong argument order
19408200c09485 Vincent Mailhol 2025-03-26  43   * - GENMASK(72, 15): doesn't fit unsigned long
19408200c09485 Vincent Mailhol 2025-03-26  44   * - GENMASK_U32(33, 15): doesn't fit in a u32
19408200c09485 Vincent Mailhol 2025-03-26  45   */
19408200c09485 Vincent Mailhol 2025-03-26  46  #define GENMASK_TYPE(t, h, l)					\
19408200c09485 Vincent Mailhol 2025-03-26  47  	((t)(GENMASK_INPUT_CHECK(h, l) +			\
19408200c09485 Vincent Mailhol 2025-03-26 @48  	     (type_max(t) << (l) &				\
19408200c09485 Vincent Mailhol 2025-03-26  49  	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
19408200c09485 Vincent Mailhol 2025-03-26  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

