Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55F159D66
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgBKXjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46840 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgBKXjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:00 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 8117770a5ac94a1f; Wed, 12 Feb 2020 00:38:58 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 07/28] PM: QoS: Clean up misc device file operations
Date:   Wed, 12 Feb 2020 00:00:12 +0100
Message-ID: <8377820.a6Hm6vfviC@kreacher>
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

Reorder the code to avoid using extra function header declarations
for the pm_qos_power_*() family of functions and drop those
declarations.

Also clean up the internals of those functions to consolidate checks,
avoid using redundant local variables and similar.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/qos.c | 62 +++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 57ff542a4f9d..9f67584d4466 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -83,21 +83,6 @@ static struct pm_qos_object *pm_qos_array[] = {
 	&cpu_dma_pm_qos,
 };
 
-static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
-		size_t count, loff_t *f_pos);
-static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
-		size_t count, loff_t *f_pos);
-static int pm_qos_power_open(struct inode *inode, struct file *filp);
-static int pm_qos_power_release(struct inode *inode, struct file *filp);
-
-static const struct file_operations pm_qos_power_fops = {
-	.write = pm_qos_power_write,
-	.read = pm_qos_power_read,
-	.open = pm_qos_power_open,
-	.release = pm_qos_power_release,
-	.llseek = noop_llseek,
-};
-
 /**
  * pm_qos_read_value - Return the current effective constraint value.
  * @c: List of PM QoS constraint requests.
@@ -414,15 +399,6 @@ EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
 /* User space interface to global PM QoS via misc device. */
 
-static int register_pm_qos_misc(struct pm_qos_object *qos)
-{
-	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
-	qos->pm_qos_power_miscdev.name = qos->name;
-	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
-
-	return misc_register(&qos->pm_qos_power_miscdev);
-}
-
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
 {
 	struct pm_qos_request *req;
@@ -439,9 +415,10 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
 
 static int pm_qos_power_release(struct inode *inode, struct file *filp)
 {
-	struct pm_qos_request *req;
+	struct pm_qos_request *req = filp->private_data;
+
+	filp->private_data = NULL;
 
-	req = filp->private_data;
 	pm_qos_remove_request(req);
 	kfree(req);
 
@@ -449,15 +426,13 @@ static int pm_qos_power_release(struct inode *inode, struct file *filp)
 }
 
 static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
-		size_t count, loff_t *f_pos)
+				 size_t count, loff_t *f_pos)
 {
-	s32 value;
-	unsigned long flags;
 	struct pm_qos_request *req = filp->private_data;
+	unsigned long flags;
+	s32 value;
 
-	if (!req)
-		return -EINVAL;
-	if (!pm_qos_request_active(req))
+	if (!req || !pm_qos_request_active(req))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pm_qos_lock, flags);
@@ -468,10 +443,9 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 }
 
 static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
-		size_t count, loff_t *f_pos)
+				  size_t count, loff_t *f_pos)
 {
 	s32 value;
-	struct pm_qos_request *req;
 
 	if (count == sizeof(s32)) {
 		if (copy_from_user(&value, buf, sizeof(s32)))
@@ -484,12 +458,28 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 			return ret;
 	}
 
-	req = filp->private_data;
-	pm_qos_update_request(req, value);
+	pm_qos_update_request(filp->private_data, value);
 
 	return count;
 }
 
+static const struct file_operations pm_qos_power_fops = {
+	.write = pm_qos_power_write,
+	.read = pm_qos_power_read,
+	.open = pm_qos_power_open,
+	.release = pm_qos_power_release,
+	.llseek = noop_llseek,
+};
+
+static int register_pm_qos_misc(struct pm_qos_object *qos)
+{
+	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
+	qos->pm_qos_power_miscdev.name = qos->name;
+	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
+
+	return misc_register(&qos->pm_qos_power_miscdev);
+}
+
 static int __init pm_qos_power_init(void)
 {
 	int ret;
-- 
2.16.4





