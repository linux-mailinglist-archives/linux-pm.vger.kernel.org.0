Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24AC64757
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfGJNow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 09:44:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:8319 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfGJNow (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 09:44:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 06:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170923306"
Received: from ygao39-mobl1.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.255.30.205])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2019 06:44:50 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V3 06/17] intel_rapl: abstract register access operations
Date:   Wed, 10 Jul 2019 21:44:27 +0800
Message-Id: <1562766278-7099-7-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562766278-7099-1-git-send-email-rui.zhang@intel.com>
References: <1562766278-7099-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSR and MMIO RAPL interfaces have different ways to access the registers,
thus in order to abstract the register access operations, two callbacks,
.read_raw()/.write_raw() are introduced, and they should be implemented by
MSR RAPL and MMIO RAPL interface driver respectly.

This patch implements them for the MSR I/F only.

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 110 ++++++++++++++++++++++--------------------
 include/linux/intel_rapl.h    |  13 +++++
 2 files changed, 70 insertions(+), 53 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 9f22aed..d3b9d1c 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -93,13 +93,6 @@ static struct rapl_if_priv rapl_msr_priv = {
 /* per domain data, some are optional */
 #define NR_RAW_PRIMITIVES (NR_RAPL_PRIMITIVES - 2)
 
-struct msrl_action {
-	u32 msr_no;
-	u64 clear_mask;
-	u64 set_mask;
-	int err;
-};
-
 #define	DOMAIN_STATE_INACTIVE           BIT(0)
 #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
 #define DOMAIN_STATE_BIOS_LOCKED        BIT(2)
@@ -692,16 +685,16 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
 			bool xlate, u64 *data)
 {
-	u64 value, final;
-	u32 msr;
+	u64 value;
 	struct rapl_primitive_info *rp = &rpi[prim];
+	struct reg_action ra;
 	int cpu;
 
 	if (!rp->name || rp->flag & RAPL_PRIMITIVE_DUMMY)
 		return -EINVAL;
 
-	msr = rd->regs[rp->id];
-	if (!msr)
+	ra.reg = rd->regs[rp->id];
+	if (!ra.reg)
 		return -EINVAL;
 
 	cpu = rd->rp->lead_cpu;
@@ -717,47 +710,23 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 		return 0;
 	}
 
-	if (rdmsrl_safe_on_cpu(cpu, msr, &value)) {
-		pr_debug("failed to read msr 0x%x on cpu %d\n", msr, cpu);
+	ra.mask = rp->mask;
+
+	if (rd->rp->priv->read_raw(cpu, &ra)) {
+		pr_debug("failed to read reg 0x%x on cpu %d\n", ra.reg, cpu);
 		return -EIO;
 	}
 
-	final = value & rp->mask;
-	final = final >> rp->shift;
+	value = ra.value >> rp->shift;
+
 	if (xlate)
-		*data = rapl_unit_xlate(rd, rp->unit, final, 0);
+		*data = rapl_unit_xlate(rd, rp->unit, value, 0);
 	else
-		*data = final;
+		*data = value;
 
 	return 0;
 }
 
-
-static int msrl_update_safe(u32 msr_no, u64 clear_mask, u64 set_mask)
-{
-	int err;
-	u64 val;
-
-	err = rdmsrl_safe(msr_no, &val);
-	if (err)
-		goto out;
-
-	val &= ~clear_mask;
-	val |= set_mask;
-
-	err = wrmsrl_safe(msr_no, val);
-
-out:
-	return err;
-}
-
-static void msrl_update_func(void *info)
-{
-	struct msrl_action *ma = info;
-
-	ma->err = msrl_update_safe(ma->msr_no, ma->clear_mask, ma->set_mask);
-}
-
 /* Similar use of primitive info in the read counterpart */
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
@@ -766,7 +735,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	struct rapl_primitive_info *rp = &rpi[prim];
 	int cpu;
 	u64 bits;
-	struct msrl_action ma;
+	struct reg_action ra;
 	int ret;
 
 	cpu = rd->rp->lead_cpu;
@@ -774,17 +743,13 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	bits <<= rp->shift;
 	bits &= rp->mask;
 
-	memset(&ma, 0, sizeof(ma));
+	memset(&ra, 0, sizeof(ra));
 
-	ma.msr_no = rd->regs[rp->id];
-	ma.clear_mask = rp->mask;
-	ma.set_mask = bits;
+	ra.reg = rd->regs[rp->id];
+	ra.mask = rp->mask;
+	ra.value = bits;
 
-	ret = smp_call_function_single(cpu, msrl_update_func, &ma, 1);
-	if (ret)
-		WARN_ON_ONCE(ret);
-	else
-		ret = ma.err;
+	ret = rd->rp->priv->write_raw(cpu, &ra);
 
 	return ret;
 }
@@ -1507,6 +1472,43 @@ static struct notifier_block rapl_pm_notifier = {
 	.notifier_call = rapl_pm_callback,
 };
 
+static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
+{
+	if (rdmsrl_safe_on_cpu(cpu, ra->reg, &ra->value)) {
+		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg, cpu);
+		return -EIO;
+	}
+	ra->value &= ra->mask;
+	return 0;
+}
+
+static void rapl_msr_update_func(void *info)
+{
+	struct reg_action *ra = info;
+	u64 val;
+
+	ra->err = rdmsrl_safe(ra->reg, &val);
+	if (ra->err)
+		return;
+
+	val &= ~ra->mask;
+	val |= ra->value;
+
+	ra->err = wrmsrl_safe(ra->reg, val);
+}
+
+
+static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
+{
+	int ret;
+
+	ret = smp_call_function_single(cpu, rapl_msr_update_func, ra, 1);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	return ra->err;
+}
+
 static int __init rapl_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -1522,6 +1524,8 @@ static int __init rapl_init(void)
 
 	rapl_defaults = (struct rapl_defaults *)id->driver_data;
 
+	rapl_msr_priv.read_raw = rapl_msr_read_raw;
+	rapl_msr_priv.write_raw = rapl_msr_write_raw;
 	ret = rapl_register_powercap();
 	if (ret)
 		return ret;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index ec2c9e8..ff215d6 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -88,6 +88,13 @@ struct rapl_domain {
 	struct rapl_package *rp;
 };
 
+struct reg_action {
+	u32 reg;
+	u64 mask;
+	u64 value;
+	int err;
+};
+
 /**
  * struct rapl_if_priv: private data for different RAPL interfaces
  * @control_type:		Each RAPL interface must have its own powercap
@@ -97,6 +104,10 @@ struct rapl_domain {
  * @pcap_rapl_online:		CPU hotplug state for each RAPL interface.
  * @reg_unit:			Register for getting energy/power/time unit.
  * @regs:			Register sets for different RAPL Domains.
+ * @read_raw:			Callback for reading RAPL interface specific
+ *				registers.
+ * @write_raw:			Callback for writing RAPL interface specific
+ *				registers.
  */
 struct rapl_if_priv {
 	struct powercap_control_type *control_type;
@@ -104,6 +115,8 @@ struct rapl_if_priv {
 	enum cpuhp_state pcap_rapl_online;
 	u32 reg_unit;
 	u32 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
+	int (*read_raw)(int cpu, struct reg_action *ra);
+	int (*write_raw)(int cpu, struct reg_action *ra);
 };
 
 /* maximum rapl package domain name: package-%d-die-%d */
-- 
2.7.4

