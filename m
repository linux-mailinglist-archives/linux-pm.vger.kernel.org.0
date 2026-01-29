Return-Path: <linux-pm+bounces-41716-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pc4LPCoe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41716-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BA0B39F5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62AA530304A2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1562FFF97;
	Thu, 29 Jan 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuNdnHJz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B22FD1C1;
	Thu, 29 Jan 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711830; cv=none; b=UYOW7ntcicVN9JfbJUsQFFOzIaynqzYDDQ9Dz7nggQjVpT7LgzUz8ZTGRIoWYyMwLR39K76/krfoQOiu7aRb/5CA7697WneOYN0AKaumDPRR29if01QJ6LjkpADT4obVFIq4ydjFVPUIZwCdeT/SyVs+nUMZAbPd1GZhpv/y78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711830; c=relaxed/simple;
	bh=6ryPmE3OorRopStbhVBhoEoT0eyeibEOYzCYWc/0zig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuRKvSV66j4WhqrYRbUdt/DfugZvPhAPyJ9IBTjxuqeypvJVJ2JHZ973SEk5U+Oh5LEwGniC5SWMqHzqxl1Kg1e8brRZZvkb51LZLVngaI/7+BN1AydLsLokPozoOx24Lprsw2uirDB9OwYFqZryfYUi3lzZpnEmMwJeyAy60bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuNdnHJz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711829; x=1801247829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ryPmE3OorRopStbhVBhoEoT0eyeibEOYzCYWc/0zig=;
  b=TuNdnHJz/nmTEeosb98IcObaCeWa0ZZ2HgMcy/AQQ8FAM0qhWQxMRJjm
   88JCMziOvMs4pHmSAZNOGmgPhpCPj0TytF0gxQ2rWLvjc8DBMwqrhb9hH
   /tjebXqB1u5JAV5wjgCpclaFsez+nUGhTX5pOLicgirE0J/cXTYmq1XuK
   OLxczYxo2G+qpFHqmpTrb2KFfVI9m0y+YUv/d4z4WyHBYMH3Rg9uXI59S
   I4go2AZG9yFkyJtLTg6QEMU0UYZsr7+jTPS4bjeaM8Z4XG+bSf3JRWC1m
   KIgDzHoMTPtsWc0477BWTbEHMulfzw2kP2CwleYsln0vqCoPvcS25JWZR
   g==;
X-CSE-ConnectionGUID: 4gXWSmN8Qt68Qm+VCSVq1g==
X-CSE-MsgGUID: 25McMezvQKakvGGPTURkyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388373"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388373"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:07 -0800
X-CSE-ConnectionGUID: mWktzOv1RqGtLokGKKJpGA==
X-CSE-MsgGUID: N8ixxUvyQbeqoU9+OExkrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070973"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:07 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/9] powercap: intel_rapl: Move TPMI default settings into TPMI interface driver
Date: Thu, 29 Jan 2026 10:36:43 -0800
Message-ID: <20260129183646.558866-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41716-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66BA0B39F5
X-Rspamd-Action: no action

TPMI-specific RAPL defaults differ from those used by MSR and MMIO
interfaces. Keeping them in RAPL common driver introduces unnecessary
complexity.

Move the TPMI defaults into the TPMI interface driver. This change
includes the following updates:

1. Add a TPMI-local struct rapl_defaults instance and assign it to
priv->defaults during TPMI probe.
2. Move rapl_check_unit_tpmi() and related unit-field definitions from
the common driver into the TPMI driver.
3. In rapl_check_unit_tpmi(), replace the generic get_rid() usage with
direct access to the TPMI package ID, since the function is now
interface-specific.

No functional changes are intended.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 45 --------------------------
 drivers/powercap/intel_rapl_tpmi.c   | 47 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index b60d8fd6cc82..54d88f1311ed 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -108,14 +108,6 @@
 #define PACKAGE_PLN_INT_SAVED		BIT(0)
 #define MAX_PRIM_NAME			32
 
-/* TPMI Unit register has different layout */
-#define TPMI_POWER_UNIT_OFFSET		POWER_UNIT_OFFSET
-#define TPMI_POWER_UNIT_MASK		POWER_UNIT_MASK
-#define TPMI_ENERGY_UNIT_OFFSET		0x06
-#define TPMI_ENERGY_UNIT_MASK		GENMASK_ULL(10, 6)
-#define TPMI_TIME_UNIT_OFFSET		0x0C
-#define TPMI_TIME_UNIT_MASK		GENMASK_ULL(15, 12)
-
 #define RAPL_EVENT_MASK			GENMASK(7, 0)
 
 enum unit_type {
@@ -222,7 +214,6 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 	container_of(_zone, struct rapl_domain, power_zone)
 
 static const struct rapl_defaults *defaults_msr;
-static const struct rapl_defaults defaults_tpmi;
 
 static const struct rapl_defaults *get_defaults(struct rapl_package *rp)
 {
@@ -779,7 +770,6 @@ static int rapl_config(struct rapl_package *rp)
 		rp->priv->rpi = (void *)rpi_msr;
 		break;
 	case RAPL_IF_TPMI:
-		rp->priv->defaults = &defaults_tpmi;
 		rp->priv->rpi = (void *)rpi_tpmi;
 		break;
 	default:
@@ -1148,41 +1138,6 @@ static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 	return (value) ? value * rd->time_unit : rd->time_unit;
 }
 
-static int rapl_check_unit_tpmi(struct rapl_domain *rd)
-{
-	struct reg_action ra;
-	u32 value;
-
-	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
-	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, false)) {
-		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
-			ra.reg.val, rd->rp->name, rd->name);
-		return -ENODEV;
-	}
-
-	value = (ra.value & TPMI_ENERGY_UNIT_MASK) >> TPMI_ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE / BIT(value);
-
-	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
-	rd->power_unit = MICROWATT_PER_WATT / BIT(value);
-
-	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
-	rd->time_unit = USEC_PER_SEC / BIT(value);
-
-	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
-		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
-
-	return 0;
-}
-
-static const struct rapl_defaults defaults_tpmi = {
-	.check_unit = rapl_check_unit_tpmi,
-	/* Reuse existing logic, ignore the PL_CLAMP failures and enable all Power Limits */
-	.set_floor_freq = rapl_default_set_floor_freq,
-	.compute_time_window = rapl_default_compute_time_window,
-};
-
 static const struct rapl_defaults rapl_defaults_core = {
 	.floor_freq_reg_addr = 0,
 	.check_unit = rapl_default_check_unit,
diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 3b52403c14f8..2d69cf594dc2 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -9,12 +9,14 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
 #include <linux/intel_rapl.h>
 #include <linux/intel_tpmi.h>
 #include <linux/intel_vsec.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #define TPMI_RAPL_MAJOR_VERSION 0
 #define TPMI_RAPL_MINOR_VERSION 1
@@ -250,6 +252,50 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 	return 0;
 }
 
+/* TPMI Unit register has different layout */
+#define TPMI_ENERGY_UNIT_SCALE		1000
+#define TPMI_POWER_UNIT_OFFSET		0x00
+#define TPMI_POWER_UNIT_MASK		GENMASK(3, 0)
+#define TPMI_ENERGY_UNIT_OFFSET		0x06
+#define TPMI_ENERGY_UNIT_MASK		GENMASK_ULL(10, 6)
+#define TPMI_TIME_UNIT_OFFSET		0x0C
+#define TPMI_TIME_UNIT_MASK		GENMASK_ULL(15, 12)
+
+static int rapl_check_unit_tpmi(struct rapl_domain *rd)
+{
+	struct reg_action ra;
+	u32 value;
+
+	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
+	ra.mask = ~0;
+	if (tpmi_rapl_read_raw(rd->rp->id, &ra, false)) {
+		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
+			ra.reg.val, rd->rp->name, rd->name);
+		return -ENODEV;
+	}
+
+	value = (ra.value & TPMI_ENERGY_UNIT_MASK) >> TPMI_ENERGY_UNIT_OFFSET;
+	rd->energy_unit = TPMI_ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE / BIT(value);
+
+	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
+	rd->power_unit = MICROWATT_PER_WATT / BIT(value);
+
+	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
+	rd->time_unit = USEC_PER_SEC / BIT(value);
+
+	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
+		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
+
+	return 0;
+}
+
+static const struct rapl_defaults defaults_tpmi = {
+	.check_unit = rapl_check_unit_tpmi,
+	/* Reuse existing logic, ignore the PL_CLAMP failures and enable all Power Limits */
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+};
+
 static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 				 const struct auxiliary_device_id *id)
 {
@@ -297,6 +343,7 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 	trp->priv.read_raw = tpmi_rapl_read_raw;
 	trp->priv.write_raw = tpmi_rapl_write_raw;
 	trp->priv.control_type = tpmi_control_type;
+	trp->priv.defaults = &defaults_tpmi;
 
 	/* RAPL TPMI I/F is per physical package */
 	trp->rp = rapl_find_package_domain(info->package_id, &trp->priv, false);
-- 
2.43.0


