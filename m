Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2937390B
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhEELK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 07:10:27 -0400
Received: from muru.com ([72.249.23.125]:51880 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhEELKW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 07:10:22 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id AABA980DB;
        Wed,  5 May 2021 11:09:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH] PM: runtime: Fix unpaired parent child_count for force_resume
Date:   Wed,  5 May 2021 14:09:15 +0300
Message-Id: <20210505110915.6861-1-tony@atomide.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As pm_runtime_need_not_resume() relies also on usage_count, it can return
a different value in pm_runtime_force_suspend() compared to when called in
pm_runtime_force_resume(). Different return values can happen if anything
calls PM runtime functions in between, and causes the parent child_count
to increase on every resume.

So far I've seen the issue only for omapdrm that does complicated things
with PM runtime calls during system suspend for legacy reasons:

omap_atomic_commit_tail() for omapdrm.0
 dispc_runtime_get()
  wakes up 58000000.dss as it's the dispc parent
   dispc_runtime_resume()
    rpm_resume() increases parent child_count
 dispc_runtime_put() won't idle, PM runtime suspend blocked
pm_runtime_force_suspend() for 58000000.dss, !pm_runtime_need_not_resume()
 __update_runtime_status()
system suspended
pm_runtime_force_resume() for 58000000.dss, pm_runtime_need_not_resume()
 pm_runtime_enable() only called because of pm_runtime_need_not_resume()
omap_atomic_commit_tail() for omapdrm.0
 dispc_runtime_get()
  wakes up 58000000.dss as it's the dispc parent
   dispc_runtime_resume()
    rpm_resume() increases parent child_count
 dispc_runtime_put() won't idle, PM runtime suspend blocked
...
rpm_suspend for 58000000.dss but parent child_count is now unbalanced

Let's fix the issue by adding a flag for needs_force_resume and use it in
pm_runtime_force_resume() instead of pm_runtime_need_not_resume().

Additionally omapdrm system suspend could be simplified later on to avoid
lots of unnecessary PM runtime calls and the complexity it adds. The
driver can just use internal functions that are shared between the PM
runtime and system suspend related functions.

Fixes: 4918e1f87c5f ("PM / runtime: Rework pm_runtime_force_suspend/resume()")
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/runtime.c | 10 +++++++---
 include/linux/pm.h           |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1637,6 +1637,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
+	dev->power.needs_force_resume = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
@@ -1804,10 +1805,12 @@ int pm_runtime_force_suspend(struct device *dev)
 	 * its parent, but set its status to RPM_SUSPENDED anyway in case this
 	 * function will be called again for it in the meantime.
 	 */
-	if (pm_runtime_need_not_resume(dev))
+	if (pm_runtime_need_not_resume(dev)) {
 		pm_runtime_set_suspended(dev);
-	else
+	} else {
 		__update_runtime_status(dev, RPM_SUSPENDED);
+		dev->power.needs_force_resume = 1;
+	}
 
 	return 0;
 
@@ -1834,7 +1837,7 @@ int pm_runtime_force_resume(struct device *dev)
 	int (*callback)(struct device *);
 	int ret = 0;
 
-	if (!pm_runtime_status_suspended(dev) || pm_runtime_need_not_resume(dev))
+	if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
 		goto out;
 
 	/*
@@ -1853,6 +1856,7 @@ int pm_runtime_force_resume(struct device *dev)
 
 	pm_runtime_mark_last_busy(dev);
 out:
+	dev->power.needs_force_resume = 0;
 	pm_runtime_enable(dev);
 	return ret;
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -602,6 +602,7 @@ struct dev_pm_info {
 	unsigned int		idle_notification:1;
 	unsigned int		request_pending:1;
 	unsigned int		deferred_resume:1;
+	unsigned int		needs_force_resume:1;
 	unsigned int		runtime_auto:1;
 	bool			ignore_children:1;
 	unsigned int		no_callbacks:1;
-- 
2.31.1
