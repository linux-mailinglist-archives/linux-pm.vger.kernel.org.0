Return-Path: <linux-pm+bounces-20089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA91A05BAE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 13:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11511161175
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56E1F8AD3;
	Wed,  8 Jan 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjgtYXD3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146A38F82;
	Wed,  8 Jan 2025 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339537; cv=none; b=RN1w/LMzXQHRQZq1C3ju9axdQDo2UaHv6kJsJXRFfoNBwcCHllB1X4drkMMtuRO0r1iLI6Y0nbV2j8Aw8xH2DGsqhhehXXiALYn9Ku+A9N98T76r1OV7XO/VAkH2p6wiR88BFwemUyAzxL6EAAsDE5WBvCXGdLXqNdxSEyjhcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339537; c=relaxed/simple;
	bh=Ea4jKsP0n4/hshTEV/PklHDtWe1+UN3n9XnYxXrF0Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blK/Yw5vXUJRZWH9GlTZEJs7zG5gwgdfO0AiJ6tm/avUxw3tE3/AjhpFaCmwclNflOO6ZaIKimEk9aZNk250STiIMkFicjf6PQE7sfBdctUz/1fFKNBis83RMUCVkZxCnkE/x5aTAGAReAvW1JVw3sPmLiMMWNW2yimTSE3B2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjgtYXD3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736339535; x=1767875535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ea4jKsP0n4/hshTEV/PklHDtWe1+UN3n9XnYxXrF0Qs=;
  b=jjgtYXD3aaEHvmmI8pQSnTxR5QeFj2B3If6761vS8L/PQ02P+Xuo57iB
   zFN7aJDjbSDtFcgwP4bvBZkvblJPLYpyYXUui0rtF/gvwgU4gi+gtW/si
   SAWTR9oOqI+oeMoeK9ZSjR9JPwtmEcqL1nz/3MC7hLurNrwdEPFuDmFJv
   jl+K9gEbdWhxVsgiGZJd1g3B+2+QWIldlUmpwOrLe4W0Z6ZBs0J3F//z/
   8SYeWzlCJKDpTPM2D05WiPIyHZxI49e8w/zyADoua1mVTBARSmuoB335T
   SwODqvG7gBopi/2xG/hQpLGnNpjqh5IiNaJwKkq5deQmHUzjLkW/Fao6O
   Q==;
X-CSE-ConnectionGUID: T68bSpIMSCu3HJjhGaDWyw==
X-CSE-MsgGUID: cf6nxjxfQ6Cx73aUfHchBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47136288"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="47136288"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 04:32:14 -0800
X-CSE-ConnectionGUID: pcyi9oEMToywcUt+uEVG+A==
X-CSE-MsgGUID: gLXSjSD0TG6pAUSJUsyUrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="102884803"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2025 04:32:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVVEG-000G3r-1Q;
	Wed, 08 Jan 2025 12:32:08 +0000
Date: Wed, 8 Jan 2025 20:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
Message-ID: <202501082018.EFwpqIgM-lkp@intel.com>
References: <20250105142645.20128-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105142645.20128-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.13-rc6 next-20250107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-airoha-Add-EN7581-CPUFreq-SMCCC-driver/20250105-223027
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250105142645.20128-1-ansuelsmth%40gmail.com
patch subject: [PATCH v9 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20250108/202501082018.EFwpqIgM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250108/202501082018.EFwpqIgM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501082018.EFwpqIgM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:3:
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c: In function 'airoha_cpu_pmdomain_clk_get':
>> include/linux/arm-smccc.h:591:49: error: expected string literal before 'SMCCC_HVC_INST'
     591 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:552:30: note: in definition of macro '__arm_smccc_1_1'
     552 |                 asm volatile(inst "\n" :                                \
         |                              ^~~~
   include/linux/arm-smccc.h:629:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     629 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:537:29: warning: unused variable 'arg7' [-Wunused-variable]
     537 |         register typeof(a7) arg7 asm("r7") = __a7
         |                             ^~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:33: note: in expansion of macro '__arm_smccc_1_1'
     591 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     629 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:532:29: warning: unused variable 'arg6' [-Wunused-variable]
     532 |         register typeof(a6) arg6 asm("r6") = __a6
         |                             ^~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:33: note: in expansion of macro '__arm_smccc_1_1'
     591 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     629 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:527:29: warning: unused variable 'arg5' [-Wunused-variable]
     527 |         register typeof(a5) arg5 asm("r5") = __a5
         |                             ^~~~
   include/linux/arm-smccc.h:531:9: note: in expansion of macro '__declare_arg_7'
     531 |         __declare_arg_7(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:33: note: in expansion of macro '__arm_smccc_1_1'
     591 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     629 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:522:29: warning: unused variable 'arg4' [-Wunused-variable]
     522 |         register typeof(a4) arg4 asm("r4") = __a4
         |                             ^~~~
   include/linux/arm-smccc.h:526:9: note: in expansion of macro '__declare_arg_6'
     526 |         __declare_arg_6(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:531:9: note: in expansion of macro '__declare_arg_7'
     531 |         __declare_arg_7(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
--
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:516:29: warning: unused variable 'arg2' [-Wunused-variable]
     516 |         register typeof(a2) arg2 asm("r2") = __a2;                      \
         |                             ^~~~
   include/linux/arm-smccc.h:521:9: note: in expansion of macro '__declare_arg_5'
     521 |         __declare_arg_5(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:526:9: note: in expansion of macro '__declare_arg_6'
     526 |         __declare_arg_6(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:531:9: note: in expansion of macro '__declare_arg_7'
     531 |         __declare_arg_7(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:33: note: in expansion of macro '__arm_smccc_1_1'
     591 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     629 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:515:29: warning: unused variable 'arg1' [-Wunused-variable]
     515 |         register typeof(a1) arg1 asm("r1") = __a1;                      \
         |                             ^~~~
   include/linux/arm-smccc.h:521:9: note: in expansion of macro '__declare_arg_5'
     521 |         __declare_arg_5(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:526:9: note: in expansion of macro '__declare_arg_6'
     526 |         __declare_arg_6(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:531:9: note: in expansion of macro '__declare_arg_7'
     531 |         __declare_arg_7(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:33: note: in expansion of macro '__arm_smccc_1_1'
     591 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     629 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:514:32: warning: unused variable 'arg0' [-Wunused-variable]
     514 |         register unsigned long arg0 asm("r0") = (u32)a0;                        \
         |                                ^~~~
   include/linux/arm-smccc.h:521:9: note: in expansion of macro '__declare_arg_5'
     521 |         __declare_arg_5(a0, a1, a2, a3, res);                           \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:526:9: note: in expansion of macro '__declare_arg_6'
     526 |         __declare_arg_6(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:531:9: note: in expansion of macro '__declare_arg_7'
     531 |         __declare_arg_7(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:591:33: note: in expansion of macro '__arm_smccc_1_1'
     591 | #define arm_smccc_1_1_hvc(...)  __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:629:25: note: in expansion of macro 'arm_smccc_1_1_hvc'
     629 |                         arm_smccc_1_1_hvc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
>> include/linux/arm-smccc.h:575:49: error: expected string literal before 'SMCCC_SMC_INST'
     575 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                                 ^~~~~~~~~~~~~~
   include/linux/arm-smccc.h:552:30: note: in definition of macro '__arm_smccc_1_1'
     552 |                 asm volatile(inst "\n" :                                \
         |                              ^~~~
   include/linux/arm-smccc.h:632:25: note: in expansion of macro 'arm_smccc_1_1_smc'
     632 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:537:29: warning: unused variable 'arg7' [-Wunused-variable]
     537 |         register typeof(a7) arg7 asm("r7") = __a7
         |                             ^~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:33: note: in expansion of macro '__arm_smccc_1_1'
     575 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:25: note: in expansion of macro 'arm_smccc_1_1_smc'
     632 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:532:29: warning: unused variable 'arg6' [-Wunused-variable]
     532 |         register typeof(a6) arg6 asm("r6") = __a6
         |                             ^~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:33: note: in expansion of macro '__arm_smccc_1_1'
     575 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:25: note: in expansion of macro 'arm_smccc_1_1_smc'
     632 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:527:29: warning: unused variable 'arg5' [-Wunused-variable]
     527 |         register typeof(a5) arg5 asm("r5") = __a5
         |                             ^~~~
   include/linux/arm-smccc.h:531:9: note: in expansion of macro '__declare_arg_7'
     531 |         __declare_arg_7(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/arm-smccc.h:550:17: note: in expansion of macro 'CONCATENATE'
     550 |                 CONCATENATE(__declare_arg_,                             \
         |                 ^~~~~~~~~~~
   include/linux/arm-smccc.h:575:33: note: in expansion of macro '__arm_smccc_1_1'
     575 | #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:632:25: note: in expansion of macro 'arm_smccc_1_1_smc'
     632 |                         arm_smccc_1_1_smc(__VA_ARGS__);                 \
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c:35:9: note: in expansion of macro 'arm_smccc_1_1_invoke'
      35 |         arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:522:29: warning: unused variable 'arg4' [-Wunused-variable]
     522 |         register typeof(a4) arg4 asm("r4") = __a4
         |                             ^~~~
   include/linux/arm-smccc.h:526:9: note: in expansion of macro '__declare_arg_6'
     526 |         __declare_arg_6(a0, a1, a2, a3, a4, res);                       \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:531:9: note: in expansion of macro '__declare_arg_7'
     531 |         __declare_arg_7(a0, a1, a2, a3, a4, a5, res);                   \
         |         ^~~~~~~~~~~~~~~
   include/linux/arm-smccc.h:536:9: note: in expansion of macro '__declare_arg_8'
     536 |         __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);               \
         |         ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__declare_arg_9'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
..


vim +/SMCCC_HVC_INST +591 include/linux/arm-smccc.h

f2d3b2e8759a58 Marc Zyngier    2018-02-06  490  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  491  #define __declare_arg_2(a0, res)					\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  492  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  493  	register unsigned long arg0 asm("r0") = (u32)a0
f2d3b2e8759a58 Marc Zyngier    2018-02-06  494  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  495  #define __declare_arg_3(a0, a1, res)					\
755a8bf5579d22 Marc Zyngier    2018-08-24  496  	typeof(a1) __a1 = a1;						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  497  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  498  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull    2020-09-15  499  	register typeof(a1) arg1 asm("r1") = __a1
f2d3b2e8759a58 Marc Zyngier    2018-02-06  500  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  501  #define __declare_arg_4(a0, a1, a2, res)				\
755a8bf5579d22 Marc Zyngier    2018-08-24  502  	typeof(a1) __a1 = a1;						\
755a8bf5579d22 Marc Zyngier    2018-08-24  503  	typeof(a2) __a2 = a2;						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  504  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  505  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull    2020-09-15  506  	register typeof(a1) arg1 asm("r1") = __a1;			\
0794a974d74dc7 Andrew Scull    2020-09-15  507  	register typeof(a2) arg2 asm("r2") = __a2
f2d3b2e8759a58 Marc Zyngier    2018-02-06  508  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  509  #define __declare_arg_5(a0, a1, a2, a3, res)				\
755a8bf5579d22 Marc Zyngier    2018-08-24  510  	typeof(a1) __a1 = a1;						\
755a8bf5579d22 Marc Zyngier    2018-08-24  511  	typeof(a2) __a2 = a2;						\
755a8bf5579d22 Marc Zyngier    2018-08-24  512  	typeof(a3) __a3 = a3;						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  513  	struct arm_smccc_res   *___res = res;				\
0794a974d74dc7 Andrew Scull    2020-09-15  514  	register unsigned long arg0 asm("r0") = (u32)a0;			\
0794a974d74dc7 Andrew Scull    2020-09-15  515  	register typeof(a1) arg1 asm("r1") = __a1;			\
0794a974d74dc7 Andrew Scull    2020-09-15  516  	register typeof(a2) arg2 asm("r2") = __a2;			\
0794a974d74dc7 Andrew Scull    2020-09-15  517  	register typeof(a3) arg3 asm("r3") = __a3
f2d3b2e8759a58 Marc Zyngier    2018-02-06  518  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  519  #define __declare_arg_6(a0, a1, a2, a3, a4, res)			\
755a8bf5579d22 Marc Zyngier    2018-08-24  520  	typeof(a4) __a4 = a4;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  521  	__declare_arg_5(a0, a1, a2, a3, res);				\
0794a974d74dc7 Andrew Scull    2020-09-15  522  	register typeof(a4) arg4 asm("r4") = __a4
f2d3b2e8759a58 Marc Zyngier    2018-02-06  523  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  524  #define __declare_arg_7(a0, a1, a2, a3, a4, a5, res)			\
755a8bf5579d22 Marc Zyngier    2018-08-24  525  	typeof(a5) __a5 = a5;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  526  	__declare_arg_6(a0, a1, a2, a3, a4, res);			\
0794a974d74dc7 Andrew Scull    2020-09-15  527  	register typeof(a5) arg5 asm("r5") = __a5
f2d3b2e8759a58 Marc Zyngier    2018-02-06  528  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  529  #define __declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res)		\
755a8bf5579d22 Marc Zyngier    2018-08-24  530  	typeof(a6) __a6 = a6;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  531  	__declare_arg_7(a0, a1, a2, a3, a4, a5, res);			\
0794a974d74dc7 Andrew Scull    2020-09-15  532  	register typeof(a6) arg6 asm("r6") = __a6
f2d3b2e8759a58 Marc Zyngier    2018-02-06  533  
90e3e18548e6a8 Andy Shevchenko 2023-07-19  534  #define __declare_arg_9(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
755a8bf5579d22 Marc Zyngier    2018-08-24  535  	typeof(a7) __a7 = a7;						\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  536  	__declare_arg_8(a0, a1, a2, a3, a4, a5, a6, res);		\
0794a974d74dc7 Andrew Scull    2020-09-15  537  	register typeof(a7) arg7 asm("r7") = __a7
f2d3b2e8759a58 Marc Zyngier    2018-02-06  538  
f2d3b2e8759a58 Marc Zyngier    2018-02-06  539  /*
f2d3b2e8759a58 Marc Zyngier    2018-02-06  540   * We have an output list that is not necessarily used, and GCC feels
f2d3b2e8759a58 Marc Zyngier    2018-02-06  541   * entitled to optimise the whole sequence away. "volatile" is what
f2d3b2e8759a58 Marc Zyngier    2018-02-06  542   * makes it stick.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  543   */
f2d3b2e8759a58 Marc Zyngier    2018-02-06  544  #define __arm_smccc_1_1(inst, ...)					\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  545  	do {								\
0794a974d74dc7 Andrew Scull    2020-09-15  546  		register unsigned long r0 asm("r0");			\
0794a974d74dc7 Andrew Scull    2020-09-15  547  		register unsigned long r1 asm("r1");			\
0794a974d74dc7 Andrew Scull    2020-09-15  548  		register unsigned long r2 asm("r2");			\
0794a974d74dc7 Andrew Scull    2020-09-15  549  		register unsigned long r3 asm("r3"); 			\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  550  		CONCATENATE(__declare_arg_,				\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  551  			    COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__);	\
8c462d56487e3a Mark Rutland    2024-11-06  552  		asm volatile(inst "\n" :				\
0794a974d74dc7 Andrew Scull    2020-09-15  553  			     "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)	\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  554  			     : CONCATENATE(__constraint_read_,		\
90e3e18548e6a8 Andy Shevchenko 2023-07-19  555  					   COUNT_ARGS(__VA_ARGS__))	\
8c462d56487e3a Mark Rutland    2024-11-06  556  			     : "memory");				\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  557  		if (___res)						\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  558  			*___res = (typeof(*___res)){r0, r1, r2, r3};	\
f2d3b2e8759a58 Marc Zyngier    2018-02-06  559  	} while (0)
f2d3b2e8759a58 Marc Zyngier    2018-02-06  560  
f2d3b2e8759a58 Marc Zyngier    2018-02-06  561  /*
f2d3b2e8759a58 Marc Zyngier    2018-02-06  562   * arm_smccc_1_1_smc() - make an SMCCC v1.1 compliant SMC call
f2d3b2e8759a58 Marc Zyngier    2018-02-06  563   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  564   * This is a variadic macro taking one to eight source arguments, and
f2d3b2e8759a58 Marc Zyngier    2018-02-06  565   * an optional return structure.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  566   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  567   * @a0-a7: arguments passed in registers 0 to 7
f2d3b2e8759a58 Marc Zyngier    2018-02-06  568   * @res: result values from registers 0 to 3
f2d3b2e8759a58 Marc Zyngier    2018-02-06  569   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  570   * This macro is used to make SMC calls following SMC Calling Convention v1.1.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  571   * The content of the supplied param are copied to registers 0 to 7 prior
f2d3b2e8759a58 Marc Zyngier    2018-02-06  572   * to the SMC instruction. The return values are updated with the content
f2d3b2e8759a58 Marc Zyngier    2018-02-06  573   * from register 0 to 3 on return from the SMC instruction if not NULL.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  574   */
f2d3b2e8759a58 Marc Zyngier    2018-02-06 @575  #define arm_smccc_1_1_smc(...)	__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
f2d3b2e8759a58 Marc Zyngier    2018-02-06  576  
f2d3b2e8759a58 Marc Zyngier    2018-02-06  577  /*
f2d3b2e8759a58 Marc Zyngier    2018-02-06  578   * arm_smccc_1_1_hvc() - make an SMCCC v1.1 compliant HVC call
f2d3b2e8759a58 Marc Zyngier    2018-02-06  579   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  580   * This is a variadic macro taking one to eight source arguments, and
f2d3b2e8759a58 Marc Zyngier    2018-02-06  581   * an optional return structure.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  582   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  583   * @a0-a7: arguments passed in registers 0 to 7
f2d3b2e8759a58 Marc Zyngier    2018-02-06  584   * @res: result values from registers 0 to 3
f2d3b2e8759a58 Marc Zyngier    2018-02-06  585   *
f2d3b2e8759a58 Marc Zyngier    2018-02-06  586   * This macro is used to make HVC calls following SMC Calling Convention v1.1.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  587   * The content of the supplied param are copied to registers 0 to 7 prior
f2d3b2e8759a58 Marc Zyngier    2018-02-06  588   * to the HVC instruction. The return values are updated with the content
f2d3b2e8759a58 Marc Zyngier    2018-02-06  589   * from register 0 to 3 on return from the HVC instruction if not NULL.
f2d3b2e8759a58 Marc Zyngier    2018-02-06  590   */
f2d3b2e8759a58 Marc Zyngier    2018-02-06 @591  #define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
f2d3b2e8759a58 Marc Zyngier    2018-02-06  592  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

