Return-Path: <linux-pm+bounces-16300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D79AC99D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 14:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A48B21749
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567371AB6E9;
	Wed, 23 Oct 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbgVu3ke"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391C19F13C
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684972; cv=none; b=lyeZJF3pbfNpVfslDW1wNaQMKG+GkZqlSoCXpp3xxTgjIJjWz1y8sVembNC+AStmDJdJQfPzSYTCogpzlIVhBmqQ+iUd6j6mOKU3ZXt1rbyb7K3c3OLVF+TsQKlal7jllpSvgWBUY/Lp3zqBB2wyBPMf5O8PlR0l979SftJuIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684972; c=relaxed/simple;
	bh=NNuPR42RIaBY9qAbmW3VqRHHDE64N6oi/OveBL9G8wU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gRg8FbLmamlwtWJbUdXGb9//1NbGJVnOH9UDFN9jvdpJuOgToLDHhJ9oFvRNJLHuW/b0rvs6WT0dUHINUORUqyTQw52hUQB83URQFZH3cYkx6TC+BV8z9yn9Cu8gbubKMKSTXlbK5d3kMYDrWyhvpH3bO/FzlPDEy/4ZtRMlqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbgVu3ke; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729684970; x=1761220970;
  h=date:from:to:cc:subject:message-id;
  bh=NNuPR42RIaBY9qAbmW3VqRHHDE64N6oi/OveBL9G8wU=;
  b=ZbgVu3kefggHdT9j4U78H/d2Y8wabrn6EJCkVrXtGwTJxLESg1Nt6P0n
   Gj6KSxnunnm5IN5zVQHVB/AINF/aNJHYRtXzBISF9ZDquHAcC1KIDq76z
   HOwk1mvDR3CUwybkzuIFXRKoqeFVM4xfevd0RbxhapBwVh9WMOd47oPqo
   nFNNylY/60nWLk8Q3inCUo4Vfq4MLnTkw0btvgcBGahNz/TTCY6NkpZCt
   FWZK59KmL9lY3PmBeUMvgj5GFdbvoxg2FYF9f4Ika0zlv7ify3wYuAm+i
   hEdFlCnX1PKG1RLXFVHK4eURhvL98QOxRTEYSWKHBdCh9H45aOCZ8VNkX
   w==;
X-CSE-ConnectionGUID: krQ1Uk6WTdK8Z+QdjO2Bww==
X-CSE-MsgGUID: RH+DQNbqQYiPt2emnZaQ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46750650"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46750650"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:02:49 -0700
X-CSE-ConnectionGUID: A6xIUG0ET5+u6ogowGuNew==
X-CSE-MsgGUID: NuDnLNcFReKdsrNVuaKFBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="79748566"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2024 05:02:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3a4c-000Ury-2C;
	Wed, 23 Oct 2024 12:02:46 +0000
Date: Wed, 23 Oct 2024 20:02:28 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 7027b415ff1a4184b99055f11455d5c7041aa3ee
Message-ID: <202410232020.BJMoaEAY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 7027b415ff1a4184b99055f11455d5c7041aa3ee  cpufreq/amd-pstate-ut: Add fix for min freq unit test

elapsed time: 863m

configs tested: 138
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
arc                          axs103_defconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    clang-20
arm                        shmobile_defconfig    clang-20
arm                    vt8500_v6_v7_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241023    clang-18
i386        buildonly-randconfig-002-20241023    clang-18
i386        buildonly-randconfig-003-20241023    clang-18
i386        buildonly-randconfig-004-20241023    clang-18
i386        buildonly-randconfig-005-20241023    clang-18
i386        buildonly-randconfig-006-20241023    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241023    clang-18
i386                  randconfig-002-20241023    clang-18
i386                  randconfig-003-20241023    clang-18
i386                  randconfig-004-20241023    clang-18
i386                  randconfig-005-20241023    clang-18
i386                  randconfig-006-20241023    clang-18
i386                  randconfig-011-20241023    clang-18
i386                  randconfig-012-20241023    clang-18
i386                  randconfig-013-20241023    clang-18
i386                  randconfig-014-20241023    clang-18
i386                  randconfig-015-20241023    clang-18
i386                  randconfig-016-20241023    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             alldefconfig    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    clang-20
m68k                                defconfig    gcc-14.1.0
m68k                           sun3_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    clang-20
mips                            gpr_defconfig    clang-20
mips                           ip28_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       holly_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-20
sh                          kfr2r09_defconfig    clang-20
sh                           se7724_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241023    gcc-12
x86_64      buildonly-randconfig-002-20241023    gcc-12
x86_64      buildonly-randconfig-003-20241023    gcc-12
x86_64      buildonly-randconfig-004-20241023    gcc-12
x86_64      buildonly-randconfig-005-20241023    gcc-12
x86_64      buildonly-randconfig-006-20241023    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241023    gcc-12
x86_64                randconfig-002-20241023    gcc-12
x86_64                randconfig-003-20241023    gcc-12
x86_64                randconfig-004-20241023    gcc-12
x86_64                randconfig-005-20241023    gcc-12
x86_64                randconfig-006-20241023    gcc-12
x86_64                randconfig-011-20241023    gcc-12
x86_64                randconfig-012-20241023    gcc-12
x86_64                randconfig-013-20241023    gcc-12
x86_64                randconfig-014-20241023    gcc-12
x86_64                randconfig-015-20241023    gcc-12
x86_64                randconfig-016-20241023    gcc-12
x86_64                randconfig-071-20241023    gcc-12
x86_64                randconfig-072-20241023    gcc-12
x86_64                randconfig-073-20241023    gcc-12
x86_64                randconfig-074-20241023    gcc-12
x86_64                randconfig-075-20241023    gcc-12
x86_64                randconfig-076-20241023    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

