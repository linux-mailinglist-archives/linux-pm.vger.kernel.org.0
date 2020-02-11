Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E6159D61
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgBKXj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51023 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgBKXjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:01 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a806f37668c6bdd0; Wed, 12 Feb 2020 00:38:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 06/28] PM: QoS: Drop iterations over global QoS classes
Date:   Tue, 11 Feb 2020 23:59:22 +0100
Message-ID: <2037812.lB3JyXoBhI@kreacher>
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
only global PM QoS class in use is PM_QOS_CPU_DMA_LATENCY, so it
does not really make sense to iterate over global QoS classes
anywhere, since there is only one.

Remove iterations over global QoS classes from the code and use
PM_QOS_CPU_DMA_LATENCY as the target class directly where needed.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/qos.c | 52 ++++++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index f09eca5ffe07..57ff542a4f9d 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -412,7 +412,8 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
-/* User space interface to PM QoS classes via misc devices */
+/* User space interface to global PM QoS via misc device. */
+
 static int register_pm_qos_misc(struct pm_qos_object *qos)
 {
 	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
@@ -422,35 +423,18 @@ static int register_pm_qos_misc(struct pm_qos_object *qos)
 	return misc_register(&qos->pm_qos_power_miscdev);
 }
 
-static int find_pm_qos_object_by_minor(int minor)
-{
-	int pm_qos_class;
-
-	for (pm_qos_class = PM_QOS_CPU_DMA_LATENCY;
-		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
-		if (minor ==
-			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
-			return pm_qos_class;
-	}
-	return -1;
-}
-
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
 {
-	long pm_qos_class;
+	struct pm_qos_request *req;
 
-	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
-	if (pm_qos_class >= PM_QOS_CPU_DMA_LATENCY) {
-		struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
-		if (!req)
-			return -ENOMEM;
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
-		pm_qos_add_request(req, pm_qos_class, PM_QOS_DEFAULT_VALUE);
-		filp->private_data = req;
+	pm_qos_add_request(req, PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
+	filp->private_data = req;
 
-		return 0;
-	}
-	return -EPERM;
+	return 0;
 }
 
 static int pm_qos_power_release(struct inode *inode, struct file *filp)
@@ -464,7 +448,6 @@ static int pm_qos_power_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-
 static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 		size_t count, loff_t *f_pos)
 {
@@ -507,26 +490,19 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 	return count;
 }
 
-
 static int __init pm_qos_power_init(void)
 {
-	int ret = 0;
-	int i;
+	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
 
-	for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
-		ret = register_pm_qos_misc(pm_qos_array[i]);
-		if (ret < 0) {
-			pr_err("%s: %s setup failed\n",
-			       __func__, pm_qos_array[i]->name);
-			return ret;
-		}
-	}
+	ret = register_pm_qos_misc(pm_qos_array[PM_QOS_CPU_DMA_LATENCY]);
+	if (ret < 0)
+		pr_err("%s: %s setup failed\n", __func__,
+		       pm_qos_array[PM_QOS_CPU_DMA_LATENCY]->name);
 
 	return ret;
 }
-
 late_initcall(pm_qos_power_init);
 
 /* Definitions related to the frequency QoS below. */
-- 
2.16.4





