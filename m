Return-Path: <linux-pm+bounces-41718-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOymFV2pe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41718-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:39:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B12B3A64
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DE86306CEC2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9E306496;
	Thu, 29 Jan 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgyQxicY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5A2FF66A;
	Thu, 29 Jan 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711831; cv=none; b=LXvfb/JQ1RlvTEmicr5qfrlRf1V8Fu+x+yZujriYL6V7UwXurSJL8srffp8lhHf5qfhzklGEv99ybMmJBKAjk44FnGiEN1Gt6jurIEgLKfnYyTWnQmmPITp9U58Jw8ORD7PCYEEBhG5zN01mwpoRWkEqb2zppLjkKKZM34Qmp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711831; c=relaxed/simple;
	bh=25tXUFVoLOKuOO+G8EUsCAt0s9JS+grpc7Qbd++kaHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2CGuqPCp3BQCiPr6T5kNx0iMPGrUIYOd193gBx+kKNT3sO640h7UctKKmKXQPjqjz1ivOmp1jQayTElMxwDdrVG8i2SrVGZktHhfYheSD7fK86Rqnh7BcO0ZsY3UzHeT2n9BFfheENblDyPNSwfsgvDqt9ZTfZvn/qWLXWcaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgyQxicY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711830; x=1801247830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=25tXUFVoLOKuOO+G8EUsCAt0s9JS+grpc7Qbd++kaHE=;
  b=NgyQxicY894CfASNliSsRRfbdLUxfFoKA1/mxGz7PMbKxFJJRyfCPOga
   ZlnIVCyw3iMGI9fEwJ4vxrBwqYfsK9+wtPRSk7BL2qA/Hs889Ad9ivSyR
   un9p77V9pFoCuhxy25lmTHbYSMHPta7DaRmlBqub2d4PhpegcOlVe8PRf
   9+IvYNSUsLfbftcwca+vsf/eOusriI6waDsuYLVqyqAdG2ht/T9CVveLJ
   1XJPZ930E+EjouptJt2wbFcOfn+KOSDaoXBA7IRxXBIJYW6CXnTI5iEMt
   HWwu28nAI7hcZSDPAc6lZtl3GtqSdndhsleZE3Jrdg5IHdkefJgknEeqe
   w==;
X-CSE-ConnectionGUID: /A9NGWNrQQq0Y3jaS6lkIQ==
X-CSE-MsgGUID: Ce0tpkkgQ4Gz3WGOT1VHKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388383"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388383"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:08 -0800
X-CSE-ConnectionGUID: icbgyR63SJubtLLmlOk4PA==
X-CSE-MsgGUID: La9bY5QFQrGNyRx4qEB1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070981"
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
Subject: [PATCH v1 8/9] powercap: intel_rapl: Register PM notifier only when RAPL package exists
Date: Thu, 29 Jan 2026 10:36:45 -0800
Message-ID: <20260129183646.558866-9-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41718-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: B2B12B3A64
X-Rspamd-Action: no action

The PM notifier callbacks are needed only when a valid RAPL package
device is registered. Register and unregister the PM notifier callbacks
when a RAPL package device is added or removed.

This is a preparatory patch before moving MSR rapl_defaults into the
MSR RAPL interface driver.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 130 +++++++++++++--------------
 1 file changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 54d88f1311ed..648bef1d5de1 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2077,6 +2077,64 @@ void rapl_package_remove_pmu(struct rapl_package *rp)
 EXPORT_SYMBOL_NS_GPL(rapl_package_remove_pmu, "INTEL_RAPL");
 #endif
 
+/* pm notifier for saving/restoring Power Limit settings */
+static void power_limit_state_save(void)
+{
+	struct rapl_package *rp;
+	struct rapl_domain *rd;
+	int ret;
+
+	cpus_read_lock();
+	list_for_each_entry(rp, &rapl_packages, plist) {
+		if (!rp->power_zone)
+			continue;
+		rd = power_zone_to_rapl_domain(rp->power_zone);
+		for (int i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
+			ret = rapl_read_pl_data(rd, i, PL_LIMIT, true,
+						&rd->rpl[i].last_power_limit);
+			if (ret)
+				rd->rpl[i].last_power_limit = 0;
+		}
+	}
+	cpus_read_unlock();
+}
+
+static void power_limit_state_restore(void)
+{
+	struct rapl_package *rp;
+	struct rapl_domain *rd;
+
+	cpus_read_lock();
+	list_for_each_entry(rp, &rapl_packages, plist) {
+		if (!rp->power_zone)
+			continue;
+		rd = power_zone_to_rapl_domain(rp->power_zone);
+		for (int i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++)
+			if (rd->rpl[i].last_power_limit)
+				rapl_write_pl_data(rd, i, PL_LIMIT,
+						   rd->rpl[i].last_power_limit);
+	}
+	cpus_read_unlock();
+}
+
+static int rapl_pm_callback(struct notifier_block *nb,
+			    unsigned long mode, void *_unused)
+{
+	switch (mode) {
+	case PM_SUSPEND_PREPARE:
+		power_limit_state_save();
+		break;
+	case PM_POST_SUSPEND:
+		power_limit_state_restore();
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block rapl_pm_notifier = {
+	.notifier_call = rapl_pm_callback,
+};
+
 /* called from CPU hotplug notifier, hotplug lock held */
 void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 {
@@ -2106,6 +2164,9 @@ void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 				 &rd_package->power_zone);
 	list_del(&rp->plist);
 	kfree(rp);
+
+	if (list_empty(&rapl_packages))
+		unregister_pm_notifier(&rapl_pm_notifier);
 }
 EXPORT_SYMBOL_NS_GPL(rapl_remove_package_cpuslocked, "INTEL_RAPL");
 
@@ -2208,6 +2269,8 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 	}
 	ret = rapl_package_register_powercap(rp);
 	if (!ret) {
+		if (list_empty(&rapl_packages))
+			register_pm_notifier(&rapl_pm_notifier);
 		INIT_LIST_HEAD(&rp->plist);
 		list_add(&rp->plist, &rapl_packages);
 		return rp;
@@ -2227,64 +2290,6 @@ struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id
 }
 EXPORT_SYMBOL_NS_GPL(rapl_add_package, "INTEL_RAPL");
 
-static void power_limit_state_save(void)
-{
-	struct rapl_package *rp;
-	struct rapl_domain *rd;
-	int ret, i;
-
-	cpus_read_lock();
-	list_for_each_entry(rp, &rapl_packages, plist) {
-		if (!rp->power_zone)
-			continue;
-		rd = power_zone_to_rapl_domain(rp->power_zone);
-		for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
-			ret = rapl_read_pl_data(rd, i, PL_LIMIT, true,
-						 &rd->rpl[i].last_power_limit);
-			if (ret)
-				rd->rpl[i].last_power_limit = 0;
-		}
-	}
-	cpus_read_unlock();
-}
-
-static void power_limit_state_restore(void)
-{
-	struct rapl_package *rp;
-	struct rapl_domain *rd;
-	int i;
-
-	cpus_read_lock();
-	list_for_each_entry(rp, &rapl_packages, plist) {
-		if (!rp->power_zone)
-			continue;
-		rd = power_zone_to_rapl_domain(rp->power_zone);
-		for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++)
-			if (rd->rpl[i].last_power_limit)
-				rapl_write_pl_data(rd, i, PL_LIMIT,
-					       rd->rpl[i].last_power_limit);
-	}
-	cpus_read_unlock();
-}
-
-static int rapl_pm_callback(struct notifier_block *nb,
-			    unsigned long mode, void *_unused)
-{
-	switch (mode) {
-	case PM_SUSPEND_PREPARE:
-		power_limit_state_save();
-		break;
-	case PM_POST_SUSPEND:
-		power_limit_state_restore();
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block rapl_pm_notifier = {
-	.notifier_call = rapl_pm_callback,
-};
-
 static struct platform_device *rapl_msr_platdev;
 
 static int __init rapl_init(void)
@@ -2307,19 +2312,12 @@ static int __init rapl_init(void)
 		}
 	}
 
-	ret = register_pm_notifier(&rapl_pm_notifier);
-	if (ret && rapl_msr_platdev) {
-		platform_device_del(rapl_msr_platdev);
-		platform_device_put(rapl_msr_platdev);
-	}
-
-	return ret;
+	return 0;
 }
 
 static void __exit rapl_exit(void)
 {
 	platform_device_unregister(rapl_msr_platdev);
-	unregister_pm_notifier(&rapl_pm_notifier);
 }
 
 fs_initcall(rapl_init);
-- 
2.43.0


