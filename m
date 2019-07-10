Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34164768
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 15:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfGJNpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 09:45:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:8342 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfGJNpH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 09:45:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 06:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170923406"
Received: from ygao39-mobl1.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.255.30.205])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2019 06:45:03 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V3 13/17] intel_rapl: Fix module autoloading issue
Date:   Wed, 10 Jul 2019 21:44:34 +0800
Message-Id: <1562766278-7099-14-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562766278-7099-1-git-send-email-rui.zhang@intel.com>
References: <1562766278-7099-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

intel_rapl driver used to have a list of cpuids, which is used to
1. check if the processor support RAPL MSRs
2. do some cpu model specific setting
3. module autoloading

Now, the cpu model specific setting are moved to intel_rapl_common.c as
part of the common code, because the setup is also needed by RAPL MMIO
interface on those platforms.
But removing the cpuid list from intel_rapl MSR interface driver results
in that the driver can not be loaded automatically.

Maintaining another copy of the cpuid list in intel_rapl_msr.c does not make
sense because it increases the complexity when enabling RAPL support on a
new cpu model.

Fix the problem by creating an "intel_rapl_msr" platform device in the
common code, and make RAPL MSR interface driver (intel_rapl_msr.c) probe the
platform device directly.

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 45 ++++++++++++++++++++++--------------
 drivers/powercap/intel_rapl_msr.c    | 24 +++++++++++++++----
 2 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index db8df19..f1b7bcc 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -18,10 +18,11 @@
 #include <linux/cpu.h>
 #include <linux/powercap.h>
 #include <linux/suspend.h>
-#include <asm/iosf_mbi.h>
 #include <linux/intel_rapl.h>
-
 #include <linux/processor.h>
+#include <linux/platform_device.h>
+
+#include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
@@ -136,8 +137,6 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 static u64 rapl_unit_xlate(struct rapl_domain *rd,
 			   enum unit_type type, u64 value, int to_raw);
 static void package_power_limit_irq_save(struct rapl_package *rp);
-static int rapl_init_core(void);
-static void rapl_remove_core(void);
 
 static LIST_HEAD(rapl_packages);	/* guarded by CPU hotplug lock */
 
@@ -1262,8 +1261,6 @@ void rapl_remove_package(struct rapl_package *rp)
 	powercap_unregister_zone(rp->priv->control_type,
 				 &rd_package->power_zone);
 	list_del(&rp->plist);
-	if (list_empty(&rapl_packages))
-		rapl_remove_core();
 	kfree(rp);
 }
 EXPORT_SYMBOL_GPL(rapl_remove_package);
@@ -1292,10 +1289,6 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	int ret;
 
-	ret = rapl_init_core();
-	if (ret)
-		return ERR_PTR(ret);
-
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
 	if (!rp)
 		return ERR_PTR(-ENOMEM);
@@ -1413,14 +1406,13 @@ static struct notifier_block rapl_pm_notifier = {
 	.notifier_call = rapl_pm_callback,
 };
 
-static int rapl_init_core(void)
+static struct platform_device *rapl_msr_platdev;
+
+static int __init rapl_init(void)
 {
 	const struct x86_cpu_id *id;
 	int ret;
 
-	if (rapl_defaults)
-		return 0;
-
 	id = x86_match_cpu(rapl_ids);
 	if (!id) {
 		pr_err("driver does not support CPU family %d model %d\n",
@@ -1432,16 +1424,35 @@ static int rapl_init_core(void)
 	rapl_defaults = (struct rapl_defaults *)id->driver_data;
 
 	ret = register_pm_notifier(&rapl_pm_notifier);
+	if (ret)
+		return ret;
 
-	return 0;
+	rapl_msr_platdev = platform_device_alloc("intel_rapl_msr", 0);
+	if (!rapl_msr_platdev) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	ret = platform_device_add(rapl_msr_platdev);
+	if (ret)
+		platform_device_put(rapl_msr_platdev);
+
+end:
+	if (ret)
+		unregister_pm_notifier(&rapl_pm_notifier);
+
+	return ret;
 }
 
-static void rapl_remove_core(void)
+static void __exit rapl_exit(void)
 {
+	platform_device_unregister(rapl_msr_platdev);
 	unregister_pm_notifier(&rapl_pm_notifier);
-	rapl_defaults = NULL;
 }
 
+module_init(rapl_init);
+module_exit(rapl_exit);
+
 MODULE_DESCRIPTION("Intel Runtime Average Power Limit (RAPL) common code");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index bc14a45..d548796 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -20,6 +20,7 @@
 #include <linux/suspend.h>
 #include <linux/intel_rapl.h>
 #include <linux/processor.h>
+#include <linux/platform_device.h>
 
 #include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
@@ -122,7 +123,7 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 	return ra->err;
 }
 
-static int __init rapl_msr_init(void)
+static int rapl_msr_probe(struct platform_device *pdev)
 {
 	int ret;
 
@@ -152,15 +153,30 @@ static int __init rapl_msr_init(void)
 	return ret;
 }
 
-static void __exit rapl_msr_exit(void)
+static int rapl_msr_remove(struct platform_device *pdev)
 {
 	cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
 	rapl_remove_platform_domain(&rapl_msr_priv);
 	powercap_unregister_control_type(rapl_msr_priv.control_type);
+	return 0;
 }
 
-module_init(rapl_msr_init);
-module_exit(rapl_msr_exit);
+static const struct platform_device_id rapl_msr_ids[] = {
+	{ .name = "intel_rapl_msr", },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, rapl_msr_ids);
+
+static struct platform_driver intel_rapl_msr_driver = {
+	.probe = rapl_msr_probe,
+	.remove = rapl_msr_remove,
+	.id_table = rapl_msr_ids,
+	.driver = {
+		.name = "intel_rapl_msr",
+	},
+};
+
+module_platform_driver(intel_rapl_msr_driver);
 
 MODULE_DESCRIPTION("Driver for Intel RAPL (Running Average Power Limit) control via MSR interface");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
-- 
2.7.4

