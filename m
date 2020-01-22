Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28187145EFA
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 00:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAVXL0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 18:11:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54191 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVXL0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 18:11:26 -0500
Received: from 79.184.255.84.ipv4.supernova.orange.pl (79.184.255.84) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 5c3577da6efc3ff5; Thu, 23 Jan 2020 00:11:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Daewoong Kim <daewoong00.kim@lge.com>,
        Seokjoo Lee <seokjoo.lee@lge.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] PM: core: Fix handling of devices deleted during system-wide resume
Date:   Thu, 23 Jan 2020 00:11:24 +0100
Message-ID: <2601275.1tEomSadG4@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a device is deleted by one of its system-wide resume callbacks
(for example, because it does not appear to be present or accessible
any more) along with its children, the resume of the children may
continue leading to use-after-free errors and other issues
(potentially).

Namely, if the device's children are resumed asynchronously, their
resume may have been scheduled already before the device's callback
runs and so the device may be deleted while dpm_wait_for_superior()
is being executed for them.  The memory taken up by the parent device
object may be freed then while dpm_wait() is waiting for the parent's
resume callback to complete, which leads to a use-after-free.
Moreover, the resume of the children is really not expected to
continue after they have been unregistered, so it must be terminated
right away in that case.

To address this problem, modify dpm_wait_for_superior() to check
if the target device is still there in the system-wide PM list of
devices and if so, to increment its parent's reference counter, both
under dpm_list_mtx which prevents device_del() running for the child
from dropping the parent's reference counter prematurely.

If the device is not present in the system-wide PM list of devices
any more, the resume of it cannot continue, so check that again after
dpm_wait() returns, which means that the parent's callback has been
completed, and pass the result of that check to the caller of
dpm_wait_for_superior() to allow it to abort the device's resume
if it is not there any more.

Link: https://lore.kernel.org/linux-pm/1579568452-27253-1-git-send-email-chanho.min@lge.com
Reported-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -273,10 +273,38 @@ static void dpm_wait_for_suppliers(struc
 	device_links_read_unlock(idx);
 }
 
-static void dpm_wait_for_superior(struct device *dev, bool async)
+static bool dpm_wait_for_superior(struct device *dev, bool async)
 {
-	dpm_wait(dev->parent, async);
+	struct device *parent;
+
+	/*
+	 * If the device is resumed asynchronously and the parent's callback
+	 * deletes both the device and the parent itself, the parent object may
+	 * be freed while this function is running, so avoid that by reference
+	 * counting the parent once more unless the device has been deleted
+	 * already (in which case return right away).
+	 */
+	mutex_lock(&dpm_list_mtx);
+
+	if (!device_pm_initialized(dev)) {
+		mutex_unlock(&dpm_list_mtx);
+		return false;
+	}
+
+	parent = get_device(dev->parent);
+
+	mutex_unlock(&dpm_list_mtx);
+
+	dpm_wait(parent, async);
+	put_device(parent);
+
 	dpm_wait_for_suppliers(dev, async);
+
+	/*
+	 * If the parent's callback has deleted the device, attempting to resume
+	 * it would be invalid, so avoid doing that then.
+	 */
+	return device_pm_initialized(dev);
 }
 
 static void dpm_wait_for_consumers(struct device *dev, bool async)
@@ -621,7 +649,8 @@ static int device_resume_noirq(struct de
 	if (!dev->power.is_noirq_suspended)
 		goto Out;
 
-	dpm_wait_for_superior(dev, async);
+	if (!dpm_wait_for_superior(dev, async))
+		goto Out;
 
 	skip_resume = dev_pm_may_skip_resume(dev);
 
@@ -829,7 +858,8 @@ static int device_resume_early(struct de
 	if (!dev->power.is_late_suspended)
 		goto Out;
 
-	dpm_wait_for_superior(dev, async);
+	if (!dpm_wait_for_superior(dev, async))
+		goto Out;
 
 	callback = dpm_subsys_resume_early_cb(dev, state, &info);
 
@@ -944,7 +974,9 @@ static int device_resume(struct device *
 		goto Complete;
 	}
 
-	dpm_wait_for_superior(dev, async);
+	if (!dpm_wait_for_superior(dev, async))
+		goto Complete;
+
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 



