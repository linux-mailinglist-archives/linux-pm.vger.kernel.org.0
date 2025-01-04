Return-Path: <linux-pm+bounces-19953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4090A012A5
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 07:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A54A3A1E7C
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B331C687;
	Sat,  4 Jan 2025 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJyvPN8u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF128377
	for <linux-pm@vger.kernel.org>; Sat,  4 Jan 2025 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735970647; cv=none; b=IkiD749FvbcKHO4WSVCvAlvPysEJtEbUaj6+04OvbWZgrIFNXcAHOX5ks5oWsoTKoSJfH0o07xCDZzAa3uStOhF0mfChKOoSzyCVS3hGktKp1Kmy6KfT8w0AO92cnDnxhgd7rxZwSCJTjKbRL2SLPhadNLM5hkc6kobc9duv9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735970647; c=relaxed/simple;
	bh=CnHkEaFWg7Arubxh6mG6qTi/E0IOM7hwLRsoAAxMQwA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RbO2bJhHKwIyjaCGMwqoDJsHJPCWAYolh3GCzxBCRiIWTIPnhq6gslFvSnsw/vOJnyThwWTwut/pglXyYXutHElKZZEv0crBXKZSg38itp5tbRfdm3+56KUZRxqoYq3UOhnPOQuwzIgwGd0MsAudlbO7vE4T/UXsWiG8/BGZ9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJyvPN8u; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735970646; x=1767506646;
  h=date:from:to:cc:subject:message-id;
  bh=CnHkEaFWg7Arubxh6mG6qTi/E0IOM7hwLRsoAAxMQwA=;
  b=QJyvPN8uf66YQ4QvcpYoJyDXszDnM0wWPLg7G4722tQ0QDhkl7yPNMwf
   L7R+cAZoscBHmHvh3ngsJunlamVD+SUzCBhejHX3wYeIPoL3FBN/+2Kr5
   BphV/SEtVNhp389M1CyUgSqMSYsgl20PqJOS52BG6OSdzBPZGGUn3eQyk
   sFhYFhrY6bAFIzbYJek9RXmRm4niXd7qC/GvWPxoZ1wd4AMvao6zA6Ri5
   6MSmFc8uKsgGTP3o6idweMEE79O+9FGKs5cr31MX1GSbXqP8DRexjCCJf
   7r5b+aQNxNMXE/TSoRdwSp/79cdK5yiIxS7c19wxdHo16W4z6s5aaEZhG
   w==;
X-CSE-ConnectionGUID: 93wh9JurQQaNzr0YvGgJaQ==
X-CSE-MsgGUID: dzTLxut7QzaD+Qz9MoJXKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="58669318"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="58669318"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 22:04:05 -0800
X-CSE-ConnectionGUID: hoMndfAOTfmVodOlLVzjSw==
X-CSE-MsgGUID: TvePWlLWTPSuMZBksFjVlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="102142418"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jan 2025 22:04:05 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTxGU-000AfL-0C;
	Sat, 04 Jan 2025 06:04:02 +0000
Date: Sat, 04 Jan 2025 14:03:47 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 fd604ae6c261c5a56bb977ae99f875bbd7264a3f
Message-ID: <202501041438.NMGZMOeV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: fd604ae6c261c5a56bb977ae99f875bbd7264a3f  cpufreq/amd-pstate: Fix prefcore rankings

elapsed time: 779m

configs tested: 222
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250104    clang-16
arc                   randconfig-001-20250104    gcc-13.2.0
arc                   randconfig-002-20250104    clang-16
arc                   randconfig-002-20250104    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250104    clang-16
arm                   randconfig-001-20250104    clang-20
arm                   randconfig-002-20250104    clang-16
arm                   randconfig-002-20250104    clang-20
arm                   randconfig-003-20250104    clang-16
arm                   randconfig-003-20250104    gcc-14.2.0
arm                   randconfig-004-20250104    clang-16
arm                   randconfig-004-20250104    gcc-14.2.0
arm                           sunxi_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250104    clang-16
arm64                 randconfig-001-20250104    clang-20
arm64                 randconfig-002-20250104    clang-16
arm64                 randconfig-003-20250104    clang-16
arm64                 randconfig-003-20250104    gcc-14.2.0
arm64                 randconfig-004-20250104    clang-16
arm64                 randconfig-004-20250104    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250104    gcc-14.2.0
csky                  randconfig-002-20250104    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250104    clang-20
hexagon               randconfig-001-20250104    gcc-14.2.0
hexagon               randconfig-002-20250104    clang-20
hexagon               randconfig-002-20250104    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250104    clang-19
i386        buildonly-randconfig-002-20250104    clang-19
i386        buildonly-randconfig-002-20250104    gcc-12
i386        buildonly-randconfig-003-20250104    clang-19
i386        buildonly-randconfig-004-20250104    clang-19
i386        buildonly-randconfig-004-20250104    gcc-12
i386        buildonly-randconfig-005-20250104    clang-19
i386        buildonly-randconfig-006-20250104    clang-19
i386        buildonly-randconfig-006-20250104    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250104    gcc-12
i386                  randconfig-002-20250104    gcc-12
i386                  randconfig-003-20250104    gcc-12
i386                  randconfig-004-20250104    gcc-12
i386                  randconfig-005-20250104    gcc-12
i386                  randconfig-006-20250104    gcc-12
i386                  randconfig-007-20250104    gcc-12
i386                  randconfig-011-20250104    gcc-12
i386                  randconfig-012-20250104    gcc-12
i386                  randconfig-013-20250104    gcc-12
i386                  randconfig-014-20250104    gcc-12
i386                  randconfig-015-20250104    gcc-12
i386                  randconfig-016-20250104    gcc-12
i386                  randconfig-017-20250104    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250104    gcc-14.2.0
loongarch             randconfig-002-20250104    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250104    gcc-14.2.0
nios2                 randconfig-002-20250104    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250104    gcc-14.2.0
parisc                randconfig-002-20250104    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-13.2.0
powerpc               randconfig-001-20250104    clang-20
powerpc               randconfig-001-20250104    gcc-14.2.0
powerpc               randconfig-002-20250104    clang-18
powerpc               randconfig-002-20250104    gcc-14.2.0
powerpc               randconfig-003-20250104    gcc-14.2.0
powerpc64             randconfig-001-20250104    gcc-14.2.0
powerpc64             randconfig-002-20250104    gcc-14.2.0
powerpc64             randconfig-003-20250104    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250104    gcc-11
riscv                 randconfig-001-20250104    gcc-14.2.0
riscv                 randconfig-002-20250104    clang-16
riscv                 randconfig-002-20250104    gcc-11
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250104    clang-20
s390                  randconfig-001-20250104    gcc-11
s390                  randconfig-002-20250104    clang-20
s390                  randconfig-002-20250104    gcc-11
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250104    gcc-11
sh                    randconfig-001-20250104    gcc-14.2.0
sh                    randconfig-002-20250104    gcc-11
sh                    randconfig-002-20250104    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-13.2.0
sh                          sdk7786_defconfig    gcc-13.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250104    gcc-11
sparc                 randconfig-001-20250104    gcc-14.2.0
sparc                 randconfig-002-20250104    gcc-11
sparc                 randconfig-002-20250104    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250104    gcc-11
sparc64               randconfig-001-20250104    gcc-14.2.0
sparc64               randconfig-002-20250104    gcc-11
sparc64               randconfig-002-20250104    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250104    gcc-11
um                    randconfig-001-20250104    gcc-12
um                    randconfig-002-20250104    gcc-11
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250104    clang-19
x86_64      buildonly-randconfig-001-20250104    gcc-12
x86_64      buildonly-randconfig-002-20250104    clang-19
x86_64      buildonly-randconfig-003-20250104    clang-19
x86_64      buildonly-randconfig-003-20250104    gcc-12
x86_64      buildonly-randconfig-004-20250104    clang-19
x86_64      buildonly-randconfig-004-20250104    gcc-12
x86_64      buildonly-randconfig-005-20250104    clang-19
x86_64      buildonly-randconfig-006-20250104    clang-19
x86_64      buildonly-randconfig-006-20250104    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250104    clang-19
x86_64                randconfig-002-20250104    clang-19
x86_64                randconfig-003-20250104    clang-19
x86_64                randconfig-004-20250104    clang-19
x86_64                randconfig-005-20250104    clang-19
x86_64                randconfig-006-20250104    clang-19
x86_64                randconfig-007-20250104    clang-19
x86_64                randconfig-008-20250104    clang-19
x86_64                randconfig-071-20250104    gcc-11
x86_64                randconfig-072-20250104    gcc-11
x86_64                randconfig-073-20250104    gcc-11
x86_64                randconfig-074-20250104    gcc-11
x86_64                randconfig-075-20250104    gcc-11
x86_64                randconfig-076-20250104    gcc-11
x86_64                randconfig-077-20250104    gcc-11
x86_64                randconfig-078-20250104    gcc-11
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250104    gcc-11
xtensa                randconfig-001-20250104    gcc-14.2.0
xtensa                randconfig-002-20250104    gcc-11
xtensa                randconfig-002-20250104    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

