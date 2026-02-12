Return-Path: <linux-pm+bounces-42596-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHV7ABdjjmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42596-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:32:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F51131C26
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA50C315E229
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C02F39A4;
	Thu, 12 Feb 2026 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/OejkTv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEB2ECD14;
	Thu, 12 Feb 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939053; cv=none; b=fEqsP5K6JH4b+Pgdz8/Mtq+szbtD0WHxP8NPr07TaU+LBg3KDRV930zNQ0TuRjRWUxkoMgGCJuPfZUP0yTcWA/Yviik0A+73Ngn8lO5C0Eo1sPEMIlcedzq9JYbeArnWglNMZ9bJnl9hzwb4z+CcAhX6MDYuDVNV6LNcHAuhryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939053; c=relaxed/simple;
	bh=AyHjD9sCNB3eEbexkpwFnMFKYXeOS7r7FDV5qXYO3b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfpdIQNQnOH1JnOKVN5d7HeRq6D/tQs9gf7OPpxWUDuUGMJHteXsgwJ05JTcfpPkhiYxrloPRXAIX0a6YY4+w31Z+Cbd+FZ8t84tajkGxIld2nyrMKPmDYNG30HrS5W5VA44BhVfM+2MYgmiNC/jX4ujd8EEkanXAM4sHvdUv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/OejkTv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939052; x=1802475052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AyHjD9sCNB3eEbexkpwFnMFKYXeOS7r7FDV5qXYO3b4=;
  b=J/OejkTvsiowkfWn4heeeZavc74PNrI9rtTFM8q73juwLl7z3sB+debL
   TjEq5kOp7H7Vh8rahVP6JD+ylHQcKb1BRBMXqkR+C8H4ro5js4e3a7KZg
   yY1J8TxDW0m4qIo3eynQ5ZSakr6QNFDQwrj8RnoHQUTcrgxMDnAy6NKi2
   5u7+ynr9TY6IZRDQpuck/W5ga/zIDmo+PHJonUtaTRKZo234efSWNRA0A
   ErT/gcfcvlCC+66yVGg9MHblLuULhzHEe1cpceZSBjqGTlTNCduuf5PWg
   lYDa6djwN1g2gm4I18fRviHSN8tb+iCVvfjyp3A17upT+7AgF2bdyiNKd
   Q==;
X-CSE-ConnectionGUID: +mZlfHoLQEKCcf4xRtKTXA==
X-CSE-MsgGUID: dEok0FFhTFWaWM4MsWwmfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017435"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017435"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: OHYMowxTRdSxQ2J7ySLVXg==
X-CSE-MsgGUID: aa80TwK+RD2BOiikxHaIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845412"
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
Subject: [PATCH v2 11/12] powercap: intel_rapl: Register PM notifier only when RAPL package exists
Date: Thu, 12 Feb 2026 15:30:43 -0800
Message-ID: <20260212233044.329790-12-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42596-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 78F51131C26
X-Rspamd-Action: no action

The PM notifier callbacks are needed only when a valid RAPL package
device is registered. Register and unregister the PM notifier callbacks
when a RAPL package device is added or removed.

This is a preparatory patch before moving MSR rapl_defaults into the
MSR RAPL interface driver.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 130 +++++++++++++--------------
 1 file changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index bfe3dc011911..0d363451cb0d 100644
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


