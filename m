Return-Path: <linux-pm+bounces-14427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EDB97C3E3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 07:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D521C229A2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79E1B7FD;
	Thu, 19 Sep 2024 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rb+UnqBE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F111BC39
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726723524; cv=none; b=Ysw1X+c7aGS4qnQHWSv7G6Uy1Zv7Ja9kCjKRuBoxhSvNr/kpNb5Pcur1G+4FYqAC+fBP2gnvKiUCD2wtu9t1DOfMWkX65zgIrlFlXXKVDjNtFCPMpOPQEWV+HKqSOLr8Nz87ZvoCn+uix9+3k9CveFtMjHfKt+AJQDS91wvPjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726723524; c=relaxed/simple;
	bh=nCW2JTmSVNMZoTicxEoqMRsbRQOdQtJDkAgeM6ZZxS4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kq4OPEdPZ6PEODJExI9BHlOa3m73fHXVHSfetlSBZn60tPZyUTRNEat6F7Ar70Y0UeFAp+TNqVggf6Lv+tj41KQ2KALCzf+Bwc23A7AkmyF9eH5s/97x+DAN9EqAYoAvBKOrKae0fpQHfeQeNyQaxsk/AJNZ1K93sOlZoh+Y+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rb+UnqBE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726723522; x=1758259522;
  h=date:from:to:cc:subject:message-id;
  bh=nCW2JTmSVNMZoTicxEoqMRsbRQOdQtJDkAgeM6ZZxS4=;
  b=Rb+UnqBE60jevx+ol8NOrMZs3bhncU5U0GwuvcYWMK/PcHcXKR5SOQT2
   hOH6zQIgAV4e3vbyfBnzMdHefgrIH3idDeqIjTRSK4hXXfpIINzaPTNgO
   v4AkSYXScnY6TqHFG/ZaS7Q6m9fxP7qy7rFI7GtPpbe/uNVqO8AFThSbH
   H3R1Ct/0Lmzn6o16C07MTlxeTUfHQiuQSX61k+DMvUdp+q1maSOE9piRy
   qzpJxVbzVIlxjbnV7ub6HTzSdAbG9p9CCDDaQLm5eMHW8RTe6igpy7rc8
   3K08LLApQKhy2F8eirznVL/4KSsKF2m5pfd9xQv3KPG4H0l56HPpbyP/P
   w==;
X-CSE-ConnectionGUID: V+ah5/1rTvCLWv7RjM4b9A==
X-CSE-MsgGUID: 66lDNwTJTq+Uo6mV7ko5dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25539729"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="25539729"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 22:25:22 -0700
X-CSE-ConnectionGUID: NzqBwYkrSiSja0ig4ydWTw==
X-CSE-MsgGUID: 5KiKEWvJQEOg3goaDNRkVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="69687857"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 Sep 2024 22:25:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr9fK-000Cxo-1P;
	Thu, 19 Sep 2024 05:25:18 +0000
Date: Thu, 19 Sep 2024 13:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 bc6115435d9412d4c28f73d0912bbdaecbf1b724
Message-ID: <202409191333.vSgnLM6G-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: bc6115435d9412d4c28f73d0912bbdaecbf1b724  cpufreq/amd-pstate: Fix non kerneldoc comment

elapsed time: 2417m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              alldefconfig    gcc-13.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                        nsim_700_defconfig    gcc-13.2.0
arc                   randconfig-001-20240919    gcc-13.2.0
arc                   randconfig-002-20240919    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                       imx_v4_v5_defconfig    clang-16
arm                         lpc18xx_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                   randconfig-001-20240919    clang-20
arm                   randconfig-002-20240919    clang-20
arm                   randconfig-003-20240919    clang-20
arm                   randconfig-004-20240919    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240919    gcc-14.1.0
arm64                 randconfig-002-20240919    clang-15
arm64                 randconfig-003-20240919    clang-20
arm64                 randconfig-004-20240919    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240919    gcc-14.1.0
csky                  randconfig-002-20240919    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20240919    clang-20
hexagon               randconfig-002-20240919    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-002-20240918    gcc-12
i386        buildonly-randconfig-003-20240918    gcc-12
i386        buildonly-randconfig-004-20240918    gcc-12
i386        buildonly-randconfig-005-20240918    clang-18
i386        buildonly-randconfig-006-20240918    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240918    clang-18
i386                  randconfig-002-20240918    clang-18
i386                  randconfig-003-20240918    clang-18
i386                  randconfig-004-20240918    gcc-12
i386                  randconfig-005-20240918    gcc-12
i386                  randconfig-006-20240918    clang-18
i386                  randconfig-011-20240918    gcc-12
i386                  randconfig-012-20240918    clang-18
i386                  randconfig-013-20240918    gcc-12
i386                  randconfig-014-20240918    clang-18
i386                  randconfig-015-20240918    clang-18
i386                  randconfig-016-20240918    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240919    gcc-14.1.0
loongarch             randconfig-002-20240919    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  maltasmvp_eva_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240919    gcc-14.1.0
nios2                 randconfig-002-20240919    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                generic-32bit_defconfig    gcc-14.1.0
parisc                randconfig-001-20240919    gcc-14.1.0
parisc                randconfig-002-20240919    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240919    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                            migor_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

