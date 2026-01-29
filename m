Return-Path: <linux-pm+bounces-41719-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKpbEQupe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41719-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:38:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B23B3A28
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A74303DAE2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D0308F33;
	Thu, 29 Jan 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZziHWSoo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E12FFFAB;
	Thu, 29 Jan 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711832; cv=none; b=efjZGk9mMh/IxdRfuusoV8dPP2/AelY2xRxiIZIgm49BMfw6x6CMzJVBmEuFsHzenewk4jOVtga4RG9p8Ss9N3scl/USk/RA7iYfZKG78TI4fElQRxd4W5R5IyB2K/NXlj4yjUQrSBfWkEF7JJ3Sh5tqzGiJQY7vG2roUBvybzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711832; c=relaxed/simple;
	bh=qwejIcEeMSzXBi0UnRthQ5hIfijCMOVFKmApMSMMuR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9STi0lqFfg+BUzXNF66Z2T3XnGv86o49pCwhpYj39zBP81oarsh5VJcaIAosp4L4JGX6mqf2vK0rx4vxmGsEVCIgOJzks/O136KGhX+cH/7yUY6Zg2je+yKdEKbFoxdzkUcpxlunJ3frYoXl4NjwGc1qUn3Q5yHJQvKZbW7X3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZziHWSoo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711830; x=1801247830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwejIcEeMSzXBi0UnRthQ5hIfijCMOVFKmApMSMMuR4=;
  b=ZziHWSoodct8BrjGVskDdJdSpMgN31TsSoM6KtZjmvAJ7d3B+7uSS1cl
   2XYuIMl/wsMewkCKRVqiWx+uhaKsVPeOHDA8/I4Yw1rnpNVs66H1Ic6n5
   bKI1RSMnfcyoWqL12dkt77ajb/MifSz9DK0DShHdPiXYY2ZYTnc4/XM+i
   Kmpcfab5ThS1V4XEWkX7MvOLcaskfrFhRCFMSrDrZqGkmPu05lGmQHIE0
   m+QJzD0Y6MZ1FRSyG4qpBwANCN+ChKUlN+VT7siwOxD/9vxixN6lrVmwN
   P5g/IQBiBIQuMmL1+RyZJmwlGqj++ALDsdZorZSSHrb5GO9eRRV/N7whS
   A==;
X-CSE-ConnectionGUID: v/uIBfsnSKGlEtU93uLrRA==
X-CSE-MsgGUID: k02NbvP8SgKsR8hIDKrMbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388388"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388388"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:09 -0800
X-CSE-ConnectionGUID: +mxavh1aRe23I4FukDjxjA==
X-CSE-MsgGUID: AQk7a1a0TKqFysQc1Mx8oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070990"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:08 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 9/9] powercap: intel_rapl: Move MSR default settings into MSR interface driver
Date: Thu, 29 Jan 2026 10:36:46 -0800
Message-ID: <20260129183646.558866-10-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-41719-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 00B23B3A28
X-Rspamd-Action: no action

MSR-specific RAPL defaults differ from those used by the TPMI interface.
The MMIO and MSR interfaces shared the same rapl_defaults pointer in the
common driver, but MMIO does not require the CPU-specific variations
needed by MSR. Keeping these in the common driver adds unnecessary
complexity and MSR-specific initialization.

Move MSR defaults and CPU matching into the MSR interface driver.

Moves
-----
  * Move rapl_check_unit_atom(), set_floor_freq_atom(), and
    rapl_compute_time_window_atom() into intel_rapl_msr.c.
  * Move MSR unit-field GENMASK definitions and local constants.
  * Move all MSR-related rapl_defaults tables and the CPU-ID matching
    logic (rapl_ids[]) into the MSR driver.
  * Move iosf_mbi dependencies (floor-frequency control and related MBI
    register definitions) as they are MSR-platform specific.

Modifications
-------------
  * Replace the common driver's platform-device manual alloc/add sequence
    with platform_device_register_data() in the MSR driver to pass
    matching rapl_defaults as platform_data.
  * Update MSR driver probe to assign pdev->dev.platform_data to
    priv->defaults.
  * Update Atom helper functions to use rp->lead_cpu directly for MSR
    reads/writes instead of the generic get_rid().
  * Update Atom floor frequency logic to access defaults via the
    package private data pointer.
  * Convert MSR device creation from fs_initcall() to module_init().
    This preserves existing enumeration behavior as the driver was
    already using module_init().
  * Since rapl_ids need to exist after boot, remove __initconst
    specifier.

No functional changes are expected.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 232 -------------------------
 drivers/powercap/intel_rapl_msr.c    | 250 ++++++++++++++++++++++++++-
 2 files changed, 249 insertions(+), 233 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 648bef1d5de1..75637ad69152 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -28,7 +28,6 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/iosf_mbi.h>
 #include <asm/msr.h>
 
 /* bitmasks for RAPL MSRs, used by primitive access functions */
@@ -213,8 +212,6 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
 
-static const struct rapl_defaults *defaults_msr;
-
 static const struct rapl_defaults *get_defaults(struct rapl_package *rp)
 {
 	return rp->priv->defaults;
@@ -766,7 +763,6 @@ static int rapl_config(struct rapl_package *rp)
 	/* MMIO I/F shares the same register layout as MSR registers */
 	case RAPL_IF_MMIO:
 	case RAPL_IF_MSR:
-		rp->priv->defaults = defaults_msr;
 		rp->priv->rpi = (void *)rpi_msr;
 		break;
 	case RAPL_IF_TPMI:
@@ -960,34 +956,6 @@ int rapl_default_check_unit(struct rapl_domain *rd)
 }
 EXPORT_SYMBOL_NS_GPL(rapl_default_check_unit, "INTEL_RAPL");
 
-static int rapl_check_unit_atom(struct rapl_domain *rd)
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
-	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * BIT(value);
-
-	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = BIT(value) * MILLIWATT_PER_WATT;
-
-	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = USEC_PER_SEC / BIT(value);
-
-	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
-		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
-
-	return 0;
-}
-
 static void power_limit_irq_save_cpu(void *info)
 {
 	u32 l, h = 0;
@@ -1068,30 +1036,6 @@ void rapl_default_set_floor_freq(struct rapl_domain *rd, bool mode)
 }
 EXPORT_SYMBOL_NS_GPL(rapl_default_set_floor_freq, "INTEL_RAPL");
 
-static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
-{
-	static u32 power_ctrl_orig_val;
-	const struct rapl_defaults *defaults = get_defaults(rd->rp);
-	u32 mdata;
-
-	if (!defaults->floor_freq_reg_addr) {
-		pr_err("Invalid floor frequency config register\n");
-		return;
-	}
-
-	if (!power_ctrl_orig_val)
-		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
-			      defaults->floor_freq_reg_addr,
-			      &power_ctrl_orig_val);
-	mdata = power_ctrl_orig_val;
-	if (enable) {
-		mdata &= ~GENMASK(14, 8);
-		mdata |= BIT(8);
-	}
-	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
-		       defaults->floor_freq_reg_addr, mdata);
-}
-
 u64 rapl_default_compute_time_window(struct rapl_domain *rd, u64 value, bool to_raw)
 {
 	u64 f, y;		/* fraction and exp. used for time unit */
@@ -1125,149 +1069,6 @@ u64 rapl_default_compute_time_window(struct rapl_domain *rd, u64 value, bool to_
 }
 EXPORT_SYMBOL_NS_GPL(rapl_default_compute_time_window, "INTEL_RAPL");
 
-static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
-					 bool to_raw)
-{
-	if (to_raw)
-		return div64_u64(value, rd->time_unit);
-
-	/*
-	 * Atom time unit encoding is straight forward val * time_unit,
-	 * where time_unit is default to 1 sec. Never 0.
-	 */
-	return (value) ? value * rd->time_unit : rd->time_unit;
-}
-
-static const struct rapl_defaults rapl_defaults_core = {
-	.floor_freq_reg_addr = 0,
-	.check_unit = rapl_default_check_unit,
-	.set_floor_freq = rapl_default_set_floor_freq,
-	.compute_time_window = rapl_default_compute_time_window,
-};
-
-static const struct rapl_defaults rapl_defaults_hsw_server = {
-	.check_unit = rapl_default_check_unit,
-	.set_floor_freq = rapl_default_set_floor_freq,
-	.compute_time_window = rapl_default_compute_time_window,
-	.dram_domain_energy_unit = 15300,
-};
-
-static const struct rapl_defaults rapl_defaults_spr_server = {
-	.check_unit = rapl_default_check_unit,
-	.set_floor_freq = rapl_default_set_floor_freq,
-	.compute_time_window = rapl_default_compute_time_window,
-	.psys_domain_energy_unit = NANOJOULE_PER_JOULE,
-	.spr_psys_bits = true,
-};
-
-static const struct rapl_defaults rapl_defaults_byt = {
-	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = set_floor_freq_atom,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_tng = {
-	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_TNG,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = set_floor_freq_atom,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_ann = {
-	.floor_freq_reg_addr = 0,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = NULL,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_cht = {
-	.floor_freq_reg_addr = 0,
-	.check_unit = rapl_check_unit_atom,
-	.set_floor_freq = NULL,
-	.compute_time_window = rapl_compute_time_window_atom,
-};
-
-static const struct rapl_defaults rapl_defaults_amd = {
-	.check_unit = rapl_default_check_unit,
-};
-
-static const struct x86_cpu_id rapl_ids[] __initconst = {
-	X86_MATCH_VFM(INTEL_SANDYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_IVYBRIDGE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_HASWELL,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_G,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_X,			&rapl_defaults_hsw_server),
-
-	X86_MATCH_VFM(INTEL_BROADWELL,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_G,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_D,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_VFM(INTEL_SKYLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SKYLAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SKYLAKE_X,			&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_KABYLAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_KABYLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_CANNONLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_X,			&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_ICELAKE_D,			&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_COMETLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_COMETLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_TIGERLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ROCKETLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BARTLETTLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,		&rapl_defaults_spr_server),
-	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaults_spr_server),
-	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_LAKEFIELD,			&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,		&rapl_defaults_byt),
-	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,		&rapl_defaults_cht),
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,	&rapl_defaults_ann),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,		&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,		&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_VENDOR_FAM(AMD, 0x17,			&rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(AMD, 0x19,			&rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(AMD, 0x1A,			&rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(HYGON, 0x18,		&rapl_defaults_amd),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-
 /* Read once for all raw primitive data for domains */
 static void rapl_update_domain_data(struct rapl_package *rp)
 {
@@ -2290,39 +2091,6 @@ struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id
 }
 EXPORT_SYMBOL_NS_GPL(rapl_add_package, "INTEL_RAPL");
 
-static struct platform_device *rapl_msr_platdev;
-
-static int __init rapl_init(void)
-{
-	const struct x86_cpu_id *id;
-	int ret;
-
-	id = x86_match_cpu(rapl_ids);
-	if (id) {
-		defaults_msr = (const struct rapl_defaults *)id->driver_data;
-
-		rapl_msr_platdev = platform_device_alloc("intel_rapl_msr", 0);
-		if (!rapl_msr_platdev)
-			return -ENOMEM;
-
-		ret = platform_device_add(rapl_msr_platdev);
-		if (ret) {
-			platform_device_put(rapl_msr_platdev);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static void __exit rapl_exit(void)
-{
-	platform_device_unregister(rapl_msr_platdev);
-}
-
-fs_initcall(rapl_init);
-module_exit(rapl_exit);
-
 MODULE_DESCRIPTION("Intel Runtime Average Power Limit (RAPL) common code");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 6f23e601832d..cb89905e9ae1 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -21,15 +21,33 @@
 #include <linux/intel_rapl.h>
 #include <linux/processor.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
+#include <linux/bits.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/iosf_mbi.h>
 #include <asm/msr.h>
 
 /* Local defines */
 #define MSR_PLATFORM_POWER_LIMIT	0x0000065C
 #define MSR_VR_CURRENT_CONFIG		0x00000601
 
+#define ENERGY_UNIT_SCALE		1000	/* scale from driver unit to powercap unit */
+
+#define POWER_UNIT_OFFSET		0x00
+#define POWER_UNIT_MASK			GENMASK(3, 0)
+
+#define ENERGY_UNIT_OFFSET		0x08
+#define ENERGY_UNIT_MASK		GENMASK(12, 8)
+
+#define TIME_UNIT_OFFSET		0x10
+#define TIME_UNIT_MASK			GENMASK(19, 16)
+
+/* Sideband MBI registers */
+#define IOSF_CPU_POWER_BUDGET_CTL_BYT	0x02
+#define IOSF_CPU_POWER_BUDGET_CTL_TNG	0xDF
+
 /* private data for RAPL MSR Interface */
 static struct rapl_if_priv *rapl_msr_priv;
 
@@ -186,6 +204,201 @@ static const struct x86_cpu_id pmu_support_ids[] = {
 	{}
 };
 
+static int rapl_check_unit_atom(struct rapl_domain *rd)
+{
+	struct reg_action ra;
+	u32 value;
+
+	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
+	ra.mask = ~0;
+	if (rapl_msr_read_raw(rd->rp->lead_cpu, &ra, false)) {
+		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
+			ra.reg.val, rd->rp->name, rd->name);
+		return -ENODEV;
+	}
+
+	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
+	rd->energy_unit = ENERGY_UNIT_SCALE * BIT(value);
+
+	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
+	rd->power_unit = BIT(value) * MILLIWATT_PER_WATT;
+
+	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
+	rd->time_unit = USEC_PER_SEC / BIT(value);
+
+	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
+		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
+
+	return 0;
+}
+
+static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
+{
+	static u32 power_ctrl_orig_val;
+	const struct rapl_defaults *defaults = rd->rp->priv->defaults;
+	u32 mdata;
+
+	if (!defaults->floor_freq_reg_addr) {
+		pr_err("Invalid floor frequency config register\n");
+		return;
+	}
+
+	if (!power_ctrl_orig_val)
+		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
+			      defaults->floor_freq_reg_addr,
+			      &power_ctrl_orig_val);
+	mdata = power_ctrl_orig_val;
+	if (enable) {
+		mdata &= ~GENMASK(14, 8);
+		mdata |= BIT(8);
+	}
+	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
+		       defaults->floor_freq_reg_addr, mdata);
+}
+
+static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
+					 bool to_raw)
+{
+	if (to_raw)
+		return div64_u64(value, rd->time_unit);
+
+	/*
+	 * Atom time unit encoding is straight forward val * time_unit,
+	 * where time_unit is default to 1 sec. Never 0.
+	 */
+	return value ? value * rd->time_unit : rd->time_unit;
+}
+
+static const struct rapl_defaults rapl_defaults_core = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+};
+
+static const struct rapl_defaults rapl_defaults_hsw_server = {
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+	.dram_domain_energy_unit = 15300,
+};
+
+static const struct rapl_defaults rapl_defaults_spr_server = {
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+	.psys_domain_energy_unit = NANOJOULE_PER_JOULE,
+	.spr_psys_bits = true,
+};
+
+static const struct rapl_defaults rapl_defaults_byt = {
+	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_BYT,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = set_floor_freq_atom,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_tng = {
+	.floor_freq_reg_addr = IOSF_CPU_POWER_BUDGET_CTL_TNG,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = set_floor_freq_atom,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_ann = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = NULL,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_cht = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_check_unit_atom,
+	.set_floor_freq = NULL,
+	.compute_time_window = rapl_compute_time_window_atom,
+};
+
+static const struct rapl_defaults rapl_defaults_amd = {
+	.check_unit = rapl_default_check_unit,
+};
+
+static const struct x86_cpu_id rapl_ids[]  = {
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_HASWELL,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_G,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_X,			&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_KABYLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_COMETLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,		&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_LAKEFIELD,			&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,		&rapl_defaults_byt),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,		&rapl_defaults_cht),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VENDOR_FAM(AMD, 0x17,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1A,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(HYGON, 0x18,		&rapl_defaults_amd),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
+
 static int rapl_msr_probe(struct platform_device *pdev)
 {
 	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
@@ -205,6 +418,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	}
 	rapl_msr_priv->read_raw = rapl_msr_read_raw;
 	rapl_msr_priv->write_raw = rapl_msr_write_raw;
+	rapl_msr_priv->defaults = (const struct rapl_defaults *)pdev->dev.platform_data;
 
 	if (id) {
 		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |= BIT(POWER_LIMIT4);
@@ -259,7 +473,41 @@ static struct platform_driver intel_rapl_msr_driver = {
 	},
 };
 
-module_platform_driver(intel_rapl_msr_driver);
+static struct platform_device *rapl_msr_platdev;
+
+static int intel_rapl_msr_init(void)
+{
+	const struct rapl_defaults *def;
+	const struct x86_cpu_id *id;
+	int ret;
+
+	ret = platform_driver_register(&intel_rapl_msr_driver);
+	if (ret)
+		return ret;
+
+	/* Create the MSR RAPL platform device for supported platforms */
+	id = x86_match_cpu(rapl_ids);
+	if (!id)
+		return 0;
+
+	def = (const struct rapl_defaults *)id->driver_data;
+
+	rapl_msr_platdev = platform_device_register_data(NULL, "intel_rapl_msr", 0, def,
+							 sizeof(*def));
+	if (IS_ERR(rapl_msr_platdev))
+		pr_debug("intel_rapl_msr device register failed, ret:%ld\n",
+			 PTR_ERR(rapl_msr_platdev));
+
+	return 0;
+}
+module_init(intel_rapl_msr_init);
+
+static void intel_rapl_msr_exit(void)
+{
+	platform_device_unregister(rapl_msr_platdev);
+	platform_driver_unregister(&intel_rapl_msr_driver);
+}
+module_exit(intel_rapl_msr_exit);
 
 MODULE_DESCRIPTION("Driver for Intel RAPL (Running Average Power Limit) control via MSR interface");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
-- 
2.43.0


