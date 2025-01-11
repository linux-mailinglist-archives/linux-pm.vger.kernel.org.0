Return-Path: <linux-pm+bounces-20277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D894DA0A4ED
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05FE166403
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94315098F;
	Sat, 11 Jan 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCaA5Dd2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD40EBE
	for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736614941; cv=none; b=lkP/4EGT6HdgQxWvi7RVakiYTD86okcgSbXVP+H200JPFFvs8HxerKAVp4qwPbrbmwJQi+3uhIWVPUpsqd8g2rfFJhwzfCmSKtzZYLxjNZfdf7eDLjhtpSMvEMHfgJHrGKTvg+3NPP+dnhWsj7TWADqEPunc+pMyWdLnxEhls+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736614941; c=relaxed/simple;
	bh=2MpVhUBo65+pFfDwUrq+kdlcgJ+xdU2daajaW8CWEyk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TAIcb+0vJACCazhxQdXZbasCpbnyn+tX3NmPa7mPD7VQts9humO6kC078PKX/nthpdGFFrrRhr+/Pxf1kGMxdIyD5xQnCp+/ZYyjsLzD/oB+wnfOUZc3xycutO8dcWFStRb1ULvOnsoZYyPQPqyQV1dfDBPe9L/cPr/WKRxkHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCaA5Dd2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736614940; x=1768150940;
  h=date:from:to:cc:subject:message-id;
  bh=2MpVhUBo65+pFfDwUrq+kdlcgJ+xdU2daajaW8CWEyk=;
  b=GCaA5Dd2TzmO0VJQPPPFgR621NU569lrsb3F1IaxOF/Q5xnRCHszG2gL
   nVsW8Ga1xtzUb6Am3WFMnOyTzGhRGS4Y5VDUrKx3p8NlYAyNz+8M6W8j7
   hqWgEyr1LhOr5EERCrcSR2mTDfz0MMQ0oHxUPIWFcez6x/OfKBEjw5jzd
   jRLnRjHqbaXMMderHopQt7X8OF7dLej9I0O9tCpp1EvK6OD5LiZBeqnUK
   WVDU5CC6NWpAElWDP6eJQqfeQUA6fy9u/skZbEAU95nmkTklBASj4dd9+
   L3RwjRwcRRYIPcls1pVo5Fp/TUTRm//H+pDv1PGIstvF35CKJonOwusxr
   Q==;
X-CSE-ConnectionGUID: XRkHhp7wR0iG6jpRxIicrA==
X-CSE-MsgGUID: hNuBvvPQSpW7iOGlsWrOlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="47467663"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="47467663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 09:02:19 -0800
X-CSE-ConnectionGUID: k+LVTcnNQxmhD535algZOw==
X-CSE-MsgGUID: Mw7oC0sMTa2VirB1fyW7oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104889581"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Jan 2025 09:02:17 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWesJ-000L0h-0K;
	Sat, 11 Jan 2025 17:02:15 +0000
Date: Sun, 12 Jan 2025 01:02:07 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 0cdfb4ad0b2af2409d833e7705a2cd53ab03775d
Message-ID: <202501120100.toSfoKzy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 0cdfb4ad0b2af2409d833e7705a2cd53ab03775d  cpufreq/amd-pstate: Fix per-policy boost flag incorrect when fail

elapsed time: 1441m

configs tested: 73
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250111    gcc-13.2.0
arc                  randconfig-001-20250112    gcc-13.2.0
arc                  randconfig-002-20250111    gcc-13.2.0
arc                  randconfig-002-20250112    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250111    clang-16
arm                  randconfig-001-20250112    clang-20
arm                  randconfig-002-20250111    gcc-14.2.0
arm                  randconfig-002-20250112    gcc-14.2.0
arm                  randconfig-003-20250111    clang-20
arm                  randconfig-004-20250111    clang-20
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250111    gcc-14.2.0
arm64                randconfig-002-20250111    clang-20
arm64                randconfig-003-20250111    clang-18
arm64                randconfig-004-20250111    clang-16
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250111    gcc-14.2.0
csky                 randconfig-002-20250111    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20250111    clang-20
hexagon              randconfig-002-20250111    clang-15
i386       buildonly-randconfig-001-20250111    gcc-12
i386       buildonly-randconfig-002-20250111    gcc-11
i386       buildonly-randconfig-003-20250111    gcc-12
i386       buildonly-randconfig-004-20250111    gcc-12
i386       buildonly-randconfig-005-20250111    gcc-12
i386       buildonly-randconfig-006-20250111    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250111    gcc-14.2.0
loongarch            randconfig-002-20250111    gcc-14.2.0
nios2                randconfig-001-20250111    gcc-14.2.0
nios2                randconfig-002-20250111    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250111    gcc-14.2.0
parisc               randconfig-002-20250111    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250111    gcc-14.2.0
powerpc              randconfig-002-20250111    gcc-14.2.0
powerpc              randconfig-003-20250111    gcc-14.2.0
powerpc64            randconfig-001-20250111    gcc-14.2.0
powerpc64            randconfig-002-20250111    gcc-14.2.0
powerpc64            randconfig-003-20250111    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250111    clang-18
riscv                randconfig-002-20250111    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250111    clang-20
s390                 randconfig-002-20250111    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250111    gcc-14.2.0
sh                   randconfig-002-20250111    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250111    gcc-14.2.0
sparc                randconfig-002-20250111    gcc-14.2.0
sparc64              randconfig-001-20250111    gcc-14.2.0
sparc64              randconfig-002-20250111    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250111    clang-18
um                   randconfig-002-20250111    clang-20
x86_64     buildonly-randconfig-001-20250111    clang-19
x86_64     buildonly-randconfig-002-20250111    gcc-12
x86_64     buildonly-randconfig-003-20250111    gcc-12
x86_64     buildonly-randconfig-004-20250111    clang-19
x86_64     buildonly-randconfig-005-20250111    gcc-12
x86_64     buildonly-randconfig-006-20250111    gcc-12
xtensa               randconfig-001-20250111    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

