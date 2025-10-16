Return-Path: <linux-pm+bounces-36279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC6BE45CD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7EC1A643CD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8B34AB18;
	Thu, 16 Oct 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAJc/6eJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003F345739
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629987; cv=none; b=XRT8w18AqfuIPZO5TPZwhZEZH6Q2/UkrqERRqIasBXtp+CbgecccoQ7HgMVTN3kooBI/0VUJyXbZYfpU6Qtd5U/mp5NiwMhjx0R7NeIyFKQ5wm/G9Hydu3t2xrd99ozyNMSMU7cJ0xC9OrK5Jnv/sx6bXTw7Wjw8ZxjSVsKAM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629987; c=relaxed/simple;
	bh=4PmpJUEvrJvuhq54JroR+06mc+n5JaYJi32r/Fq8yr8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iFGRRBailN7HnLQB8KNlAyEG09AYxD8QpxK85GGHdOw2pWzzxByKiIZ5Xtwqg1rMSeWjWNLQ6nppXJkcArgTOrg2vn5tOyWbpiYVZxImXbbqgh5roTFise9mjQ8ReYK53zbAHpxRY2F+raENEmrseU8qUqcwinKGkYcJU2YPRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAJc/6eJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760629986; x=1792165986;
  h=date:from:to:cc:subject:message-id;
  bh=4PmpJUEvrJvuhq54JroR+06mc+n5JaYJi32r/Fq8yr8=;
  b=XAJc/6eJKJZIqtJIRGF6EhQ7gJv6TYcD4vtPYT6amlwP8dbybizAcd4I
   YT+dmLiyXeIlV5gBhHe42fySixc9hNe21xu02eWer4gye50SbV0Yxhi/0
   A/NB/EepMIWckkSgDFMKUIb9uXrtONR8ndyJkiceSJFjAnIrVx/P3o2tp
   BgflrFd81j8CZeC0FAi06VkwOhq804XxZXbFu1+WxgmvGxz2tiSTsGy17
   aeNirzlgSYWvz8NoYX9m4MfyVJ3bvBW1390MpahDSK3YpjoIUO68n1zAv
   wQDmN6ViRT68Pua7jBMeiXFVagoYczCqypimtGc3RaIFBn1QPwfM6plrK
   A==;
X-CSE-ConnectionGUID: 2vsvwVGoStWkasblTb3g6g==
X-CSE-MsgGUID: YtGUwYTYTXSVHJ1BUfaubQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="61859000"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="61859000"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:50:15 -0700
X-CSE-ConnectionGUID: 2R8w99UNSYObZe1BtggZPw==
X-CSE-MsgGUID: CFrIp5MhTt2N71AQtKm5nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182965276"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 16 Oct 2025 08:50:14 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9QF1-000503-2J;
	Thu, 16 Oct 2025 15:50:11 +0000
Date: Thu, 16 Oct 2025 23:49:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 85d7dda5a9f665ea579741ec873a8841f37e8943
Message-ID: <202510162328.3xY7KZjC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: 85d7dda5a9f665ea579741ec873a8841f37e8943  cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate

elapsed time: 1442m

configs tested: 207
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251016    gcc-13.4.0
arc                   randconfig-002-20251016    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20251016    clang-22
arm                   randconfig-002-20251016    gcc-10.5.0
arm                   randconfig-003-20251016    clang-22
arm                   randconfig-004-20251016    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251016    clang-22
arm64                 randconfig-002-20251016    gcc-13.4.0
arm64                 randconfig-003-20251016    gcc-10.5.0
arm64                 randconfig-004-20251016    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251016    clang-22
csky                  randconfig-001-20251016    gcc-11.5.0
csky                  randconfig-002-20251016    clang-22
csky                  randconfig-002-20251016    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251016    clang-22
hexagon               randconfig-002-20251016    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251016    clang-20
i386        buildonly-randconfig-002-20251016    clang-20
i386        buildonly-randconfig-002-20251016    gcc-14
i386        buildonly-randconfig-003-20251016    clang-20
i386        buildonly-randconfig-004-20251016    clang-20
i386        buildonly-randconfig-005-20251016    clang-20
i386        buildonly-randconfig-006-20251016    clang-20
i386        buildonly-randconfig-006-20251016    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251016    clang-20
i386                  randconfig-002-20251016    clang-20
i386                  randconfig-003-20251016    clang-20
i386                  randconfig-004-20251016    clang-20
i386                  randconfig-005-20251016    clang-20
i386                  randconfig-006-20251016    clang-20
i386                  randconfig-007-20251016    clang-20
i386                  randconfig-011-20251016    gcc-14
i386                  randconfig-012-20251016    gcc-14
i386                  randconfig-013-20251016    gcc-14
i386                  randconfig-014-20251016    gcc-14
i386                  randconfig-015-20251016    gcc-14
i386                  randconfig-016-20251016    gcc-14
i386                  randconfig-017-20251016    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251016    clang-22
loongarch             randconfig-001-20251016    gcc-15.1.0
loongarch             randconfig-002-20251016    clang-22
loongarch             randconfig-002-20251016    gcc-13.4.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251016    clang-22
nios2                 randconfig-001-20251016    gcc-8.5.0
nios2                 randconfig-002-20251016    clang-22
nios2                 randconfig-002-20251016    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251016    clang-22
parisc                randconfig-001-20251016    gcc-9.5.0
parisc                randconfig-002-20251016    clang-22
parisc                randconfig-002-20251016    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251016    clang-16
powerpc               randconfig-001-20251016    clang-22
powerpc               randconfig-002-20251016    clang-22
powerpc               randconfig-002-20251016    gcc-8.5.0
powerpc               randconfig-003-20251016    clang-22
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-002-20251016    clang-22
powerpc64             randconfig-003-20251016    clang-22
powerpc64             randconfig-003-20251016    gcc-13.4.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251016    gcc-10.5.0
riscv                 randconfig-001-20251016    gcc-9.5.0
riscv                 randconfig-002-20251016    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251016    clang-18
s390                  randconfig-001-20251016    gcc-10.5.0
s390                  randconfig-002-20251016    gcc-10.5.0
s390                  randconfig-002-20251016    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251016    gcc-10.5.0
sh                    randconfig-001-20251016    gcc-14.3.0
sh                    randconfig-002-20251016    gcc-10.5.0
sh                    randconfig-002-20251016    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251016    gcc-10.5.0
sparc                 randconfig-001-20251016    gcc-15.1.0
sparc                 randconfig-002-20251016    gcc-10.5.0
sparc                 randconfig-002-20251016    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251016    gcc-10.5.0
sparc64               randconfig-001-20251016    gcc-13.4.0
sparc64               randconfig-002-20251016    gcc-10.5.0
sparc64               randconfig-002-20251016    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251016    gcc-10.5.0
um                    randconfig-001-20251016    gcc-12
um                    randconfig-002-20251016    clang-22
um                    randconfig-002-20251016    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251016    clang-20
x86_64      buildonly-randconfig-002-20251016    gcc-14
x86_64      buildonly-randconfig-003-20251016    gcc-14
x86_64      buildonly-randconfig-004-20251016    gcc-12
x86_64      buildonly-randconfig-005-20251016    gcc-14
x86_64      buildonly-randconfig-006-20251016    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251016    clang-20
x86_64                randconfig-002-20251016    clang-20
x86_64                randconfig-003-20251016    clang-20
x86_64                randconfig-004-20251016    clang-20
x86_64                randconfig-005-20251016    clang-20
x86_64                randconfig-006-20251016    clang-20
x86_64                randconfig-007-20251016    clang-20
x86_64                randconfig-008-20251016    clang-20
x86_64                randconfig-071-20251016    gcc-14
x86_64                randconfig-072-20251016    gcc-14
x86_64                randconfig-073-20251016    gcc-14
x86_64                randconfig-074-20251016    gcc-14
x86_64                randconfig-075-20251016    gcc-14
x86_64                randconfig-076-20251016    gcc-14
x86_64                randconfig-077-20251016    gcc-14
x86_64                randconfig-078-20251016    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251016    gcc-10.5.0
xtensa                randconfig-002-20251016    gcc-10.5.0
xtensa                randconfig-002-20251016    gcc-9.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

