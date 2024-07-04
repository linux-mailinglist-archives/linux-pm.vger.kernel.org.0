Return-Path: <linux-pm+bounces-10640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3B927EEB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 00:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E67A1F224F9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C070142E86;
	Thu,  4 Jul 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVr6VLg2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB577344C
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720130913; cv=none; b=owsDTxPkWpD3MS7MZazfMYoG5nWFjW293y3PKXFWRBEisbWXGBvWaIo6/GGnp0b9CauynSaXFrErgqnlWTH3Wl7NVz+pcOcf0TldJbwmXnvSfay5F+K6uK3aM/YQUdHtV7vTgAmZOwih76ADjt48fcEBdHfmNtez6wbjHngA1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720130913; c=relaxed/simple;
	bh=I/spWcT0ddJymuNpaxXWsxmb7P5DOH54YSRIk6B7uV0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CYSb4aXva0NDjMvwhi8ySf2QMoQeODZeBnMcO04fVYwB99SDdqHo+yTF8fdOGPwb9tMMqz7KQCFW1qfwxpdQ7q3bHoPiuw29ar7+TX3ADh/jp0o2Sz83jr3pBH2kVzROuQWuN+WzYEj/sMaNf5ddMupDtJHHKa7Uf0kRAb8gsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVr6VLg2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720130911; x=1751666911;
  h=date:from:to:cc:subject:message-id;
  bh=I/spWcT0ddJymuNpaxXWsxmb7P5DOH54YSRIk6B7uV0=;
  b=FVr6VLg2t+dc1NVF61DJ3Wq8smM4AdaE2YSdemC+mozdkjWDfV7/rvkx
   mQMIZD21jy1xifU2r8nyhAO22lm+rMvaQW3XnWfRQzlMxxfIR758KT0Hb
   vtNWwyYgiCKw29Lk3E6gI033NVfQgBVNL9ozD0x88YBWHoilIfSuH/nv1
   S5IwCXUQEOADfRBLDNcoeBD6GI1QWygzkXfZ4cnrf4OYkPRO+ExjdGxx4
   KtApHS1yFCeAQIhGeYuSEGsljBOu248+uJmzqYXRGq4e+O7BUvt2NG9Ae
   lTtxq6ko38hh515t4jpJIyNdrbqs9G29wr+UDDF0OvC1+s4C1YMkwn4TH
   A==;
X-CSE-ConnectionGUID: hWrTyYX1Qm+HD5vOE3luiw==
X-CSE-MsgGUID: +68UOeR3Sk2NtUsTLC4rBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21184114"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21184114"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 15:08:30 -0700
X-CSE-ConnectionGUID: yFO26G33QGy3nFCfGwl1vg==
X-CSE-MsgGUID: 4D7DQO9ERsupmfQdyeVgYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47349055"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Jul 2024 15:08:30 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPUct-000RVZ-1f;
	Thu, 04 Jul 2024 22:08:27 +0000
Date: Fri, 05 Jul 2024 06:07:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 2e65811232f8b105e7988ce3ab8c8a6c931b45f3
Message-ID: <202407050627.qSPUhQZL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 2e65811232f8b105e7988ce3ab8c8a6c931b45f3  cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems

elapsed time: 1448m

configs tested: 122
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240704   gcc-13.2.0
arc                   randconfig-002-20240704   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                          pxa168_defconfig   clang-19
arm                   randconfig-001-20240704   gcc-13.2.0
arm                   randconfig-002-20240704   gcc-13.2.0
arm                   randconfig-003-20240704   clang-19
arm                   randconfig-004-20240704   gcc-13.2.0
arm                           sama7_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240704   clang-19
arm64                 randconfig-002-20240704   gcc-13.2.0
arm64                 randconfig-003-20240704   clang-19
arm64                 randconfig-004-20240704   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240704   gcc-13.2.0
csky                  randconfig-002-20240704   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240704   clang-19
hexagon               randconfig-002-20240704   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240704   clang-18
i386         buildonly-randconfig-002-20240704   gcc-13
i386         buildonly-randconfig-003-20240704   gcc-13
i386         buildonly-randconfig-004-20240704   gcc-12
i386         buildonly-randconfig-005-20240704   gcc-12
i386         buildonly-randconfig-006-20240704   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240704   clang-18
i386                  randconfig-002-20240704   gcc-13
i386                  randconfig-003-20240704   clang-18
i386                  randconfig-004-20240704   gcc-13
i386                  randconfig-005-20240704   clang-18
i386                  randconfig-006-20240704   gcc-12
i386                  randconfig-011-20240704   gcc-13
i386                  randconfig-012-20240704   clang-18
i386                  randconfig-013-20240704   clang-18
i386                  randconfig-014-20240704   clang-18
i386                  randconfig-015-20240704   clang-18
i386                  randconfig-016-20240704   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240704   gcc-13.2.0
loongarch             randconfig-002-20240704   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                       m5208evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240704   gcc-13.2.0
nios2                 randconfig-002-20240704   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240704   gcc-13.2.0
parisc                randconfig-002-20240704   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                   bluestone_defconfig   clang-19
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   clang-19
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                      walnut_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                    nommu_virt_defconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240704   clang-18
x86_64       buildonly-randconfig-002-20240704   gcc-12
x86_64       buildonly-randconfig-003-20240704   clang-18
x86_64       buildonly-randconfig-004-20240704   gcc-13
x86_64       buildonly-randconfig-005-20240704   gcc-12
x86_64       buildonly-randconfig-006-20240704   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240704   clang-18
x86_64                randconfig-002-20240704   gcc-11
x86_64                randconfig-003-20240704   clang-18
x86_64                randconfig-004-20240704   clang-18
x86_64                randconfig-005-20240704   gcc-13
x86_64                randconfig-006-20240704   clang-18
x86_64                randconfig-011-20240704   gcc-13
x86_64                randconfig-012-20240704   gcc-10
x86_64                randconfig-013-20240704   gcc-13
x86_64                randconfig-014-20240704   clang-18
x86_64                randconfig-015-20240704   clang-18
x86_64                randconfig-016-20240704   gcc-13
x86_64                randconfig-071-20240704   gcc-12
x86_64                randconfig-072-20240704   gcc-13
x86_64                randconfig-073-20240704   clang-18
x86_64                randconfig-074-20240704   gcc-12
x86_64                randconfig-075-20240704   clang-18
x86_64                randconfig-076-20240704   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

