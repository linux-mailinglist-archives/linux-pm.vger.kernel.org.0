Return-Path: <linux-pm+bounces-16442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9B9AFF69
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 12:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A41C22638
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE191D9A76;
	Fri, 25 Oct 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3/sYVwc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E41D47D7
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850520; cv=none; b=uY++CLqNjCH8h+zlhX/IcJasulp/h4Ly2ikpzdNadLXv8OFafcFtQmxEevGOR+34zt3TeqiAbobm9uwxZvk67vvFNlzqdfu99MsfwfeYZToZtKlFPHOhPPTUYv1OZ4VIaOGER8AQEkvRjcvKDxW4BCByiOlpCR+GP21CvT5I5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850520; c=relaxed/simple;
	bh=+wqKK4rQJfdQrt0fVnLwxgTp1JgH2XkHfZmnb4G8SzM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HU1IUy4hnl8/kLgmrQwcX+4Z69kXYRPMkNYEQjX2AqGwQVJgspFqqPtpU5yLKIE+WV5rYKWRIMkjybHEx6XFLp2bknPF48lNX49A/5Q/APTcQHxC5dzodF/ZEVHMnYBMYoW/4n2a5PFTKcpKsSX0NJiKR9mcJ7HWglXbfpsx5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3/sYVwc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729850518; x=1761386518;
  h=date:from:to:cc:subject:message-id;
  bh=+wqKK4rQJfdQrt0fVnLwxgTp1JgH2XkHfZmnb4G8SzM=;
  b=C3/sYVwcktKUS6Xl/ZN5OqIdEsZciqyUpDemLGrt5N/BksxGleH9gVPT
   HOVIGN1+4eSk4IBq+q7IeMmitKm3Lah7tJWDhD/phmOYS9Ewy2aLp/mCK
   B8nIy5wVX02sGrz4V4dpb3CWSR6uxD7EemHOFTbinesvRnA2vUn2qWFdw
   igiuRyjHYrg5zA123lRK6a2/Umor+Gxli57ySuwvgDRV61uRfJIg65mk0
   R3HKVhkc+P2gEAuOiInnLg2glXsX23NZOWAIWOdd97Dl9Dj55Y1hGGN79
   1/WypxBDpPTB6PJjldOOqwRAibamQXh8qhzGDYQSX8TFjlemDedaV2tNK
   Q==;
X-CSE-ConnectionGUID: LCXEkZgSQR2bj8KTt8viYg==
X-CSE-MsgGUID: huBxHuUDT2eNnAdBY+hkKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40130752"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40130752"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 03:01:57 -0700
X-CSE-ConnectionGUID: /fIetxQ9Sly7Oi0m4ft7ng==
X-CSE-MsgGUID: eR5XD5xJQceZlkvjjNM4TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81191562"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Oct 2024 03:01:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4H8j-000Y1Y-2Q;
	Fri, 25 Oct 2024 10:01:53 +0000
Date: Fri, 25 Oct 2024 18:01:25 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 04b62d25c211bfeb9def1e984ef370b8d58419ef
Message-ID: <202410251816.pJ6o5dTY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 04b62d25c211bfeb9def1e984ef370b8d58419ef  cpufreq/amd-pstate: Align offline flow of shared memory and MSR based systems

elapsed time: 1219m

configs tested: 189
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241025    gcc-14.1.0
arc                   randconfig-002-20241025    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       multi_v4t_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm                   randconfig-001-20241025    gcc-14.1.0
arm                   randconfig-002-20241025    gcc-14.1.0
arm                   randconfig-003-20241025    gcc-14.1.0
arm                   randconfig-004-20241025    gcc-14.1.0
arm                           sama5_defconfig    clang-20
arm                        vexpress_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241025    gcc-14.1.0
arm64                 randconfig-002-20241025    gcc-14.1.0
arm64                 randconfig-003-20241025    gcc-14.1.0
arm64                 randconfig-004-20241025    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241025    gcc-14.1.0
csky                  randconfig-002-20241025    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241025    gcc-14.1.0
hexagon               randconfig-002-20241025    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241025    gcc-12
i386        buildonly-randconfig-002-20241025    gcc-12
i386        buildonly-randconfig-003-20241025    gcc-12
i386        buildonly-randconfig-004-20241025    gcc-12
i386        buildonly-randconfig-005-20241025    gcc-12
i386        buildonly-randconfig-006-20241025    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241025    gcc-12
i386                  randconfig-002-20241025    gcc-12
i386                  randconfig-003-20241025    gcc-12
i386                  randconfig-004-20241025    gcc-12
i386                  randconfig-005-20241025    gcc-12
i386                  randconfig-006-20241025    gcc-12
i386                  randconfig-011-20241025    gcc-12
i386                  randconfig-012-20241025    gcc-12
i386                  randconfig-013-20241025    gcc-12
i386                  randconfig-014-20241025    gcc-12
i386                  randconfig-015-20241025    gcc-12
i386                  randconfig-016-20241025    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241025    gcc-14.1.0
loongarch             randconfig-002-20241025    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    clang-20
m68k                       m5475evb_defconfig    clang-20
m68k                        stmark2_defconfig    clang-20
m68k                           sun3_defconfig    clang-20
microblaze                       alldefconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    clang-20
mips                         bigsur_defconfig    clang-20
mips                         db1xxx_defconfig    clang-20
mips                           gcw0_defconfig    clang-20
mips                            gpr_defconfig    clang-20
mips                        omega2p_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241025    gcc-14.1.0
nios2                 randconfig-002-20241025    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241025    gcc-14.1.0
parisc                randconfig-002-20241025    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      cm5200_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc               randconfig-001-20241025    gcc-14.1.0
powerpc               randconfig-002-20241025    gcc-14.1.0
powerpc               randconfig-003-20241025    gcc-14.1.0
powerpc                     tqm5200_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc64             randconfig-001-20241025    gcc-14.1.0
powerpc64             randconfig-002-20241025    gcc-14.1.0
powerpc64             randconfig-003-20241025    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241025    gcc-14.1.0
riscv                 randconfig-002-20241025    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241025    gcc-14.1.0
s390                  randconfig-002-20241025    gcc-14.1.0
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241025    gcc-14.1.0
sh                    randconfig-002-20241025    gcc-14.1.0
sh                      rts7751r2d1_defconfig    clang-20
sh                           se7619_defconfig    clang-20
sh                           se7705_defconfig    clang-20
sh                  sh7785lcr_32bit_defconfig    clang-20
sh                             shx3_defconfig    clang-20
sh                              ul2_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241025    gcc-14.1.0
sparc64               randconfig-002-20241025    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241025    gcc-14.1.0
um                    randconfig-002-20241025    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241025    gcc-12
x86_64      buildonly-randconfig-002-20241025    gcc-12
x86_64      buildonly-randconfig-003-20241025    gcc-12
x86_64      buildonly-randconfig-004-20241025    gcc-12
x86_64      buildonly-randconfig-005-20241025    gcc-12
x86_64      buildonly-randconfig-006-20241025    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241025    gcc-12
x86_64                randconfig-002-20241025    gcc-12
x86_64                randconfig-003-20241025    gcc-12
x86_64                randconfig-004-20241025    gcc-12
x86_64                randconfig-005-20241025    gcc-12
x86_64                randconfig-006-20241025    gcc-12
x86_64                randconfig-011-20241025    gcc-12
x86_64                randconfig-012-20241025    gcc-12
x86_64                randconfig-013-20241025    gcc-12
x86_64                randconfig-014-20241025    gcc-12
x86_64                randconfig-015-20241025    gcc-12
x86_64                randconfig-016-20241025    gcc-12
x86_64                randconfig-071-20241025    gcc-12
x86_64                randconfig-072-20241025    gcc-12
x86_64                randconfig-073-20241025    gcc-12
x86_64                randconfig-074-20241025    gcc-12
x86_64                randconfig-075-20241025    gcc-12
x86_64                randconfig-076-20241025    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  cadence_csp_defconfig    clang-20
xtensa                randconfig-001-20241025    gcc-14.1.0
xtensa                randconfig-002-20241025    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

