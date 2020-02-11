Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3E159D5F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBKXjX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43420 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgBKXjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:02 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 5a059576f132a7f4; Wed, 12 Feb 2020 00:38:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 08/28] PM: QoS: Redefine struct pm_qos_request and drop struct pm_qos_object
Date:   Wed, 12 Feb 2020 00:01:18 +0100
Message-ID: <2443315.yJlvsR4f3f@kreacher>
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

First, change the definition of struct pm_qos_request so that it
contains a struct pm_qos_constraints pointer (called "qos") instead
of a PM QoS class number (in preparation for dropping the PM QoS
classes concept altogether going forward) and move its definition
(along with the definition of struct pm_qos_flags_request that does
not change) after the definition of struct pm_qos_constraints.

Next, drop the definition of struct pm_qos_object and the null_pm_qos
and cpu_dma_pm_qos variables of that type along with pm_qos_array[]
holding pointers to them and change the code to refer to the
pm_qos_constraints structure directly or to use the new qos pointer
in struct pm_qos_request for that instead of going through
pm_qos_array[] to access it.  Also update kerneldoc comments that
mention pm_qos_class to refer to PM_QOS_CPU_DMA_LATENCY directly
instead.

Finally, drop register_pm_qos_misc(), introduce cpu_latency_qos_miscdev
(with the name field set to "cpu_dma_latency") to implement the
CPU latency QoS interface in /dev/ and register it directly from
pm_qos_power_init().

After these changes the notion of PM QoS classes remains only in the
API (in the form of redundant function parameters that are ignored)
and in the definitions of PM QoS trace events.

While at it, some redundant local variables are dropped etc.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h |  20 ++++----
 kernel/power/qos.c     | 121 +++++++++++++++++--------------------------------
 2 files changed, 51 insertions(+), 90 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 48bfb96a9360..bef110aa80cc 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -39,16 +39,6 @@ enum pm_qos_flags_status {
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
 
-struct pm_qos_request {
-	struct plist_node node;
-	int pm_qos_class;
-};
-
-struct pm_qos_flags_request {
-	struct list_head node;
-	s32 flags;	/* Do not change to 64 bit */
-};
-
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,
 	PM_QOS_MAX,		/* return the largest value */
@@ -69,6 +59,16 @@ struct pm_qos_constraints {
 	struct blocking_notifier_head *notifiers;
 };
 
+struct pm_qos_request {
+	struct plist_node node;
+	struct pm_qos_constraints *qos;
+};
+
+struct pm_qos_flags_request {
+	struct list_head node;
+	s32 flags;	/* Do not change to 64 bit */
+};
+
 struct pm_qos_flags {
 	struct list_head list;
 	s32 effective_flags;	/* Do not change to 64 bit */
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 9f67584d4466..952c5f55e23c 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -54,16 +54,8 @@
  * or pm_qos_object list and pm_qos_objects need to happen with pm_qos_lock
  * held, taken with _irqsave.  One lock to rule them all
  */
-struct pm_qos_object {
-	struct pm_qos_constraints *constraints;
-	struct miscdevice pm_qos_power_miscdev;
-	char *name;
-};
-
 static DEFINE_SPINLOCK(pm_qos_lock);
 
-static struct pm_qos_object null_pm_qos;
-
 static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_constraints cpu_dma_constraints = {
 	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list),
@@ -73,15 +65,6 @@ static struct pm_qos_constraints cpu_dma_constraints = {
 	.type = PM_QOS_MIN,
 	.notifiers = &cpu_dma_lat_notifier,
 };
-static struct pm_qos_object cpu_dma_pm_qos = {
-	.constraints = &cpu_dma_constraints,
-	.name = "cpu_dma_latency",
-};
-
-static struct pm_qos_object *pm_qos_array[] = {
-	&null_pm_qos,
-	&cpu_dma_pm_qos,
-};
 
 /**
  * pm_qos_read_value - Return the current effective constraint value.
@@ -248,46 +231,34 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 
 /**
  * pm_qos_request - returns current system wide qos expectation
- * @pm_qos_class: identification of which qos value is requested
+ * @pm_qos_class: Ignored.
  *
  * This function returns the current target value.
  */
 int pm_qos_request(int pm_qos_class)
 {
-	return pm_qos_read_value(pm_qos_array[pm_qos_class]->constraints);
+	return pm_qos_read_value(&cpu_dma_constraints);
 }
 EXPORT_SYMBOL_GPL(pm_qos_request);
 
 int pm_qos_request_active(struct pm_qos_request *req)
 {
-	return req->pm_qos_class != 0;
+	return req->qos == &cpu_dma_constraints;
 }
 EXPORT_SYMBOL_GPL(pm_qos_request_active);
 
-static void __pm_qos_update_request(struct pm_qos_request *req,
-			   s32 new_value)
-{
-	trace_pm_qos_update_request(req->pm_qos_class, new_value);
-
-	if (new_value != req->node.prio)
-		pm_qos_update_target(
-			pm_qos_array[req->pm_qos_class]->constraints,
-			&req->node, PM_QOS_UPDATE_REQ, new_value);
-}
-
 /**
  * pm_qos_add_request - inserts new qos request into the list
  * @req: pointer to a preallocated handle
- * @pm_qos_class: identifies which list of qos request to use
+ * @pm_qos_class: Ignored.
  * @value: defines the qos request
  *
- * This function inserts a new entry in the pm_qos_class list of requested qos
- * performance characteristics.  It recomputes the aggregate QoS expectations
- * for the pm_qos_class of parameters and initializes the pm_qos_request
+ * This function inserts a new entry in the PM_QOS_CPU_DMA_LATENCY list of
+ * requested QoS performance characteristics.  It recomputes the aggregate QoS
+ * expectations for the PM_QOS_CPU_DMA_LATENCY list and initializes the @req
  * handle.  Caller needs to save this handle for later use in updates and
  * removal.
  */
-
 void pm_qos_add_request(struct pm_qos_request *req,
 			int pm_qos_class, s32 value)
 {
@@ -298,10 +269,11 @@ void pm_qos_add_request(struct pm_qos_request *req,
 		WARN(1, KERN_ERR "pm_qos_add_request() called for already added request\n");
 		return;
 	}
-	req->pm_qos_class = pm_qos_class;
-	trace_pm_qos_add_request(pm_qos_class, value);
-	pm_qos_update_target(pm_qos_array[pm_qos_class]->constraints,
-			     &req->node, PM_QOS_ADD_REQ, value);
+
+	trace_pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY, value);
+
+	req->qos = &cpu_dma_constraints;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ, value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_request);
 
@@ -310,13 +282,12 @@ EXPORT_SYMBOL_GPL(pm_qos_add_request);
  * @req : handle to list element holding a pm_qos request to use
  * @value: defines the qos request
  *
- * Updates an existing qos request for the pm_qos_class of parameters along
- * with updating the target pm_qos_class value.
+ * Updates an existing qos request for the PM_QOS_CPU_DMA_LATENCY list along
+ * with updating the target PM_QOS_CPU_DMA_LATENCY value.
  *
  * Attempts are made to make this code callable on hot code paths.
  */
-void pm_qos_update_request(struct pm_qos_request *req,
-			   s32 new_value)
+void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
 {
 	if (!req) /*guard against callers passing in null */
 		return;
@@ -326,7 +297,12 @@ void pm_qos_update_request(struct pm_qos_request *req,
 		return;
 	}
 
-	__pm_qos_update_request(req, new_value);
+	trace_pm_qos_update_request(PM_QOS_CPU_DMA_LATENCY, new_value);
+
+	if (new_value == req->node.prio)
+		return;
+
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, new_value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
@@ -335,7 +311,7 @@ EXPORT_SYMBOL_GPL(pm_qos_update_request);
  * @req: handle to request list element
  *
  * Will remove pm qos request from the list of constraints and
- * recompute the current target value for the pm_qos_class.  Call this
+ * recompute the current target value for PM_QOS_CPU_DMA_LATENCY.  Call this
  * on slow code paths.
  */
 void pm_qos_remove_request(struct pm_qos_request *req)
@@ -349,9 +325,9 @@ void pm_qos_remove_request(struct pm_qos_request *req)
 		return;
 	}
 
-	trace_pm_qos_remove_request(req->pm_qos_class, PM_QOS_DEFAULT_VALUE);
-	pm_qos_update_target(pm_qos_array[req->pm_qos_class]->constraints,
-			     &req->node, PM_QOS_REMOVE_REQ,
+	trace_pm_qos_remove_request(PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
+
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
 			     PM_QOS_DEFAULT_VALUE);
 	memset(req, 0, sizeof(*req));
 }
@@ -359,41 +335,31 @@ EXPORT_SYMBOL_GPL(pm_qos_remove_request);
 
 /**
  * pm_qos_add_notifier - sets notification entry for changes to target value
- * @pm_qos_class: identifies which qos target changes should be notified.
+ * @pm_qos_class: Ignored.
  * @notifier: notifier block managed by caller.
  *
  * will register the notifier into a notification chain that gets called
- * upon changes to the pm_qos_class target value.
+ * upon changes to the PM_QOS_CPU_DMA_LATENCY target value.
  */
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
 {
-	int retval;
-
-	retval = blocking_notifier_chain_register(
-			pm_qos_array[pm_qos_class]->constraints->notifiers,
-			notifier);
-
-	return retval;
+	return blocking_notifier_chain_register(cpu_dma_constraints.notifiers,
+						notifier);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
 
 /**
  * pm_qos_remove_notifier - deletes notification entry from chain.
- * @pm_qos_class: identifies which qos target changes are notified.
+ * @pm_qos_class: Ignored.
  * @notifier: notifier block to be removed.
  *
  * will remove the notifier from the notification chain that gets called
- * upon changes to the pm_qos_class target value.
+ * upon changes to the PM_QOS_CPU_DMA_LATENCY target value.
  */
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 {
-	int retval;
-
-	retval = blocking_notifier_chain_unregister(
-			pm_qos_array[pm_qos_class]->constraints->notifiers,
-			notifier);
-
-	return retval;
+	return blocking_notifier_chain_unregister(cpu_dma_constraints.notifiers,
+						  notifier);
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
@@ -436,7 +402,7 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 		return -EINVAL;
 
 	spin_lock_irqsave(&pm_qos_lock, flags);
-	value = pm_qos_get_value(pm_qos_array[req->pm_qos_class]->constraints);
+	value = pm_qos_get_value(&cpu_dma_constraints);
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
 	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
@@ -471,25 +437,20 @@ static const struct file_operations pm_qos_power_fops = {
 	.llseek = noop_llseek,
 };
 
-static int register_pm_qos_misc(struct pm_qos_object *qos)
-{
-	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
-	qos->pm_qos_power_miscdev.name = qos->name;
-	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
-
-	return misc_register(&qos->pm_qos_power_miscdev);
-}
+static struct miscdevice cpu_latency_qos_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "cpu_dma_latency",
+	.fops = &pm_qos_power_fops,
+};
 
 static int __init pm_qos_power_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
-
-	ret = register_pm_qos_misc(pm_qos_array[PM_QOS_CPU_DMA_LATENCY]);
+	ret = misc_register(&cpu_latency_qos_miscdev);
 	if (ret < 0)
 		pr_err("%s: %s setup failed\n", __func__,
-		       pm_qos_array[PM_QOS_CPU_DMA_LATENCY]->name);
+		       cpu_latency_qos_miscdev.name);
 
 	return ret;
 }
-- 
2.16.4





