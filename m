Return-Path: <linux-pm+bounces-42600-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKtZJ+5ijmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42600-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4F131C10
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0771430649DA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680942F3C10;
	Thu, 12 Feb 2026 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWDxdnet"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE912E0926;
	Thu, 12 Feb 2026 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939061; cv=none; b=tVX2hs/Q88wd7XjuCfpudDyE3pqwq81C9j1b8PxEuE5BKyTGYs/1UfpkVAonoP5pTJWp58ZoF2a9LWL2nSCXlPqftRkMlgIzk49QH7jmeC6AXvtdp//tcK9QnxBUJ37cKUibSIrfbZucKFvLZXY9qhC94O6TsJdzJUdOlSqnzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939061; c=relaxed/simple;
	bh=mLBCRNb+BbRb/txhGGWFmIA1mvzuD4rw96+2QGo4GLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgCO4DJlDgMTV4e8wH7MhfdS6wTSlZD6ugnC9cgHDyWmvz7eMpb0pr2z8O0qLrbFr0GCU4S3dP1vsqhLt3obKyR8qp7/yS6JV5817W1vXWTD2FcNTpp13muSVv3qCtqU7XlzmhookUDGwPw+NnM8zfjLLVpu08xlr+PzKqxSAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWDxdnet; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939059; x=1802475059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLBCRNb+BbRb/txhGGWFmIA1mvzuD4rw96+2QGo4GLE=;
  b=cWDxdnetIJuNNyalkLQW6zFDOIx+reWsm6xwXqhxqx0FgP4BIpwDnine
   Ea94d/5iPQrRnLCh6iFIkMzjC+CBL7C9uClsIhMPfjXwUu78lc+JJrDM2
   31JF0xXDeElkAR5T1f1G4MRN6WlnUm+SCDAFlmHLf9+bNinlHpQM5WR5Q
   WVDWivqpiXJwDID69z4gb+aSzwd0F6HF0SmUhEdo70WVzXrrDwb+d5BDE
   gmHzGm40V+JZkfpcEKojIWl+g46flqWJwDO+UDodJ6tWOBMpxBppNY0IF
   uhsdutFjxk7IyOYQYDJhwzJP2aYNb2rsZLfYkaK8z8CEQ7j6jIZ+xOwsb
   g==;
X-CSE-ConnectionGUID: MPpm2eSgSuCAh/oOIj8vDw==
X-CSE-MsgGUID: wQdVyU/UTQGfRWl6JuSXxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017446"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017446"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: q3//cpbcRrCG7cspKowAJA==
X-CSE-MsgGUID: wpPbL0JETjmv3TGt2qYlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845406"
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
Subject: [PATCH v2 08/12] powercap: intel_rapl: Allow interface drivers to configure rapl_defaults
Date: Thu, 12 Feb 2026 15:30:40 -0800
Message-ID: <20260212233044.329790-9-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42600-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 21F4F131C10
X-Rspamd-Action: no action

RAPL default settings vary across different RAPL interfaces (MSR, TPMI,
MMIO). Currently, these defaults are stored in the common RAPL driver,
which requires interface-specific handling logic and makes the common
layer unnecessarily complex. There is no strong reason for the common
code to own these defaults, since they are inherently
interface-specific.

To prepare for moving default configuration into the individual
interface drivers,

1. Move struct rapl_defaults into a shared header so that interface
   drivers can directly populate their own default settings.
2. Change the @defaults field in struct rapl_if_priv from void * to
   const struct rapl_defaults * to improve type safety and readability
   and update the common driver to use the typed defaults structure.
3. Update all internal getter functions and local pointers to use
   const struct rapl_defaults * to maintain const-correctness.
4. Rename and export the common helper functions (check_unit,
   set_floor_freq, compute_time_window) so interface drivers may
   reuse or override them as appropriate.

No functional changes. This is a preparatory refactoring to allow
interface drivers to supply their own RAPL default settings.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 64 ++++++++++++----------------
 include/linux/intel_rapl.h           | 17 +++++++-
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 38b21e3077de..f3a9d3d538cd 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -221,20 +221,10 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
 
-struct rapl_defaults {
-	u8 floor_freq_reg_addr;
-	int (*check_unit)(struct rapl_domain *rd);
-	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
-	u64 (*compute_time_window)(struct rapl_domain *rd, u64 val,
-				    bool to_raw);
-	unsigned int dram_domain_energy_unit;
-	unsigned int psys_domain_energy_unit;
-	bool spr_psys_bits;
-};
-static struct rapl_defaults *defaults_msr;
+static const struct rapl_defaults *defaults_msr;
 static const struct rapl_defaults defaults_tpmi;
 
-static struct rapl_defaults *get_defaults(struct rapl_package *rp)
+static const struct rapl_defaults *get_defaults(struct rapl_package *rp)
 {
 	return rp->priv->defaults;
 }
@@ -351,7 +341,7 @@ static int find_nr_power_limit(struct rapl_domain *rd)
 static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
-	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	const struct rapl_defaults *defaults = get_defaults(rd->rp);
 	u64 val;
 	int ret;
 
@@ -640,7 +630,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 			   u64 value, int to_raw)
 {
 	u64 units = 1;
-	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	const struct rapl_defaults *defaults = get_defaults(rd->rp);
 	u64 scale = 1;
 
 	switch (type) {
@@ -785,11 +775,11 @@ static int rapl_config(struct rapl_package *rp)
 	/* MMIO I/F shares the same register layout as MSR registers */
 	case RAPL_IF_MMIO:
 	case RAPL_IF_MSR:
-		rp->priv->defaults = (void *)defaults_msr;
+		rp->priv->defaults = defaults_msr;
 		rp->priv->rpi = (void *)rpi_msr;
 		break;
 	case RAPL_IF_TPMI:
-		rp->priv->defaults = (void *)&defaults_tpmi;
+		rp->priv->defaults = &defaults_tpmi;
 		rp->priv->rpi = (void *)rpi_tpmi;
 		break;
 	default:
@@ -806,7 +796,7 @@ static int rapl_config(struct rapl_package *rp)
 static enum rapl_primitives
 prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
 {
-	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	const struct rapl_defaults *defaults = get_defaults(rd->rp);
 
 	if (!defaults->spr_psys_bits)
 		return prim;
@@ -951,7 +941,7 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
  * power unit : microWatts  : Represented in milliWatts by default
  * time unit  : microseconds: Represented in seconds by default
  */
-static int rapl_check_unit_core(struct rapl_domain *rd)
+int rapl_default_check_unit(struct rapl_domain *rd)
 {
 	struct reg_action ra;
 	u32 value;
@@ -978,6 +968,7 @@ static int rapl_check_unit_core(struct rapl_domain *rd)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(rapl_default_check_unit, "INTEL_RAPL");
 
 static int rapl_check_unit_atom(struct rapl_domain *rd)
 {
@@ -1071,7 +1062,7 @@ static void package_power_limit_irq_restore(struct rapl_package *rp)
 	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
 }
 
-static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
+void rapl_default_set_floor_freq(struct rapl_domain *rd, bool mode)
 {
 	int i;
 
@@ -1085,11 +1076,12 @@ static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
 		rapl_write_pl_data(rd, i, PL_CLAMP, mode);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(rapl_default_set_floor_freq, "INTEL_RAPL");
 
 static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 {
 	static u32 power_ctrl_orig_val;
-	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	const struct rapl_defaults *defaults = get_defaults(rd->rp);
 	u32 mdata;
 
 	if (!defaults->floor_freq_reg_addr) {
@@ -1110,8 +1102,7 @@ static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 		       defaults->floor_freq_reg_addr, mdata);
 }
 
-static u64 rapl_compute_time_window_core(struct rapl_domain *rd, u64 value,
-					 bool to_raw)
+u64 rapl_default_compute_time_window(struct rapl_domain *rd, u64 value, bool to_raw)
 {
 	u64 f, y;		/* fraction and exp. used for time unit */
 
@@ -1142,6 +1133,7 @@ static u64 rapl_compute_time_window_core(struct rapl_domain *rd, u64 value,
 	}
 	return value;
 }
+EXPORT_SYMBOL_NS_GPL(rapl_default_compute_time_window, "INTEL_RAPL");
 
 static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 					 bool to_raw)
@@ -1187,28 +1179,28 @@ static int rapl_check_unit_tpmi(struct rapl_domain *rd)
 static const struct rapl_defaults defaults_tpmi = {
 	.check_unit = rapl_check_unit_tpmi,
 	/* Reuse existing logic, ignore the PL_CLAMP failures and enable all Power Limits */
-	.set_floor_freq = set_floor_freq_default,
-	.compute_time_window = rapl_compute_time_window_core,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
 };
 
 static const struct rapl_defaults rapl_defaults_core = {
 	.floor_freq_reg_addr = 0,
-	.check_unit = rapl_check_unit_core,
-	.set_floor_freq = set_floor_freq_default,
-	.compute_time_window = rapl_compute_time_window_core,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
 };
 
 static const struct rapl_defaults rapl_defaults_hsw_server = {
-	.check_unit = rapl_check_unit_core,
-	.set_floor_freq = set_floor_freq_default,
-	.compute_time_window = rapl_compute_time_window_core,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
 	.dram_domain_energy_unit = 15300,
 };
 
 static const struct rapl_defaults rapl_defaults_spr_server = {
-	.check_unit = rapl_check_unit_core,
-	.set_floor_freq = set_floor_freq_default,
-	.compute_time_window = rapl_compute_time_window_core,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
 	.psys_domain_energy_unit = NANOJOULE_PER_JOULE,
 	.spr_psys_bits = true,
 };
@@ -1242,7 +1234,7 @@ static const struct rapl_defaults rapl_defaults_cht = {
 };
 
 static const struct rapl_defaults rapl_defaults_amd = {
-	.check_unit = rapl_check_unit_core,
+	.check_unit = rapl_default_check_unit,
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
@@ -1448,7 +1440,7 @@ static int rapl_check_domain(int domain, struct rapl_package *rp)
  */
 static int rapl_get_domain_unit(struct rapl_domain *rd)
 {
-	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	const struct rapl_defaults *defaults = get_defaults(rd->rp);
 	int ret;
 
 	if (!rd->regs[RAPL_DOMAIN_REG_UNIT].val) {
@@ -2347,7 +2339,7 @@ static int __init rapl_init(void)
 
 	id = x86_match_cpu(rapl_ids);
 	if (id) {
-		defaults_msr = (struct rapl_defaults *)id->driver_data;
+		defaults_msr = (const struct rapl_defaults *)id->driver_data;
 
 		rapl_msr_platdev = platform_device_alloc("intel_rapl_msr", 0);
 		if (!rapl_msr_platdev)
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index f479ef5b3341..19f619fb37ff 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -128,6 +128,16 @@ struct reg_action {
 	int err;
 };
 
+struct rapl_defaults {
+	u8 floor_freq_reg_addr;
+	int (*check_unit)(struct rapl_domain *rd);
+	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
+	u64 (*compute_time_window)(struct rapl_domain *rd, u64 val, bool to_raw);
+	unsigned int dram_domain_energy_unit;
+	unsigned int psys_domain_energy_unit;
+	bool spr_psys_bits;
+};
+
 /**
  * struct rapl_if_priv: private data for different RAPL interfaces
  * @control_type:		Each RAPL interface must have its own powercap
@@ -142,7 +152,7 @@ struct reg_action {
  *				registers.
  * @write_raw:			Callback for writing RAPL interface specific
  *				registers.
- * @defaults:			internal pointer to interface default settings
+ * @defaults:			pointer to default settings
  * @rpi:			internal pointer to interface primitive info
  */
 struct rapl_if_priv {
@@ -154,7 +164,7 @@ struct rapl_if_priv {
 	int limits[RAPL_DOMAIN_MAX];
 	int (*read_raw)(int id, struct reg_action *ra, bool atomic);
 	int (*write_raw)(int id, struct reg_action *ra);
-	void *defaults;
+	const struct rapl_defaults *defaults;
 	void *rpi;
 };
 
@@ -211,6 +221,9 @@ void rapl_remove_package_cpuslocked(struct rapl_package *rp);
 struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 void rapl_remove_package(struct rapl_package *rp);
+int rapl_default_check_unit(struct rapl_domain *rd);
+void rapl_default_set_floor_freq(struct rapl_domain *rd, bool mode);
+u64 rapl_default_compute_time_window(struct rapl_domain *rd, u64 value, bool to_raw);
 
 #ifdef CONFIG_PERF_EVENTS
 int rapl_package_add_pmu(struct rapl_package *rp);
-- 
2.43.0


