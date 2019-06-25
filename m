Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F85531A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 17:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbfFYPRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 11:17:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:15842 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfFYPRJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 11:17:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 08:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="161946660"
Received: from syhu-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.173.95])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2019 08:17:08 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH 07/13] intel_rapl: cleanup some functions
Date:   Tue, 25 Jun 2019 23:16:42 +0800
Message-Id: <1561475808-24839-8-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561475808-24839-1-git-send-email-rui.zhang@intel.com>
References: <1561475808-24839-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously, there are three functions:
rapl_register_psys(), which registers platform rapl domain.
rapl_register_powercap(), which registers powercap control type.
rapl_unregsiter_powercap(), which unregisters platform rapl domain and
powercap control type.

This is confusing as the function name does not describe what it does
clearly.

With this patch, the three functions are removed, and two new functions
rapl_register_platform_domain()/rapl_unregister_platform_domain() are
introduced instead, and they do exactly what their function name describes.

Plus, as part of the common code, hardcoded MSR accesses in these functions
are converted to follow the abstracted register access.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 62 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 7dc9965..fbf91dd5 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1051,16 +1051,6 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 
 }
 
-static void rapl_unregister_powercap(void)
-{
-	if (&rapl_msr_priv.platform_rapl_domain) {
-		powercap_unregister_zone(rapl_msr_priv.control_type,
-					 &rapl_msr_priv.platform_rapl_domain->power_zone);
-		kfree(rapl_msr_priv.platform_rapl_domain);
-	}
-	powercap_unregister_control_type(rapl_msr_priv.control_type);
-}
-
 static int rapl_package_register_powercap(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
@@ -1130,16 +1120,23 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	return ret;
 }
 
-static int __init rapl_register_psys(void)
+static int __init rapl_add_platform_domain(struct rapl_priv *priv)
 {
 	struct rapl_domain *rd;
 	struct powercap_zone *power_zone;
-	u64 val;
+	struct reg_action ra;
+	int ret;
 
-	if (rdmsrl_safe_on_cpu(0, rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS], &val) || !val)
+	ra.reg = priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS];
+	ra.mask = ~0;
+	ret = priv->read_raw(0, &ra);
+	if (ret || !ra.value)
 		return -ENODEV;
 
-	if (rdmsrl_safe_on_cpu(0, rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT], &val) || !val)
+	ra.reg = priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT];
+	ra.mask = ~0;
+	ret = priv->read_raw(0, &ra);
+	if (ret || !ra.value)
 		return -ENODEV;
 
 	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
@@ -1148,15 +1145,15 @@ static int __init rapl_register_psys(void)
 
 	rd->name = rapl_domain_names[RAPL_DOMAIN_PLATFORM];
 	rd->id = RAPL_DOMAIN_PLATFORM;
-	rd->regs[RAPL_DOMAIN_REG_LIMIT] = rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT];
-	rd->regs[RAPL_DOMAIN_REG_STATUS] = rapl_msr_priv.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS];
+	rd->regs[RAPL_DOMAIN_REG_LIMIT] = priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT];
+	rd->regs[RAPL_DOMAIN_REG_STATUS] = priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS];
 	rd->rpl[0].prim_id = PL1_ENABLE;
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
 	rd->rpl[1].name = pl2_name;
-	rd->rp = rapl_find_package_domain(0, &rapl_msr_priv);
+	rd->rp = rapl_find_package_domain(0, priv);
 
-	power_zone = powercap_register_zone(&rd->power_zone, rapl_msr_priv.control_type,
+	power_zone = powercap_register_zone(&rd->power_zone, priv->control_type,
 					    "psys", NULL,
 					    &zone_ops[RAPL_DOMAIN_PLATFORM],
 					    2, &constraint_ops);
@@ -1166,19 +1163,18 @@ static int __init rapl_register_psys(void)
 		return PTR_ERR(power_zone);
 	}
 
-	rapl_msr_priv.platform_rapl_domain = rd;
+	priv->platform_rapl_domain = rd;
 
 	return 0;
 }
 
-static int __init rapl_register_powercap(void)
+static void rapl_remove_platform_domain(struct rapl_priv *priv)
 {
-	rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
-	if (IS_ERR(rapl_msr_priv.control_type)) {
-		pr_debug("failed to register powercap control_type.\n");
-		return PTR_ERR(rapl_msr_priv.control_type);
+	if (priv->platform_rapl_domain) {
+		powercap_unregister_zone(priv->control_type,
+			&priv->platform_rapl_domain->power_zone);
+		kfree(priv->platform_rapl_domain);
 	}
-	return 0;
 }
 
 static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
@@ -1526,9 +1522,12 @@ static int __init rapl_init(void)
 
 	rapl_msr_priv.read_raw = rapl_msr_read_raw;
 	rapl_msr_priv.write_raw = rapl_msr_write_raw;
-	ret = rapl_register_powercap();
-	if (ret)
-		return ret;
+
+	rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
+	if (IS_ERR(rapl_msr_priv.control_type)) {
+		pr_debug("failed to register powercap control_type.\n");
+		return PTR_ERR(rapl_msr_priv.control_type);
+	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
 				rapl_cpu_online, rapl_cpu_down_prep);
@@ -1537,7 +1536,7 @@ static int __init rapl_init(void)
 	rapl_msr_priv.pcap_rapl_online = ret;
 
 	/* Don't bail out if PSys is not supported */
-	rapl_register_psys();
+	rapl_add_platform_domain(&rapl_msr_priv);
 
 	ret = register_pm_notifier(&rapl_pm_notifier);
 	if (ret)
@@ -1549,7 +1548,7 @@ static int __init rapl_init(void)
 	cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
 
 err_unreg:
-	rapl_unregister_powercap();
+	powercap_unregister_control_type(rapl_msr_priv.control_type);
 	return ret;
 }
 
@@ -1557,7 +1556,8 @@ static void __exit rapl_exit(void)
 {
 	unregister_pm_notifier(&rapl_pm_notifier);
 	cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
-	rapl_unregister_powercap();
+	rapl_remove_platform_domain(&rapl_msr_priv);
+	powercap_unregister_control_type(rapl_msr_priv.control_type);
 }
 
 module_init(rapl_init);
-- 
2.7.4

