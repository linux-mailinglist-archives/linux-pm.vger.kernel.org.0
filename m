Return-Path: <linux-pm+bounces-10243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E191CF03
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 22:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF8E281F6C
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 20:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE97F483;
	Sat, 29 Jun 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAlEUmQB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AB38F97
	for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719692597; cv=none; b=vDXDvn3zf2VwbqqMgl1o3cPN4Kkc2M5Rl8555UNdk9ysW2zPnTbYeCIODLpiURhRJnuyu8ql3nc/FaqXvdQnJxAqfOkr0C7BQensnV3rI72I9+RsLjdHvT0yUUxLslPMWKSJFYKMtHKYWaKrpQL3TNL1+6Ewb8WSbK2MB4M8X50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719692597; c=relaxed/simple;
	bh=XXZXfQS+1pQwgd9kdAbs92yML70KLyy9VeeYqiS58o4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CDw9RV4vNG0CLx0l/Uvyl5iYmtFnFzNo5V66zZJBbr8pgWHQHUm1msGAOgitOjl6fk9R8k/WK8RFpBaGRjRInTbwMGWfyD8PFSCq+dhbgUZxwuQuoBjrY2Mun72iSexQLKpyH60zfBYzPZYRs1dJRdyF8QiyVPaYNlGjM+gGJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAlEUmQB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719692595; x=1751228595;
  h=date:from:to:cc:subject:message-id;
  bh=XXZXfQS+1pQwgd9kdAbs92yML70KLyy9VeeYqiS58o4=;
  b=hAlEUmQB7Rlt4F0Xbqr6bSYpSVWsYz9eMXrhUPo6Fp/LkSiKRyazAkel
   sqhfyXhJUCox1KwySduu2h4YtyMvEWyuvUm9eJt1OCDpgxL4ftF8n7wgU
   Q3onNbTcvcjeNMVtIH8Ew8YMMwlOKaOh67L5ZMp1rAEQh3y+E6FbCmgle
   mCaTpwPGopbhMgFOe6hj+XXUkO/ucutJsRzfUR7UH3CzV1zQupD6/glbt
   fiCyTQRtx8n/RzBJCteBp1f5U2RC1yvxWt/udFBacr1BjoyFLkrVO5Njc
   1lEsCkrTb+Qsz7tcvt8dLdsR0tl06rJ1h/YcG+Cp7otYkDBAMoIK3thBo
   A==;
X-CSE-ConnectionGUID: hX+tGIr0Sh6HHzftkVCgQA==
X-CSE-MsgGUID: oyfujDdkTYmv2KQI+ep35w==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="42273762"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="42273762"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 13:23:14 -0700
X-CSE-ConnectionGUID: 2a70Om+OSOWg/2pNQOSLWQ==
X-CSE-MsgGUID: /4FPupyoQHW2zc4bJCp9sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45150138"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jun 2024 13:23:13 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNebH-000KGB-0Q;
	Sat, 29 Jun 2024 20:23:11 +0000
Date: Sun, 30 Jun 2024 04:22:36 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 b476b2371118da13ccf5d593483b142d99c60ef1
Message-ID: <202406300435.ttA5onUD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: b476b2371118da13ccf5d593483b142d99c60ef1  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method

elapsed time: 5192m

configs tested: 64
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                          collie_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                       imx_v6_v7_defconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   clang-19
arm64                            alldefconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   clang-19
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
hexagon               randconfig-001-20240628   clang-19
hexagon               randconfig-002-20240628   clang-19
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   clang-19
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                  randconfig-001-20240628   clang-19
s390                  randconfig-002-20240628   clang-19
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                    randconfig-001-20240628   gcc-13
um                    randconfig-002-20240628   clang-19
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

