Return-Path: <linux-pm+bounces-15154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABAE990601
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041471C21647
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D32D217301;
	Fri,  4 Oct 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsYqLAfQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BABF215F6D
	for <linux-pm@vger.kernel.org>; Fri,  4 Oct 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051986; cv=none; b=IyDfj7iJDGk9a3N46W4HAaM0HXahNg3U5cbn1MQYLe5O/3FL9+/3Q0GhPjfbzWIq5ImQTEX2gdmIVtnSXLlypaLyLauH/zgFl7AU3CsO/PYPvnKLUqtmAFHAggd/apOByNoY9iIKBEi0+H/O66ynFFP62rDlmGlDDFNxfxQYsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051986; c=relaxed/simple;
	bh=OniCCagBNPfRNj6k5Rn3A4QkZwPjX2eFp1bk42XHG60=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PPFaUUdecDMgsOFCYuO/ww7PTEaJUuUnWSnO2jzUVfQtDK+1vRAcLVHj85rAX3TDRRBWXhU4i+cBCOF0q85FynPzlwZfOzGEwhm9CQitK/QgyV/JfEWaKsJ634/eusMRzxLgBEmtk0leaogUxVVCykNYtYatuiH7XWoB/pLewS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsYqLAfQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728051984; x=1759587984;
  h=date:from:to:cc:subject:message-id;
  bh=OniCCagBNPfRNj6k5Rn3A4QkZwPjX2eFp1bk42XHG60=;
  b=ZsYqLAfQD1hdVlNrPnT3Y9XnXylWk7CejSr7cfClH1iXzkdbpDCDRCDH
   lbZsXpvUWpxYL0/O5yQOx5TPRkcjtZ/4dGZZFIBTfpGXJOLYZ+u+sINN6
   +MEhVNN1L0BShr7FQjkDXnQtAkpWDdsPnXeo8QxX6NTXx55swAWQQmCmx
   CAGlFQkR2juA8LtZ4qJUPvEQ+3nDf5cc31DXmW0bf3pEVYq+jxcrN9yqJ
   jQGPZAw7A9ubWf6D6gb34mSjTda01MdWJ/rciFmz9Rn2erp5twN45M3C6
   xa/T8ay/m0YK2HPswhnGO+NbinUJEidIaXdy3wsVKeg3dh6X7RtgwnEvT
   A==;
X-CSE-ConnectionGUID: z5eu9e/uRsmscrXNU251ww==
X-CSE-MsgGUID: NEGwIORPTXiLwWoLNIdqoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27160239"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27160239"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:26:23 -0700
X-CSE-ConnectionGUID: 5p5n0adFQv6kJeFc/G2tWA==
X-CSE-MsgGUID: SbQ+9JWFS+e63U+1ez5USw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74974305"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Oct 2024 07:26:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swjG7-0001kw-2i;
	Fri, 04 Oct 2024 14:26:19 +0000
Date: Fri, 04 Oct 2024 22:25:46 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 b65a151bbff006a2e85a34d7306f6c6c0e76a528
Message-ID: <202410042231.0tsah8Wp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: b65a151bbff006a2e85a34d7306f6c6c0e76a528  cpufreq/amd-pstate: Cleanup the old min_freq qos request remnants

elapsed time: 1127m

configs tested: 156
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
arc                   randconfig-001-20241004    gcc-14.1.0
arc                   randconfig-002-20241004    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                   randconfig-001-20241004    gcc-14.1.0
arm                   randconfig-002-20241004    gcc-14.1.0
arm                   randconfig-003-20241004    gcc-14.1.0
arm                   randconfig-004-20241004    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241004    gcc-14.1.0
arm64                 randconfig-002-20241004    gcc-14.1.0
arm64                 randconfig-003-20241004    gcc-14.1.0
arm64                 randconfig-004-20241004    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241004    gcc-14.1.0
csky                  randconfig-002-20241004    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241004    gcc-14.1.0
hexagon               randconfig-002-20241004    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241004    clang-18
i386        buildonly-randconfig-002-20241004    clang-18
i386        buildonly-randconfig-003-20241004    clang-18
i386        buildonly-randconfig-004-20241004    clang-18
i386        buildonly-randconfig-005-20241004    clang-18
i386        buildonly-randconfig-006-20241004    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241004    clang-18
i386                  randconfig-002-20241004    clang-18
i386                  randconfig-003-20241004    clang-18
i386                  randconfig-004-20241004    clang-18
i386                  randconfig-005-20241004    clang-18
i386                  randconfig-006-20241004    clang-18
i386                  randconfig-011-20241004    clang-18
i386                  randconfig-012-20241004    clang-18
i386                  randconfig-013-20241004    clang-18
i386                  randconfig-014-20241004    clang-18
i386                  randconfig-015-20241004    clang-18
i386                  randconfig-016-20241004    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241004    gcc-14.1.0
loongarch             randconfig-002-20241004    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241004    gcc-14.1.0
nios2                 randconfig-002-20241004    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241004    gcc-14.1.0
parisc                randconfig-002-20241004    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc               randconfig-001-20241004    gcc-14.1.0
powerpc               randconfig-002-20241004    gcc-14.1.0
powerpc               randconfig-003-20241004    gcc-14.1.0
powerpc64             randconfig-001-20241004    gcc-14.1.0
powerpc64             randconfig-002-20241004    gcc-14.1.0
powerpc64             randconfig-003-20241004    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241004    gcc-14.1.0
riscv                 randconfig-002-20241004    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241004    gcc-14.1.0
s390                  randconfig-002-20241004    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241004    gcc-14.1.0
sh                    randconfig-002-20241004    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241004    gcc-14.1.0
sparc64               randconfig-002-20241004    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241004    gcc-14.1.0
um                    randconfig-002-20241004    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241004    clang-18
x86_64      buildonly-randconfig-002-20241004    clang-18
x86_64      buildonly-randconfig-003-20241004    clang-18
x86_64      buildonly-randconfig-004-20241004    clang-18
x86_64      buildonly-randconfig-005-20241004    clang-18
x86_64      buildonly-randconfig-006-20241004    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241004    clang-18
x86_64                randconfig-002-20241004    clang-18
x86_64                randconfig-003-20241004    clang-18
x86_64                randconfig-004-20241004    clang-18
x86_64                randconfig-005-20241004    clang-18
x86_64                randconfig-006-20241004    clang-18
x86_64                randconfig-011-20241004    clang-18
x86_64                randconfig-012-20241004    clang-18
x86_64                randconfig-013-20241004    clang-18
x86_64                randconfig-014-20241004    clang-18
x86_64                randconfig-015-20241004    clang-18
x86_64                randconfig-016-20241004    clang-18
x86_64                randconfig-071-20241004    clang-18
x86_64                randconfig-072-20241004    clang-18
x86_64                randconfig-073-20241004    clang-18
x86_64                randconfig-074-20241004    clang-18
x86_64                randconfig-075-20241004    clang-18
x86_64                randconfig-076-20241004    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241004    gcc-14.1.0
xtensa                randconfig-002-20241004    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

