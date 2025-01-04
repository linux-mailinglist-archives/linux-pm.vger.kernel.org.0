Return-Path: <linux-pm+bounces-19959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB7A01776
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 00:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1993A386B
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615D1C1AAA;
	Sat,  4 Jan 2025 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJptXzAs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738B35959
	for <linux-pm@vger.kernel.org>; Sat,  4 Jan 2025 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736033559; cv=none; b=r5iDE5u41HghJTSuNQSqwvQOiwyvGIjpjczEREQAlTslUCh+slREkTPewrf2UtUVtZUkV8Kiv6rLCByVpDnN6iQvr1SYfOQsNC5O+IEiTcyotZ9+ZLTe+qUbxnQ3jqpJpiVPiyf+cLhtiD+gLAEW0aN5MT5dqWinhqfjcqVT6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736033559; c=relaxed/simple;
	bh=y6VhQZd3hDSTcRewgzLiRTLA2K07W8aHOlv7fvm2Xx4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RCGP4VGjrxG9iPmGx86akG1onmY9uRxQI8+/E8+0XMIfDulusWq/1LxxcVzWupgFOp/ckqZUucfuN8WBb5fB/huX9A1tcqpcuZRkw2VlCCekAHOnG5vBjDqtxOTmY+1CoOrmGxol1B5C/oI3Sb5oiZq3VW8R+njooy7UvCKe18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJptXzAs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736033558; x=1767569558;
  h=date:from:to:cc:subject:message-id;
  bh=y6VhQZd3hDSTcRewgzLiRTLA2K07W8aHOlv7fvm2Xx4=;
  b=PJptXzAseizbOATnXR+31QNlxn/Go9rHBnQL5px7O5XomyaJrF7cvj8O
   ag3h4CMn9ZiOlXguldRLC3FM249kHhcLt26cysPRO95wmGNFPk6YE5V2v
   vGdtC34d7wvpaCJocG5RPUk0W41aeWG12f4M2U9oyUMf9J7yxtHXRVfRb
   vcLYPlWL0VHyn7/BR3sdYqbbp1GDaZJs1u2snD+QD/zB1mm4ss63TItNz
   RQ6C4ryHX7vWVM5r6DeG1WfYgJa3Nh3IcG1Xmqq3d80gpj9aEMhsS84ga
   DMniaPZJUf2gkIZ9NErBshL713KDTbiDJBdXTU1rJXRv4fSTRWfTp0RYi
   Q==;
X-CSE-ConnectionGUID: UkPS9jg0QTqWsYNaqpLmCw==
X-CSE-MsgGUID: MEtgu2ZuQ92zobx2zFLWnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11305"; a="39998022"
X-IronPort-AV: E=Sophos;i="6.12,289,1728975600"; 
   d="scan'208";a="39998022"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 15:32:37 -0800
X-CSE-ConnectionGUID: AHUnUP2yTtWdKszyjkKJeg==
X-CSE-MsgGUID: Iof5GimqTq2GifWaB60nmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,289,1728975600"; 
   d="scan'208";a="132928210"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Jan 2025 15:32:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUDdB-000BIZ-32;
	Sat, 04 Jan 2025 23:32:33 +0000
Date: Sun, 05 Jan 2025 07:32:09 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 857a61c2ce74e30fc3b10bc89d68ddd8d05b188c
Message-ID: <202501050703.WXTPYO7p-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 857a61c2ce74e30fc3b10bc89d68ddd8d05b188c  cpufreq/amd-pstate: Refactor max frequency calculation

elapsed time: 1023m

configs tested: 164
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250104    gcc-13.2.0
arc                   randconfig-002-20250104    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                        neponset_defconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-20
arm                   randconfig-001-20250104    clang-20
arm                   randconfig-002-20250104    clang-20
arm                   randconfig-003-20250104    gcc-14.2.0
arm                   randconfig-004-20250104    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250104    clang-20
arm64                 randconfig-002-20250104    clang-16
arm64                 randconfig-003-20250104    gcc-14.2.0
arm64                 randconfig-004-20250104    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250104    gcc-14.2.0
csky                  randconfig-001-20250105    gcc-14.2.0
csky                  randconfig-002-20250104    gcc-14.2.0
csky                  randconfig-002-20250105    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20250104    clang-20
hexagon               randconfig-001-20250105    clang-20
hexagon               randconfig-002-20250104    clang-20
hexagon               randconfig-002-20250105    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250104    clang-19
i386        buildonly-randconfig-002-20250104    gcc-12
i386        buildonly-randconfig-003-20250104    clang-19
i386        buildonly-randconfig-004-20250104    gcc-12
i386        buildonly-randconfig-005-20250104    clang-19
i386        buildonly-randconfig-006-20250104    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250104    gcc-14.2.0
loongarch             randconfig-001-20250105    gcc-14.2.0
loongarch             randconfig-002-20250104    gcc-14.2.0
loongarch             randconfig-002-20250105    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250104    gcc-14.2.0
nios2                 randconfig-001-20250105    gcc-14.2.0
nios2                 randconfig-002-20250104    gcc-14.2.0
nios2                 randconfig-002-20250105    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250104    gcc-14.2.0
parisc                randconfig-001-20250105    gcc-14.2.0
parisc                randconfig-002-20250104    gcc-14.2.0
parisc                randconfig-002-20250105    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   currituck_defconfig    clang-17
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc               randconfig-001-20250104    clang-20
powerpc               randconfig-001-20250105    clang-15
powerpc               randconfig-002-20250104    clang-18
powerpc               randconfig-002-20250105    clang-20
powerpc               randconfig-003-20250104    gcc-14.2.0
powerpc               randconfig-003-20250105    clang-20
powerpc64             randconfig-001-20250104    gcc-14.2.0
powerpc64             randconfig-001-20250105    clang-20
powerpc64             randconfig-002-20250104    gcc-14.2.0
powerpc64             randconfig-002-20250105    clang-20
powerpc64             randconfig-003-20250104    gcc-14.2.0
powerpc64             randconfig-003-20250105    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250104    gcc-14.2.0
riscv                 randconfig-001-20250105    gcc-14.2.0
riscv                 randconfig-002-20250104    clang-16
riscv                 randconfig-002-20250105    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250104    clang-20
s390                  randconfig-001-20250105    gcc-14.2.0
s390                  randconfig-002-20250104    clang-20
s390                  randconfig-002-20250105    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250104    gcc-14.2.0
sh                    randconfig-001-20250105    gcc-14.2.0
sh                    randconfig-002-20250104    gcc-14.2.0
sh                    randconfig-002-20250105    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250104    gcc-14.2.0
sparc                 randconfig-001-20250105    gcc-14.2.0
sparc                 randconfig-002-20250104    gcc-14.2.0
sparc                 randconfig-002-20250105    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250104    gcc-14.2.0
sparc64               randconfig-001-20250105    gcc-14.2.0
sparc64               randconfig-002-20250104    gcc-14.2.0
sparc64               randconfig-002-20250105    gcc-14.2.0
um                               alldefconfig    clang-19
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250104    gcc-12
um                    randconfig-001-20250105    gcc-12
um                    randconfig-002-20250104    gcc-11
um                    randconfig-002-20250105    clang-19
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250104    gcc-12
x86_64      buildonly-randconfig-002-20250104    clang-19
x86_64      buildonly-randconfig-003-20250104    gcc-12
x86_64      buildonly-randconfig-004-20250104    gcc-12
x86_64      buildonly-randconfig-005-20250104    clang-19
x86_64      buildonly-randconfig-006-20250104    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250104    gcc-14.2.0
xtensa                randconfig-001-20250105    gcc-14.2.0
xtensa                randconfig-002-20250104    gcc-14.2.0
xtensa                randconfig-002-20250105    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

