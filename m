Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA45FBE4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGDQfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 12:35:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:33045 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDQfG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 12:35:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169480544"
Received: from conghuic-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.172.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:35:04 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 10/13] intel_rapl: support 64 bit register
Date:   Fri,  5 Jul 2019 00:34:42 +0800
Message-Id: <1562258085-3165-11-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RAPL MMIO interface uses 64 bit registers, thus force use 64 bit register
for all the RAPL code.

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c |  6 +++---
 drivers/powercap/intel_rapl_msr.c    | 11 +++++++----
 include/linux/intel_rapl.h           |  8 ++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 323ed41..d648411 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -689,7 +689,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	ra.mask = rp->mask;
 
 	if (rd->rp->priv->read_raw(cpu, &ra)) {
-		pr_debug("failed to read reg 0x%x on cpu %d\n", ra.reg, cpu);
+		pr_debug("failed to read reg 0x%llx on cpu %d\n", ra.reg, cpu);
 		return -EIO;
 	}
 
@@ -749,7 +749,7 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
 	ra.reg = rp->priv->reg_unit;
 	ra.mask = ~0;
 	if (rp->priv->read_raw(cpu, &ra)) {
-		pr_err("Failed to read power unit REG 0x%x on CPU %d, exit.\n",
+		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
 		       rp->priv->reg_unit, cpu);
 		return -ENODEV;
 	}
@@ -777,7 +777,7 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	ra.reg = rp->priv->reg_unit;
 	ra.mask = ~0;
 	if (rp->priv->read_raw(cpu, &ra)) {
-		pr_err("Failed to read power unit REG 0x%x on CPU %d, exit.\n",
+		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
 		       rp->priv->reg_unit, cpu);
 		return -ENODEV;
 	}
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 8964522..6cd8a8f 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -84,8 +84,10 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 
 static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
 {
-	if (rdmsrl_safe_on_cpu(cpu, ra->reg, &ra->value)) {
-		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg, cpu);
+	u32 msr = (u32)ra->reg;
+
+	if (rdmsrl_safe_on_cpu(cpu, msr, &ra->value)) {
+		pr_debug("failed to read msr 0x%x on cpu %d\n", msr, cpu);
 		return -EIO;
 	}
 	ra->value &= ra->mask;
@@ -95,16 +97,17 @@ static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
 static void rapl_msr_update_func(void *info)
 {
 	struct reg_action *ra = info;
+	u32 msr = (u32)ra->reg;
 	u64 val;
 
-	ra->err = rdmsrl_safe(ra->reg, &val);
+	ra->err = rdmsrl_safe(msr, &val);
 	if (ra->err)
 		return;
 
 	val &= ~ra->mask;
 	val |= ra->value;
 
-	ra->err = wrmsrl_safe(ra->reg, val);
+	ra->err = wrmsrl_safe(msr, val);
 }
 
 static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 9579f45..649e199 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -78,7 +78,7 @@ struct rapl_package;
 struct rapl_domain {
 	const char *name;
 	enum rapl_domain_type id;
-	int regs[RAPL_DOMAIN_REG_MAX];
+	u64 regs[RAPL_DOMAIN_REG_MAX];
 	struct powercap_zone power_zone;
 	struct rapl_domain_data rdd;
 	struct rapl_power_limit rpl[NR_POWER_LIMITS];
@@ -89,7 +89,7 @@ struct rapl_domain {
 };
 
 struct reg_action {
-	u32 reg;
+	u64 reg;
 	u64 mask;
 	u64 value;
 	int err;
@@ -113,8 +113,8 @@ struct rapl_if_priv {
 	struct powercap_control_type *control_type;
 	struct rapl_domain *platform_rapl_domain;
 	enum cpuhp_state pcap_rapl_online;
-	u32 reg_unit;
-	u32 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
+	u64 reg_unit;
+	u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
 	int (*read_raw)(int cpu, struct reg_action *ra);
 	int (*write_raw)(int cpu, struct reg_action *ra);
 };
-- 
2.7.4

