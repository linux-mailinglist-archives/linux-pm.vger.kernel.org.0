Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9DD178F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIS2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 14:28:38 -0400
Received: from muru.com ([72.249.23.125]:36298 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJIS2i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 14:28:38 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 27DB88140;
        Wed,  9 Oct 2019 18:29:11 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM / runtime: Add support for wake-up reason for wakeirqs
Date:   Wed,  9 Oct 2019 11:28:03 -0700
Message-Id: <20191009182803.63742-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With generic wakeirqs we can wake a device, but do not know if the
device woke to a wakeirq. Let's add pm_runtime_wakeup_is_wakeirq() so
a device can check the wake-up reason.

This can used for cases where a device wakes up on its own to a
wake-up interrupt, and the device PM runtime resume function can
then skip some or all of the device wake-up sequence based on
pm_runtime_wakeup_is_wakeirq().

Let's only add RPM_WAKEUP_NONE and RPM_WAKEUP_WAKEIRQ for now, other
events can be added later on if really needed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/wakeirq.c | 14 ++++++++++++--
 include/linux/pm.h           | 14 ++++++++++++++
 include/linux/pm_runtime.h   |  6 ++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -127,13 +127,18 @@ EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
 static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 {
 	struct wake_irq *wirq = _wirq;
+	struct device *dev = wirq->dev;
+	unsigned long flags;
 	int res;
 
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev->power.wakeup_reason = RPM_WAKEUP_WAKEIRQ;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
 	/* Maybe abort suspend? */
 	if (irqd_is_wakeup_set(irq_get_irq_data(irq))) {
 		pm_wakeup_event(wirq->dev, 0);
-
-		return IRQ_HANDLED;
+		goto out_handled;
 	}
 
 	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
@@ -142,6 +147,11 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 		dev_warn(wirq->dev,
 			 "wake IRQ with no resume: %i\n", res);
 
+out_handled:
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev->power.wakeup_reason = RPM_WAKEUP_NONE;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -523,6 +523,19 @@ enum rpm_request {
 	RPM_REQ_RESUME,
 };
 
+/*
+ * Device run-time wake-up reason types.
+ *
+ * RPM_WAKEUP_NONE	No wake-up reason
+ *
+ * RPM_WAKEUP_WAKEIRQ	Wake-up to a dedicated wakeirq
+ */
+
+enum rpm_wakeup_reason {
+	RPM_WAKEUP_NONE = 0,
+	RPM_WAKEUP_WAKEIRQ,
+};
+
 struct wakeup_source;
 struct wake_irq;
 struct pm_domain_data;
@@ -615,6 +628,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		wakeup_reason:1;
 	unsigned int		links_count;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -117,6 +117,11 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
 	return dev->power.irq_safe;
 }
 
+static inline bool pm_runtime_wakeup_is_wakeirq(struct device *dev)
+{
+	return dev->power.wakeup_reason == RPM_WAKEUP_WAKEIRQ;
+}
+
 extern u64 pm_runtime_suspended_time(struct device *dev);
 
 #else /* !CONFIG_PM */
@@ -183,6 +188,7 @@ static inline void pm_runtime_get_suppliers(struct device *dev) {}
 static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
 static inline void pm_runtime_drop_link(struct device *dev) {}
+static inline bool pm_runtime_wakeup_is_wakeirq(struct device *dev) { return false; }
 
 #endif /* !CONFIG_PM */
 
-- 
2.23.0
