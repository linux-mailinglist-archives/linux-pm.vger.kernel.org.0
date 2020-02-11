Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82C159D58
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBKXjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46664 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgBKXjF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:05 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id c814c39a8c8d77ab; Wed, 12 Feb 2020 00:39:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 01/28] PM: QoS: Drop debugfs interface
Date:   Tue, 11 Feb 2020 23:52:35 +0100
Message-ID: <2121727.25eEc26k0f@kreacher>
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

After commit c3082a674f46 ("PM: QoS: Get rid of unused flags") the
only global PM QoS class in use is PM_QOS_CPU_DMA_LATENCY and the
existing PM QoS debugfs interface has become overly complicated (as
it takes other potentially possible PM QoS classes that are not there
any more into account).  It is also not particularly useful (the
"type" of the PM_QOS_CPU_DMA_LATENCY is known, its aggregate value
can be read from /dev/cpu_dma_latency and the number of requests in
the queue does not really matter) and there are no known users
depending on it.  Moreover, there are dedicated trace events that
can be used for tracking PM QoS usage with much higher precision.

For these reasons, drop the PM QoS debugfs interface altogether.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/qos.c | 73 ++----------------------------------------------------
 1 file changed, 2 insertions(+), 71 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 83edf8698118..d932fa42e8e4 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -137,69 +137,6 @@ static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 	c->target_value = value;
 }
 
-static int pm_qos_debug_show(struct seq_file *s, void *unused)
-{
-	struct pm_qos_object *qos = (struct pm_qos_object *)s->private;
-	struct pm_qos_constraints *c;
-	struct pm_qos_request *req;
-	char *type;
-	unsigned long flags;
-	int tot_reqs = 0;
-	int active_reqs = 0;
-
-	if (IS_ERR_OR_NULL(qos)) {
-		pr_err("%s: bad qos param!\n", __func__);
-		return -EINVAL;
-	}
-	c = qos->constraints;
-	if (IS_ERR_OR_NULL(c)) {
-		pr_err("%s: Bad constraints on qos?\n", __func__);
-		return -EINVAL;
-	}
-
-	/* Lock to ensure we have a snapshot */
-	spin_lock_irqsave(&pm_qos_lock, flags);
-	if (plist_head_empty(&c->list)) {
-		seq_puts(s, "Empty!\n");
-		goto out;
-	}
-
-	switch (c->type) {
-	case PM_QOS_MIN:
-		type = "Minimum";
-		break;
-	case PM_QOS_MAX:
-		type = "Maximum";
-		break;
-	case PM_QOS_SUM:
-		type = "Sum";
-		break;
-	default:
-		type = "Unknown";
-	}
-
-	plist_for_each_entry(req, &c->list, node) {
-		char *state = "Default";
-
-		if ((req->node).prio != c->default_value) {
-			active_reqs++;
-			state = "Active";
-		}
-		tot_reqs++;
-		seq_printf(s, "%d: %d: %s\n", tot_reqs,
-			   (req->node).prio, state);
-	}
-
-	seq_printf(s, "Type=%s, Value=%d, Requests: active=%d / total=%d\n",
-		   type, pm_qos_get_value(c), active_reqs, tot_reqs);
-
-out:
-	spin_unlock_irqrestore(&pm_qos_lock, flags);
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(pm_qos_debug);
-
 /**
  * pm_qos_update_target - manages the constraints list and calls the notifiers
  *  if needed
@@ -529,15 +466,12 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
 /* User space interface to PM QoS classes via misc devices */
-static int register_pm_qos_misc(struct pm_qos_object *qos, struct dentry *d)
+static int register_pm_qos_misc(struct pm_qos_object *qos)
 {
 	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
 	qos->pm_qos_power_miscdev.name = qos->name;
 	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
 
-	debugfs_create_file(qos->name, S_IRUGO, d, (void *)qos,
-			    &pm_qos_debug_fops);
-
 	return misc_register(&qos->pm_qos_power_miscdev);
 }
 
@@ -631,14 +565,11 @@ static int __init pm_qos_power_init(void)
 {
 	int ret = 0;
 	int i;
-	struct dentry *d;
 
 	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
 
-	d = debugfs_create_dir("pm_qos", NULL);
-
 	for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
-		ret = register_pm_qos_misc(pm_qos_array[i], d);
+		ret = register_pm_qos_misc(pm_qos_array[i]);
 		if (ret < 0) {
 			pr_err("%s: %s setup failed\n",
 			       __func__, pm_qos_array[i]->name);
-- 
2.16.4





