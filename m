Return-Path: <linux-pm+bounces-12380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E450955565
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 06:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF483B222CD
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650355769;
	Sat, 17 Aug 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jroJ2YHM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFF10A12
	for <linux-pm@vger.kernel.org>; Sat, 17 Aug 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723869630; cv=none; b=aWKXTuheOEEmj3RfyrRPN43D0kbTgVfPyDeQrAoJaqPJoSxinJGv4661om+qXgDt29M94+fXmHQzGtsbTGrP8e/eNBHa8q8QANMDKMQpegu9P+JjEYTXSdNp4TGNSvEHGXkLWKNcuJmwyCaj8duhiKCaZrJ2NX1bBA/kWzOaEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723869630; c=relaxed/simple;
	bh=T4sdMjHFLXcVto1u9rXziIraB4+JKTC2Ngo2N8IV7eE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WooWoyn7sSjgCFM5d2xwNv2vnZi+/mvv+++Q1riXCqQvSnJC63d5qBxPwk99hs7oCi67f4Vkl0lK/tFiYNo/qaXvpGq7FhdiSSUuBklkIKE/Z35Fg8X1eOw1XIpxXwKdfbsupjmCcjuAOiIk7CRaAd6kBLHOBZ28ZXswfwmlaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jroJ2YHM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723869628; x=1755405628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T4sdMjHFLXcVto1u9rXziIraB4+JKTC2Ngo2N8IV7eE=;
  b=jroJ2YHM4lKWCZvVg2QKBA55JN8rX/FRlTWtnWZ1aILyAFNc/t6O1KoP
   j9TkDGsm0Xnr5yOlVXiGBH3eu79WaDJXolB83MiwgWBeJYCZ4usYn37Qg
   0Ju052VM+pTxH7bUID4RYItRMbyIhz4XqTuRbebhMQpudAZxyeqBMXcPa
   nSJUBNjg/zNIfifaEqMZ86ce5a9d96me0gsMcDTlaTrcRntVyldf4KHs9
   Zr4JEe3GIRw+NDWNRvqkaxAr+R4n3iF8f/02t34/1+svEbLUn5hEdTtWZ
   psxSRtx9DRl6RWzLhrPa1DYwBFSXWJwUx3O8CwE4fLb2dkG+22ApMpqHV
   w==;
X-CSE-ConnectionGUID: BGnp4phDQ0mA9dP1J5Mc+w==
X-CSE-MsgGUID: /Eb9fZ8XQrOu6BNC6VwDyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21801186"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="21801186"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 21:40:28 -0700
X-CSE-ConnectionGUID: XmldVZ8cSKKMlW9TWSdRow==
X-CSE-MsgGUID: kUX4NZihQ3eMEGefho97+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59496643"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Aug 2024 21:40:27 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfBEm-0007Bm-2K;
	Sat, 17 Aug 2024 04:40:24 +0000
Date: Sat, 17 Aug 2024 12:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/runtime-pm-screen-on-off 2/5]
 include/linux/suspend.h:304:70: error: expected ';' before '}' token
Message-ID: <202408171204.tvI0NKc9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/runtime-pm-screen-on-off
head:   09020cb8f4063731baa98c5f0fd9f1785597c989
commit: b932cdf52b629330f537863edcd0075b23facf63 [2/5] acpi/x86: s2idle: add support for screen off and screen on callbacks
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240817/202408171204.tvI0NKc9-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171204.tvI0NKc9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171204.tvI0NKc9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:13:
   include/linux/suspend.h: In function 'platform_suspend_screen_off':
>> include/linux/suspend.h:304:70: error: expected ';' before '}' token
     304 | static inline int platform_suspend_screen_off(void) { return -ENODEV };
         |                                                                      ^
   include/linux/suspend.h: In function 'platform_suspend_screen_on':
   include/linux/suspend.h:305:69: error: expected ';' before '}' token
     305 | static inline int platform_suspend_screen_on(void) { return -ENODEV };
         |                                                                     ^
   make[3]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1193: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +304 include/linux/suspend.h

   296	
   297	static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
   298	static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
   299	static inline bool sync_on_suspend_enabled(void) { return true; }
   300	static inline bool idle_should_enter_s2idle(void) { return false; }
   301	static inline void __init pm_states_init(void) {}
   302	static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {}
   303	static inline void s2idle_wake(void) {}
 > 304	static inline int platform_suspend_screen_off(void) { return -ENODEV };
   305	static inline int platform_suspend_screen_on(void) { return -ENODEV };
   306	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

