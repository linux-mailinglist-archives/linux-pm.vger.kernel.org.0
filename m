Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0641D3F2B8F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbhHTLw0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 07:52:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:4363 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239876AbhHTLwZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Aug 2021 07:52:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203957602"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="203957602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="682253757"
Received: from srpawnik.iind.intel.com ([10.223.107.57])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2021 04:51:45 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rjw@rjwysocki.net, rui.zhang@intel.com,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: Add Power Limit4 support for Alder Lake SoC
Date:   Fri, 20 Aug 2021 17:22:33 +0530
Message-Id: <20210820115233.5297-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Power Limit4 support for Alder Lake SoC.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index cc3b22881bfe..1be45f36ab6c 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -138,6 +138,8 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
 	{}
 };
 
-- 
2.17.1

