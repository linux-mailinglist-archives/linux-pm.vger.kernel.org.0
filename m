Return-Path: <linux-pm+bounces-15330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0A994EF1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E8FB24D8C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3D1DEFC6;
	Tue,  8 Oct 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfLUy8VF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160631DEFEA
	for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393340; cv=none; b=kpn9MDckrQRgaMPuqtSBw1skh5SC4Ycf8JGzpUrr0kQfiSz9HTNb63Ql9iMmvqxCXwYY4F/ys1QC9SeU09YE9Xkv1mymLYvfheVits32sjJKTk2e0DS/6tCNLrkcKu73u5+xz8vyPOdqBVsxkPREvtArIU14pihTK2NJS1KkXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393340; c=relaxed/simple;
	bh=rbn5ZjU1GFfLAGzA7y1KsOiIKmAUwNkN+x8uvShbUKI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MUaan+x1L3WA7pciXqh8DAx+EBZsD78k7CIi1wgUk7ZOlMngriLh1mZ5maKg/L/QCciS13k6nG5kqZDTsbRqZYZW11uVoUU2SxqfU3C/H+BsDXA7Xv80WcDb1zksiaHx0p83MEDWadDKExfeDCKsutQPTyNVDPfS07bHziCuo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfLUy8VF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728393338; x=1759929338;
  h=date:from:to:cc:subject:message-id;
  bh=rbn5ZjU1GFfLAGzA7y1KsOiIKmAUwNkN+x8uvShbUKI=;
  b=QfLUy8VFrqnQyZJAp5aIAWmPrjcro9Q4GBB/JrPZ+HZIVidMwBpy0553
   xIDg5t/MjWH8pNQTHkkZbxO8u1gxkIE9LewVtZMTS8L870TfwHFPn+29y
   ap+DU2iXnV1edE35p0Wa39IAIg8/JkaRvJ1diRxt/6SjEuBoGT1sPyfp3
   b+eVSZTPrnSFeH+jucvbyS7c96ahkKDbuZJ3kGwirtmQrrGOwqme5Herb
   l5iLKfvRQRjnOgWLnfCkZid4dBLtJ/U6HIswFDPic4glEANINkyDtLKaO
   Cv/S6hCJNtYmOH/vD8ifJgJdhgUZhZ446kCdKwQVuEcZ3egeW4vzbj0o1
   w==;
X-CSE-ConnectionGUID: 0NkcVmBbRvKIC5iT4Bd43Q==
X-CSE-MsgGUID: I2FJ3/GBSEGZI68Cp1Uqmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27678422"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27678422"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 06:15:37 -0700
X-CSE-ConnectionGUID: 7elbrzSNQa+jxtadQx7PUQ==
X-CSE-MsgGUID: CgfTBVyJSg+sscwHIK9GVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76091319"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Oct 2024 06:15:37 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syA3o-0007Zi-2t;
	Tue, 08 Oct 2024 13:15:32 +0000
Date: Tue, 08 Oct 2024 21:15:01 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 c10e50a469b5ec91eabf653526a22bdce03a9bca
Message-ID: <202410082150.S5Bm32Ut-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: c10e50a469b5ec91eabf653526a22bdce03a9bca  cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory systems

elapsed time: 1196m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.2.0
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241008    gcc-14.1.0
arc                   randconfig-002-20241008    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g4_defconfig    gcc-13.2.0
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-13.2.0
arm                          ixp4xx_defconfig    gcc-13.2.0
arm                         orion5x_defconfig    gcc-13.2.0
arm                   randconfig-001-20241008    gcc-14.1.0
arm                   randconfig-002-20241008    gcc-14.1.0
arm                   randconfig-003-20241008    gcc-14.1.0
arm                   randconfig-004-20241008    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241008    gcc-14.1.0
arm64                 randconfig-002-20241008    gcc-14.1.0
arm64                 randconfig-003-20241008    gcc-14.1.0
arm64                 randconfig-004-20241008    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241008    gcc-14.1.0
csky                  randconfig-002-20241008    gcc-14.1.0
hexagon                          alldefconfig    gcc-13.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241008    gcc-14.1.0
hexagon               randconfig-002-20241008    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241008    clang-18
i386        buildonly-randconfig-002-20241008    clang-18
i386        buildonly-randconfig-002-20241008    gcc-12
i386        buildonly-randconfig-003-20241008    clang-18
i386        buildonly-randconfig-003-20241008    gcc-12
i386        buildonly-randconfig-004-20241008    clang-18
i386        buildonly-randconfig-004-20241008    gcc-12
i386        buildonly-randconfig-005-20241008    clang-18
i386        buildonly-randconfig-006-20241008    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241008    clang-18
i386                  randconfig-002-20241008    clang-18
i386                  randconfig-002-20241008    gcc-12
i386                  randconfig-003-20241008    clang-18
i386                  randconfig-003-20241008    gcc-12
i386                  randconfig-004-20241008    clang-18
i386                  randconfig-005-20241008    clang-18
i386                  randconfig-005-20241008    gcc-12
i386                  randconfig-006-20241008    clang-18
i386                  randconfig-006-20241008    gcc-12
i386                  randconfig-011-20241008    clang-18
i386                  randconfig-012-20241008    clang-18
i386                  randconfig-013-20241008    clang-18
i386                  randconfig-013-20241008    gcc-12
i386                  randconfig-014-20241008    clang-18
i386                  randconfig-014-20241008    gcc-12
i386                  randconfig-015-20241008    clang-18
i386                  randconfig-016-20241008    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241008    gcc-14.1.0
loongarch             randconfig-002-20241008    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    gcc-13.2.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                malta_qemu_32r6_defconfig    gcc-13.2.0
mips                    maltaup_xpa_defconfig    gcc-13.2.0
mips                           xway_defconfig    gcc-13.2.0
nios2                         10m50_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241008    gcc-14.1.0
nios2                 randconfig-002-20241008    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-13.2.0
parisc                randconfig-001-20241008    gcc-14.1.0
parisc                randconfig-002-20241008    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      cm5200_defconfig    gcc-13.2.0
powerpc                  iss476-smp_defconfig    gcc-13.2.0
powerpc                   lite5200b_defconfig    gcc-13.2.0
powerpc                     mpc512x_defconfig    gcc-13.2.0
powerpc                      pasemi_defconfig    gcc-13.2.0
powerpc                         ps3_defconfig    gcc-13.2.0
powerpc               randconfig-001-20241008    gcc-14.1.0
powerpc               randconfig-002-20241008    gcc-14.1.0
powerpc               randconfig-003-20241008    gcc-14.1.0
powerpc                      tqm8xx_defconfig    gcc-13.2.0
powerpc64             randconfig-001-20241008    gcc-14.1.0
powerpc64             randconfig-002-20241008    gcc-14.1.0
powerpc64             randconfig-003-20241008    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241008    gcc-14.1.0
riscv                 randconfig-002-20241008    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241008    gcc-14.1.0
s390                  randconfig-002-20241008    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         ap325rxa_defconfig    gcc-13.2.0
sh                         apsh4a3a_defconfig    gcc-13.2.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    gcc-13.2.0
sh                          r7785rp_defconfig    gcc-13.2.0
sh                    randconfig-001-20241008    gcc-14.1.0
sh                    randconfig-002-20241008    gcc-14.1.0
sh                          rsk7203_defconfig    gcc-13.2.0
sh                           se7722_defconfig    gcc-13.2.0
sh                           se7780_defconfig    gcc-13.2.0
sh                              ul2_defconfig    gcc-13.2.0
sh                          urquell_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-13.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241008    gcc-14.1.0
sparc64               randconfig-002-20241008    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241008    gcc-14.1.0
um                    randconfig-002-20241008    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    gcc-13.2.0
xtensa                randconfig-001-20241008    gcc-14.1.0
xtensa                randconfig-002-20241008    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

