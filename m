Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743105EF80
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 01:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfGCXFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 19:05:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60801 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfGCXFk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 19:05:40 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 3f159dca3fbf52f1; Thu, 4 Jul 2019 01:05:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PM: sleep: Drop dev_pm_skip_next_resume_phases()
Date:   Thu, 04 Jul 2019 01:05:38 +0200
Message-ID: <2100414.Plmip0uhM5@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent hibernation-related changes, there are no more callers
of dev_pm_skip_next_resume_phases() except for the PM core itself
in which it is more straightforward to run the statements from
that function directly, so do that and drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the patch series at:

https://lore.kernel.org/linux-acpi/20190701162017.GB2640@lahna.fi.intel.com/T/#madf00de2d5a9b67e3c7bf51e882bd66ed7efc7ea

---
 drivers/base/power/main.c |   19 +++----------------
 include/linux/pm.h        |    1 -
 2 files changed, 3 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -530,21 +530,6 @@ static void dpm_watchdog_clear(struct dp
 /*------------------------- Resume routines -------------------------*/
 
 /**
- * dev_pm_skip_next_resume_phases - Skip next system resume phases for device.
- * @dev: Target device.
- *
- * Make the core skip the "early resume" and "resume" phases for @dev.
- *
- * This function can be called by middle-layer code during the "noirq" phase of
- * system resume if necessary, but not by device drivers.
- */
-void dev_pm_skip_next_resume_phases(struct device *dev)
-{
-	dev->power.is_late_suspended = false;
-	dev->power.is_suspended = false;
-}
-
-/**
  * suspend_event - Return a "suspend" message for given "resume" one.
  * @resume_msg: PM message representing a system-wide resume transition.
  */
@@ -681,6 +666,9 @@ Skip:
 	dev->power.is_noirq_suspended = false;
 
 	if (skip_resume) {
+		/* Make the next phases of resume skip the device. */
+		dev->power.is_late_suspended = false;
+		dev->power.is_suspended = false;
 		/*
 		 * The device is going to be left in suspend, but it might not
 		 * have been in runtime suspend before the system suspended, so
@@ -689,7 +677,6 @@ Skip:
 		 * device again.
 		 */
 		pm_runtime_set_suspended(dev);
-		dev_pm_skip_next_resume_phases(dev);
 	}
 
 Out:
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -760,7 +760,6 @@ extern int pm_generic_poweroff_late(stru
 extern int pm_generic_poweroff(struct device *dev);
 extern void pm_generic_complete(struct device *dev);
 
-extern void dev_pm_skip_next_resume_phases(struct device *dev);
 extern bool dev_pm_may_skip_resume(struct device *dev);
 extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
 



