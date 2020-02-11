Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1427159D81
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBKXin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48838 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgBKXin (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:43 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id cde7f2ee43101b1e; Wed, 12 Feb 2020 00:38:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 25/28] PM: QoS: Drop PM_QOS_CPU_DMA_LATENCY and rename related functions
Date:   Wed, 12 Feb 2020 00:35:04 +0100
Message-ID: <1836468.2mkKzJxuJO@kreacher>
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

Drop the PM QoS classes enum including PM_QOS_CPU_DMA_LATENCY,
drop the wrappers around pm_qos_request(), pm_qos_request_active(),
and pm_qos_add/update/remove_request() introduced previously, rename
these functions, respectively, to cpu_latency_qos_limit(),
cpu_latency_qos_request_active(), and
cpu_latency_qos_add/update/remove_request(), and update their
kerneldoc comments.  [While at it, drop some useless comments from
these functions.]

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h | 47 +++---------------------
 kernel/power/qos.c     | 98 +++++++++++++++++++++++++-------------------------
 2 files changed, 54 insertions(+), 91 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 63d39e66f95d..e0ca4d780457 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -9,14 +9,6 @@
 #include <linux/notifier.h>
 #include <linux/device.h>
 
-enum {
-	PM_QOS_RESERVED = 0,
-	PM_QOS_CPU_DMA_LATENCY,
-
-	/* insert new class ID */
-	PM_QOS_NUM_CLASSES,
-};
-
 enum pm_qos_flags_status {
 	PM_QOS_FLAGS_UNDEFINED = -1,
 	PM_QOS_FLAGS_NONE,
@@ -144,40 +136,11 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
 			 enum pm_qos_req_action action, s32 val);
 
-void pm_qos_add_request(struct pm_qos_request *req, int pm_qos_class,
-			s32 value);
-void pm_qos_update_request(struct pm_qos_request *req,
-			   s32 new_value);
-void pm_qos_remove_request(struct pm_qos_request *req);
-s32 pm_qos_request(int pm_qos_class);
-int pm_qos_request_active(struct pm_qos_request *req);
-
-static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
-					       s32 value)
-{
-	pm_qos_add_request(req, PM_QOS_CPU_DMA_LATENCY, value);
-}
-
-static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
-						  s32 new_value)
-{
-	pm_qos_update_request(req, new_value);
-}
-
-static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req)
-{
-	pm_qos_remove_request(req);
-}
-
-static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
-{
-	return pm_qos_request_active(req);
-}
-
-static inline s32 cpu_latency_qos_limit(void)
-{
-	return pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
-}
+s32 cpu_latency_qos_limit(void);
+bool cpu_latency_qos_request_active(struct pm_qos_request *req);
+void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value);
+void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value);
+void cpu_latency_qos_remove_request(struct pm_qos_request *req);
 
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 7bb55aca03bb..7374c76f409a 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -230,21 +230,25 @@ static struct pm_qos_constraints cpu_latency_constraints = {
 };
 
 /**
- * pm_qos_request - returns current system wide qos expectation
- * @pm_qos_class: Ignored.
- *
- * This function returns the current target value.
+ * cpu_latency_qos_limit - Return current system-wide CPU latency QoS limit.
  */
-s32 pm_qos_request(int pm_qos_class)
+s32 cpu_latency_qos_limit(void)
 {
 	return pm_qos_read_value(&cpu_latency_constraints);
 }
 
-int pm_qos_request_active(struct pm_qos_request *req)
+/**
+ * cpu_latency_qos_request_active - Check the given PM QoS request.
+ * @req: PM QoS request to check.
+ *
+ * Return: 'true' if @req has been added to the CPU latency QoS list, 'false'
+ * otherwise.
+ */
+bool cpu_latency_qos_request_active(struct pm_qos_request *req)
 {
 	return req->qos == &cpu_latency_constraints;
 }
-EXPORT_SYMBOL_GPL(pm_qos_request_active);
+EXPORT_SYMBOL_GPL(cpu_latency_qos_request_active);
 
 static void cpu_latency_qos_apply(struct pm_qos_request *req,
 				  enum pm_qos_req_action action, s32 value)
@@ -255,25 +259,24 @@ static void cpu_latency_qos_apply(struct pm_qos_request *req,
 }
 
 /**
- * pm_qos_add_request - inserts new qos request into the list
- * @req: pointer to a preallocated handle
- * @pm_qos_class: Ignored.
- * @value: defines the qos request
+ * cpu_latency_qos_add_request - Add new CPU latency QoS request.
+ * @req: Pointer to a preallocated handle.
+ * @value: Requested constraint value.
+ *
+ * Use @value to initialize the request handle pointed to by @req, insert it as
+ * a new entry to the CPU latency QoS list and recompute the effective QoS
+ * constraint for that list.
  *
- * This function inserts a new entry in the PM_QOS_CPU_DMA_LATENCY list of
- * requested QoS performance characteristics.  It recomputes the aggregate QoS
- * expectations for the PM_QOS_CPU_DMA_LATENCY list and initializes the @req
- * handle.  Caller needs to save this handle for later use in updates and
- * removal.
+ * Callers need to save the handle for later use in updates and removal of the
+ * QoS request represented by it.
  */
-void pm_qos_add_request(struct pm_qos_request *req,
-			int pm_qos_class, s32 value)
+void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value)
 {
-	if (!req) /*guard against callers passing in null */
+	if (!req)
 		return;
 
-	if (pm_qos_request_active(req)) {
-		WARN(1, KERN_ERR "pm_qos_add_request() called for already added request\n");
+	if (cpu_latency_qos_request_active(req)) {
+		WARN(1, KERN_ERR "%s called for already added request\n", __func__);
 		return;
 	}
 
@@ -282,25 +285,24 @@ void pm_qos_add_request(struct pm_qos_request *req,
 	req->qos = &cpu_latency_constraints;
 	cpu_latency_qos_apply(req, PM_QOS_ADD_REQ, value);
 }
-EXPORT_SYMBOL_GPL(pm_qos_add_request);
+EXPORT_SYMBOL_GPL(cpu_latency_qos_add_request);
 
 /**
- * pm_qos_update_request - modifies an existing qos request
- * @req : handle to list element holding a pm_qos request to use
- * @value: defines the qos request
- *
- * Updates an existing qos request for the PM_QOS_CPU_DMA_LATENCY list along
- * with updating the target PM_QOS_CPU_DMA_LATENCY value.
+ * cpu_latency_qos_update_request - Modify existing CPU latency QoS request.
+ * @req : QoS request to update.
+ * @new_value: New requested constraint value.
  *
- * Attempts are made to make this code callable on hot code paths.
+ * Use @new_value to update the QoS request represented by @req in the CPU
+ * latency QoS list along with updating the effective constraint value for that
+ * list.
  */
-void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
+void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value)
 {
-	if (!req) /*guard against callers passing in null */
+	if (!req)
 		return;
 
-	if (!pm_qos_request_active(req)) {
-		WARN(1, KERN_ERR "pm_qos_update_request() called for unknown object\n");
+	if (!cpu_latency_qos_request_active(req)) {
+		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
 		return;
 	}
 
@@ -311,24 +313,22 @@ void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
 
 	cpu_latency_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
 }
-EXPORT_SYMBOL_GPL(pm_qos_update_request);
+EXPORT_SYMBOL_GPL(cpu_latency_qos_update_request);
 
 /**
- * pm_qos_remove_request - modifies an existing qos request
- * @req: handle to request list element
+ * cpu_latency_qos_remove_request - Remove existing CPU latency QoS request.
+ * @req: QoS request to remove.
  *
- * Will remove pm qos request from the list of constraints and
- * recompute the current target value for PM_QOS_CPU_DMA_LATENCY.  Call this
- * on slow code paths.
+ * Remove the CPU latency QoS request represented by @req from the CPU latency
+ * QoS list along with updating the effective constraint value for that list.
  */
-void pm_qos_remove_request(struct pm_qos_request *req)
+void cpu_latency_qos_remove_request(struct pm_qos_request *req)
 {
-	if (!req) /*guard against callers passing in null */
+	if (!req)
 		return;
-		/* silent return to keep pcm code cleaner */
 
-	if (!pm_qos_request_active(req)) {
-		WARN(1, KERN_ERR "pm_qos_remove_request() called for unknown object\n");
+	if (!cpu_latency_qos_request_active(req)) {
+		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
 		return;
 	}
 
@@ -337,7 +337,7 @@ void pm_qos_remove_request(struct pm_qos_request *req)
 	cpu_latency_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 	memset(req, 0, sizeof(*req));
 }
-EXPORT_SYMBOL_GPL(pm_qos_remove_request);
+EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_request);
 
 /* User space interface to the CPU latency QoS via misc device. */
 
@@ -349,7 +349,7 @@ static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
 	if (!req)
 		return -ENOMEM;
 
-	pm_qos_add_request(req, PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_add_request(req, PM_QOS_DEFAULT_VALUE);
 	filp->private_data = req;
 
 	return 0;
@@ -361,7 +361,7 @@ static int cpu_latency_qos_release(struct inode *inode, struct file *filp)
 
 	filp->private_data = NULL;
 
-	pm_qos_remove_request(req);
+	cpu_latency_qos_remove_request(req);
 	kfree(req);
 
 	return 0;
@@ -374,7 +374,7 @@ static ssize_t cpu_latency_qos_read(struct file *filp, char __user *buf,
 	unsigned long flags;
 	s32 value;
 
-	if (!req || !pm_qos_request_active(req))
+	if (!req || !cpu_latency_qos_request_active(req))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pm_qos_lock, flags);
@@ -400,7 +400,7 @@ static ssize_t cpu_latency_qos_write(struct file *filp, const char __user *buf,
 			return ret;
 	}
 
-	pm_qos_update_request(filp->private_data, value);
+	cpu_latency_qos_update_request(filp->private_data, value);
 
 	return count;
 }
-- 
2.16.4





