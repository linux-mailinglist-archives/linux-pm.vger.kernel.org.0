Return-Path: <linux-pm+bounces-525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5F7FE460
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 00:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302B41C208FF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 23:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99347A6A;
	Wed, 29 Nov 2023 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJMGtfYF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB25B2
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 15:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701302216; x=1732838216;
  h=date:from:to:cc:subject:message-id;
  bh=hIo3Osw9+03N1VH/mwI7RN2IxmEGiSRPIi1c7kIqJds=;
  b=jJMGtfYFnZ5NKHMc6mfAMGAHZT36IkhC9MmZEKpcaiMu/Z4hybCLrQkr
   abdjlOIhzoqXa1vikxjv6ZgBaPhwGnQVHoDwG0wDbNcLc7XnGiLtPLFcf
   u/aNb9aB51xBbZd25KGudVfwwqi0I3QN+hkO1XpOZn8Z+esWk00e31+sg
   syqk7MIdNcvzEuUN0TVZX/2JA48wS6lf/IgA0A5YZrKjKzAIxvtRcpfUr
   zWzdkgn4d5UYrN2iuuu8r0Y4DW2BzyXMn2+0fSmUGyms2t+hWogxbfWkf
   RsFLrxGsJNe/9MpA2gAULkwJMgXvm9bWawKzUtTjZJdTBcqvotW5gJlBZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="424393819"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="424393819"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:56:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839613317"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="839613317"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2023 15:56:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8UQF-000171-2E;
	Wed, 29 Nov 2023 23:56:51 +0000
Date: Thu, 30 Nov 2023 07:55:51 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 apparmor@lists.ubuntu.com, linux-pm@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS
 1618cb8f574175a196b0e8926c62efc45760e856
Message-ID: <202311300746.zOJcaNAw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: 1618cb8f574175a196b0e8926c62efc45760e856  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- arc-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- i386-buildonly-randconfig-002-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- i386-buildonly-randconfig-005-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-buildonly-randconfig-006-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-001-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- i386-randconfig-002-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-005-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-006-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
`-- x86_64-alldefconfig
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
    `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
clang_recent_errors
|-- i386-randconfig-011-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- i386-randconfig-012-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-013-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-014-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-015-20231129
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- powerpc-allmodconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- powerpc-allyesconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
`-- riscv-rv32_defconfig
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
    `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security

elapsed time: 1535m

configs tested: 212
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231129   gcc  
arc                   randconfig-002-20231129   gcc  
arm                               allnoconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231129   gcc  
arm                   randconfig-002-20231129   gcc  
arm                   randconfig-003-20231129   gcc  
arm                   randconfig-004-20231129   gcc  
arm                             rpc_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                       spear13xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231129   gcc  
arm64                 randconfig-002-20231129   gcc  
arm64                 randconfig-003-20231129   gcc  
arm64                 randconfig-004-20231129   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231129   gcc  
csky                  randconfig-002-20231129   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231129   gcc  
i386         buildonly-randconfig-002-20231129   gcc  
i386         buildonly-randconfig-003-20231129   gcc  
i386         buildonly-randconfig-004-20231129   gcc  
i386         buildonly-randconfig-005-20231129   gcc  
i386         buildonly-randconfig-006-20231129   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231129   gcc  
i386                  randconfig-002-20231129   gcc  
i386                  randconfig-003-20231129   gcc  
i386                  randconfig-004-20231129   gcc  
i386                  randconfig-005-20231129   gcc  
i386                  randconfig-006-20231129   gcc  
i386                  randconfig-011-20231129   clang
i386                  randconfig-012-20231129   clang
i386                  randconfig-013-20231129   clang
i386                  randconfig-014-20231129   clang
i386                  randconfig-015-20231129   clang
i386                  randconfig-016-20231129   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231129   gcc  
loongarch             randconfig-002-20231129   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                           rs90_defconfig   clang
mips                        vocore2_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231129   gcc  
nios2                 randconfig-002-20231129   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231129   gcc  
parisc                randconfig-002-20231129   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc               randconfig-001-20231129   gcc  
powerpc               randconfig-002-20231129   gcc  
powerpc               randconfig-003-20231129   gcc  
powerpc64             randconfig-001-20231129   gcc  
powerpc64             randconfig-002-20231129   gcc  
powerpc64             randconfig-003-20231129   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231129   gcc  
riscv                 randconfig-002-20231129   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231129   gcc  
sh                    randconfig-002-20231129   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231129   gcc  
sparc64               randconfig-002-20231129   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231129   gcc  
um                    randconfig-002-20231129   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231129   gcc  
x86_64       buildonly-randconfig-002-20231129   gcc  
x86_64       buildonly-randconfig-003-20231129   gcc  
x86_64       buildonly-randconfig-004-20231129   gcc  
x86_64       buildonly-randconfig-005-20231129   gcc  
x86_64       buildonly-randconfig-006-20231129   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231129   gcc  
x86_64                randconfig-012-20231129   gcc  
x86_64                randconfig-013-20231129   gcc  
x86_64                randconfig-014-20231129   gcc  
x86_64                randconfig-015-20231129   gcc  
x86_64                randconfig-016-20231129   gcc  
x86_64                randconfig-071-20231129   gcc  
x86_64                randconfig-072-20231129   gcc  
x86_64                randconfig-073-20231129   gcc  
x86_64                randconfig-074-20231129   gcc  
x86_64                randconfig-075-20231129   gcc  
x86_64                randconfig-076-20231129   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231129   gcc  
xtensa                randconfig-002-20231129   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

