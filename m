Return-Path: <linux-pm+bounces-19072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5149ED8FA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 22:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D15D188B64E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 21:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63D1F0E29;
	Wed, 11 Dec 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeNBSH9z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14001EC4F0
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953449; cv=none; b=DGGXwRZNbAyoPcA6P7C4CAPhGIY9LkZgTSOUNEn0tjXIajqSCW0rLws5MTUPPh/lzMpGBD8h0dV4o6zHBPrwA6IIbyt+XQqu63ivgMFVQtOnLucsEnkBvGxq/AVfeRDAIxJAsOypmW9ZvLQvaKXVdB/MzggTTAEyPRTT5aB6Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953449; c=relaxed/simple;
	bh=3uDbOis2J08VjiN6Xw0HI7l6S+YxTMe2wkSdfgvnyXQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S2oVTkVohQYNMCMl9GnlUJYw6u/aqyi5uxz4kKJog0z7SlqxNBuGtQL4ouuMnFDQu1FPSwgixYtYQMcZNqffpsOdYy6iP6v46UQPt+1vqccF6kXvv7Da0jt2J54Di7rT55X7yfaNxW4I7B7juS9AHLv4APK8qLhMCQyQixtLy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeNBSH9z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733953448; x=1765489448;
  h=date:from:to:cc:subject:message-id;
  bh=3uDbOis2J08VjiN6Xw0HI7l6S+YxTMe2wkSdfgvnyXQ=;
  b=HeNBSH9zTPz7E+kv9KbsfuJD/XC/efWuDvNoTRbyBDWy4owH1a4S36XG
   ySiFN124z1Jfb51XUNIKfCatkq0jCCEEwgQOdGf+dO3W64r2MbxnMPG4K
   QH7wX1/omczBNAiTv/D7YxLQJnsWy2nK/QWFiASLobdvvmNwNcS7/CVtI
   rNLlWCCRGikqdkGD3U9JKnGDF9CMzFLGeVyXVaLBGfuFDYkISC5Ybbm81
   54UJHNGSVY52lIYjiEVENXoWNSHeJOThzDTNWyyJdirfLngn0B9aHXVSJ
   HNWZGp5tPFnwTt1cKEoLmxN5+Q/UNwvvHWoShYqOCrRaBL1GE9/aQw4j+
   g==;
X-CSE-ConnectionGUID: jtyw1qw7STSP8WdsG7oj4w==
X-CSE-MsgGUID: t2xhPQ3HRu+7sQXZRSjtRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38137894"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="38137894"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 13:44:06 -0800
X-CSE-ConnectionGUID: pKiq5p3QQSG7kGVuv7QZbg==
X-CSE-MsgGUID: QSo+HQXVTMutSQG+TuOV5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="95820837"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2024 13:44:05 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLUV0-00077B-2B;
	Wed, 11 Dec 2024 21:44:02 +0000
Date: Thu, 12 Dec 2024 05:43:47 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 2993b29b2a98f2bc9d55dfd37ef39f56a2908748
Message-ID: <202412120541.U4yxO8Wi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: 2993b29b2a98f2bc9d55dfd37ef39f56a2908748  cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies

elapsed time: 1478m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241211    gcc-13.2.0
arc                   randconfig-002-20241211    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-17
arm                   randconfig-001-20241211    clang-18
arm                   randconfig-002-20241211    gcc-14.2.0
arm                   randconfig-003-20241211    clang-20
arm                   randconfig-004-20241211    gcc-14.2.0
arm                        realview_defconfig    clang-19
arm                           tegra_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241211    gcc-14.2.0
arm64                 randconfig-002-20241211    clang-18
arm64                 randconfig-003-20241211    gcc-14.2.0
arm64                 randconfig-004-20241211    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241211    gcc-14.2.0
csky                  randconfig-002-20241211    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241211    clang-20
hexagon               randconfig-002-20241211    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241211    clang-19
i386        buildonly-randconfig-002-20241211    gcc-11
i386        buildonly-randconfig-003-20241211    clang-19
i386        buildonly-randconfig-004-20241211    gcc-11
i386        buildonly-randconfig-005-20241211    gcc-12
i386        buildonly-randconfig-006-20241211    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241211    gcc-14.2.0
loongarch             randconfig-002-20241211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                           xway_defconfig    clang-20
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
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241211    clang-18
powerpc               randconfig-002-20241211    clang-16
powerpc               randconfig-003-20241211    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20241211    gcc-14.2.0
powerpc64             randconfig-002-20241211    clang-20
powerpc64             randconfig-003-20241211    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241211    gcc-14.2.0
riscv                 randconfig-002-20241211    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241211    clang-20
s390                  randconfig-002-20241211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241211    gcc-14.2.0
sh                    randconfig-002-20241211    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20241211    gcc-14.2.0
sparc                 randconfig-002-20241211    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241211    gcc-14.2.0
sparc64               randconfig-002-20241211    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241211    gcc-12
um                    randconfig-002-20241211    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241211    gcc-12
x86_64      buildonly-randconfig-002-20241211    gcc-11
x86_64      buildonly-randconfig-003-20241211    gcc-12
x86_64      buildonly-randconfig-004-20241211    gcc-12
x86_64      buildonly-randconfig-005-20241211    gcc-12
x86_64      buildonly-randconfig-006-20241211    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20241211    gcc-14.2.0
xtensa                randconfig-002-20241211    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

