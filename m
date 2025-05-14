Return-Path: <linux-pm+bounces-27138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92DAB6DC8
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 16:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921701665F2
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6317A2F8;
	Wed, 14 May 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8IF3/AB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5D4A0F
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231476; cv=none; b=JoOWAdfVcRRFZUaWGCBiynFduvV5v8nasr9+/nSjHC/Bb6wenzEmoUmtMLywiFLwZGWA8fg9rszXlagSnBDmXC/nz+gZuD7PSpPVs8p4SdbPL/I1w2Tp9Bro5m4Jy3vIGNdiN99Y1Bv5O+JE8Mhbik31QQYXHk71wese2vMHtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231476; c=relaxed/simple;
	bh=9QHeqssbNLdYmN4DqhelqLqw85qrqvF8ijqFCF/Vo4s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rHH5zkqpR4dwhnipanMhGF/yvVHOhSTOeOeGGLqrw0BHMMVDS2nPlGzSWMR4eD2T1kzcFudtjJCQEZugZCXjaUwyy1T/j97lyIJ1MD782hfiMQRw5FXuOK+GoSu8w0yDIk5SGXK7KIlUGZavg7OAm0mn8nxbtjez0b0hK1Z4xMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8IF3/AB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747231473; x=1778767473;
  h=date:from:to:cc:subject:message-id;
  bh=9QHeqssbNLdYmN4DqhelqLqw85qrqvF8ijqFCF/Vo4s=;
  b=H8IF3/ABrGSadi/gdEXGDNJGGYsLpWVF6Lg+e+6m1T5ydFlQN5rDH4et
   VqCUUSpZer1l3o4kK5XK8EOy0jSpRD15apJo+7S107ve4WHZ9WBxFiiu+
   FygAoSoYYNSyDQ408QptrichRb6jAjDhFmD9xOVAl6ihsnQ1AaK40i6AE
   V0mr/0wWFN9t9sQlXCuxU+pux//SIRJCcBPo5uD2F4x2bcClEjExFXe8w
   LIH2R2lp7hD5cZR/8IOtkP9nyZzd2WQELRYGQnc8tEg7+Ke/MzzA/VDMJ
   v95A/bX9/0pTuyCqwz++KkGYF5AuHmAGoKSq9ktWFK+k+cHLPj1e0TYaH
   g==;
X-CSE-ConnectionGUID: LP0tFBQmTde9+Ged0KkiNA==
X-CSE-MsgGUID: zZThQqFsRdqaVx1np4/NzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66535615"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="66535615"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 07:04:33 -0700
X-CSE-ConnectionGUID: YomNrs9SRqWXgE/+9O0idg==
X-CSE-MsgGUID: ghGgy6zASw2AMKP4SXpGHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="169141109"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 07:04:30 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFCij-000HCN-1X;
	Wed, 14 May 2025 14:04:29 +0000
Date: Wed, 14 May 2025 22:03:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 f6b1eebbdbc75377f98fc9774bb86ffc270dae8e
Message-ID: <202505142239.aKuxzysz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: f6b1eebbdbc75377f98fc9774bb86ffc270dae8e  cpufreq/amd-pstate: Avoid shadowing ret in amd_pstate_ut_check_driver()

elapsed time: 1278m

configs tested: 214
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250514    gcc-13.3.0
arc                   randconfig-002-20250514    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250514    clang-21
arm                   randconfig-002-20250514    clang-21
arm                   randconfig-003-20250514    gcc-7.5.0
arm                   randconfig-004-20250514    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250514    clang-17
arm64                 randconfig-002-20250514    gcc-5.5.0
arm64                 randconfig-003-20250514    gcc-5.5.0
arm64                 randconfig-004-20250514    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250514    gcc-13.3.0
csky                  randconfig-002-20250514    gcc-14.2.0
hexagon                          alldefconfig    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250514    clang-21
hexagon               randconfig-002-20250514    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250514    clang-20
i386        buildonly-randconfig-002-20250514    clang-20
i386        buildonly-randconfig-002-20250514    gcc-12
i386        buildonly-randconfig-003-20250514    clang-20
i386        buildonly-randconfig-004-20250514    clang-20
i386        buildonly-randconfig-005-20250514    clang-20
i386        buildonly-randconfig-005-20250514    gcc-12
i386        buildonly-randconfig-006-20250514    clang-20
i386        buildonly-randconfig-006-20250514    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250514    clang-20
i386                  randconfig-002-20250514    clang-20
i386                  randconfig-003-20250514    clang-20
i386                  randconfig-004-20250514    clang-20
i386                  randconfig-005-20250514    clang-20
i386                  randconfig-006-20250514    clang-20
i386                  randconfig-007-20250514    clang-20
i386                  randconfig-011-20250514    clang-20
i386                  randconfig-012-20250514    clang-20
i386                  randconfig-013-20250514    clang-20
i386                  randconfig-014-20250514    clang-20
i386                  randconfig-015-20250514    clang-20
i386                  randconfig-016-20250514    clang-20
i386                  randconfig-017-20250514    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250514    gcc-14.2.0
loongarch             randconfig-002-20250514    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                          eyeq6_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250514    gcc-7.5.0
nios2                 randconfig-002-20250514    gcc-11.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250514    gcc-12.4.0
parisc                randconfig-002-20250514    gcc-10.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250514    clang-17
powerpc               randconfig-002-20250514    gcc-5.5.0
powerpc               randconfig-003-20250514    gcc-7.5.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250514    gcc-10.5.0
powerpc64             randconfig-002-20250514    clang-19
powerpc64             randconfig-003-20250514    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250514    clang-21
riscv                 randconfig-001-20250514    gcc-7.5.0
riscv                 randconfig-002-20250514    clang-21
riscv                 randconfig-002-20250514    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250514    clang-21
s390                  randconfig-002-20250514    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250514    clang-21
sh                    randconfig-001-20250514    gcc-11.5.0
sh                    randconfig-002-20250514    clang-21
sh                    randconfig-002-20250514    gcc-9.3.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250514    clang-21
sparc                 randconfig-001-20250514    gcc-8.5.0
sparc                 randconfig-002-20250514    clang-21
sparc                 randconfig-002-20250514    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250514    clang-21
sparc64               randconfig-001-20250514    gcc-14.2.0
sparc64               randconfig-002-20250514    clang-21
sparc64               randconfig-002-20250514    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250514    clang-21
um                    randconfig-001-20250514    gcc-12
um                    randconfig-002-20250514    clang-21
um                    randconfig-002-20250514    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250514    clang-20
x86_64      buildonly-randconfig-001-20250514    gcc-12
x86_64      buildonly-randconfig-002-20250514    gcc-12
x86_64      buildonly-randconfig-003-20250514    gcc-12
x86_64      buildonly-randconfig-004-20250514    gcc-12
x86_64      buildonly-randconfig-005-20250514    clang-20
x86_64      buildonly-randconfig-005-20250514    gcc-12
x86_64      buildonly-randconfig-006-20250514    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250514    gcc-12
x86_64                randconfig-002-20250514    gcc-12
x86_64                randconfig-003-20250514    gcc-12
x86_64                randconfig-004-20250514    gcc-12
x86_64                randconfig-005-20250514    gcc-12
x86_64                randconfig-006-20250514    gcc-12
x86_64                randconfig-007-20250514    gcc-12
x86_64                randconfig-008-20250514    gcc-12
x86_64                randconfig-071-20250514    clang-20
x86_64                randconfig-072-20250514    clang-20
x86_64                randconfig-073-20250514    clang-20
x86_64                randconfig-074-20250514    clang-20
x86_64                randconfig-075-20250514    clang-20
x86_64                randconfig-076-20250514    clang-20
x86_64                randconfig-077-20250514    clang-20
x86_64                randconfig-078-20250514    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250514    clang-21
xtensa                randconfig-001-20250514    gcc-10.5.0
xtensa                randconfig-002-20250514    clang-21
xtensa                randconfig-002-20250514    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

