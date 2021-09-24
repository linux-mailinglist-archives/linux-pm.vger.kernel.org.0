Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15524416A0F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 04:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhIXCjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 22:39:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56252 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232976AbhIXCjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 22:39:25 -0400
X-UUID: 28acf20c0a5445578d9935b89ef135da-20210924
X-UUID: 28acf20c0a5445578d9935b89ef135da-20210924
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 665185749; Fri, 24 Sep 2021 10:37:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Sep 2021 10:37:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Sep
 2021 10:37:48 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Sep 2021 10:37:47 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH RESEND v3 1/2] PM / wakeirq: support enabling wake-up irq after runtime_suspend called
Date:   Fri, 24 Sep 2021 10:37:45 +0800
Message-ID: <20210924023746.22423-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the dedicated wake-irq is level trigger, and it uses the
consumer's sleep status as the wakeup source, that means if the
consumer is not in sleep state, the wake-irq will be triggered
when enable it; For this case, need enable the wake-irq after
invoking the consumer's runtime_suspend() which make the consumer
enter sleep state.

e.g.
Assume the wake-irq is a low level trigger type, and the wakeup
signal comes from the sleep status of consumer.
The wakeup signal is low level at running time (0), and becomes
high level when the consumer enters sleep state (runtime_suspend
(1) is called), a wakeup event at (2) make the consumer exit sleep
state, then the wakeup signal also becomes low level.

                ------------------
               |           ^     ^|
----------------           |     | --------------
 |<---(0)--->|<--(1)--|   (3)   (2)    (4)

if enable the wake-irq before calling runtime_suspend during (0),
an interrupt will arise, it causes resume immediately;
it works if enable wake-irq ( e.g. at (3) or (4)) after calling
runtime_suspend.

This patch introduces a new status WAKE_IRQ_DEDICATED_LATE_ENABLED
to optionally support enabling wake-irq after calling runtime_suspend().

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add new status suggested by Rafael

v2: add more commit message

  Use the falling edge trigger interrupt suggested by Ikjoon [1], it
works well at firstly when only use this related wakeup source, but
encounter issues if use other wakeup sources to wakeup platform as
below steps:
1. use another wakeup source to wake up the suspended system;
2. the consumer's resume() will be called, and exits sleep state;
3. the consumer's wakeup signal will fall into low level, due to
   currently the wakeup irq is disabled, the wake-irq is pending;
4. the consumer tries to enter runtime suspend, but there is a
   pending wakeup irq, so will resume again, this will repeat
   endlessly.

  Send out the patch again for further discussion.

[1]: https://patchwork.kernel.org/patch/12190407

---
 drivers/base/power/power.h   |  7 ++++--
 drivers/base/power/runtime.c |  6 +++--
 drivers/base/power/wakeirq.c | 49 +++++++++++++++++++++++++++++++++---
 include/linux/pm_wakeirq.h   |  5 ++++
 4 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 54292cdd7808..2d5dfc886f0b 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -25,8 +25,10 @@ extern u64 pm_runtime_active_time(struct device *dev);
 
 #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
 #define WAKE_IRQ_DEDICATED_MANAGED	BIT(1)
+#define WAKE_IRQ_DEDICATED_LATE_ENABLED	BIT(2)
 #define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
-					 WAKE_IRQ_DEDICATED_MANAGED)
+					 WAKE_IRQ_DEDICATED_MANAGED | \
+					 WAKE_IRQ_DEDICATED_LATE_ENABLED)
 
 struct wake_irq {
 	struct device *dev;
@@ -39,7 +41,8 @@ extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_enable_wake_irq_check(struct device *dev,
 					 bool can_change_status);
-extern void dev_pm_disable_wake_irq_check(struct device *dev);
+extern void dev_pm_disable_wake_irq_check(struct device *dev, bool skip_enable_late);
+extern void dev_pm_enable_wake_irq_complete(struct device *dev);
 
 #ifdef CONFIG_PM_SLEEP
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ec94049442b9..e8b807cd7010 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -645,6 +645,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	if (retval)
 		goto fail;
 
+	dev_pm_enable_wake_irq_complete(dev);
+
  no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
@@ -690,7 +692,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, false);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -873,7 +875,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, true);
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index b91a3a9bf9f6..1acf785ebdcd 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -212,6 +212,24 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
 
+/**
+ * dev_pm_wake_irq_set_late_enabled_status - set status WAKE_IRQ_DEDICATED_LATE_ENABLED
+ * @dev: Device
+ *
+ * Set the status of WAKE_IRQ_DEDICATED_LATE_ENABLED to tell rpm_suspend()
+ * to enable dedicated wake-up interrupt after invoking the runtime_suspend(),
+ *
+ * Should be called after setting dedicated wake-up interrupt.
+ */
+void dev_pm_wake_irq_set_late_enabled_status(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (wirq && (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED))
+		wirq->status |= WAKE_IRQ_DEDICATED_LATE_ENABLED;
+}
+EXPORT_SYMBOL_GPL(dev_pm_wake_irq_set_late_enabled_status);
+
 /**
  * dev_pm_enable_wake_irq - Enable device wake-up interrupt
  * @dev: Device
@@ -282,27 +300,52 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	enable_irq(wirq->irq);
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_LATE_ENABLED))
+		enable_irq(wirq->irq);
 }
 
 /**
  * dev_pm_disable_wake_irq_check - Checks and disables wake-up interrupt
  * @dev: Device
+ * @skip_late_enabled_status: skip checking WAKE_IRQ_DEDICATED_LATE_ENABLED
  *
  * Disables wake-up interrupt conditionally based on status.
  * Should be only called from rpm_suspend() and rpm_resume() path.
  */
-void dev_pm_disable_wake_irq_check(struct device *dev)
+void dev_pm_disable_wake_irq_check(struct device *dev, bool skip_late_enabled_status)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
 	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
 		return;
 
-	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
+	    (skip_late_enabled_status ||
+	     !(wirq->status & WAKE_IRQ_DEDICATED_LATE_ENABLED)))
 		disable_irq_nosync(wirq->irq);
 }
 
+/**
+ * dev_pm_enable_wake_irq_complete - enable wake irq based on status
+ * @dev: Device
+ *
+ * Enable wake-up interrupt conditionally based on status, mainly for
+ * enabling wake-up interrupt after runtime_suspend() is called.
+ *
+ * Should be only called from rpm_suspend() path.
+ */
+void dev_pm_enable_wake_irq_complete(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
+		return;
+
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
+	    wirq->status & WAKE_IRQ_DEDICATED_LATE_ENABLED)
+		enable_irq(wirq->irq);
+}
+
 /**
  * dev_pm_arm_wake_irq - Arm device wake-up
  * @wirq: Device wake-up interrupt
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index cd5b62db9084..92f814d583f8 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -22,6 +22,7 @@ extern int dev_pm_set_dedicated_wake_irq(struct device *dev,
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern void dev_pm_enable_wake_irq(struct device *dev);
 extern void dev_pm_disable_wake_irq(struct device *dev);
+extern void dev_pm_wake_irq_set_late_enabled_status(struct device *dev);
 
 #else	/* !CONFIG_PM */
 
@@ -47,5 +48,9 @@ static inline void dev_pm_disable_wake_irq(struct device *dev)
 {
 }
 
+static inline void dev_pm_wake_irq_set_late_enabled_status(struct device *dev)
+{
+}
+
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */
-- 
2.18.0

