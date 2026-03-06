Return-Path: <linux-pm+bounces-43858-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJpYJjkVq2lzZwEAu9opvQ
	(envelope-from <linux-pm+bounces-43858-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:56:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B992267F3
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766D03023375
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2F73B893F;
	Fri,  6 Mar 2026 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDqli8ev"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1E1607A4;
	Fri,  6 Mar 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819766; cv=none; b=p8r/PeCeGY6pMi/Di2agMd7fJ77eEJ46PdkYOcfLO2C2KHhqWf8IA0kS322hsoUR2ydct/AaFYYAZrZoBhi7RGhmOAvgu+07G1ulpjSqyAlHN/1D206dUy5KVBUb/wEoK06ST8EQkAPNLOngdZTm8h6yaUPH+LTtp/8s2Qkji4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819766; c=relaxed/simple;
	bh=JBmLCA38e8oFySoqUOd5XdlX3DTS/VAbPsRGUCFQVeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2W7L6af945CZKAeZBLxDYXS2o+SGKW7odi/4JlNgVXwv0bGdnE6n7Z8bT8wUQtSMmRMn/8WMsCi29FmhRcUi+rJgW7Hnyc/tX41lCQPcDhzuTmnHqfyp3GDmtpx0szJuuLNI3z4+bDn21j62vkQYasNh6COj9SQtAUzlTAsNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDqli8ev; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772819762; x=1804355762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JBmLCA38e8oFySoqUOd5XdlX3DTS/VAbPsRGUCFQVeQ=;
  b=dDqli8evzy3OHJ/Dde708UScMAJuXYCDeI5SCxpmGJTZbgCW3QGnDY5L
   9gxy8rZisuvr9iL+3/Bxv3+1kqeCwpj393ai7hR3ZKPnZx2p37h4/OhuF
   JjYa7Sg1sYoqbabGDbaSAKXVdw5mG/g857QeEkZucNS5YZdn1rHKwNTRq
   VWN5chBIFwEVi6gjRTHsZtL7pOWKJ++eDWVMsZFoAPEGTo+MJka69l/wo
   iINP4fB3qk0ZtjFHJIVXKxK5/6ovCRXo7AygFLxSQrKbq4/txqFo2CAa8
   wVhYZgL7tCNPUDBCv8pq0G5Nl0tmguoIKa/LlKkjBwkYn8Q/V8G5uGG4l
   Q==;
X-CSE-ConnectionGUID: i8rTFeL8Sric9O5T4JdrRQ==
X-CSE-MsgGUID: BEitJtouSe6ohnaESmNpng==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="76538470"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="76538470"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 09:56:01 -0800
X-CSE-ConnectionGUID: SWN/wohfSgS8Uj1TPv0uQw==
X-CSE-MsgGUID: ycIWSdkwSkSMQpDzoTr4sQ==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 06 Mar 2026 09:55:59 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyZP3-000000002Ij-0k7K;
	Fri, 06 Mar 2026 17:55:57 +0000
Date: Fri, 6 Mar 2026 18:54:59 +0100
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
Message-ID: <202603061846.lCieImRU-lkp@intel.com>
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
X-Rspamd-Queue-Id: C5B992267F3
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
	TAGGED_FROM(0.00)[bounces-43858-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,git-scm.com:url]
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
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260306/202603061846.lCieImRU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603061846.lCieImRU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603061846.lCieImRU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from ./include/linux/compiler.h:372,
                    from ./include/linux/build_bug.h:5,
                    from ./include/linux/bitfield.h:10,
                    from drivers/cpufreq/amd-pstate.c:25:
   drivers/cpufreq/amd-pstate.c: In function 'msr_init_perf':
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:79:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:79:26: note: in expansion of macro '__bf_cast_unsigned'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |                          ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:177:17: note: in expansion of macro '__BF_FIELD_CHECK_REG'
     177 |                 __BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:79:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:79:26: note: in expansion of macro '__bf_cast_unsigned'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |                          ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:177:17: note: in expansion of macro '__BF_FIELD_CHECK_REG'
     177 |                 __BF_FIELD_CHECK_REG(_mask, _reg, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:69:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      69 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:69:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      69 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:71:47: note: in expansion of macro '__bf_shf'
      71 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:70:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:71:47: note: in expansion of macro '__bf_shf'
      71 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ././include/linux/compiler_types.h:694:9: note: in expansion of macro '__compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   ./include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
      75 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   ./include/linux/bitfield.h:97:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      97 |                 __BF_FIELD_CHECK_MASK(mask, 0U, pfx);                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ./include/linux/bitfield.h:98:52: note: in expansion of macro '__bf_shf'
      98 |                 (typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));     \
         |                                                    ^~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   ./include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   drivers/cpufreq/amd-pstate.c:497:9: note: in expansion of macro 'WRITE_ONCE'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |         ^~~~~~~~~~
   ./include/linux/bitfield.h:98:52: note: in expansion of macro '__bf_shf'
      98 |                 (typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));     \
         |                                                    ^~~~~~~~
   ./include/linux/bitfield.h:178:17: note: in expansion of macro '__FIELD_GET'
     178 |                 __FIELD_GET(_mask, _reg, "FIELD_GET: ");                \
         |                 ^~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:497:45: note: in expansion of macro 'FIELD_GET'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                             ^~~~~~~~~
   ./include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   ./arch/x86/include/asm/msr-index.h:772:41: note: in expansion of macro 'GENMASK'
     772 | #define AMD_CPPC_FLOOR_PERF_CNT_MASK    GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/cpufreq/amd-pstate.c:497:55: note: in expansion of macro 'AMD_CPPC_FLOOR_PERF_CNT_MASK'
     497 |         WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +48 ./include/linux/bits.h

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

