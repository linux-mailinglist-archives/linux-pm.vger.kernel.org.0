Return-Path: <linux-pm+bounces-42601-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PjKM9tjjmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42601-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:35:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DA8131C78
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADA4B320179A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97A2EDD5D;
	Thu, 12 Feb 2026 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+OvA9kF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743A2F25F0;
	Thu, 12 Feb 2026 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939066; cv=none; b=AeVWQORVy6BbiCNlOAV0qXJDPNXa5DkqgJA1pt0FRVoI0XnCEk0fogogaM6ZnVP5BW0iY8+7vaJrpdxceQMcmb6Yt1CW2RJL+vFAyXl+24TAzAutJwXgLYFp0MVvF3PGO/CfcUK5IcQsHIvRBv04F/NFzQoqM+Qx8l2M1olghwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939066; c=relaxed/simple;
	bh=/+i6Nk67HkJZJewCj3D1iKKpfyUtVvVUzzKEo527WdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os2vy4UGTkc2CYpYOjxR0BABUNlxToU41uboZZQTgxaZOqHmAxVTfPVuGaaoxtA81w5eaeJA+oc5ZoAI0eg87OQUv1yj7VEC3zjqI6RVP5kTbBEzIob131Ql0breJC4W2jqtqAViTANnIn6FZecBPRMuuiFyswWITqHMcE/JcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+OvA9kF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939060; x=1802475060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+i6Nk67HkJZJewCj3D1iKKpfyUtVvVUzzKEo527WdM=;
  b=M+OvA9kFKpB+UAyKLeujTVb2weHBGiKrxCKMhfg0zYLEaFxqjkzFK7SC
   fRF8WQ89KgFGc7gtX2gZf9PotqbdWDu0NqF8lCRPJfWnPEGKeKDoJGYKN
   jFEUvGns0bmtyycwinhUdbx7b/Od0YHxIepXUkAXXcUPs2vRNLiMq9mYg
   m1eDJ9vrUemGtEtjB2N6RSWn723TjKFg9U2KG/wJYvazfM9GbEMDHXey9
   qxRCAm03ahnWIUnDqjgYEm5mM9/xZCzDy9VUg3rBg8hZ+esneks2y3Azc
   0vmw17T5vxbfRW/CnksZXmE3OMAekIEctQlvcafxJjvomgrhoEo1w5T5Q
   A==;
X-CSE-ConnectionGUID: 5xH9YgRiT7CETD3C5VusQg==
X-CSE-MsgGUID: TY6a2CedS72wSzMXncat/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017450"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017450"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: N7op7ktMQBSK783c6Hc6VQ==
X-CSE-MsgGUID: cbBB571ZSWKG9Y4pZN2okA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845408"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:46 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] powercap: intel_rapl: Move TPMI default settings into TPMI interface driver
Date: Thu, 12 Feb 2026 15:30:41 -0800
Message-ID: <20260212233044.329790-10-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42601-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29DA8131C78
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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 45 --------------------------
 drivers/powercap/intel_rapl_tpmi.c   | 47 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index f3a9d3d538cd..bfe3dc011911 100644
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
-	rd->energy_unit = (ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE) >> value;
-
-	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
-	rd->power_unit = MICROWATT_PER_WATT >> value;
-
-	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
-	rd->time_unit = USEC_PER_SEC >> value;
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
index 3b52403c14f8..fb61678ca701 100644
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
+	rd->energy_unit = (TPMI_ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE) >> value;
+
+	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
+	rd->power_unit = MICROWATT_PER_WATT >> value;
+
+	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
+	rd->time_unit = USEC_PER_SEC >> value;
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


