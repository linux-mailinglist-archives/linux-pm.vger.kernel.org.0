Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1186055319
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfFYPRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 11:17:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:15842 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfFYPRI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 11:17:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 08:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="161946649"
Received: from syhu-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.173.95])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2019 08:17:06 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH 06/13] intel_rapl: abstract register access operations
Date:   Tue, 25 Jun 2019 23:16:41 +0800
Message-Id: <1561475808-24839-7-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561475808-24839-1-git-send-email-rui.zhang@intel.com>
References: <1561475808-24839-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSR and MMIO RAPL interfaces have different ways to access the registers,
thus in order to abstract the regsiter access operations, two callbacks,
.read_raw()/.write_raw() are introduced, and they should be implemented by
MSR RAPL and MMIO RAPL interface driver respectly.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 111 ++++++++++++++++++++++--------------------
 include/linux/intel_rapl.h    |   9 ++++
 2 files changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 70990ff..7dc9965 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -92,13 +92,6 @@ static struct rapl_priv rapl_msr_priv = {
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
@@ -691,16 +684,16 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
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
@@ -716,47 +709,23 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
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
@@ -765,7 +734,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	struct rapl_primitive_info *rp = &rpi[prim];
 	int cpu;
 	u64 bits;
-	struct msrl_action ma;
+	struct reg_action ra;
 	int ret;
 
 	cpu = rd->rp->lead_cpu;
@@ -773,17 +742,13 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
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
@@ -1506,6 +1471,44 @@ static struct notifier_block rapl_pm_notifier = {
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
+	if (ret)
+		WARN_ON_ONCE(ret);
+	else
+		ret = ra->err;
+	return ret;
+}
+
 static int __init rapl_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -1521,6 +1524,8 @@ static int __init rapl_init(void)
 
 	rapl_defaults = (struct rapl_defaults *)id->driver_data;
 
+	rapl_msr_priv.read_raw = rapl_msr_read_raw;
+	rapl_msr_priv.write_raw = rapl_msr_write_raw;
 	ret = rapl_register_powercap();
 	if (ret)
 		return ret;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 0277579..1a0df65 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -88,12 +88,21 @@ struct rapl_domain {
 	struct rapl_package *rp;
 };
 
+struct reg_action {
+	u32 reg;
+	u64 mask;
+	u64 value;
+	int err;
+};
+
 struct rapl_priv {
 	struct powercap_control_type *control_type;
 	struct rapl_domain *platform_rapl_domain;
 	enum cpuhp_state pcap_rapl_online;
 	u32 reg_unit;
 	u32 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
+	int (*read_raw)(int cpu, struct reg_action *ra);
+	int (*write_raw)(int cpu, struct reg_action *ra);
 };
 
 /* maximum rapl package domain name: package-%d-die-%d */
-- 
2.7.4

