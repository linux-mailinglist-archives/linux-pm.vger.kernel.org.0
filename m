Return-Path: <linux-pm+bounces-36028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C4BD758C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 06:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A6A422CE7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 04:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3030CDB3;
	Tue, 14 Oct 2025 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+5hpU5/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621C30CDAE
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417915; cv=none; b=tRxN/cehDnVtYZjLQVfUdlsCN4wdAn2RQGyXeZE6eOgP7Ryc/Lvgfdj5GDVSjX2Ju6D/PQpdFP/log3MQkfvIZhh/lRDm4Wk7hw7Zkp1qZhV+Pq+jisuorGZecA5HYgFeuWIyNyK0Y4uHvYRmYjXqswYHEE5i0tNHohOBxKR6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417915; c=relaxed/simple;
	bh=EiIaRIi7QEuq4TUME42rKvA9xIY4hrH+UFVjbvkx8lk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Lv/1RFxGM66ZyksvfM8EN5YPmdSOxmKIzfHEDW1GFOVyMQQN7gWACi9hdFzX1rmNTWdBNqszCHvZzAi/+RU+WN0R9CkbsdLLgKhf/zAam22e/JN2QvElqxxY4y8bHb14H3eBmhALv3oNXHU8yfBsyu8uG6i4BiSVkJhTkmI3IRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+5hpU5/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760417913; x=1791953913;
  h=date:from:to:cc:subject:message-id;
  bh=EiIaRIi7QEuq4TUME42rKvA9xIY4hrH+UFVjbvkx8lk=;
  b=W+5hpU5/JErbmokRbOf9NxCW7/8YFaXaybIPVhbOCF68hQJaC1oqiU+d
   8fjFSW174EJJDKLTGZbmRlHJxxj6VyBq14aA3gTXKrg5URkT1LI/0em3p
   GQOCLpn9zvBpHn3uPDQYjwJU6kXeySBQJD7rGeTG/KzJnyCWcN7o59+ZT
   lcA9LsydJQCLxYLVliOfjA9WV5N4uZbxMAiotCEPNGo84uGA5B37/gLtS
   BpWFFZWbGofs7UujeOKTg0bJgtjosxuo58QBusO2giDAteprgS7eteTup
   1/QPrlJA1hwdGFqsOposRQrRIhusjA0RWhso1KL1ukxflxAhl2xx11DW7
   w==;
X-CSE-ConnectionGUID: oAnZt8jCSfC6cFSpKk1nYg==
X-CSE-MsgGUID: xLE94MZVQjqwLuPpp8Yisw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73247348"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="73247348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 21:58:31 -0700
X-CSE-ConnectionGUID: s2vIaL32R3+B8ye1uL5TiQ==
X-CSE-MsgGUID: fsnjcdNnSHSFWtZnJGPMIQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 13 Oct 2025 21:58:30 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8X4U-0002N5-0N;
	Tue, 14 Oct 2025 04:56:02 +0000
Date: Tue, 14 Oct 2025 12:55:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 6558aebfdd468cd1b16f8ca684ff3e7c8dfa8cd3
Message-ID: <202510141230.TVm35U8E-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 6558aebfdd468cd1b16f8ca684ff3e7c8dfa8cd3  cpufreq/amd-pstate: Add static asserts for EPP indices

elapsed time: 1449m

configs tested: 175
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251013    gcc-8.5.0
arc                   randconfig-001-20251014    gcc-15.1.0
arc                   randconfig-002-20251013    gcc-13.4.0
arc                   randconfig-002-20251014    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20251013    gcc-10.5.0
arm                   randconfig-001-20251014    gcc-15.1.0
arm                   randconfig-002-20251013    clang-22
arm                   randconfig-002-20251014    gcc-13.4.0
arm                   randconfig-003-20251013    gcc-12.5.0
arm                   randconfig-003-20251014    clang-16
arm                   randconfig-004-20251013    clang-22
arm                   randconfig-004-20251014    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251013    clang-19
arm64                 randconfig-001-20251014    gcc-9.5.0
arm64                 randconfig-002-20251013    gcc-8.5.0
arm64                 randconfig-002-20251014    gcc-10.5.0
arm64                 randconfig-003-20251013    clang-22
arm64                 randconfig-003-20251014    gcc-14.3.0
arm64                 randconfig-004-20251013    gcc-8.5.0
arm64                 randconfig-004-20251014    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251013    gcc-15.1.0
csky                  randconfig-001-20251014    gcc-15.1.0
csky                  randconfig-002-20251013    gcc-15.1.0
csky                  randconfig-002-20251014    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251013    clang-22
hexagon               randconfig-001-20251014    clang-22
hexagon               randconfig-002-20251013    clang-22
hexagon               randconfig-002-20251014    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251013    gcc-13
i386        buildonly-randconfig-002-20251013    clang-20
i386        buildonly-randconfig-003-20251013    gcc-14
i386        buildonly-randconfig-004-20251013    clang-20
i386        buildonly-randconfig-005-20251013    gcc-14
i386        buildonly-randconfig-006-20251013    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251013    clang-18
loongarch             randconfig-001-20251014    clang-18
loongarch             randconfig-002-20251013    gcc-13.4.0
loongarch             randconfig-002-20251014    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251013    gcc-8.5.0
nios2                 randconfig-001-20251014    gcc-11.5.0
nios2                 randconfig-002-20251013    gcc-8.5.0
nios2                 randconfig-002-20251014    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251013    gcc-12.5.0
parisc                randconfig-001-20251014    gcc-11.5.0
parisc                randconfig-002-20251013    gcc-8.5.0
parisc                randconfig-002-20251014    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20251013    clang-22
powerpc               randconfig-001-20251014    gcc-9.5.0
powerpc               randconfig-002-20251013    clang-18
powerpc               randconfig-002-20251014    clang-22
powerpc               randconfig-003-20251013    clang-22
powerpc               randconfig-003-20251014    gcc-14.3.0
powerpc64             randconfig-001-20251013    gcc-10.5.0
powerpc64             randconfig-001-20251014    gcc-8.5.0
powerpc64             randconfig-002-20251013    gcc-15.1.0
powerpc64             randconfig-002-20251014    gcc-8.5.0
powerpc64             randconfig-003-20251013    clang-20
powerpc64             randconfig-003-20251014    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251013    clang-22
riscv                 randconfig-001-20251014    gcc-10.5.0
riscv                 randconfig-002-20251013    clang-22
riscv                 randconfig-002-20251014    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251013    gcc-8.5.0
s390                  randconfig-001-20251014    clang-22
s390                  randconfig-002-20251013    clang-22
s390                  randconfig-002-20251014    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251013    gcc-10.5.0
sh                    randconfig-001-20251014    gcc-14.3.0
sh                    randconfig-002-20251013    gcc-15.1.0
sh                    randconfig-002-20251014    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251013    gcc-8.5.0
sparc                 randconfig-001-20251014    gcc-15.1.0
sparc                 randconfig-002-20251013    gcc-8.5.0
sparc                 randconfig-002-20251014    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251013    clang-20
sparc64               randconfig-001-20251014    clang-20
sparc64               randconfig-002-20251013    gcc-14.3.0
sparc64               randconfig-002-20251014    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251013    gcc-14
um                    randconfig-001-20251014    gcc-14
um                    randconfig-002-20251013    gcc-14
um                    randconfig-002-20251014    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251013    gcc-13
x86_64      buildonly-randconfig-002-20251013    clang-20
x86_64      buildonly-randconfig-003-20251013    clang-20
x86_64      buildonly-randconfig-004-20251013    gcc-14
x86_64      buildonly-randconfig-005-20251013    clang-20
x86_64      buildonly-randconfig-006-20251013    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251013    gcc-11.5.0
xtensa                randconfig-001-20251014    gcc-8.5.0
xtensa                randconfig-002-20251013    gcc-11.5.0
xtensa                randconfig-002-20251014    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

