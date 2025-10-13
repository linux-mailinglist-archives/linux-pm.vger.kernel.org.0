Return-Path: <linux-pm+bounces-36003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C6BD6118
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7AB04F18A7
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B141B3064B7;
	Mon, 13 Oct 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwn4vdj8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB52DC794
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387023; cv=none; b=L0kP+tXnBC9V0xkJK2cGUgpoCJwReGEWCPw0auVmTgqbHo7VwVLo0q54Y1kZ0/vP4bFKIc8Rl4ebQfDOWmNABEEZfVoliSTaEJCEqxkNvKzDxDFAJNoIicUuDthU80PLUduTTpVZgL5cDn9yLtk0Y7kd4QutVrRY+Cw8rOn7bt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387023; c=relaxed/simple;
	bh=wHuIs3XbNL2j0RXB2n6MDsv7Pa/zCoCz6UfqvYnbrIA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uQvu4zQ6p03MmbQAxTsBPFO30wQr07SLk2GYSuubfE9zpc+TykTOGQSJMryz5JH6ccJvrVM7nICHJhWzXDedVkQ6Si3TsR0Ek9F4c1jbPkwmK86XhhECuQeZxWNHplmMAxaB1CftAT06cM2zd4SoAqgO3pk/5Jxb3VxMaLhfrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwn4vdj8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760387022; x=1791923022;
  h=date:from:to:cc:subject:message-id;
  bh=wHuIs3XbNL2j0RXB2n6MDsv7Pa/zCoCz6UfqvYnbrIA=;
  b=dwn4vdj8SRDdicwQBILJDtKkDiljWy9xmJXzbBOJFSd5cApeX18tnYSs
   TYhDF1I5qD3mtNz52cdCLEgI7EiHPgzjxTPMtTMv/h/NvkLvCXQqScBYn
   n91TcuR3kTDh7XkrII6IiqccOdss11Q3mGCWBLHxzqVOsC/o0PckMs9nB
   y+ISQ9OEs0v5bR0P4+90I1M16fKEK/VsculBUhUcPjYPtkEpimBQDCDVT
   ywKDhn0u0q1eGjPGdMEwo9XsBWQWYs9fi3JgUO8WQrdjujCcAmex1hdJe
   rn28+/ktQmY2TyNJ4ItpIS3yvcl1zOe6XDaNZ5LBGZJdtZQYMcoe2WA3Z
   g==;
X-CSE-ConnectionGUID: YU7/BHNFSp6S7tk207iIVg==
X-CSE-MsgGUID: yjR5tZ1KRcG9lMM5t8vz5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="72801485"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="72801485"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 13:23:41 -0700
X-CSE-ConnectionGUID: OpW8yQAXRLibvWlBUsbCYQ==
X-CSE-MsgGUID: O/flBjnaQC6oO9bVYcw4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="185709856"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 13 Oct 2025 13:23:40 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8P4w-00021j-1x;
	Mon, 13 Oct 2025 20:23:35 +0000
Date: Tue, 14 Oct 2025 04:23:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 46fd2a111aa531f08805431d22312b37e43926d5
Message-ID: <202510140421.xHcVvyKX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: 46fd2a111aa531f08805431d22312b37e43926d5  cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate

elapsed time: 937m

configs tested: 123
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251013    gcc-8.5.0
arc                   randconfig-002-20251013    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          ep93xx_defconfig    clang-22
arm                       imx_v6_v7_defconfig    clang-16
arm                   randconfig-001-20251013    gcc-10.5.0
arm                   randconfig-002-20251013    clang-22
arm                   randconfig-003-20251013    gcc-12.5.0
arm                   randconfig-004-20251013    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251013    clang-19
arm64                 randconfig-002-20251013    gcc-8.5.0
arm64                 randconfig-003-20251013    clang-22
arm64                 randconfig-004-20251013    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251013    gcc-15.1.0
csky                  randconfig-002-20251013    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251013    clang-22
hexagon               randconfig-002-20251013    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251013    gcc-13
i386        buildonly-randconfig-002-20251013    clang-20
i386        buildonly-randconfig-003-20251013    gcc-14
i386        buildonly-randconfig-004-20251013    clang-20
i386        buildonly-randconfig-005-20251013    gcc-14
i386        buildonly-randconfig-006-20251013    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20251013    clang-18
loongarch             randconfig-002-20251013    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251013    gcc-8.5.0
nios2                 randconfig-002-20251013    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251013    gcc-12.5.0
parisc                randconfig-002-20251013    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251013    clang-22
powerpc               randconfig-002-20251013    clang-18
powerpc               randconfig-003-20251013    clang-22
powerpc64             randconfig-001-20251013    gcc-10.5.0
powerpc64             randconfig-002-20251013    gcc-15.1.0
powerpc64             randconfig-003-20251013    clang-20
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251013    clang-22
riscv                 randconfig-002-20251013    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251013    gcc-8.5.0
s390                  randconfig-002-20251013    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251013    gcc-10.5.0
sh                    randconfig-002-20251013    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251013    gcc-8.5.0
sparc                 randconfig-002-20251013    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251013    clang-20
sparc64               randconfig-002-20251013    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251013    gcc-14
um                    randconfig-002-20251013    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251013    gcc-13
x86_64      buildonly-randconfig-002-20251013    clang-20
x86_64      buildonly-randconfig-003-20251013    clang-20
x86_64      buildonly-randconfig-004-20251013    gcc-14
x86_64      buildonly-randconfig-005-20251013    clang-20
x86_64      buildonly-randconfig-006-20251013    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251013    gcc-11.5.0
xtensa                randconfig-002-20251013    gcc-11.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

