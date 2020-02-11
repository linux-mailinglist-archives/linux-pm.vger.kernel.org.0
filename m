Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66249159D68
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgBKXjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51238 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgBKXi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:59 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 8bb256ff5905def3; Wed, 12 Feb 2020 00:38:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 09/28] PM: QoS: Drop PM_QOS_CPU_DMA_LATENCY notifier chain
Date:   Wed, 12 Feb 2020 00:02:30 +0100
Message-ID: <1901998.KeA0Q3sAH1@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Notice that pm_qos_remove_notifier() is not used at all and the only
caller of pm_qos_add_notifier() is the cpuidle core, which only needs
the PM_QOS_CPU_DMA_LATENCY notifier to invoke wake_up_all_idle_cpus()
upon changes of the PM_QOS_CPU_DMA_LATENCY target value.

First, to ensure that wake_up_all_idle_cpus() will be called
whenever the PM_QOS_CPU_DMA_LATENCY target value changes, modify the
pm_qos_add/update/remove_request() family of functions to check if
the effective constraint for the PM_QOS_CPU_DMA_LATENCY has changed
and call wake_up_all_idle_cpus() directly in that case.

Next, drop the PM_QOS_CPU_DMA_LATENCY notifier from cpuidle as it is
not necessary any more.

Finally, drop both pm_qos_add_notifier() and pm_qos_remove_notifier(),
as they have no callers now, along with cpu_dma_lat_notifier which is
only used by them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c | 40 +---------------------------------------
 include/linux/pm_qos.h    |  2 --
 kernel/power/qos.c        | 47 +++++++++++------------------------------------
 3 files changed, 12 insertions(+), 77 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index de81298051b3..c149d9e20dfd 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -736,53 +736,15 @@ int cpuidle_register(struct cpuidle_driver *drv,
 }
 EXPORT_SYMBOL_GPL(cpuidle_register);
 
-#ifdef CONFIG_SMP
-
-/*
- * This function gets called when a part of the kernel has a new latency
- * requirement.  This means we need to get all processors out of their C-state,
- * and then recalculate a new suitable C-state. Just do a cross-cpu IPI; that
- * wakes them all right up.
- */
-static int cpuidle_latency_notify(struct notifier_block *b,
-		unsigned long l, void *v)
-{
-	wake_up_all_idle_cpus();
-	return NOTIFY_OK;
-}
-
-static struct notifier_block cpuidle_latency_notifier = {
-	.notifier_call = cpuidle_latency_notify,
-};
-
-static inline void latency_notifier_init(struct notifier_block *n)
-{
-	pm_qos_add_notifier(PM_QOS_CPU_DMA_LATENCY, n);
-}
-
-#else /* CONFIG_SMP */
-
-#define latency_notifier_init(x) do { } while (0)
-
-#endif /* CONFIG_SMP */
-
 /**
  * cpuidle_init - core initializer
  */
 static int __init cpuidle_init(void)
 {
-	int ret;
-
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-	ret = cpuidle_add_interface(cpu_subsys.dev_root);
-	if (ret)
-		return ret;
-
-	latency_notifier_init(&cpuidle_latency_notifier);
-
-	return 0;
+	return cpuidle_add_interface(cpu_subsys.dev_root);
 }
 
 module_param(off, int, 0444);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index bef110aa80cc..cb57e5918a25 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -149,8 +149,6 @@ void pm_qos_update_request(struct pm_qos_request *req,
 void pm_qos_remove_request(struct pm_qos_request *req);
 
 int pm_qos_request(int pm_qos_class);
-int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
-int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_request_active(struct pm_qos_request *req);
 s32 pm_qos_read_value(struct pm_qos_constraints *c);
 
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 952c5f55e23c..201b43bc6457 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -56,14 +56,12 @@
  */
 static DEFINE_SPINLOCK(pm_qos_lock);
 
-static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_constraints cpu_dma_constraints = {
 	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list),
 	.target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
 	.default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
 	.no_constraint_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
 	.type = PM_QOS_MIN,
-	.notifiers = &cpu_dma_lat_notifier,
 };
 
 /**
@@ -247,6 +245,14 @@ int pm_qos_request_active(struct pm_qos_request *req)
 }
 EXPORT_SYMBOL_GPL(pm_qos_request_active);
 
+static void cpu_latency_qos_update(struct pm_qos_request *req,
+				   enum pm_qos_req_action action, s32 value)
+{
+	int ret = pm_qos_update_target(req->qos, &req->node, action, value);
+	if (ret > 0)
+		wake_up_all_idle_cpus();
+}
+
 /**
  * pm_qos_add_request - inserts new qos request into the list
  * @req: pointer to a preallocated handle
@@ -273,7 +279,7 @@ void pm_qos_add_request(struct pm_qos_request *req,
 	trace_pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY, value);
 
 	req->qos = &cpu_dma_constraints;
-	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ, value);
+	cpu_latency_qos_update(req, PM_QOS_ADD_REQ, value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_request);
 
@@ -302,7 +308,7 @@ void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
 	if (new_value == req->node.prio)
 		return;
 
-	pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, new_value);
+	cpu_latency_qos_update(req, PM_QOS_UPDATE_REQ, new_value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
@@ -327,42 +333,11 @@ void pm_qos_remove_request(struct pm_qos_request *req)
 
 	trace_pm_qos_remove_request(PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
 
-	pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
-			     PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_update(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 	memset(req, 0, sizeof(*req));
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_request);
 
-/**
- * pm_qos_add_notifier - sets notification entry for changes to target value
- * @pm_qos_class: Ignored.
- * @notifier: notifier block managed by caller.
- *
- * will register the notifier into a notification chain that gets called
- * upon changes to the PM_QOS_CPU_DMA_LATENCY target value.
- */
-int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
-{
-	return blocking_notifier_chain_register(cpu_dma_constraints.notifiers,
-						notifier);
-}
-EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
-
-/**
- * pm_qos_remove_notifier - deletes notification entry from chain.
- * @pm_qos_class: Ignored.
- * @notifier: notifier block to be removed.
- *
- * will remove the notifier from the notification chain that gets called
- * upon changes to the PM_QOS_CPU_DMA_LATENCY target value.
- */
-int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
-{
-	return blocking_notifier_chain_unregister(cpu_dma_constraints.notifiers,
-						  notifier);
-}
-EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
-
 /* User space interface to global PM QoS via misc device. */
 
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
-- 
2.16.4





