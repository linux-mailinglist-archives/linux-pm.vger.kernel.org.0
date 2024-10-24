Return-Path: <linux-pm+bounces-16339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B0E9ADAF6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 06:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466D61C21A19
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 04:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B82616130C;
	Thu, 24 Oct 2024 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuWUTN9z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607EBA4B
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744418; cv=none; b=ccES6mTHXuDQU1B8DkzA+/TDAnvWztGYQzzQC5uAgShDOFmt2ahQ3oux928vrJhM4kj48w/HuWcReDz18rnXo3tbaUL+ksr1POiK8nhDibShg8pch53ybWqTWiAhYItVxK/43BJaUhOUzqtR9wm7ypn3vfJAPkAO2Rw1x7FmkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744418; c=relaxed/simple;
	bh=aiG3SbuKeJVKFswLCNh+I9+gRFG2zqSfHBNbowAYaNE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BjuCs9PcrpQNgZYbl9n2bTJTZkgPn6oWs3DSt4gAqXkB0itmf7kBY61jzVWfufMBV/3Zpn9AEoppWmv071nx6v0l8V9GPidAi+oomVPkenkZLeIn//mXl/Wet4SCf3qsdrRJgMUUSyC8MPlBEP0WHZp0t/SL27SEU+z+kPweed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuWUTN9z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729744416; x=1761280416;
  h=date:from:to:cc:subject:message-id;
  bh=aiG3SbuKeJVKFswLCNh+I9+gRFG2zqSfHBNbowAYaNE=;
  b=nuWUTN9zYyubWOHZoBLEVBNjLzhljuqfI3YvGtZ+GmX9STI3npGzVhMm
   IUHfHowLDxlX8lBi7Joy39C39CGGzwwOGELvrg1L+xR0HruVEgNLJlx8A
   0C7hTCJ2ePBygCpezfT41vqqcTj3MVcC2ZNz7iwPop1xJtWiSKf/SGDl2
   vDWxnNF05VVcn3TdiOv8h2YlJiOAAjxJjA6sGlEhG2JKeHdoqV+SnEzI8
   a1xkCRmCzMhrcv6hDDIPuEVBjjfaiMpNmmIaClMKSITF/jGeuaANM6QFF
   mrdkiFY+CUKY+el7Mxi5Xzta8CxoEI1mSnNEAgcUaY6XQXYZ+c5eg170C
   A==;
X-CSE-ConnectionGUID: btxberSVSsGvyEyb2kqCZw==
X-CSE-MsgGUID: upxFPScSQCChrzwSwwNr4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40475235"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40475235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 21:33:35 -0700
X-CSE-ConnectionGUID: /5oWsA5PSvaD4Ea5C2BskQ==
X-CSE-MsgGUID: CadxePHMR2eQV3Xs2BMx+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="103796167"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 23 Oct 2024 21:33:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3pXP-000VwE-1E;
	Thu, 24 Oct 2024 04:33:31 +0000
Date: Thu, 24 Oct 2024 12:32:50 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 c44cd8865138d5ca76d67c0b11679fa0c1dba20d
Message-ID: <202410241243.sFnFoNux-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: c44cd8865138d5ca76d67c0b11679fa0c1dba20d  cpufreq/amd-pstate: Align offline flow of shared memory and MSR based systems

elapsed time: 870m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        spear3xx_defconfig    gcc-14.1.0
arm                           stm32_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                             alldefconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241024    clang-18
i386        buildonly-randconfig-002-20241024    clang-18
i386        buildonly-randconfig-003-20241024    clang-18
i386        buildonly-randconfig-004-20241024    clang-18
i386        buildonly-randconfig-005-20241024    clang-18
i386        buildonly-randconfig-006-20241024    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241024    clang-18
i386                  randconfig-002-20241024    clang-18
i386                  randconfig-003-20241024    clang-18
i386                  randconfig-004-20241024    clang-18
i386                  randconfig-005-20241024    clang-18
i386                  randconfig-006-20241024    clang-18
i386                  randconfig-011-20241024    clang-18
i386                  randconfig-012-20241024    clang-18
i386                  randconfig-013-20241024    clang-18
i386                  randconfig-014-20241024    clang-18
i386                  randconfig-015-20241024    clang-18
i386                  randconfig-016-20241024    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                        edosk7760_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7751_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

