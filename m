Return-Path: <linux-pm+bounces-16051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20F9A5266
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 06:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E3EB2553C
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 04:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79837D299;
	Sun, 20 Oct 2024 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACqYCCKQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD48462
	for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2024 04:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729398018; cv=none; b=cCK0/9dtkrpCJ9WhJ4MYCyS+ZE8QyVv/3MVMWGw3Tu5HGfrmsqBEaNteXPmaQFWx2TNJ5T3+DiKfh+TFWlQBDNzt4DW8GpdIGx1fRHXP01IB4Yd2+KA0ql9FF9tsf8Fg31SBEmA0vFTdXq8n/NxjJ3gGfLHisfLO45gAhASgXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729398018; c=relaxed/simple;
	bh=u2I+7A6+uUhd/2DOuvE8ZklLskNyOEQVzVry6LE/MUE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TnJCIRK4TUZlksOYMIgtNN4DkgRXXS1l3ZXLQjxQ0McizROdA+1xLWTCQ1q7XoM8fX2TsP83PfiI83rrK2ppvdASOppFX0fQWyrMtfHQ38m48zB2NxtlEnWzgzvvaeyHUVhs1nMZ24xiWYwD9kAM2y3Z9pogclpkgx1AV0FPHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACqYCCKQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729398016; x=1760934016;
  h=date:from:to:cc:subject:message-id;
  bh=u2I+7A6+uUhd/2DOuvE8ZklLskNyOEQVzVry6LE/MUE=;
  b=ACqYCCKQfq9EhV9L7n+q9KfSAvVQljcYLtNSGv/GQe7m9nHiHw9PHHMc
   raAmI1XmX720Ftcr1FWxu5HXF20e83EQJQPGv2OhB5yTM7Z/nC6/MOxPk
   pNcRzdsZskOhYy3L8Ewpn9ML+dzpdXWT4+ZrDe0/HX7M86CBxthosrpgb
   2D0Vj8a3OTGhhKf7Uuj6Db38hWGlbx1I9BKs+4Nvsxc4vmLBACsWFitr2
   D0i5S4n12Ic2mzm2GHbCGeX6sdV2FGTsK1oz9O5QpkyYv+RAbp7oDMDaU
   KYxpQvaZhNS45xaxeTpAufQIuv0jPTGtbxuneySR51kDgo80iw8ni9KQf
   w==;
X-CSE-ConnectionGUID: arPzwfrRRA+AxLkNoUueww==
X-CSE-MsgGUID: 5R4FJ43jRjmaBjQhNHkipQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="16521645"
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="16521645"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 21:20:16 -0700
X-CSE-ConnectionGUID: 1AZcucMLQWimGD/riYFnZw==
X-CSE-MsgGUID: jitWcUEtTkSXrX9iomjvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="116685275"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Oct 2024 21:20:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2NQK-000Pt3-1x;
	Sun, 20 Oct 2024 04:20:12 +0000
Date: Sun, 20 Oct 2024 12:19:13 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 7ffa491e59801762e47487ce0d2c784c32ae7b34
Message-ID: <202410201205.6uYhij4W-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 7ffa491e59801762e47487ce0d2c784c32ae7b34  cpufreq/amd-pstate-ut: Add fix for min freq unit test

elapsed time: 3461m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241020    gcc-13.2.0
arc                   randconfig-002-20241020    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20241020    gcc-14.1.0
arm                   randconfig-002-20241020    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241019    gcc-12
i386        buildonly-randconfig-002-20241019    clang-18
i386        buildonly-randconfig-003-20241019    gcc-12
i386        buildonly-randconfig-004-20241019    gcc-12
i386        buildonly-randconfig-005-20241019    clang-18
i386        buildonly-randconfig-006-20241019    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241019    gcc-12
i386                  randconfig-002-20241019    clang-18
i386                  randconfig-003-20241019    gcc-12
i386                  randconfig-004-20241019    clang-18
i386                  randconfig-005-20241019    clang-18
i386                  randconfig-006-20241019    gcc-12
i386                  randconfig-011-20241019    clang-18
i386                  randconfig-012-20241019    clang-18
i386                  randconfig-013-20241019    clang-18
i386                  randconfig-014-20241019    clang-18
i386                  randconfig-015-20241019    gcc-12
i386                  randconfig-016-20241019    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                                allnoconfig    clang-17
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

