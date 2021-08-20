Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3273F2BC4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhHTMMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 08:12:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:34756 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238179AbhHTMMe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Aug 2021 08:12:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="280493852"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="280493852"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="506454729"
Received: from srpawnik.iind.intel.com ([10.223.107.57])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2021 05:11:54 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     lenb@kernel.org, x86@kernel.org, tony.luck@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] tools/power/turbostat: Add Power Limit4 support
Date:   Fri, 20 Aug 2021 17:42:43 +0530
Message-Id: <20210820121243.5543-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Power Limit4 support.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
We can see below output with this patch under turbostat.
On Alder Lake:
cpu0: MSR_VR_CURRENT_CONFIG: 0x000003f0
cpu0: PKG Limit #4: 126.000000 Watts (UNlocked)

On Tiger Lake:
cpu0: MSR_VR_CURRENT_CONFIG: 0x00000348
cpu0: PKG Limit #4: 105.000000 Watts (UNlocked)
---
 arch/x86/include/asm/msr-index.h      | 1 +
 tools/power/x86/turbostat/turbostat.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c413432b33..336a811c8683 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -310,6 +310,7 @@
 
 /* Run Time Average Power Limiting (RAPL) Interface */
 
+#define MSR_VR_CURRENT_CONFIG	0x00000601
 #define MSR_RAPL_POWER_UNIT		0x00000606
 
 #define MSR_PKG_POWER_LIMIT		0x00000610
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 47d3ba895d6d..4eb59f459830 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4768,6 +4768,15 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			((msr >> 32) & 0x7FFF) * rapl_power_units,
 			(1.0 + (((msr >> 54) & 0x3) / 4.0)) * (1 << ((msr >> 49) & 0x1F)) * rapl_time_units,
 			((msr >> 48) & 1) ? "EN" : "DIS");
+
+		if (get_msr(cpu, MSR_VR_CURRENT_CONFIG, &msr))
+			return -9;
+
+		fprintf(outf, "cpu%d: MSR_VR_CURRENT_CONFIG: 0x%08llx\n", cpu, msr);
+		fprintf(outf, "cpu%d: PKG Limit #4: %f Watts (%slocked)\n",
+			cpu,
+			((msr >> 0) & 0x1FFF) * rapl_power_units,
+			(msr >> 31) & 1 ? "" : "UN");
 	}
 
 	if (do_rapl & RAPL_DRAM_POWER_INFO) {
-- 
2.17.1

