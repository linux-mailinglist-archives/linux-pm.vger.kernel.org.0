Return-Path: <linux-pm+bounces-19021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9E69ECDFF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C716B027
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CE23693D;
	Wed, 11 Dec 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIWU2JfS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F537236943
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925918; cv=none; b=mf+YTdRj81OYxSlfmRDIe/Wr2YQcx0CZWIxGzixEYUXwrPVUNXm9YbxTjl4U2CsyF/DqX7GdqpsD61Bz3poG6OHIvU0rfXzbwg9GDvCnxMhEGP4awEeAceW8o33f/hmgdPs6H1zkQrJB5VvT1CmcYVDfAv/GiCMoBuXr3RkXQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925918; c=relaxed/simple;
	bh=bydlnrZQWfXbfpWgcoqdJDth9yB5+iTPxxtPD0jdJCw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vv1KaGXZuEYv3fBIVB/kCkiGZPH/YTlRqsJd4NfyEd5AjOfDATKzQRsKjASCF4MwiKvhkPlRbQyyWZF61noG5eesOf7F9pk9yQ2rYJZxPkOGkWT8VuZ8hF98Mwv2Swf0C7e85ghrvVchczm2x6ZLXcjNklWT8wh9Dpv1cNFcQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIWU2JfS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733925916; x=1765461916;
  h=date:from:to:cc:subject:message-id;
  bh=bydlnrZQWfXbfpWgcoqdJDth9yB5+iTPxxtPD0jdJCw=;
  b=iIWU2JfSpo03uRFlnKdaVxvbH2RYXnu+g3swbSDuRA0AkWJYXUlzkIVJ
   nvACHDlctrc/qfnVfWzW946D0l+4e7h5RAxUBjszB0lz9R2fVW7ALGKJM
   731zektInbAR+x8NA01mKBSTwoUmACdsFXqD76DBeGKvgrarUUnCumE46
   yYYAbl3RxkraX9h188IhLarfaYR+AfsGJfOZJ6LQKOAtvs2yp2vC8+mmY
   3sDQNLpeb9JGLYp63b9xU6jNHSb/WC9Ytip4ANW1Tp59KYxxv3vErnkn5
   TF1JcvSVgxXbbCmJUmh10RjXkmN0KVfWju6uLolup1GAlB7nxH9uD7MEh
   g==;
X-CSE-ConnectionGUID: TBegacDUQGSYPYXkd5JctA==
X-CSE-MsgGUID: dy4aaHp3QeSHOmk3Mi1FUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44915373"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="44915373"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:05:00 -0800
X-CSE-ConnectionGUID: g++2bgNWQcO39AzwBbAnFw==
X-CSE-MsgGUID: vCVEz3sZRkyarot4h9HKIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95642306"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2024 06:04:58 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLNKi-0006ir-25;
	Wed, 11 Dec 2024 14:04:56 +0000
Date: Wed, 11 Dec 2024 22:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD REGRESSION
 0123e9c4f6190227590e4497068990c0ed229c84
Message-ID: <202412112219.on2XcaS0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 0123e9c4f6190227590e4497068990c0ed229c84  cpufreq/amd-pstate: Drop boost_state variable

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202412110820.DkiqvP3G-lkp@intel.com

    ld.lld: error: relocation R_PPC_ADDR16_HA cannot be used against symbol '__got2_start'; recompile with -fPIC

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-randconfig-002-20241211
    `-- ld.lld:error:relocation-R_PPC_ADDR16_HA-cannot-be-used-against-symbol-__got2_start-recompile-with-fPIC

elapsed time: 1456m

configs tested: 144
configs skipped: 5

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241211    gcc-13.2.0
arc                   randconfig-002-20241211    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-20
arm                   randconfig-001-20241211    clang-18
arm                   randconfig-002-20241211    gcc-14.2.0
arm                   randconfig-003-20241211    clang-20
arm                   randconfig-004-20241211    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241211    gcc-14.2.0
arm64                 randconfig-002-20241211    clang-18
arm64                 randconfig-003-20241211    gcc-14.2.0
arm64                 randconfig-004-20241211    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241211    gcc-14.2.0
csky                  randconfig-002-20241211    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241211    clang-20
hexagon               randconfig-002-20241211    clang-17
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241210    gcc-12
i386        buildonly-randconfig-001-20241211    clang-19
i386        buildonly-randconfig-002-20241210    clang-19
i386        buildonly-randconfig-002-20241211    gcc-11
i386        buildonly-randconfig-003-20241210    gcc-12
i386        buildonly-randconfig-003-20241211    clang-19
i386        buildonly-randconfig-004-20241210    clang-19
i386        buildonly-randconfig-004-20241211    gcc-11
i386        buildonly-randconfig-005-20241210    clang-19
i386        buildonly-randconfig-005-20241211    gcc-12
i386        buildonly-randconfig-006-20241210    clang-19
i386        buildonly-randconfig-006-20241211    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241211    gcc-14.2.0
loongarch             randconfig-002-20241211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241211    gcc-14.2.0
nios2                 randconfig-002-20241211    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241211    gcc-14.2.0
parisc                randconfig-002-20241211    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241211    clang-18
powerpc               randconfig-002-20241211    clang-16
powerpc               randconfig-003-20241211    gcc-14.2.0
powerpc64             randconfig-001-20241211    gcc-14.2.0
powerpc64             randconfig-002-20241211    clang-20
powerpc64             randconfig-003-20241211    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241210    clang-19
riscv                 randconfig-001-20241211    gcc-14.2.0
riscv                 randconfig-002-20241210    gcc-14.2.0
riscv                 randconfig-002-20241211    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241210    gcc-14.2.0
s390                  randconfig-001-20241211    clang-20
s390                  randconfig-002-20241210    gcc-14.2.0
s390                  randconfig-002-20241211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                    randconfig-001-20241210    gcc-14.2.0
sh                    randconfig-001-20241211    gcc-14.2.0
sh                    randconfig-002-20241210    gcc-14.2.0
sh                    randconfig-002-20241211    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20241210    gcc-14.2.0
sparc                 randconfig-001-20241211    gcc-14.2.0
sparc                 randconfig-002-20241210    gcc-14.2.0
sparc                 randconfig-002-20241211    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241210    gcc-14.2.0
sparc64               randconfig-001-20241211    gcc-14.2.0
sparc64               randconfig-002-20241210    gcc-14.2.0
sparc64               randconfig-002-20241211    gcc-14.2.0
um                                allnoconfig    clang-18
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241210    clang-20
um                    randconfig-001-20241211    gcc-12
um                    randconfig-002-20241210    gcc-12
um                    randconfig-002-20241211    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241210    gcc-12
x86_64      buildonly-randconfig-001-20241211    gcc-12
x86_64      buildonly-randconfig-002-20241210    clang-19
x86_64      buildonly-randconfig-002-20241211    gcc-11
x86_64      buildonly-randconfig-003-20241210    clang-19
x86_64      buildonly-randconfig-003-20241211    gcc-12
x86_64      buildonly-randconfig-004-20241210    gcc-12
x86_64      buildonly-randconfig-004-20241211    gcc-12
x86_64      buildonly-randconfig-005-20241210    gcc-12
x86_64      buildonly-randconfig-005-20241211    gcc-12
x86_64      buildonly-randconfig-006-20241210    clang-19
x86_64      buildonly-randconfig-006-20241211    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20241210    gcc-14.2.0
xtensa                randconfig-001-20241211    gcc-14.2.0
xtensa                randconfig-002-20241210    gcc-14.2.0
xtensa                randconfig-002-20241211    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

