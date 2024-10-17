Return-Path: <linux-pm+bounces-15840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F88F9A1B34
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 09:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334731C21A78
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 07:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D6119409C;
	Thu, 17 Oct 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dprvIGTR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053416BE0D
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148466; cv=none; b=WxHfXHmZTDjjr5eVr4SCidfG1pqxkHjSNTY8wQjKSEmqn4VfXzhCxcBsuOOll/C218OlASJBM2AnEXxO4mXnkJQsC+I6zmVoLd2gHR9rBCGcHfk6AgA9Lct3LDFIZhtFqc2egoXF9qL0ZnjKXLNykLFC/FYvdokefO7abf1nfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148466; c=relaxed/simple;
	bh=hr5pmqnUersm2DtA7E2JRLBa1JhMZyDBkfPx4gIQICk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rgG7Orhi+i87n7XOPl8Y9gpZtPLRMHe7wi3Q7w/lTFG3WqaReh7gjEKguT0GcMf5SnwGjFBswEM1qX4wLZul1PsUTstsa6WCsLfCuojMgqPkTxXB9LxK07DpbV2wgToMX9SZQYevxjSKMUrL+b0ffiwoUAshoAKdgsQG/L2lEh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dprvIGTR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729148464; x=1760684464;
  h=date:from:to:cc:subject:message-id;
  bh=hr5pmqnUersm2DtA7E2JRLBa1JhMZyDBkfPx4gIQICk=;
  b=dprvIGTRCsUUmQaxYq4thoStihlYfZ9s5H+kDlkTpaAtEv3C5v7b3y7d
   /rI4oMNBoz3VqAHZlCpj2V+xoAXPXZcGWk6g664fHrG10AwEgBmZCIsGr
   X+e6G9GGixGXTBW0rEq3gGPwv1/S9I0kW1K/pv9yTKRmk0M9KPlLpTlF9
   v7GxYUd5HqZEYCtyXSgtz9BnddzatbDoaYQxFm+mDONNrRpbvJBpSxXdG
   Lwrm92hLBEz9DchnYZt5mglFFR//7XJ8cl8Qin8Hcl3UATOqOUSo1M5GH
   43gkiLgN1SkJ2Be5oqGb1bLvoiTqandTz3K3zyi8Fp92lUn5L9zs+t1nK
   g==;
X-CSE-ConnectionGUID: CdiDQv4WQF6W+Z+qIdboaA==
X-CSE-MsgGUID: J1bjPi9JRPKVCitMY0OljQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="16240047"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="16240047"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:01:04 -0700
X-CSE-ConnectionGUID: wySdjFqITaOEGgDo2mwePQ==
X-CSE-MsgGUID: pOPmouSiRkyIvxIDqXEUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83236066"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Oct 2024 00:01:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1KVH-000LqZ-37;
	Thu, 17 Oct 2024 07:00:59 +0000
Date: Thu, 17 Oct 2024 15:00:36 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 18d9b52271213890da295a7c63ef8880ed570cd8
Message-ID: <202410171529.MXHA5P8E-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: 18d9b52271213890da295a7c63ef8880ed570cd8  cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled

elapsed time: 1494m

configs tested: 133
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                         haps_hs_defconfig    clang-14
arc                            hsdk_defconfig    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         axm55xx_defconfig    gcc-14.1.0
arm                            mmp2_defconfig    gcc-14.1.0
arm                       spear13xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241017    clang-18
i386        buildonly-randconfig-002-20241017    clang-18
i386        buildonly-randconfig-003-20241017    clang-18
i386        buildonly-randconfig-004-20241017    clang-18
i386        buildonly-randconfig-005-20241017    clang-18
i386        buildonly-randconfig-006-20241017    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241017    clang-18
i386                  randconfig-002-20241017    clang-18
i386                  randconfig-003-20241017    clang-18
i386                  randconfig-004-20241017    clang-18
i386                  randconfig-005-20241017    clang-18
i386                  randconfig-006-20241017    clang-18
i386                  randconfig-011-20241017    clang-18
i386                  randconfig-012-20241017    clang-18
i386                  randconfig-013-20241017    clang-18
i386                  randconfig-014-20241017    clang-18
i386                  randconfig-015-20241017    clang-18
i386                  randconfig-016-20241017    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                       bvme6000_defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    clang-14
m68k                        m5407c3_defconfig    gcc-14.1.0
m68k                           virt_defconfig    clang-14
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip28_defconfig    clang-14
mips                           ip28_defconfig    gcc-14.1.0
mips                           jazz_defconfig    clang-14
mips                      maltaaprp_defconfig    clang-14
mips                          rb532_defconfig    clang-14
mips                          rb532_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
powerpc                           allnoconfig    clang-20
powerpc                      bamboo_defconfig    clang-14
powerpc                     ksi8560_defconfig    clang-14
powerpc                       maple_defconfig    clang-14
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-14
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    clang-14
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7705_defconfig    clang-14
sh                           se7750_defconfig    clang-14
sh                             sh03_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.1.0
sh                  sh7785lcr_32bit_defconfig    clang-14
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241017    gcc-12
x86_64      buildonly-randconfig-002-20241017    gcc-12
x86_64      buildonly-randconfig-003-20241017    gcc-12
x86_64      buildonly-randconfig-004-20241017    gcc-12
x86_64      buildonly-randconfig-005-20241017    gcc-12
x86_64      buildonly-randconfig-006-20241017    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241017    gcc-12
x86_64                randconfig-002-20241017    gcc-12
x86_64                randconfig-003-20241017    gcc-12
x86_64                randconfig-004-20241017    gcc-12
x86_64                randconfig-005-20241017    gcc-12
x86_64                randconfig-006-20241017    gcc-12
x86_64                randconfig-011-20241017    gcc-12
x86_64                randconfig-012-20241017    gcc-12
x86_64                randconfig-013-20241017    gcc-12
x86_64                randconfig-014-20241017    gcc-12
x86_64                randconfig-015-20241017    gcc-12
x86_64                randconfig-016-20241017    gcc-12
x86_64                randconfig-071-20241017    gcc-12
x86_64                randconfig-072-20241017    gcc-12
x86_64                randconfig-073-20241017    gcc-12
x86_64                randconfig-074-20241017    gcc-12
x86_64                randconfig-075-20241017    gcc-12
x86_64                randconfig-076-20241017    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    clang-14
xtensa                         virt_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

