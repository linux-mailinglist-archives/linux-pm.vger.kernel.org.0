Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FF97EFE1E
	for <lists+linux-pm@lfdr.de>; Sat, 18 Nov 2023 07:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjKRGe7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Nov 2023 01:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjKRGe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Nov 2023 01:34:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558ECD72
        for <linux-pm@vger.kernel.org>; Fri, 17 Nov 2023 22:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700289291; x=1731825291;
  h=date:from:to:cc:subject:message-id;
  bh=/jROWcvOmBNtjfT/KUiCGCSOIYMEWAyKKMVw+uSsTkc=;
  b=CXllNgMSCt0/6n+LC61z+N9Cp9nx+IgEntBJg5MLBV/Pu/hmGCrZ5OyV
   KVWqnbIZ5Vgp2IUXW9dbGnPWeqlOlCuTOTrVvL6uJ8op+ul9yMEN4uBbW
   193kfbeVsaPmH60KtItgLfho8M0Slhqw8LIECkM6Ge4mtpeWP7WmMGtG0
   EIMP63qQbWTZjFS96jpwURGFVmmq/prqMLimuVLfvejuM795uZt58SoiV
   gZB5C7PtDpQgG+0dWmaxSH0I4pAVokQZeBfTh7dFY3H5fFKunyYwk+HJD
   8XyJ7gEbePupoKe0kkSihLfbujBcK/kUIzOX97yziEaujMCPLElwLJtjz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="394259414"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="394259414"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 22:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1013127935"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="1013127935"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2023 22:34:48 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Euk-0003bj-10;
        Sat, 18 Nov 2023 06:34:46 +0000
Date:   Sat, 18 Nov 2023 14:34:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        apparmor@lists.ubuntu.com, linux-pm@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS
 1da100f819fbef3f6f1982cd0e448694e6ef2956
Message-ID: <202311181437.4ci7jRm8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: 1da100f819fbef3f6f1982cd0e448694e6ef2956  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- arc-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- arc-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- arc-randconfig-001-20231117
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- arm-allmodconfig
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
|-- arm-randconfig-004-20231117
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- arm64-defconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- csky-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- csky-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- csky-randconfig-001-20231117
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- i386-allmodconfig
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
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- i386-allnoconfig
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-allyesconfig
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
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- i386-buildonly-randconfig-003-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-buildonly-randconfig-005-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-buildonly-randconfig-006-20231117
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
|-- i386-defconfig
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
|-- i386-randconfig-001-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-002-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-003-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-004-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-005-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-006-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-011-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-012-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- i386-randconfig-013-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-015-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-016-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-141-20231118
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
|-- loongarch-allmodconfig
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
|-- loongarch-allyesconfig
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
|-- loongarch-defconfig
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
|-- m68k-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- m68k-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- microblaze-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- microblaze-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- mips-allmodconfig
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
|-- mips-allyesconfig
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
|-- nios2-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- nios2-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- parisc-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
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
|-- powerpc-randconfig-003-20231117
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- riscv-allmodconfig
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
|-- riscv-allyesconfig
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
|-- riscv-defconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- riscv-rv32_defconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- s390-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- s390-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- sh-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- sh-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- sparc-allmodconfig
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
|-- sparc-allyesconfig
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
|-- sparc64-allmodconfig
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
|-- sparc64-allyesconfig
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
|-- um-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- um-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- x86_64-allnoconfig
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-allyesconfig
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
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- x86_64-buildonly-randconfig-002-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-buildonly-randconfig-004-20231117
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- x86_64-buildonly-randconfig-005-20231117
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- x86_64-buildonly-randconfig-006-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-defconfig
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
|-- x86_64-randconfig-001-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-003-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-004-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-006-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-012-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-013-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-014-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-015-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-071-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-072-20231117
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- x86_64-randconfig-073-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-074-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-075-20231117
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-076-20231117
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
`-- x86_64-randconfig-161-20231118
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
    `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
clang_recent_errors
`-- x86_64-rhel-8.3-rust
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
    |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
    `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security

elapsed time: 1921m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231117   gcc  
arc                   randconfig-002-20231117   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231117   gcc  
arm                   randconfig-002-20231117   gcc  
arm                   randconfig-003-20231117   gcc  
arm                   randconfig-004-20231117   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231117   gcc  
arm64                 randconfig-002-20231117   gcc  
arm64                 randconfig-003-20231117   gcc  
arm64                 randconfig-004-20231117   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231117   gcc  
csky                  randconfig-002-20231117   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231117   gcc  
i386         buildonly-randconfig-002-20231117   gcc  
i386         buildonly-randconfig-003-20231117   gcc  
i386         buildonly-randconfig-004-20231117   gcc  
i386         buildonly-randconfig-005-20231117   gcc  
i386         buildonly-randconfig-006-20231117   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231117   gcc  
i386                  randconfig-002-20231117   gcc  
i386                  randconfig-003-20231117   gcc  
i386                  randconfig-004-20231117   gcc  
i386                  randconfig-005-20231117   gcc  
i386                  randconfig-006-20231117   gcc  
i386                  randconfig-011-20231117   gcc  
i386                  randconfig-012-20231117   gcc  
i386                  randconfig-013-20231117   gcc  
i386                  randconfig-014-20231117   gcc  
i386                  randconfig-015-20231117   gcc  
i386                  randconfig-016-20231117   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231117   gcc  
loongarch             randconfig-002-20231117   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231117   gcc  
nios2                 randconfig-002-20231117   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231117   gcc  
parisc                randconfig-002-20231117   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231117   gcc  
powerpc               randconfig-002-20231117   gcc  
powerpc               randconfig-003-20231117   gcc  
powerpc64             randconfig-001-20231117   gcc  
powerpc64             randconfig-002-20231117   gcc  
powerpc64             randconfig-003-20231117   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231117   gcc  
riscv                 randconfig-002-20231117   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231117   gcc  
s390                  randconfig-002-20231117   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231117   gcc  
sh                    randconfig-002-20231117   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231117   gcc  
sparc64               randconfig-002-20231117   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231117   gcc  
um                    randconfig-002-20231117   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231117   gcc  
x86_64       buildonly-randconfig-002-20231117   gcc  
x86_64       buildonly-randconfig-003-20231117   gcc  
x86_64       buildonly-randconfig-004-20231117   gcc  
x86_64       buildonly-randconfig-005-20231117   gcc  
x86_64       buildonly-randconfig-006-20231117   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231117   gcc  
x86_64                randconfig-002-20231117   gcc  
x86_64                randconfig-003-20231117   gcc  
x86_64                randconfig-004-20231117   gcc  
x86_64                randconfig-005-20231117   gcc  
x86_64                randconfig-006-20231117   gcc  
x86_64                randconfig-011-20231117   gcc  
x86_64                randconfig-012-20231117   gcc  
x86_64                randconfig-013-20231117   gcc  
x86_64                randconfig-014-20231117   gcc  
x86_64                randconfig-015-20231117   gcc  
x86_64                randconfig-016-20231117   gcc  
x86_64                randconfig-071-20231117   gcc  
x86_64                randconfig-072-20231117   gcc  
x86_64                randconfig-073-20231117   gcc  
x86_64                randconfig-074-20231117   gcc  
x86_64                randconfig-075-20231117   gcc  
x86_64                randconfig-076-20231117   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231117   gcc  
xtensa                randconfig-002-20231117   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
