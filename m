Return-Path: <linux-pm+bounces-38325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224CC76B44
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 01:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5C0C354E33
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7D72610;
	Fri, 21 Nov 2025 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5mD+9PZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1FFC0A;
	Fri, 21 Nov 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763683636; cv=none; b=BNI+Vt1RHm8xAcsBZzm1L0evpGFpXZLiA73THQ2QrgukRY43rQvRM+cvLpLe7VhJsPUYE/JpXQsTZbhGYZXmlu6/ZFO8SYXQ10eUfmkrYfVy7ZHtDXuJ5OIcVbGCfFf7IWVjiJmvXY86OTH6RvgdcV5XftCd4CVNOvN4ESeqwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763683636; c=relaxed/simple;
	bh=bfJwRDXAxhXckL6EVpNJPFVPl4F1xun6htoI0zZiAhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGMJ0yi16rMrGG0kZ/4rlLKcNEt7ArE9TVEZM/unIYJpbWuvwmi2HYf4klHc5yH7r3vg64RCGzO5hc+sm0QEqcAkzMH7dQSX+aIEtEmObnSaifV9nkXEUu62cr0ZpP+Y5Uf/B79OdYvc3rqdLJeFkV/IPfI6oGxrs1fyoND2tVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5mD+9PZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763683635; x=1795219635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfJwRDXAxhXckL6EVpNJPFVPl4F1xun6htoI0zZiAhI=;
  b=i5mD+9PZXBleqiEMUUoCWZTTy+lyNkbqTeqJgDwKU1+HiDbhbQqUvy4c
   MYTotz0xh+leARSqcP5TCTAJJG4sml8n1svVOiM1BHUHjv/EVFcNNnuGB
   qPdNTUuvM1Jr/+oDjw6EpBm8itVUG73FlKWU0NKF+NKADPf4uutI0AM/f
   lLZxwvovEPda0zp6dS35TM/qvZbVA+8LhJRgVpEqCKO5hgaTYUEy9NAR7
   5ikV5uVFL1gc93y2Iz6tUPbQ7qcxkhj2adre3lat8o/BpQMhiw13d4Jwp
   3fxmvL34gdCV3HoYEgGofP0ODeoS2UQ2EgeaiJFFduiSPSQwALL/7b3FT
   w==;
X-CSE-ConnectionGUID: MH3Z2+b0QXynTB8Ta8X14Q==
X-CSE-MsgGUID: /8osxnl6QMmJtP8RG3seXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65718688"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65718688"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:07:12 -0800
X-CSE-ConnectionGUID: E1FrIAVKRLa4/uuKHJVbBw==
X-CSE-MsgGUID: UOPg/p0BQLujOOlh4Uq5Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="192298636"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:07:12 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] powercap: intel_rapl: Prepare read_raw interface for atomic-context callers
Date: Thu, 20 Nov 2025 16:05:38 -0800
Message-ID: <20251121000539.386069-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current read_raw() implementation of the TPMI, MMIO and MSR
interfaces does not distinguish between atomic and non-atomic callers.

rapl_msr_read_raw() uses rdmsrq_safe_on_cpu(), which can sleep and
issue cross CPU calls. When MSR-based RAPL PMU support is enabled, PMU
event handlers can invoke this function from atomic context where
sleeping or rescheduling is not allowed. In atomic context, the caller
is already executing on the target CPU, so a direct rdmsrq() is
sufficient.

To support such usage, introduce an atomic flag to the read_raw()
interface to allow callers pass the context information. Modify the
common RAPL code to propagate this flag, and set the flag to reflect
the calling contexts.

Utilize the atomic flag in rapl_msr_read_raw() to perform direct MSR
read with rdmsrq() when running in atomic context, and a sanity check
to ensure target CPU matches the current CPU for such use cases.

The TPMI and MMIO implementations do not require special atomic
handling, so the flag is ignored in those paths.

This is a preparatory patch for adding MSR-based RAPL PMU support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c          | 24 ++++++++++---------
 drivers/powercap/intel_rapl_msr.c             | 16 ++++++++++++-
 drivers/powercap/intel_rapl_tpmi.c            |  2 +-
 .../int340x_thermal/processor_thermal_rapl.c  |  2 +-
 include/linux/intel_rapl.h                    |  2 +-
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index c7e7f9bf5313..066779460bc8 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -253,7 +253,8 @@ struct rapl_primitive_info {
 static void rapl_init_domains(struct rapl_package *rp);
 static int rapl_read_data_raw(struct rapl_domain *rd,
 			      enum rapl_primitives prim,
-			      bool xlate, u64 *data);
+			      bool xlate, u64 *data,
+			      bool atomic);
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			       enum rapl_primitives prim,
 			       unsigned long long value);
@@ -289,7 +290,7 @@ static int get_energy_counter(struct powercap_zone *power_zone,
 	cpus_read_lock();
 	rd = power_zone_to_rapl_domain(power_zone);
 
-	if (!rapl_read_data_raw(rd, ENERGY_COUNTER, true, &energy_now)) {
+	if (!rapl_read_data_raw(rd, ENERGY_COUNTER, true, &energy_now, false)) {
 		*energy_raw = energy_now;
 		cpus_read_unlock();
 
@@ -830,7 +831,8 @@ prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
  * 63-------------------------- 31--------------------------- 0
  */
 static int rapl_read_data_raw(struct rapl_domain *rd,
-			      enum rapl_primitives prim, bool xlate, u64 *data)
+			      enum rapl_primitives prim, bool xlate, u64 *data,
+			      bool atomic)
 {
 	u64 value;
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
@@ -852,7 +854,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	ra.mask = rpi->mask;
 
-	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, atomic)) {
 		pr_debug("failed to read reg 0x%llx for %s:%s\n", ra.reg.val, rd->rp->name, rd->name);
 		return -EIO;
 	}
@@ -904,7 +906,7 @@ static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
 	if (!is_pl_valid(rd, pl))
 		return -EINVAL;
 
-	return rapl_read_data_raw(rd, prim, xlate, data);
+	return rapl_read_data_raw(rd, prim, xlate, data, false);
 }
 
 static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
@@ -941,7 +943,7 @@ static int rapl_check_unit_core(struct rapl_domain *rd)
 
 	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, false)) {
 		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
 			ra.reg.val, rd->rp->name, rd->name);
 		return -ENODEV;
@@ -969,7 +971,7 @@ static int rapl_check_unit_atom(struct rapl_domain *rd)
 
 	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, false)) {
 		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
 			ra.reg.val, rd->rp->name, rd->name);
 		return -ENODEV;
@@ -1156,7 +1158,7 @@ static int rapl_check_unit_tpmi(struct rapl_domain *rd)
 
 	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, false)) {
 		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
 			ra.reg.val, rd->rp->name, rd->name);
 		return -ENODEV;
@@ -1325,7 +1327,7 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 			struct rapl_primitive_info *rpi = get_rpi(rp, prim);
 
 			if (!rapl_read_data_raw(&rp->domains[dmn], prim,
-						rpi->unit, &val))
+						rpi->unit, &val, false))
 				rp->domains[dmn].rdd.primitives[prim] = val;
 		}
 	}
@@ -1425,7 +1427,7 @@ static int rapl_check_domain(int domain, struct rapl_package *rp)
 	 */
 
 	ra.mask = ENERGY_STATUS_MASK;
-	if (rp->priv->read_raw(get_rid(rp), &ra) || !ra.value)
+	if (rp->priv->read_raw(get_rid(rp), &ra, false) || !ra.value)
 		return -ENODEV;
 
 	return 0;
@@ -1636,7 +1638,7 @@ static u64 event_read_counter(struct perf_event *event)
 	if (event->hw.idx < 0)
 		return 0;
 
-	ret = rapl_read_data_raw(&rp->domains[event->hw.idx], ENERGY_COUNTER, false, &val);
+	ret = rapl_read_data_raw(&rp->domains[event->hw.idx], ENERGY_COUNTER, false, &val, true);
 
 	/* Return 0 for failed read */
 	if (ret)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 4ed06c71a3ac..46b716ea45b2 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -102,12 +102,26 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
+static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool atomic)
 {
+	/*
+	 * When called from atomic-context (eg PMU event handler)
+	 * perform MSR read directly using rdmsrq().
+	 */
+	if (atomic) {
+		if (unlikely(smp_processor_id() != cpu))
+			return -EIO;
+
+		rdmsrq(ra->reg.msr, ra->value);
+		goto out;
+	}
+
 	if (rdmsrq_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
 		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg.msr, cpu);
 		return -EIO;
 	}
+
+out:
 	ra->value &= ra->mask;
 	return 0;
 }
diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 82201bf4685d..0a0b85f4528b 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -60,7 +60,7 @@ static DEFINE_MUTEX(tpmi_rapl_lock);
 
 static struct powercap_control_type *tpmi_control_type;
 
-static int tpmi_rapl_read_raw(int id, struct reg_action *ra)
+static int tpmi_rapl_read_raw(int id, struct reg_action *ra, bool atomic)
 {
 	if (!ra->reg.mmio)
 		return -EINVAL;
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index bde2cc386afd..bf51a17c5be6 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -19,7 +19,7 @@ static const struct rapl_mmio_regs rapl_mmio_default = {
 	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
-static int rapl_mmio_read_raw(int cpu, struct reg_action *ra)
+static int rapl_mmio_read_raw(int cpu, struct reg_action *ra, bool atomic)
 {
 	if (!ra->reg.mmio)
 		return -EINVAL;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index c0397423d3a8..e9ade2ff4af6 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -152,7 +152,7 @@ struct rapl_if_priv {
 	union rapl_reg reg_unit;
 	union rapl_reg regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
 	int limits[RAPL_DOMAIN_MAX];
-	int (*read_raw)(int id, struct reg_action *ra);
+	int (*read_raw)(int id, struct reg_action *ra, bool atomic);
 	int (*write_raw)(int id, struct reg_action *ra);
 	void *defaults;
 	void *rpi;
-- 
2.43.0


