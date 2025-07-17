Return-Path: <linux-pm+bounces-31011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E3B08DE8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2991A61757
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149E2E0903;
	Thu, 17 Jul 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9NbdtPr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6922E06C9
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758026; cv=none; b=NCOHw6XyYRoe0QMdHQKSUD/41zSMhhZoEbVz+RJ4ngCUtKGQ+ioOQsV2dNSKj+8iyuGtDcBFB9PawchXNzndA/dOlFv07uaQ2WHqbtiUwdvwbQOcq27bl9i7alMrCBhj/jzY9bRrOt/PX60uWP1KIIv0przqNpXtcfyyISpP/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758026; c=relaxed/simple;
	bh=rDDqlIgSrHG/2pO20Q6PzkvnPh2BRNpiAThJ0MwiGvg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DlsR/jXJwsbMmB0jeTJAY/me26P1JQbWiFQkQ4yk5OSdjuoHP77xKg5VxOzE+VRZxbB/+L3vTmzLh23scm9m1SbaYhmx2SJqINasDhujfONZrIZ9SwXfflzeVbvkmq9s4LgdH+1IZbHds5TU+e+VCwpGhILPQD50kFKl409Hjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9NbdtPr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752758024; x=1784294024;
  h=date:from:to:cc:subject:message-id;
  bh=rDDqlIgSrHG/2pO20Q6PzkvnPh2BRNpiAThJ0MwiGvg=;
  b=H9NbdtPrAIa/xwk2RpFGIXVCUr3ERlmBXSmzM0wKNLvTdJ70Rw5yggOp
   r0GpgcH2tBgOLQdKAiJtcq1b055V+c2oPML7iqKuJp85XX9KXCm0RYbHG
   SeiNWyvBS/MS0/o+SSzyuZg1Jm61zkdR1Q0yE9+y9sd5Wp3aqOQYS8JQV
   oJCZUFKDNGNoyL7z15MQzT+QG/kZa9TBOgwLKPql3t74ZSWAsc65dyok+
   DX7FQbEXrYQqfyY9unt2JP2X5ixAgGiC8+01hUbQpoIJC2Ari8v8kdPOp
   DINzM8hAj3qk3nYpZMUiBtvswdSDTd5YZY9RQnpGTZZ5a5REngpwNVIR/
   g==;
X-CSE-ConnectionGUID: NyPUKdsQQ7CCAR62slKVRA==
X-CSE-MsgGUID: /GFkGZFxQ4yHIXzlV0SC7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66382382"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="66382382"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 06:13:43 -0700
X-CSE-ConnectionGUID: dIic63vPRtmA2urP/TM9Fg==
X-CSE-MsgGUID: 4DfqW6vkTxSKJutg4LP5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="157465140"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2025 06:13:42 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucOQd-000Ded-2P;
	Thu, 17 Jul 2025 13:13:39 +0000
Date: Thu, 17 Jul 2025 21:12:55 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 efbc5b4ac98e187375bf14c18ecc76988d3bab3c
Message-ID: <202507172143.XQUMGasE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: efbc5b4ac98e187375bf14c18ecc76988d3bab3c  Documentation: amd-pstate:fix minimum performance state label error

elapsed time: 1008m

configs tested: 223
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250717    clang-21
arc                   randconfig-001-20250717    gcc-8.5.0
arc                   randconfig-002-20250717    clang-21
arc                   randconfig-002-20250717    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250717    clang-21
arm                   randconfig-002-20250717    clang-21
arm                   randconfig-002-20250717    gcc-8.5.0
arm                   randconfig-003-20250717    clang-21
arm                   randconfig-003-20250717    gcc-8.5.0
arm                   randconfig-004-20250717    clang-21
arm                             rpc_defconfig    clang-21
arm                           sama5_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250717    clang-18
arm64                 randconfig-001-20250717    clang-21
arm64                 randconfig-002-20250717    clang-18
arm64                 randconfig-002-20250717    clang-21
arm64                 randconfig-003-20250717    clang-21
arm64                 randconfig-003-20250717    gcc-10.5.0
arm64                 randconfig-004-20250717    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250717    gcc-12.4.0
csky                  randconfig-001-20250717    gcc-15.1.0
csky                  randconfig-002-20250717    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250717    clang-20
hexagon               randconfig-001-20250717    gcc-12.4.0
hexagon               randconfig-002-20250717    clang-19
hexagon               randconfig-002-20250717    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250717    clang-20
i386        buildonly-randconfig-001-20250717    gcc-12
i386        buildonly-randconfig-002-20250717    clang-20
i386        buildonly-randconfig-002-20250717    gcc-12
i386        buildonly-randconfig-003-20250717    clang-20
i386        buildonly-randconfig-004-20250717    clang-20
i386        buildonly-randconfig-005-20250717    clang-20
i386        buildonly-randconfig-006-20250717    clang-20
i386        buildonly-randconfig-006-20250717    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250717    gcc-12
i386                  randconfig-002-20250717    gcc-12
i386                  randconfig-003-20250717    gcc-12
i386                  randconfig-004-20250717    gcc-12
i386                  randconfig-005-20250717    gcc-12
i386                  randconfig-006-20250717    gcc-12
i386                  randconfig-007-20250717    gcc-12
i386                  randconfig-011-20250717    gcc-12
i386                  randconfig-012-20250717    gcc-12
i386                  randconfig-013-20250717    gcc-12
i386                  randconfig-014-20250717    gcc-12
i386                  randconfig-015-20250717    gcc-12
i386                  randconfig-016-20250717    gcc-12
i386                  randconfig-017-20250717    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250717    gcc-12.4.0
loongarch             randconfig-001-20250717    gcc-15.1.0
loongarch             randconfig-002-20250717    clang-21
loongarch             randconfig-002-20250717    gcc-12.4.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250717    gcc-12.4.0
nios2                 randconfig-001-20250717    gcc-8.5.0
nios2                 randconfig-002-20250717    gcc-12.4.0
nios2                 randconfig-002-20250717    gcc-9.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250717    gcc-12.4.0
parisc                randconfig-001-20250717    gcc-9.3.0
parisc                randconfig-002-20250717    gcc-12.4.0
parisc                randconfig-002-20250717    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        icon_defconfig    clang-21
powerpc                         ps3_defconfig    clang-21
powerpc               randconfig-001-20250717    clang-21
powerpc               randconfig-001-20250717    gcc-12.4.0
powerpc               randconfig-002-20250717    gcc-12.4.0
powerpc               randconfig-002-20250717    gcc-13.4.0
powerpc               randconfig-003-20250717    clang-21
powerpc               randconfig-003-20250717    gcc-12.4.0
powerpc64             randconfig-001-20250717    clang-21
powerpc64             randconfig-001-20250717    gcc-12.4.0
powerpc64             randconfig-002-20250717    clang-18
powerpc64             randconfig-002-20250717    gcc-12.4.0
powerpc64             randconfig-003-20250717    clang-21
powerpc64             randconfig-003-20250717    gcc-12.4.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250717    gcc-13.4.0
riscv                 randconfig-001-20250717    gcc-14.3.0
riscv                 randconfig-002-20250717    clang-21
riscv                 randconfig-002-20250717    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250717    gcc-13.4.0
s390                  randconfig-001-20250717    gcc-8.5.0
s390                  randconfig-002-20250717    gcc-13.4.0
s390                  randconfig-002-20250717    gcc-9.3.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250717    gcc-13.4.0
sh                    randconfig-001-20250717    gcc-14.3.0
sh                    randconfig-002-20250717    gcc-13.4.0
sh                    randconfig-002-20250717    gcc-9.3.0
sh                   sh7724_generic_defconfig    clang-21
sparc                            alldefconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250717    gcc-13.4.0
sparc                 randconfig-001-20250717    gcc-14.3.0
sparc                 randconfig-002-20250717    gcc-13.4.0
sparc                 randconfig-002-20250717    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250717    gcc-12.4.0
sparc64               randconfig-001-20250717    gcc-13.4.0
sparc64               randconfig-002-20250717    clang-21
sparc64               randconfig-002-20250717    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250717    gcc-12
um                    randconfig-001-20250717    gcc-13.4.0
um                    randconfig-002-20250717    gcc-12
um                    randconfig-002-20250717    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250717    clang-20
x86_64      buildonly-randconfig-001-20250717    gcc-12
x86_64      buildonly-randconfig-002-20250717    clang-20
x86_64      buildonly-randconfig-002-20250717    gcc-12
x86_64      buildonly-randconfig-003-20250717    clang-20
x86_64      buildonly-randconfig-003-20250717    gcc-12
x86_64      buildonly-randconfig-004-20250717    gcc-12
x86_64      buildonly-randconfig-005-20250717    gcc-12
x86_64      buildonly-randconfig-006-20250717    clang-20
x86_64      buildonly-randconfig-006-20250717    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250717    gcc-11
x86_64                randconfig-002-20250717    gcc-11
x86_64                randconfig-003-20250717    gcc-11
x86_64                randconfig-004-20250717    gcc-11
x86_64                randconfig-005-20250717    gcc-11
x86_64                randconfig-006-20250717    gcc-11
x86_64                randconfig-007-20250717    gcc-11
x86_64                randconfig-008-20250717    gcc-11
x86_64                randconfig-071-20250717    gcc-12
x86_64                randconfig-072-20250717    gcc-12
x86_64                randconfig-073-20250717    gcc-12
x86_64                randconfig-074-20250717    gcc-12
x86_64                randconfig-075-20250717    gcc-12
x86_64                randconfig-076-20250717    gcc-12
x86_64                randconfig-077-20250717    gcc-12
x86_64                randconfig-078-20250717    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250717    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

