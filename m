Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B6196DD5
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgC2OLk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 10:11:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43412 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgC2OLk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 10:11:40 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 0f53fe2481d82a5e; Sun, 29 Mar 2020 16:11:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: sleep: core: Drop racy and redundant checks from device_prepare()
Date:   Sun, 29 Mar 2020 16:11:18 +0200
Message-ID: <1792393.Ra5xgIVOUU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Alan Stern points out that the WARN_ON() check in device_prepare()
is racy (because the PM-runtime API can be disabled briefly for any
device at any time and system suspend can start at any time too) and
the pm_runtime_suspended() check in the computation of the
direct_complete flag value is redundant (because it will be
repeated later anyway).

Drop both these checks accordingly.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1922,10 +1922,6 @@ static int device_prepare(struct device
 	if (dev->power.syscore)
 		return 0;
 
-	WARN_ON(!pm_runtime_enabled(dev) &&
-		dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
-					      DPM_FLAG_LEAVE_SUSPENDED));
-
 	/*
 	 * If a device's parent goes into runtime suspend at the wrong time,
 	 * it won't be possible to resume the device.  To prevent this we
@@ -1973,8 +1969,7 @@ unlock:
 	 */
 	spin_lock_irq(&dev->power.lock);
 	dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
-		((pm_runtime_suspended(dev) && ret > 0) ||
-		 dev->power.no_pm_callbacks) &&
+		(ret > 0 || dev->power.no_pm_callbacks) &&
 		!dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
 	spin_unlock_irq(&dev->power.lock);
 	return 0;



