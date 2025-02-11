Return-Path: <linux-pm+bounces-21841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A33A30EFF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9290C161D3C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762CB1F3FD0;
	Tue, 11 Feb 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8Wjd4b2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDD1DFE11
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286086; cv=none; b=XR/vPjpDyq/Nr6cHONWFaJFgiyNmyZUDpXOXTMnZmZ31EKZ5aB5zwoW3bvxIV9203rtNui11B1ObdWdFnrqvCdw2ltdxDedjyN4JsW5qfLaNOJdDPKV3kfZl5yV1rfujJgd6Bi0q/myghwNdFRUYnCf/hWrzxV/Bm0rgMOvW2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286086; c=relaxed/simple;
	bh=bSAcWx02D6Yx14A0cP9DCWk8s2D27EovLxYV0tyvJPw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Oe+uG3V//FqR4CMRSPSF/iEm90HZFJ/kxbxBCeivBaUOJ0Uc36DaetjdfMuB4pc2UtkSAXtxwkrHamoyGbaGUSTR2lwT2tPjalEmA9VaEbTs12eRPP9Zqidl6RNu95h6cdhm2IwsVUMuf4oeutJxOjNJ1eJJHNAn4ix8NxHCvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8Wjd4b2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739286084; x=1770822084;
  h=date:from:to:cc:subject:message-id;
  bh=bSAcWx02D6Yx14A0cP9DCWk8s2D27EovLxYV0tyvJPw=;
  b=E8Wjd4b2oKz6Et0l2wniVCMoTo4QHWRwgnb6DOoWYwc/44SAzND7JjZV
   EBdU/m4BYuR2PsCI/vmlyAx5rBpz1kjr/XECgBCAwqFVNxT/c/MkAWiJq
   Y09ZBmEsFIvlakW0rsWriyt6WOx7o3b1M/Cu7HqaGoGCIftD1S6T3O0SW
   xjCXc4Jn1Rhf6LeIhm1yFXbFs94IbmWFlpqLXepGiTFkuX8UxG9ByFKPb
   lxOLq+Szw5Z6KFtEUQ3WyO+mR3Jvu0tJxYkD9tZCmwcKCgkmx7rYoi34B
   hNvRTOGRdI58bIkHBv7kx5mUkeBTSmEcnVafJ5kXric6R0Gfvd4E0Op9i
   Q==;
X-CSE-ConnectionGUID: MwuoaxkxQeymfVFGo/tjIg==
X-CSE-MsgGUID: GX8J+CIzRWCwH2HhhhRksQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50544304"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50544304"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:01:24 -0800
X-CSE-ConnectionGUID: s2OFc7xhRmylCq6TIOWpVg==
X-CSE-MsgGUID: X0iFD+1cSRO1mSkutXgpSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="113175530"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Feb 2025 07:01:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thrlI-0014KN-2b;
	Tue, 11 Feb 2025 15:01:20 +0000
Date: Tue, 11 Feb 2025 23:01:07 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 6cd008362e139d5b49aebb9c42bde05fbc6945ee
Message-ID: <202502112300.Z2CXILog-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 6cd008362e139d5b49aebb9c42bde05fbc6945ee  cpufreq/amd-pstate: Remove the unncecessary driver_lock in amd_pstate_update_limits

elapsed time: 1003m

configs tested: 214
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                   randconfig-001-20250211    clang-19
arc                   randconfig-001-20250211    gcc-13.2.0
arc                   randconfig-002-20250211    clang-19
arc                   randconfig-002-20250211    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                   randconfig-001-20250211    clang-19
arm                   randconfig-001-20250211    gcc-14.2.0
arm                   randconfig-002-20250211    clang-19
arm                   randconfig-002-20250211    clang-21
arm                   randconfig-003-20250211    clang-19
arm                   randconfig-003-20250211    gcc-14.2.0
arm                   randconfig-004-20250211    clang-19
arm                   randconfig-004-20250211    gcc-14.2.0
arm                        realview_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250211    clang-17
arm64                 randconfig-001-20250211    clang-19
arm64                 randconfig-002-20250211    clang-19
arm64                 randconfig-003-20250211    clang-19
arm64                 randconfig-003-20250211    gcc-14.2.0
arm64                 randconfig-004-20250211    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250211    clang-18
csky                  randconfig-001-20250211    gcc-14.2.0
csky                  randconfig-002-20250211    clang-18
csky                  randconfig-002-20250211    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250211    clang-18
hexagon               randconfig-002-20250211    clang-18
hexagon               randconfig-002-20250211    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250211    gcc-12
i386        buildonly-randconfig-002-20250211    gcc-12
i386        buildonly-randconfig-003-20250211    gcc-12
i386        buildonly-randconfig-004-20250211    gcc-12
i386        buildonly-randconfig-005-20250211    gcc-12
i386        buildonly-randconfig-006-20250211    clang-19
i386        buildonly-randconfig-006-20250211    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250211    gcc-12
i386                  randconfig-002-20250211    gcc-12
i386                  randconfig-003-20250211    gcc-12
i386                  randconfig-004-20250211    gcc-12
i386                  randconfig-005-20250211    gcc-12
i386                  randconfig-006-20250211    gcc-12
i386                  randconfig-007-20250211    gcc-12
i386                  randconfig-011-20250211    gcc-11
i386                  randconfig-012-20250211    gcc-11
i386                  randconfig-013-20250211    gcc-11
i386                  randconfig-014-20250211    gcc-11
i386                  randconfig-015-20250211    gcc-11
i386                  randconfig-016-20250211    gcc-11
i386                  randconfig-017-20250211    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250211    clang-18
loongarch             randconfig-001-20250211    gcc-14.2.0
loongarch             randconfig-002-20250211    clang-18
loongarch             randconfig-002-20250211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250211    clang-18
nios2                 randconfig-001-20250211    gcc-14.2.0
nios2                 randconfig-002-20250211    clang-18
nios2                 randconfig-002-20250211    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250211    clang-18
parisc                randconfig-001-20250211    gcc-14.2.0
parisc                randconfig-002-20250211    clang-18
parisc                randconfig-002-20250211    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250211    clang-15
powerpc               randconfig-001-20250211    clang-18
powerpc               randconfig-002-20250211    clang-18
powerpc               randconfig-002-20250211    clang-21
powerpc               randconfig-003-20250211    clang-18
powerpc               randconfig-003-20250211    clang-19
powerpc64             randconfig-001-20250211    clang-18
powerpc64             randconfig-001-20250211    clang-21
powerpc64             randconfig-002-20250211    clang-18
powerpc64             randconfig-002-20250211    gcc-14.2.0
powerpc64             randconfig-003-20250211    clang-17
powerpc64             randconfig-003-20250211    clang-18
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250211    clang-15
riscv                 randconfig-001-20250211    gcc-14.2.0
riscv                 randconfig-002-20250211    clang-15
riscv                 randconfig-002-20250211    clang-19
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250211    clang-15
s390                  randconfig-001-20250211    clang-21
s390                  randconfig-002-20250211    clang-15
s390                  randconfig-002-20250211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250211    clang-15
sh                    randconfig-001-20250211    gcc-14.2.0
sh                    randconfig-002-20250211    clang-15
sh                    randconfig-002-20250211    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250211    clang-15
sparc                 randconfig-001-20250211    gcc-14.2.0
sparc                 randconfig-002-20250211    clang-15
sparc                 randconfig-002-20250211    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250211    clang-15
sparc64               randconfig-001-20250211    gcc-14.2.0
sparc64               randconfig-002-20250211    clang-15
sparc64               randconfig-002-20250211    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250211    clang-15
um                    randconfig-001-20250211    clang-17
um                    randconfig-002-20250211    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250211    clang-19
x86_64      buildonly-randconfig-001-20250211    gcc-12
x86_64      buildonly-randconfig-002-20250211    gcc-12
x86_64      buildonly-randconfig-003-20250211    clang-19
x86_64      buildonly-randconfig-003-20250211    gcc-12
x86_64      buildonly-randconfig-004-20250211    gcc-11
x86_64      buildonly-randconfig-004-20250211    gcc-12
x86_64      buildonly-randconfig-005-20250211    clang-19
x86_64      buildonly-randconfig-005-20250211    gcc-12
x86_64      buildonly-randconfig-006-20250211    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250211    gcc-11
x86_64                randconfig-002-20250211    gcc-11
x86_64                randconfig-003-20250211    gcc-11
x86_64                randconfig-004-20250211    gcc-11
x86_64                randconfig-005-20250211    gcc-11
x86_64                randconfig-006-20250211    gcc-11
x86_64                randconfig-007-20250211    gcc-11
x86_64                randconfig-008-20250211    gcc-11
x86_64                randconfig-071-20250211    clang-19
x86_64                randconfig-072-20250211    clang-19
x86_64                randconfig-073-20250211    clang-19
x86_64                randconfig-074-20250211    clang-19
x86_64                randconfig-075-20250211    clang-19
x86_64                randconfig-076-20250211    clang-19
x86_64                randconfig-077-20250211    clang-19
x86_64                randconfig-078-20250211    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250211    clang-15
xtensa                randconfig-001-20250211    gcc-14.2.0
xtensa                randconfig-002-20250211    clang-15
xtensa                randconfig-002-20250211    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

