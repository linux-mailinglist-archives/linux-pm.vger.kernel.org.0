Return-Path: <linux-pm+bounces-13559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B696BB62
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E391F24F40
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F01D460A;
	Wed,  4 Sep 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrgAySpb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838B1D094E
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451217; cv=none; b=BUPiM5W4D/khuX2YVLwrctoFyUUSuQUmzigJjRgmyf+JVpyJIKA9+Y5QV6ITgxQ3lNM5jLNTBraWLVRtd++9Z5+MxzzM7/KRnRj4l7DfM1ONPO90uemt7l+/qyXuVLW5WJDPv/TpPCjBzUAtPNiqHC8vo3ikhmlG6rMhqTPOzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451217; c=relaxed/simple;
	bh=4++1cMhxBFl84HGErRpqlQZjN0L55ZcqgklYJrss5kQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y5S4tOMHMc+FqPcJVPkJeUkJv/AGoPM2POreP6GF26E6zH7j4tUpKIZzPMuIgB7oJglpDWysjhdDgm03O0rofmF0I2bvSNW//szwsiPe8bs80NiJTtGaze8GNykVd1nCsw5JZwU2c/AcJOX3aceZj5gk0HjDhSDPt9iQrlSwopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrgAySpb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725451215; x=1756987215;
  h=date:from:to:cc:subject:message-id;
  bh=4++1cMhxBFl84HGErRpqlQZjN0L55ZcqgklYJrss5kQ=;
  b=IrgAySpbFBr9zmTLUd/KJT6n7+XQk9F+oHBsuOVsocnbdkDUfi78XcNr
   45RzfPYCq7Wx0PN86LgEojsDcSWWrnGSIBTh4th7dQxDySxdoaHvcJGvy
   mlIPqfVy97z73EF9l2hmNqSej3+ZdwIMYIlNq0ez4T+HszNrCcQldrUW/
   2TqVg+0YGnX/YRoOgUstOWQd5PpeEEGMY24kz6kCo1SHKxRZt2u16j1mP
   p4+kA04iQka+I46hVGdSYrrQRFlueY4VepQTaYBOXZ7NzmcMsJq+lSSzK
   N36I8Qq+lDX0ArsqOcSHD/AYJiJ0Mzy8mpXNaAfCnVF3o0e/gCTB7eYI6
   Q==;
X-CSE-ConnectionGUID: n3pHoDQCQQK0vSABfu7DKg==
X-CSE-MsgGUID: q2EeiK+9QZO4M5GkVN/ZaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34768017"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="34768017"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:00:15 -0700
X-CSE-ConnectionGUID: 1BcM1H4gTfW1WAq6OuzVTA==
X-CSE-MsgGUID: 6yfq+IgPRbGQoB/+I+t26g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="70117207"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2024 05:00:12 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slogC-0007w7-2z;
	Wed, 04 Sep 2024 12:00:08 +0000
Date: Wed, 04 Sep 2024 19:59:14 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 aa9b87e442c0f457aba83ab6421a3d19a2821c30
Message-ID: <202409041912.sc9WcsNl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: aa9b87e442c0f457aba83ab6421a3d19a2821c30  cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit()

elapsed time: 1220m

configs tested: 110
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         socfpga_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240904   gcc-12
i386         buildonly-randconfig-002-20240904   gcc-12
i386         buildonly-randconfig-003-20240904   gcc-12
i386         buildonly-randconfig-004-20240904   gcc-12
i386         buildonly-randconfig-005-20240904   gcc-12
i386         buildonly-randconfig-006-20240904   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240904   gcc-12
i386                  randconfig-002-20240904   gcc-12
i386                  randconfig-004-20240904   gcc-12
i386                  randconfig-005-20240904   gcc-12
i386                  randconfig-006-20240904   gcc-12
i386                  randconfig-011-20240904   gcc-12
i386                  randconfig-012-20240904   gcc-12
i386                  randconfig-013-20240904   gcc-12
i386                  randconfig-014-20240904   gcc-12
i386                  randconfig-015-20240904   gcc-12
i386                  randconfig-016-20240904   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           gcw0_defconfig   gcc-14.1.0
mips                           ip28_defconfig   gcc-14.1.0
mips                           jazz_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-14.1.0
powerpc                          g5_defconfig   gcc-14.1.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

