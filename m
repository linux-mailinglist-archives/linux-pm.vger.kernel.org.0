Return-Path: <linux-pm+bounces-37746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650EC47615
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 15:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496811891629
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893822652D;
	Mon, 10 Nov 2025 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gotP5fKS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB013A86C
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786740; cv=none; b=TFAaG8DtMYHwLEIPyQ2IDjZDxpKpu487uiszsQO6/NNVxrxNk6bHdSJn5PtJOAZVsEoHnkqUzx/1nFh9wrB+Pohdzm0wGretZ97L2J8m8ZR5RkequvykLEB/MSXA2qAGsDUGVF2fVk61ayNXmG0lmIWiL1ElN/TrDkMTUqfpjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786740; c=relaxed/simple;
	bh=4LMuXpUrx2dCN1Jk8UwtEPs68HOthcK1zm32CaYVElg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DNZZd/Ev0wcRr07t6QHFB3epzCe6K/Q99NfCUG+BJ7wA6h+Pt2hl/W+oYRzwmtmT4mxqg/fig44RZFIxWRS7Vw51W0SqMZmbVm4VDpk9ja7GrI97ogEmQygGw5koiK0TEBOufMkTiApzULQU+kMRU19g8UgFARkRybyM6g7wMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gotP5fKS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762786738; x=1794322738;
  h=date:from:to:cc:subject:message-id;
  bh=4LMuXpUrx2dCN1Jk8UwtEPs68HOthcK1zm32CaYVElg=;
  b=gotP5fKS03XtM/I7TYX3J9CVA/FyAiqw0sE/4dNIj2pxs/8iyIZ6d4dX
   huXC8Rs/vE0KtFM14VDUzcLTdptO7wMAz7BINyyqOT3WAXo+7+/tcMlTT
   Ft8xJdkoeuBxDVGnkUxyp2k5FlguZ4rcpSumAUlVbYxshTs/ELsvdMtX2
   YW/Qsc30Xzgv6ZAV8FeM/EvjxfnPYgg7rZs47fw/uuYX9YLm4xKiy1tt2
   vVy/fi1M01DJ1wq15Hqe7HDoKref7cOtKx3O5+4xedmA7gdFX9r7qLxaX
   oigYpjBPl67hz4ZpC1fMm1Xc/NSC0F9GUW0E8HvnWhWA8ySnXl8mkV4zO
   w==;
X-CSE-ConnectionGUID: EpgFfzwlQ4+LtSpKCbOhrA==
X-CSE-MsgGUID: IaikWNedTLeN1XZ0IehuGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75941242"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75941242"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 06:58:58 -0800
X-CSE-ConnectionGUID: vFXm6JooTuKIcgBa33dSJA==
X-CSE-MsgGUID: 7pie9QSnSTKiRITLDRkPlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193700272"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Nov 2025 06:58:57 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vITM7-0000Zv-07;
	Mon, 10 Nov 2025 14:58:55 +0000
Date: Mon, 10 Nov 2025 22:58:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 8ea7b97f0589d969a991ed1f11f5383080980864
Message-ID: <202511102220.BoswFMSR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 8ea7b97f0589d969a991ed1f11f5383080980864  cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

elapsed time: 2913m

configs tested: 63
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251109    gcc-12.5.0
arc         randconfig-002-20251109    gcc-8.5.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251109    clang-16
arm         randconfig-002-20251109    clang-22
arm         randconfig-003-20251109    clang-22
arm         randconfig-004-20251109    gcc-8.5.0
arm64                   allnoconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-22
hexagon     randconfig-001-20251109    clang-22
hexagon     randconfig-002-20251109    clang-22
i386                    allnoconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251109    clang-22
loongarch   randconfig-002-20251109    gcc-15.1.0
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251109    gcc-11.5.0
nios2       randconfig-002-20251109    gcc-8.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc      randconfig-001-20251109    gcc-9.5.0
parisc      randconfig-002-20251109    gcc-13.4.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc     randconfig-001-20251109    clang-22
powerpc     randconfig-002-20251109    clang-22
powerpc64   randconfig-001-20251109    gcc-8.5.0
powerpc64   randconfig-002-20251109    gcc-8.5.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251109    gcc-9.5.0
riscv       randconfig-002-20251109    gcc-8.5.0
s390                    allnoconfig    clang-22
s390        randconfig-001-20251109    gcc-14.3.0
s390        randconfig-002-20251109    gcc-8.5.0
sh                      allnoconfig    gcc-15.1.0
sh          randconfig-001-20251109    gcc-11.5.0
sh          randconfig-002-20251109    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                  allnoconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

