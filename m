Return-Path: <linux-pm+bounces-42375-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBeTISRximnPKQAAu9opvQ
	(envelope-from <linux-pm+bounces-42375-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 00:43:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1B1156C0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 00:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B5D8302BDC8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326232B98A;
	Mon,  9 Feb 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTOS2Z4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801A30F543;
	Mon,  9 Feb 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770680599; cv=none; b=Au3USxCQ4TcVpgKOz6xwBSM+u/7iMqrXUL8tlqUDRlBcFMjdJUoyrNhbX35i/vWbVX8IM5sfmGYXfg7juwK2lQ9RrnvRcibB4VgKIBLPuqQo26U2uho0qU415lFVXlDmoxuesIVW/cjg2msMiQmSGc3atOzjtCuZg0pQcAr937c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770680599; c=relaxed/simple;
	bh=S+zr8lfsS9Knuv4YXV7nh50ifkEwNLPUtzbkxnNYRyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6B3FQ3yKf4HxDzKIdAafmkPorK6kZdcXJzOQrdOEtxGvRr80K0RCxgZSzbiPE4//IEXjUYD+FW5esU5bCPPd55A50Xar4YXGEnMw3/QaxXgghNKWVV62ix0+O1GE42B8sOA+q9XcakCqZdoRe+oDakDu2ToI40E41lLUgFF9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTOS2Z4e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770680598; x=1802216598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S+zr8lfsS9Knuv4YXV7nh50ifkEwNLPUtzbkxnNYRyU=;
  b=jTOS2Z4enK9MozKlCVXGHOJDciY3q6EMxh8BaWE1Xe/DArjksGOVjf2g
   ih70jt1EDM5BkSMFF7znOdG3DtMaTXOBm+Lc6is6L8u9VhqTWUgw9R2n5
   JZKGkOzea8jMl1iLmRrvBeqzNMhiqeLy/ttPnqXh1VNGF20Z8OhO58RNS
   ZbC4Clte+0R6u1hROxALpDUL691GGyIyKEo/PQz7KPUwnnhxr9IUctg9m
   JmpqCVevaRX6QsTwfDFWV3cZm5lUfyXfZYZ5oEebObnnualaZuHEra3ia
   ELe3uXCmVXt+tskskJ6TH8LZl3LaYPvK4GlPM6nfLQrBjHTorRziJPDJY
   g==;
X-CSE-ConnectionGUID: 6+sc1zNJQ2++ks91LnAYUg==
X-CSE-MsgGUID: NegkI9UJQTmT1quGnsJA4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89385235"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89385235"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:43:15 -0800
X-CSE-ConnectionGUID: 4Vd+x0s6SPu8gEaZkdcy5w==
X-CSE-MsgGUID: 6WrRfO+1QzSgKCqUR5d1cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="242351919"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:43:15 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] powercap: intel_rapl: Remove incorrect CPU check in PMU context
Date: Mon,  9 Feb 2026 15:43:09 -0800
Message-ID: <20260209234310.1440722-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42375-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EB1B1156C0
X-Rspamd-Action: no action

The RAPL MSR read path incorrectly validates CPU context when called
from the PMU subsystem:

    if (atomic) {
        if (unlikely(smp_processor_id() != cpu))
            return -EIO;
        rdmsrq(ra->reg.msr, ra->value);
    }

This check fails for package-scoped MSRs like RAPL energy counters,
which are readable from any CPU within the package.

The perf tool avoids hitting this check by validating against
/sys/bus/event_source/devices/power/cpumask before opening events.
However, turbostat does not perform this validation and may attempt
reads from non-lead CPUs, causing the check to fail and return zero
power values.

Since package-scoped MSRs are architecturally accessible from any CPU
in the package, remove the CPU matching check.

Also rename 'atomic' to 'pmu_ctx' to clarify this indicates PMU context
where rdmsrq() can be used directly instead of rdmsrl_safe_on_cpu().

Fixes: 748d6ba43afd ("powercap: intel_rapl: Enable MSR-based RAPL PMU support")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Furquim Ulisses <ulisses.furquim@intel.com>
---
 drivers/powercap/intel_rapl_common.c |  6 +++---
 drivers/powercap/intel_rapl_msr.c    | 12 +++++-------
 include/linux/intel_rapl.h           |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3ff6da3bf4e6..3705d0608a0f 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -254,7 +254,7 @@ static void rapl_init_domains(struct rapl_package *rp);
 static int rapl_read_data_raw(struct rapl_domain *rd,
 			      enum rapl_primitives prim,
 			      bool xlate, u64 *data,
-			      bool atomic);
+			      bool pmu_ctx);
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			       enum rapl_primitives prim,
 			       unsigned long long value);
@@ -832,7 +832,7 @@ prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
  */
 static int rapl_read_data_raw(struct rapl_domain *rd,
 			      enum rapl_primitives prim, bool xlate, u64 *data,
-			      bool atomic)
+			      bool pmu_ctx)
 {
 	u64 value;
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
@@ -854,7 +854,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	ra.mask = rpi->mask;
 
-	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, atomic)) {
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra, pmu_ctx)) {
 		pr_debug("failed to read reg 0x%llx for %s:%s\n", ra.reg.val, rd->rp->name, rd->name);
 		return -EIO;
 	}
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 9a7e150b3536..152893dca565 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -110,16 +110,14 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool atomic)
+static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool pmu_ctx)
 {
 	/*
-	 * When called from atomic-context (eg PMU event handler)
-	 * perform MSR read directly using rdmsrq().
+	 * When called from PMU context, perform MSR read directly using
+	 * rdmsrq() without IPI overhead. Package-scoped MSRs are readable
+	 * from any CPU in the package.
 	 */
-	if (atomic) {
-		if (unlikely(smp_processor_id() != cpu))
-			return -EIO;
-
+	if (pmu_ctx) {
 		rdmsrq(ra->reg.msr, ra->value);
 		goto out;
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index f479ef5b3341..fa1f328d6712 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -152,7 +152,7 @@ struct rapl_if_priv {
 	union rapl_reg reg_unit;
 	union rapl_reg regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
 	int limits[RAPL_DOMAIN_MAX];
-	int (*read_raw)(int id, struct reg_action *ra, bool atomic);
+	int (*read_raw)(int id, struct reg_action *ra, bool pmu_ctx);
 	int (*write_raw)(int id, struct reg_action *ra);
 	void *defaults;
 	void *rpi;
-- 
2.43.0


