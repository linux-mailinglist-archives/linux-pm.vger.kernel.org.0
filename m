Return-Path: <linux-pm+bounces-9814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF89136B8
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 00:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09CA1C20BAD
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376F51C3E;
	Sat, 22 Jun 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhKIaPOd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9CD524
	for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096370; cv=none; b=PjqMLqZngN1uHZABH+w1yoRA7pFnkaTZN1E8tH/EoJg9N8JRHCaE4XRHb+trIDHD99fZmdlVPRYQjTePpffOEKbpoSsk/6ooa2h2xqxm9rmGeYqXawrdEcg+LhTqyCchn5XJRcagy9WDBI8vpbwE5n8TdznINJ6ewIN3uttviXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096370; c=relaxed/simple;
	bh=viOsXshdvBKj5jAIuFphfFXCICWrIOcXXsufjqPVfII=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nQidrfwx91+fclKF/e+VeqLQ6hYCEAXiumeV0J8g+s89+LO1pRQghHgWVdecyQNCYFCRuGcGGmZFg81LRP/XBvJnX8tCRBJgioJPr33NpbCtyEGEd/qBhzgHUxdZZr2Yih3xW2Itwf3KbpwGh1FdgjRW2Iy/+b6slkUSru/Y0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhKIaPOd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719096368; x=1750632368;
  h=date:from:to:cc:subject:message-id;
  bh=viOsXshdvBKj5jAIuFphfFXCICWrIOcXXsufjqPVfII=;
  b=MhKIaPOdnG6stcP+OGwqIqCGDlIZZAvbuuX1bABmI25M/NLkstFcuzIS
   CkfBUmjJpKTNvush7hJxgta5fDQ4iv3Kop2F9tze8Xe+ylMsZDgYkEi4m
   +8Gi+DJPK0ovULIFw+jAyfo//NWTfYZLdMprzbjYJw+9WQ7LDkWDKVvjl
   pb96nBv8LqA1D2siwjd3v+IzYJXXFzzmCV8Gj1XNgMOSuwEYTvcz6NTfN
   KqAZI/A/fKQ8a7dYEKnCC2w5JqK+ygQHk4crqMscq9SyWMt+jmzDDWZ+E
   fwj9ZQpMsuQZbRuGdLnLAPMnX0XHmKY8UZIXGUj72KkMukvGHsqI7UTo1
   Q==;
X-CSE-ConnectionGUID: IP/J9rOuTZ+oCJs2vQUKXQ==
X-CSE-MsgGUID: vff/++GTSFWmdjtrjaPmRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16222173"
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="16222173"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 15:46:08 -0700
X-CSE-ConnectionGUID: RoqzL+0MRbycKHlKTSNNrg==
X-CSE-MsgGUID: o/wxhY+vR1K8uSGDzRwOjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="47856424"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Jun 2024 15:46:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sL9Ui-000A30-16;
	Sat, 22 Jun 2024 22:46:04 +0000
Date: Sun, 23 Jun 2024 06:45:30 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD REGRESSION
 ca8cc4ec88d54d4b7c59fe82de0deae3fcefb711
Message-ID: <202406230626.IeNe8pnr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: ca8cc4ec88d54d4b7c59fe82de0deae3fcefb711  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202406222016.R4A2TMs8-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "amd_pstate_global_params" [drivers/cpufreq/amd-pstate-ut.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-004-20240622
    `-- ERROR:amd_pstate_global_params-drivers-cpufreq-amd-pstate-ut.ko-undefined

elapsed time: 1618m

configs tested: 68
configs skipped: 0

tested configs:
arc                   randconfig-001-20240622   gcc-13.2.0
arc                   randconfig-002-20240622   gcc-13.2.0
arm                   randconfig-001-20240622   gcc-13.2.0
arm                   randconfig-002-20240622   clang-19
arm                   randconfig-003-20240622   clang-14
arm                   randconfig-004-20240622   gcc-13.2.0
arm64                 randconfig-001-20240622   clang-19
arm64                 randconfig-002-20240622   clang-14
arm64                 randconfig-003-20240622   gcc-13.2.0
arm64                 randconfig-004-20240622   clang-19
csky                  randconfig-001-20240622   gcc-13.2.0
csky                  randconfig-002-20240622   gcc-13.2.0
hexagon               randconfig-001-20240622   clang-19
hexagon               randconfig-002-20240622   clang-19
i386         buildonly-randconfig-001-20240622   gcc-13
i386         buildonly-randconfig-001-20240623   clang-18
i386         buildonly-randconfig-002-20240622   clang-18
i386         buildonly-randconfig-002-20240623   clang-18
i386         buildonly-randconfig-003-20240622   clang-18
i386         buildonly-randconfig-003-20240623   clang-18
i386         buildonly-randconfig-004-20240622   gcc-13
i386         buildonly-randconfig-004-20240623   gcc-13
i386         buildonly-randconfig-005-20240622   gcc-13
i386         buildonly-randconfig-005-20240623   clang-18
i386         buildonly-randconfig-006-20240622   clang-18
i386         buildonly-randconfig-006-20240623   clang-18
i386                  randconfig-001-20240622   gcc-10
i386                  randconfig-001-20240623   gcc-9
i386                  randconfig-002-20240622   clang-18
i386                  randconfig-002-20240623   clang-18
i386                  randconfig-003-20240622   gcc-13
i386                  randconfig-003-20240623   gcc-13
i386                  randconfig-004-20240622   gcc-13
i386                  randconfig-004-20240623   clang-18
i386                  randconfig-005-20240622   clang-18
i386                  randconfig-005-20240623   gcc-7
i386                  randconfig-006-20240622   gcc-13
i386                  randconfig-006-20240623   clang-18
i386                  randconfig-011-20240622   gcc-9
i386                  randconfig-012-20240622   gcc-7
i386                  randconfig-013-20240622   clang-18
i386                  randconfig-014-20240622   clang-18
i386                  randconfig-015-20240622   clang-18
i386                  randconfig-016-20240622   clang-18
loongarch             randconfig-001-20240622   gcc-13.2.0
loongarch             randconfig-002-20240622   gcc-13.2.0
nios2                 randconfig-001-20240622   gcc-13.2.0
nios2                 randconfig-002-20240622   gcc-13.2.0
parisc                randconfig-001-20240622   gcc-13.2.0
parisc                randconfig-002-20240622   gcc-13.2.0
powerpc               randconfig-001-20240622   gcc-13.2.0
powerpc               randconfig-002-20240622   gcc-13.2.0
powerpc               randconfig-003-20240622   clang-19
powerpc64             randconfig-001-20240622   gcc-13.2.0
powerpc64             randconfig-002-20240622   gcc-13.2.0
powerpc64             randconfig-003-20240622   gcc-13.2.0
riscv                 randconfig-001-20240622   gcc-13.2.0
riscv                 randconfig-002-20240622   gcc-13.2.0
s390                  randconfig-001-20240622   clang-19
s390                  randconfig-002-20240622   clang-15
sh                    randconfig-001-20240622   gcc-13.2.0
sh                    randconfig-002-20240622   gcc-13.2.0
sparc64               randconfig-001-20240622   gcc-13.2.0
sparc64               randconfig-002-20240622   gcc-13.2.0
um                    randconfig-001-20240622   gcc-10
um                    randconfig-002-20240622   clang-19
xtensa                randconfig-001-20240622   gcc-13.2.0
xtensa                randconfig-002-20240622   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

