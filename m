Return-Path: <linux-pm+bounces-16682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320869B552A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68391F23C78
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 21:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345A205E0B;
	Tue, 29 Oct 2024 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhEKyn3/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24B1422AB
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237794; cv=none; b=a4YQfvFQWGvMP/XfvodxfDobbTlpL9ZmTuX6ZVSkZS3roq2qMEZ+8wntuuqPjlK8u2Gg9OZjwWVmM4RXnM2wTnGzWyhjR0r6V5AjHO6kemkrZV68Z1J6UK79yJYYpIfmIqcf3AcIrnRmoSgM8FIQ2ldk9fx9fJEN42BZURwhvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237794; c=relaxed/simple;
	bh=1xgch32nqiqMjdmgHjBnXYxWm1h7BMlZNN5uGA4gUdw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b+fFSv+IIlgj2vQOVK/o2LHhFulRJE4r1SdeOYhQBYYLOGUodJd7KiPgYKtLSkkKh4oZ3QVJQ2NEYdFJTWUMdaPyIuxTyd8vutk8UXaPf09FUNww0E7U5F+1hZ3ZUUDAeyE7u43Cj+Wli7YPz2geb8zuQMO1Hv8UjmZabOYHYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhEKyn3/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730237793; x=1761773793;
  h=date:from:to:cc:subject:message-id;
  bh=1xgch32nqiqMjdmgHjBnXYxWm1h7BMlZNN5uGA4gUdw=;
  b=fhEKyn3/4fXkqfz769Scpo4XIK7l1H2DE5fjVEx4fBixNa7j7gZC8Sy/
   jk12OkqCvGxVp608tyPvp5vUbJSJRzRT9REWGFjFQw5bqheqsoqM/yXn1
   WuNbDp9aeWFYvBbHJdg8dNrTjOB0DKuojsFCYe+i1qUYwdzArmyat5nNl
   cqdf123xfkhfHq+5wl5c1UNXS8YJ0rtl3EFncrKz0BkGWqNLrV8xnQjKX
   LpH07TTf3+TCeXDOIbSS3LmGxROhOSGLuO77XbJVhgOeQtyaHdtuZTVW0
   1KirZAwAhiuP5eW14le490XUQlzL8L5Uik51APcIa8H1w6ZmjHj7pezLZ
   g==;
X-CSE-ConnectionGUID: HxqMIrRYQu2Ysq5rglsiOg==
X-CSE-MsgGUID: iwLPyiFXTOSZJ2Hpdv9VcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40440838"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40440838"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 14:36:32 -0700
X-CSE-ConnectionGUID: kg3r01z8QG6D+YJ+ymDGJw==
X-CSE-MsgGUID: DxTm3lowQaGVJZb7WLCQfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82915891"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Oct 2024 14:36:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5tt6-000eB4-0j;
	Tue, 29 Oct 2024 21:36:28 +0000
Date: Wed, 30 Oct 2024 05:35:51 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 e3cea20c2735c3c7d0373ec201d0bfb584617cf1
Message-ID: <202410300545.ztd9fro2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: e3cea20c2735c3c7d0373ec201d0bfb584617cf1  cpufreq/amd-pstate: Move registration after static function call update

elapsed time: 1473m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241029    gcc-13.2.0
arc                   randconfig-002-20241029    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-14.1.0
arm                         nhk8815_defconfig    clang-20
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20241029    gcc-14.1.0
arm                   randconfig-002-20241029    gcc-14.1.0
arm                   randconfig-003-20241029    gcc-14.1.0
arm                   randconfig-004-20241029    clang-16
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241029    clang-17
arm64                 randconfig-002-20241029    clang-20
arm64                 randconfig-003-20241029    gcc-14.1.0
arm64                 randconfig-004-20241029    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241029    gcc-14.1.0
csky                  randconfig-002-20241029    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241029    clang-20
hexagon               randconfig-002-20241029    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241029    clang-19
i386        buildonly-randconfig-002-20241029    gcc-12
i386        buildonly-randconfig-003-20241029    clang-19
i386        buildonly-randconfig-004-20241029    gcc-12
i386        buildonly-randconfig-005-20241029    clang-19
i386        buildonly-randconfig-006-20241029    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241029    gcc-12
i386                  randconfig-002-20241029    gcc-12
i386                  randconfig-003-20241029    gcc-12
i386                  randconfig-004-20241029    clang-19
i386                  randconfig-005-20241029    clang-19
i386                  randconfig-006-20241029    gcc-12
i386                  randconfig-011-20241029    gcc-12
i386                  randconfig-012-20241029    clang-19
i386                  randconfig-013-20241029    clang-19
i386                  randconfig-014-20241029    clang-19
i386                  randconfig-015-20241029    clang-19
i386                  randconfig-016-20241029    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241029    gcc-14.1.0
loongarch             randconfig-002-20241029    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241029    gcc-14.1.0
nios2                 randconfig-002-20241029    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20241029    gcc-14.1.0
parisc                randconfig-002-20241029    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                      mgcoge_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241029    gcc-14.1.0
powerpc               randconfig-002-20241029    clang-20
powerpc               randconfig-003-20241029    gcc-14.1.0
powerpc64             randconfig-001-20241029    gcc-14.1.0
powerpc64             randconfig-002-20241029    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241029    gcc-12
x86_64      buildonly-randconfig-002-20241029    gcc-12
x86_64      buildonly-randconfig-003-20241029    gcc-12
x86_64      buildonly-randconfig-004-20241029    gcc-12
x86_64      buildonly-randconfig-005-20241029    clang-19
x86_64      buildonly-randconfig-006-20241029    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241029    gcc-12
x86_64                randconfig-003-20241029    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                          iss_defconfig    gcc-14.1.0
xtensa                         virt_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

