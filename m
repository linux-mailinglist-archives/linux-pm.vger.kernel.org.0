Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81153AFC1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiFAVTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 17:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiFAVTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 17:19:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C18A76FF
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654118359; x=1685654359;
  h=from:to:cc:subject:date:message-id;
  bh=cSqWGNtv+6v6RP9cn0Y58/IafCZ7iFYvzsuBAE4yzt4=;
  b=Zmm9MnaTLW/dDI3AKym6KuZ4imfFtj+9IBtjbDbj0d17KD/G1e4dYnk4
   xvmKONfp0U1M8IGAu62vFBOQc4OTeOmZ1QIaGUjsxIsERSD3/kPgazJjw
   Ch2JS8le53uJcBAWydqbVtUzgK4vcj00/C/foOjw2ulHCZ7mT2OBF8PFT
   HZqj/mQ5FHr7yEpLbyU0AKOiTiqHnCZaB2zktUI79yPGTR/4bVt0HKkHP
   On9nYGXK8LgkAuAJXE6oCtRCaB9VscmmH4ux+KeENTJHeRXDpVmhuEy+9
   lUo81gGGTXEtnApDhlKLYE6VkCl+DKB51cRa7F5kMfL+GfhRK+aVz1ert
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="256173653"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="256173653"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 12:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="612463364"
Received: from otc-chromeosbuild-5.ostc.intel.com (HELO otc-chromeosbuild-5.intel.com) ([10.54.29.149])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2022 12:22:19 -0700
From:   george.d.sworo@intel.com
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Date:   Wed,  1 Jun 2022 12:22:16 -0700
Message-Id: <20220601192216.9174-1-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: George D Sworo <george.d.sworo@intel.com>

Add RAPTORLAKE_P to the list of supported processor model in the Intel

RAPL power capping driver.

Signed-off-by: George D Sworo <george.d.sworo@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a9c99d9e8b42..21d624f9f5fb 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1109,6 +1109,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
-- 
2.17.1

