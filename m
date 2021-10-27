Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3B43C4A4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbhJ0IJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 04:09:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:5206 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235817AbhJ0IJl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Oct 2021 04:09:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227559464"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="227559464"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="486559014"
Received: from power-sh.sh.intel.com ([10.239.183.1])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2021 01:07:14 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, artem.bityutskiy@linux.intel.com,
        rui.zhang@intel.com
Subject: [PATCH 1/3] intel_idle: cleanup code for handling with cpuidle framework
Date:   Wed, 27 Oct 2021 16:22:35 +0800
Message-Id: <20211027082237.26759-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce two helper functions and move all the code that deals with
the cpuidle framework into them.

No functional change in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/idle/intel_idle.c | 67 ++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e6c543b5ee1d..ae9d8c43e6a5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1677,14 +1677,46 @@ static int intel_idle_cpu_online(unsigned int cpu)
 }
 
 /**
- * intel_idle_cpuidle_devices_uninit - Unregister all cpuidle devices.
+ * intel_idle_cpuidle_unregister - unregister from cpuidle framework
  */
-static void __init intel_idle_cpuidle_devices_uninit(void)
+static void __init intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
 {
 	int i;
 
 	for_each_online_cpu(i)
 		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
+	cpuidle_unregister_driver(drv);
+	free_percpu(intel_idle_cpuidle_devices);
+}
+
+/**
+ * intel_idle_cpuidle_register - register to cpuidle framework
+ */
+static int __init intel_idle_cpuidle_register(struct cpuidle_driver *drv)
+{
+	int retval;
+
+	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
+	if (!intel_idle_cpuidle_devices)
+		return -ENOMEM;
+
+	retval = cpuidle_register_driver(drv);
+	if (retval) {
+		struct cpuidle_driver *drv = cpuidle_get_driver();
+
+		printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
+			drv ? drv->name : "none");
+		free_percpu(intel_idle_cpuidle_devices);
+		return retval;
+	}
+
+	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
+				intel_idle_cpu_online, NULL);
+	if (retval < 0) {
+		intel_idle_cpuidle_unregister(drv);
+		return retval;
+	}
+	return 0;
 }
 
 static int __init intel_idle_init(void)
@@ -1740,37 +1772,14 @@ static int __init intel_idle_init(void)
 	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
 		 boot_cpu_data.x86_model);
 
-	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (!intel_idle_cpuidle_devices)
-		return -ENOMEM;
-
 	intel_idle_cpuidle_driver_init(&intel_idle_driver);
 
-	retval = cpuidle_register_driver(&intel_idle_driver);
-	if (retval) {
-		struct cpuidle_driver *drv = cpuidle_get_driver();
-		printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
-		       drv ? drv->name : "none");
-		goto init_driver_fail;
-	}
-
-	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
-				   intel_idle_cpu_online, NULL);
-	if (retval < 0)
-		goto hp_setup_fail;
-
-	pr_debug("Local APIC timer is reliable in %s\n",
-		 boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
+	retval = intel_idle_cpuidle_register(&intel_idle_driver);
+	if (!retval)
+		pr_debug("Local APIC timer is reliable in %s\n",
+			boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
 
-	return 0;
-
-hp_setup_fail:
-	intel_idle_cpuidle_devices_uninit();
-	cpuidle_unregister_driver(&intel_idle_driver);
-init_driver_fail:
-	free_percpu(intel_idle_cpuidle_devices);
 	return retval;
-
 }
 device_initcall(intel_idle_init);
 
-- 
2.17.1

