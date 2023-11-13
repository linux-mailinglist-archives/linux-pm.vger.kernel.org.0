Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FDC7E9BF9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKMMOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Nov 2023 07:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMMOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Nov 2023 07:14:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E37D75
        for <linux-pm@vger.kernel.org>; Mon, 13 Nov 2023 04:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699877667; x=1731413667;
  h=date:from:to:cc:subject:message-id;
  bh=DDAO67dDpY8X9MpXp4IpW0p5vaYRTFjKxF67E3ktGIo=;
  b=bEc6wfCtCM9cmOd+uOMuKhhCbt0eIuJsenDp8iHbud2oOkV/loZuYi3e
   qQhN+hw7qQQCOWFh5n5jnSa7Jeyh4K4ldOKtJuQ4pq0+RsfRyprpRuCzl
   tCmoouY7beygkLwLnZtWQ/mXcIl4Pash0CfEIH8rYpfMAVPL4UAHLIEtN
   2CmXrGn96uAwrlCtBD3HmzfLEL8Nezo2NGiLOWIdLg26e8fjTAdo4onsK
   mPjUqyVqtjdIJys2FTmzafJmEJyhTO98z4lFdnNIAtmnnuB2jL3Wbxgqs
   +mdKeqIPL/Xx+asjCExgOTNa6PsedjVDyLubS9GQfGC3woeLqGRCWSQaS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="421520896"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421520896"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 04:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="830221650"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="830221650"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Nov 2023 04:14:25 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2Vpe-000C50-2e;
        Mon, 13 Nov 2023 12:14:22 +0000
Date:   Mon, 13 Nov 2023 20:14:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        apparmor@lists.ubuntu.com, linux-pm@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS
 f5a0c920323037a7494a7f6b81fe697d315b87a4
Message-ID: <202311132008.cKwL7w5W-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: f5a0c920323037a7494a7f6b81fe697d315b87a4  Merge branch 'ovl-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git

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
|-- arc-randconfig-001-20231113
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
|-- arm-allyesconfig
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
|-- arm-randconfig-001-20231113
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- arm64-allmodconfig
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
|-- arm64-defconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- arm64-randconfig-002-20231113
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
|-- csky-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- csky-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- csky-randconfig-002-20231113
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- i386-alldefconfig
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
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
|-- i386-buildonly-randconfig-001-20231113
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
|-- i386-buildonly-randconfig-002-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-buildonly-randconfig-004-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-buildonly-randconfig-005-20231113
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
|-- i386-buildonly-randconfig-006-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
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
|-- i386-randconfig-002-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-004-20231113
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
|-- i386-randconfig-011-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-141-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
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
|-- openrisc-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- openrisc-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- parisc-allmodconfig
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
|-- s390-randconfig-001-20231113
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- sh-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- sh-allyesconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- sh-randconfig-002-20231113
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
|-- sparc-randconfig-001-20231113
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
|-- x86_64-buildonly-randconfig-001-20231113
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
|-- x86_64-buildonly-randconfig-002-20231113
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
|-- x86_64-buildonly-randconfig-004-20231113
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
|-- x86_64-randconfig-001-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-002-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-003-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-004-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-005-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-006-20231113
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
|-- x86_64-randconfig-014-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-016-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-071-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-072-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-073-20231113
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
|-- x86_64-randconfig-074-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-121-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-122-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-123-20231113
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
`-- x86_64-rhel-8.3
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

elapsed time: 798m

configs tested: 162
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231113   gcc  
arc                   randconfig-002-20231113   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                   randconfig-001-20231113   gcc  
arm                   randconfig-002-20231113   gcc  
arm                   randconfig-003-20231113   gcc  
arm                   randconfig-004-20231113   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20231113   gcc  
arm64                 randconfig-003-20231113   gcc  
arm64                 randconfig-004-20231113   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231113   gcc  
csky                  randconfig-002-20231113   gcc  
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231113   gcc  
i386         buildonly-randconfig-002-20231113   gcc  
i386         buildonly-randconfig-003-20231113   gcc  
i386         buildonly-randconfig-004-20231113   gcc  
i386         buildonly-randconfig-005-20231113   gcc  
i386         buildonly-randconfig-006-20231113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-002-20231113   gcc  
i386                  randconfig-003-20231113   gcc  
i386                  randconfig-004-20231113   gcc  
i386                  randconfig-011-20231113   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231113   gcc  
loongarch             randconfig-002-20231113   gcc  
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
mips                          ath25_defconfig   clang
mips                          ath79_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231113   gcc  
nios2                 randconfig-002-20231113   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231113   gcc  
parisc                randconfig-002-20231113   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-002-20231113   gcc  
powerpc               randconfig-003-20231113   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231113   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231113   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231113   gcc  
s390                  randconfig-002-20231113   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231113   gcc  
sh                    randconfig-002-20231113   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231113   gcc  
sparc                 randconfig-002-20231113   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231113   gcc  
sparc64               randconfig-002-20231113   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231113   gcc  
um                    randconfig-002-20231113   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231113   gcc  
x86_64       buildonly-randconfig-002-20231113   gcc  
x86_64       buildonly-randconfig-003-20231113   gcc  
x86_64       buildonly-randconfig-004-20231113   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231113   gcc  
x86_64                randconfig-002-20231113   gcc  
x86_64                randconfig-003-20231113   gcc  
x86_64                randconfig-004-20231113   gcc  
x86_64                randconfig-005-20231113   gcc  
x86_64                randconfig-006-20231113   gcc  
x86_64                randconfig-014-20231113   gcc  
x86_64                randconfig-016-20231113   gcc  
x86_64                randconfig-071-20231113   gcc  
x86_64                randconfig-072-20231113   gcc  
x86_64                randconfig-073-20231113   gcc  
x86_64                randconfig-074-20231113   gcc  
x86_64                randconfig-075-20231113   gcc  
x86_64                randconfig-076-20231113   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231113   gcc  
xtensa                randconfig-002-20231113   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
