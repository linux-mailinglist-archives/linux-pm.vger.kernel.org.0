Return-Path: <linux-pm+bounces-27603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFADCAC299A
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CDA7BD42E
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEF29A9E1;
	Fri, 23 May 2025 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmiiZmyJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C90293736
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024664; cv=none; b=uMWY1xXF0GTlaBFe7Vjp9VhPaT15IovoSaUGqfifOLS2BMnSynPrYKpUt7fjp47gefDWaKvus3NygkQ5qQAJbDEXGO8wtMsoYQE7Rq7dRu8+5PJ10LykqGZEtz0GjB+2hdBQhA15tp17lHdlqq8hULMq3UP8juMY+lc7hj54iB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024664; c=relaxed/simple;
	bh=8ZTuSF5apumaq7g/s5XkqhGI8zzCSlIDpTYon6EdyKg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nDqhu0couVH5UExv+5sYkxpU58O1mG5ra2dOSBhzAqk6ouxtLAQzzzu0PaOCpRxXjrQCVTRUkQKkH46/d0dNM9nzuBQBT8BrC2kEpwRfo5Ht9Shw4iasccUUQsAiIyJDyd2Yjhfv/JTDEsrnCs0tqKdklk41DeA48CFfv+v14ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmiiZmyJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748024661; x=1779560661;
  h=date:from:to:cc:subject:message-id;
  bh=8ZTuSF5apumaq7g/s5XkqhGI8zzCSlIDpTYon6EdyKg=;
  b=nmiiZmyJimbCVJ/RsrYgZpOTqy1yxVMR2oGg4j7RbDCMAP1gcD5XfTfC
   RoiQZ8pZ3psSGIKAWLX3x80Bbi9zzeB5NvKra31jPboc0vfS/1XOE3ueh
   kH0VvQEDYSPbljv3d67UGuZcnPK33gponfOb/mzwOI3oGL5tlg9yTjMsL
   bKn1OKdilNltPuo3dTPkhzU3T5Ge2DMfjzojS8Vtv8MaAVAshU3FB7xSR
   J9vle6YNF0gPOrhh4gJzACOlEMpAxUpUJa7FBkezrjTSLHuDTZFWrNIiq
   MuFSyNp3/Poct9TCEs+2MZIzog6u0FpaZZAUZaU5dYqa0Jq+N0FidNNPt
   w==;
X-CSE-ConnectionGUID: t8G3yjNUTtOZG4ZakI70zQ==
X-CSE-MsgGUID: RvO1Qe0SSmaa7DhRpzO3zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50143856"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="50143856"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:24:21 -0700
X-CSE-ConnectionGUID: sGtunhgYTri9zsmgA6TccQ==
X-CSE-MsgGUID: eYxqPU7VSESm/fGNaGq4Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="146406810"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 May 2025 11:24:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIX45-000Qe4-38;
	Fri, 23 May 2025 18:24:17 +0000
Date: Sat, 24 May 2025 02:24:15 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 f5d2e0d112228578c19c8527ab0dae0a70e48e57
Message-ID: <202505240205.9paUgB5n-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: f5d2e0d112228578c19c8527ab0dae0a70e48e57  Documentation: amd-pstate:fix minimum performance state label error

elapsed time: 1449m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                   randconfig-001-20250523    gcc-15.1.0
arc                   randconfig-002-20250523    gcc-10.5.0
arm                               allnoconfig    clang-21
arm                            dove_defconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-17
arm                      integrator_defconfig    clang-21
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250523    clang-16
arm                   randconfig-002-20250523    gcc-8.5.0
arm                   randconfig-003-20250523    gcc-7.5.0
arm                   randconfig-004-20250523    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250523    gcc-8.5.0
arm64                 randconfig-002-20250523    clang-16
arm64                 randconfig-003-20250523    clang-21
arm64                 randconfig-004-20250523    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250523    gcc-10.5.0
csky                  randconfig-002-20250523    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250523    clang-21
hexagon               randconfig-002-20250523    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250523    clang-20
i386        buildonly-randconfig-002-20250523    clang-20
i386        buildonly-randconfig-003-20250523    clang-20
i386        buildonly-randconfig-004-20250523    clang-20
i386        buildonly-randconfig-005-20250523    clang-20
i386        buildonly-randconfig-006-20250523    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250523    gcc-15.1.0
loongarch             randconfig-002-20250523    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-18
mips                     decstation_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250523    gcc-10.5.0
nios2                 randconfig-002-20250523    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250523    gcc-9.3.0
parisc                randconfig-002-20250523    gcc-7.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
powerpc               randconfig-001-20250523    clang-21
powerpc               randconfig-002-20250523    clang-21
powerpc               randconfig-003-20250523    clang-20
powerpc64             randconfig-001-20250523    clang-21
powerpc64             randconfig-002-20250523    clang-19
powerpc64             randconfig-003-20250523    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250523    gcc-8.5.0
riscv                 randconfig-002-20250523    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250523    gcc-6.5.0
s390                  randconfig-002-20250523    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250523    gcc-12.4.0
sh                    randconfig-002-20250523    gcc-6.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250523    gcc-10.3.0
sparc                 randconfig-002-20250523    gcc-10.3.0
sparc64               randconfig-001-20250523    gcc-9.3.0
sparc64               randconfig-002-20250523    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250523    gcc-12
um                    randconfig-002-20250523    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250523    gcc-12
x86_64      buildonly-randconfig-002-20250523    clang-20
x86_64      buildonly-randconfig-003-20250523    clang-20
x86_64      buildonly-randconfig-004-20250523    clang-20
x86_64      buildonly-randconfig-005-20250523    clang-20
x86_64      buildonly-randconfig-006-20250523    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250523    gcc-9.3.0
xtensa                randconfig-002-20250523    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

