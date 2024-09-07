Return-Path: <linux-pm+bounces-13823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678897016B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAD1C215D9
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3CF14F9E2;
	Sat,  7 Sep 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StczZV5/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DFA55
	for <linux-pm@vger.kernel.org>; Sat,  7 Sep 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725702377; cv=none; b=tWDVErxDrKjFcSqRCIcAEL9Jgydr5Bi++UBkCOtXISX0yEQmyDg2avASadhUmeyJWw1Y0UrVQHVOccluj7uhZ0B9VhkG+bUPfVQlQxssyht+bRvSav38yY1Afi4xJJM7OFnLMh1xNjVT9yjDZ49R6R4/AM7xgP5S+yFswVr3uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725702377; c=relaxed/simple;
	bh=lP3FqiSVEVcjA9fTyLWbP+R04kpm2m0PXFj/kKNi9C4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P5GhgtJK/lo4HLHfFM6sFd5UFWqEYbTKJuUqb7rwQryweCm1hSQ7zYluhgOPwO5+olrNxf7S/m5uw8J/wye8T6m79CC/qDpiLzpku1r5wW3kRJbMicmXVM3RfNytfzSjT9hhSFR3CM9lii2DPkq2YvQp2i4urAqgKLb1lvgKOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StczZV5/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725702375; x=1757238375;
  h=date:from:to:cc:subject:message-id;
  bh=lP3FqiSVEVcjA9fTyLWbP+R04kpm2m0PXFj/kKNi9C4=;
  b=StczZV5/TnJnUttOaegUyjkGmdOKLpPx6yjlgpaExjyGQagy8NHrLyfL
   K8kHJuI3r0tPW9VDhkrrYslqmBVJu1LL6Uha60qdgPEn/wWVU6nTdTLbm
   MGwLirY8WNKpy87a4sMmtkuIYoDQOM5tJMoUDWS2ieCZQ5SRHWkUY14j0
   ObmYx/88SW1SotSU3K9bNUGiNTbSFp5NY2pqEUxTBWTPGonXvSLAb1a84
   Gg0VwD7a6MPxxHyPNNBz0IJRlCpTDJ+qOEEzifyWPuPvUoSzDowY60diV
   UFXrs91ZgkT/AfaPl4L2V6XnJWpyekjZe57QwZLaRphlz3wQqEUNHEEWt
   A==;
X-CSE-ConnectionGUID: /B6FYEM8SSmypJ3CmJyHyA==
X-CSE-MsgGUID: wiqFDJbWTd+nlXz5zCbddA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35032802"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="35032802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 02:46:14 -0700
X-CSE-ConnectionGUID: WAJ61SQ3SeK16T77n3HDlQ==
X-CSE-MsgGUID: VaZ8CJzLSjWOel5JlSRazA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="66511525"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Sep 2024 02:46:14 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sms1D-000COV-27;
	Sat, 07 Sep 2024 09:46:11 +0000
Date: Sat, 07 Sep 2024 17:45:58 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 fb06862f2a835584e8556e7d42d32f31aa7b19c5
Message-ID: <202409071756.BABETbrO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: fb06862f2a835584e8556e7d42d32f31aa7b19c5  amd-pstate: Add missing documentation for `amd_pstate_prefcore_ranking`

elapsed time: 2404m

configs tested: 104
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240907   gcc-13.2.0
arc                   randconfig-002-20240907   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                   randconfig-001-20240907   gcc-14.1.0
arm                   randconfig-002-20240907   gcc-14.1.0
arm                   randconfig-003-20240907   gcc-14.1.0
arm                   randconfig-004-20240907   clang-16
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240907   gcc-14.1.0
arm64                 randconfig-002-20240907   gcc-14.1.0
arm64                 randconfig-003-20240907   gcc-14.1.0
arm64                 randconfig-004-20240907   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240907   gcc-14.1.0
csky                  randconfig-002-20240907   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon               randconfig-001-20240907   clang-20
hexagon               randconfig-002-20240907   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-002-20240907   gcc-12
i386         buildonly-randconfig-003-20240907   gcc-12
i386         buildonly-randconfig-004-20240907   clang-18
i386         buildonly-randconfig-005-20240907   clang-18
i386         buildonly-randconfig-006-20240907   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240907   clang-18
i386                  randconfig-002-20240907   clang-18
i386                  randconfig-003-20240907   clang-18
i386                  randconfig-004-20240907   gcc-12
i386                  randconfig-005-20240907   gcc-12
i386                  randconfig-006-20240907   gcc-12
i386                  randconfig-012-20240907   gcc-12
i386                  randconfig-013-20240907   clang-18
i386                  randconfig-014-20240907   clang-18
i386                  randconfig-016-20240907   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240907   gcc-14.1.0
loongarch             randconfig-002-20240907   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
nios2                 randconfig-001-20240907   gcc-14.1.0
nios2                 randconfig-002-20240907   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240907   gcc-14.1.0
parisc                randconfig-002-20240907   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240907   clang-20
powerpc               randconfig-002-20240907   gcc-14.1.0
powerpc64             randconfig-001-20240907   clang-16
powerpc64             randconfig-002-20240907   clang-20
powerpc64             randconfig-003-20240907   gcc-13.2.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240907   gcc-14.1.0
riscv                 randconfig-002-20240907   clang-14
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240907   clang-20
s390                  randconfig-002-20240907   clang-15
sh                               allmodconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240907   gcc-14.1.0
sh                    randconfig-002-20240907   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240907   gcc-12
x86_64       buildonly-randconfig-002-20240907   gcc-12
x86_64       buildonly-randconfig-003-20240907   gcc-11
x86_64       buildonly-randconfig-004-20240907   clang-18
x86_64       buildonly-randconfig-005-20240907   gcc-12
x86_64       buildonly-randconfig-006-20240907   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240907   clang-18
x86_64                randconfig-002-20240907   gcc-12
x86_64                randconfig-003-20240907   gcc-12
x86_64                randconfig-004-20240907   clang-18
x86_64                randconfig-005-20240907   gcc-12
x86_64                randconfig-006-20240907   gcc-11
x86_64                randconfig-011-20240907   gcc-12
x86_64                randconfig-012-20240907   gcc-12
x86_64                randconfig-013-20240907   gcc-12
x86_64                randconfig-014-20240907   gcc-12
x86_64                randconfig-015-20240907   clang-18
x86_64                randconfig-016-20240907   gcc-12
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

