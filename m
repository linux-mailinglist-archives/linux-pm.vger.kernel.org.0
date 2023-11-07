Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053607E32E5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Nov 2023 03:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjKGCZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Nov 2023 21:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjKGCZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2023 21:25:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4B4D6E
        for <linux-pm@vger.kernel.org>; Mon,  6 Nov 2023 18:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699323929; x=1730859929;
  h=date:from:to:cc:subject:message-id;
  bh=x/p1DMubDDwbBCOvNDmbxklgaPJ0SjAvGw0EyxMv6aw=;
  b=Uql9lJf9fiXqNaiJ5n1Qzup9cdnJkI788EHqIbr8w8F+0Smk5puMXrrc
   sc0c0iDYyZlQgra0AhgsvZC76P6jNJqVMtQfm/EGJYbFgNDxLbYEEoJuU
   FOkcvyzmY4Ar8IxNVsh0yT6tOIEzKhtpSPI2ab2gnfHxlytEkioZNe+vQ
   VssIgLRroFWDt/WNUTf5O/uSkctSZl5gIZ9EH1u5fpkaIl7hJYE1oRTPF
   +s6HKhUOkUkRLEUhZKbFvvZXlGcSC7Ys7UVxrzemqjjcoXH53Vixa5o7q
   tLe2+OuXjFDpQTRF7KGj8d8x9WfQm2CK1gZ/rVDBCMAnJz59u4G5q4f2k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475655106"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475655106"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 18:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="853203888"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="853203888"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2023 18:25:27 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0BmP-0006tw-1J;
        Tue, 07 Nov 2023 02:25:25 +0000
Date:   Tue, 07 Nov 2023 10:24:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        apparmor@lists.ubuntu.com, linux-pm@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS
 b9892b3a09980b1b785541463ff6948360afdcde
Message-ID: <202311071034.7Bg4kLtR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: b9892b3a09980b1b785541463ff6948360afdcde  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

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
|-- arm-randconfig-002-20231106
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- csky-allmodconfig
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- csky-allyesconfig
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
|-- i386-buildonly-randconfig-001-20231106
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- i386-buildonly-randconfig-004-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-buildonly-randconfig-005-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-debian-10.3
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
|-- i386-randconfig-001-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-002-20231106
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
|-- i386-randconfig-003-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-004-20231106
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
|-- i386-randconfig-006-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- i386-randconfig-014-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
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
|-- powerpc-randconfig-002-20231106
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-end-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-gfp_mask-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-add_rtree_block
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start-not-described-in-create_zone_bm_rtree
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-add_rtree_block
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-free_zone_bm_rtree
|-- powerpc64-randconfig-002-20231106
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
|-- x86_64-buildonly-randconfig-001-20231106
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
|-- x86_64-buildonly-randconfig-002-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-buildonly-randconfig-003-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-buildonly-randconfig-005-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-buildonly-randconfig-006-20231106
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
|-- x86_64-randconfig-002-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-flags-not-described-in-apparmor_sk_alloc_security
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sk-not-described-in-apparmor_sk_free_security
|-- x86_64-randconfig-003-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-004-20231106
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
|-- x86_64-randconfig-005-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-006-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-011-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-013-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-014-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-071-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-072-20231106
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
|-- x86_64-randconfig-073-20231106
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
|-- x86_64-randconfig-074-20231106
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-num_var-not-described-in-mtrr_overwrite_state
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-start-not-described-in-mtrr_type_lookup
|   |-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-uniform-not-described-in-mtrr_type_lookup
|   `-- arch-x86-kernel-cpu-mtrr-generic.c:warning:Function-parameter-or-member-var-not-described-in-mtrr_overwrite_state
|-- x86_64-randconfig-076-20231106
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

elapsed time: 1606m

configs tested: 146
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
arc                   randconfig-001-20231106   gcc  
arc                   randconfig-002-20231106   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-002-20231106   gcc  
arm                   randconfig-003-20231106   gcc  
arm                   randconfig-004-20231106   gcc  
arm64                 randconfig-001-20231106   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231106   gcc  
csky                  randconfig-002-20231106   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20231106   gcc  
i386         buildonly-randconfig-002-20231106   gcc  
i386         buildonly-randconfig-003-20231106   gcc  
i386         buildonly-randconfig-004-20231106   gcc  
i386         buildonly-randconfig-005-20231106   gcc  
i386         buildonly-randconfig-006-20231106   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231106   gcc  
i386                  randconfig-002-20231106   gcc  
i386                  randconfig-003-20231106   gcc  
i386                  randconfig-004-20231106   gcc  
i386                  randconfig-006-20231106   gcc  
i386                  randconfig-014-20231106   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231106   gcc  
loongarch             randconfig-002-20231106   gcc  
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
nios2                 randconfig-001-20231106   gcc  
nios2                 randconfig-002-20231106   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231106   gcc  
parisc                randconfig-002-20231106   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231106   gcc  
powerpc               randconfig-002-20231106   gcc  
powerpc               randconfig-003-20231106   gcc  
powerpc64             randconfig-001-20231106   gcc  
powerpc64             randconfig-002-20231106   gcc  
powerpc64             randconfig-003-20231106   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231106   gcc  
riscv                 randconfig-002-20231106   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231106   gcc  
s390                  randconfig-002-20231106   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231106   gcc  
x86_64       buildonly-randconfig-001-20231107   gcc  
x86_64       buildonly-randconfig-002-20231106   gcc  
x86_64       buildonly-randconfig-002-20231107   gcc  
x86_64       buildonly-randconfig-003-20231106   gcc  
x86_64       buildonly-randconfig-003-20231107   gcc  
x86_64       buildonly-randconfig-004-20231106   gcc  
x86_64       buildonly-randconfig-004-20231107   gcc  
x86_64       buildonly-randconfig-005-20231106   gcc  
x86_64       buildonly-randconfig-005-20231107   gcc  
x86_64       buildonly-randconfig-006-20231106   gcc  
x86_64       buildonly-randconfig-006-20231107   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231106   gcc  
x86_64                randconfig-002-20231106   gcc  
x86_64                randconfig-003-20231106   gcc  
x86_64                randconfig-004-20231106   gcc  
x86_64                randconfig-005-20231106   gcc  
x86_64                randconfig-006-20231106   gcc  
x86_64                randconfig-011-20231106   gcc  
x86_64                randconfig-012-20231106   gcc  
x86_64                randconfig-013-20231106   gcc  
x86_64                randconfig-014-20231106   gcc  
x86_64                randconfig-015-20231106   gcc  
x86_64                randconfig-016-20231106   gcc  
x86_64                randconfig-071-20231106   gcc  
x86_64                randconfig-072-20231106   gcc  
x86_64                randconfig-073-20231106   gcc  
x86_64                randconfig-074-20231106   gcc  
x86_64                randconfig-075-20231106   gcc  
x86_64                randconfig-076-20231106   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-002-20231107   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
