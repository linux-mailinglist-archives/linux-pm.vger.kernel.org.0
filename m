Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926665FBD8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfGDQew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 12:34:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:33035 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfGDQev (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169480474"
Received: from conghuic-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.172.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:34:49 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 02/13] intel_rapl: remove hardcoded register index
Date:   Fri,  5 Jul 2019 00:34:34 +0800
Message-Id: <1562258085-3165-3-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

enum rapl_domain_reg_id is defined for the RAPL registers for each RAPL
domain, thus use it whenever possible.

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 44 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 45d5f22..9be9f20 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -642,11 +642,11 @@ static void rapl_init_domains(struct rapl_package *rp)
 		case BIT(RAPL_DOMAIN_PACKAGE):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PACKAGE];
 			rd->id = RAPL_DOMAIN_PACKAGE;
-			rd->regs[0] = MSR_PKG_POWER_LIMIT;
-			rd->regs[1] = MSR_PKG_ENERGY_STATUS;
-			rd->regs[2] = MSR_PKG_PERF_STATUS;
-			rd->regs[3] = 0;
-			rd->regs[4] = MSR_PKG_POWER_INFO;
+			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PKG_POWER_LIMIT;
+			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PKG_ENERGY_STATUS;
+			rd->regs[RAPL_DOMAIN_REG_PERF] = MSR_PKG_PERF_STATUS;
+			rd->regs[RAPL_DOMAIN_REG_POLICY] = 0;
+			rd->regs[RAPL_DOMAIN_REG_INFO] = MSR_PKG_POWER_INFO;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			rd->rpl[1].prim_id = PL2_ENABLE;
@@ -655,33 +655,33 @@ static void rapl_init_domains(struct rapl_package *rp)
 		case BIT(RAPL_DOMAIN_PP0):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PP0];
 			rd->id = RAPL_DOMAIN_PP0;
-			rd->regs[0] = MSR_PP0_POWER_LIMIT;
-			rd->regs[1] = MSR_PP0_ENERGY_STATUS;
-			rd->regs[2] = 0;
-			rd->regs[3] = MSR_PP0_POLICY;
-			rd->regs[4] = 0;
+			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PP0_POWER_LIMIT;
+			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PP0_ENERGY_STATUS;
+			rd->regs[RAPL_DOMAIN_REG_PERF] = 0;
+			rd->regs[RAPL_DOMAIN_REG_POLICY] = MSR_PP0_POLICY;
+			rd->regs[RAPL_DOMAIN_REG_INFO] = 0;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			break;
 		case BIT(RAPL_DOMAIN_PP1):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_PP1];
 			rd->id = RAPL_DOMAIN_PP1;
-			rd->regs[0] = MSR_PP1_POWER_LIMIT;
-			rd->regs[1] = MSR_PP1_ENERGY_STATUS;
-			rd->regs[2] = 0;
-			rd->regs[3] = MSR_PP1_POLICY;
-			rd->regs[4] = 0;
+			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PP1_POWER_LIMIT;
+			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PP1_ENERGY_STATUS;
+			rd->regs[RAPL_DOMAIN_REG_PERF] = 0;
+			rd->regs[RAPL_DOMAIN_REG_POLICY] = MSR_PP1_POLICY;
+			rd->regs[RAPL_DOMAIN_REG_INFO] = 0;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			break;
 		case BIT(RAPL_DOMAIN_DRAM):
 			rd->name = rapl_domain_names[RAPL_DOMAIN_DRAM];
 			rd->id = RAPL_DOMAIN_DRAM;
-			rd->regs[0] = MSR_DRAM_POWER_LIMIT;
-			rd->regs[1] = MSR_DRAM_ENERGY_STATUS;
-			rd->regs[2] = MSR_DRAM_PERF_STATUS;
-			rd->regs[3] = 0;
-			rd->regs[4] = MSR_DRAM_POWER_INFO;
+			rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_DRAM_POWER_LIMIT;
+			rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_DRAM_ENERGY_STATUS;
+			rd->regs[RAPL_DOMAIN_REG_PERF] = MSR_DRAM_PERF_STATUS;
+			rd->regs[RAPL_DOMAIN_REG_POLICY] = 0;
+			rd->regs[RAPL_DOMAIN_REG_INFO] = MSR_DRAM_POWER_INFO;
 			rd->rpl[0].prim_id = PL1_ENABLE;
 			rd->rpl[0].name = pl1_name;
 			rd->domain_energy_unit =
@@ -1282,8 +1282,8 @@ static int __init rapl_register_psys(void)
 
 	rd->name = rapl_domain_names[RAPL_DOMAIN_PLATFORM];
 	rd->id = RAPL_DOMAIN_PLATFORM;
-	rd->regs[0] = MSR_PLATFORM_POWER_LIMIT;
-	rd->regs[1] = MSR_PLATFORM_ENERGY_STATUS;
+	rd->regs[RAPL_DOMAIN_REG_LIMIT] = MSR_PLATFORM_POWER_LIMIT;
+	rd->regs[RAPL_DOMAIN_REG_STATUS] = MSR_PLATFORM_ENERGY_STATUS;
 	rd->rpl[0].prim_id = PL1_ENABLE;
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
-- 
2.7.4

