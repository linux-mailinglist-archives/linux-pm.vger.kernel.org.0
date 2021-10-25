Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4B9438FD8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJYHEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 03:04:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34546 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230176AbhJYHEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 03:04:23 -0400
X-UUID: 3c8f59f7b92f460a81068b063b3107a9-20211025
X-UUID: 3c8f59f7b92f460a81068b063b3107a9-20211025
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 64032243; Mon, 25 Oct 2021 15:01:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 Oct 2021 15:01:57 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Oct 2021 15:01:56 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 1/3] PM / wakeirq: support enabling wake-up irq after runtime_suspend called
Date:   Mon, 25 Oct 2021 15:01:53 +0800
Message-ID: <20211025070155.2995-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the dedicated wake IRQ is level trigger, and it uses the
device's low-power status as the wakeup source, that means if the
device is not in low-power state, the wake IRQ will be triggered
if enabled; For this case, need enable the wake IRQ after running
the device's ->runtime_suspend() which make it enter low-power state.

e.g.
Assume the wake IRQ is a low level trigger type, and the wakeup
signal comes from the low-power status of the device.
The wakeup signal is low level at running time (0), and becomes
high level when the device enters low-power state (runtime_suspend
(1) is called), a wakeup event at (2) make the device exit low-power
state, then the wakeup signal also becomes low level.

                ------------------
               |           ^     ^|
----------------           |     | --------------
 |<---(0)--->|<--(1)--|   (3)   (2)    (4)

if enable the wake IRQ before running runtime_suspend during (0),
a wake IRQ will arise, it causes resume immediately;
it works if enable wake IRQ ( e.g. at (3) or (4)) after running
->runtime_suspend().

This patch introduces a new status WAKE_IRQ_DEDICATED_REVERSE to
optionally support enabling wake IRQ after running ->runtime_suspend().

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v4: changes according to Rafael's suggestions
    1. rename new flag as WAKE_IRQ_DEDICATED_REVERSE;
    2. add __dev_pm_set_dedicated_wake_irq() with flag parameter, then
       rebuild dev_pm_set_dedicated_wake_irq() and add new api
       dev_pm_set_dedicated_wake_irq_reverse();
    3. rename the new added parameter as cond_disable in
       dev_pm_disable_wake_irq_check(), and also simplify its flow;
    4. modify some comments

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
 drivers/base/power/power.h   |   7 ++-
 drivers/base/power/runtime.c |   6 ++-
 drivers/base/power/wakeirq.c | 101 +++++++++++++++++++++++++++--------
 include/linux/pm_wakeirq.h   |   9 +++-
 4 files changed, 96 insertions(+), 27 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 54292cdd7808..0eb7f02b3ad5 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -25,8 +25,10 @@ extern u64 pm_runtime_active_time(struct device *dev);
 
 #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
 #define WAKE_IRQ_DEDICATED_MANAGED	BIT(1)
+#define WAKE_IRQ_DEDICATED_REVERSE	BIT(2)
 #define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
-					 WAKE_IRQ_DEDICATED_MANAGED)
+					 WAKE_IRQ_DEDICATED_MANAGED | \
+					 WAKE_IRQ_DEDICATED_REVERSE)
 
 struct wake_irq {
 	struct device *dev;
@@ -39,7 +41,8 @@ extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_enable_wake_irq_check(struct device *dev,
 					 bool can_change_status);
-extern void dev_pm_disable_wake_irq_check(struct device *dev);
+extern void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable);
+extern void dev_pm_enable_wake_irq_complete(struct device *dev);
 
 #ifdef CONFIG_PM_SLEEP
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ec94049442b9..d504cd4ab3cb 100644
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
+	dev_pm_disable_wake_irq_check(dev, true);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -873,7 +875,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, false);
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index b91a3a9bf9f6..76c163a89104 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -142,24 +142,7 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 	return IRQ_HANDLED;
 }
 
-/**
- * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
- * @dev: Device entry
- * @irq: Device wake-up interrupt
- *
- * Unless your hardware has separate wake-up interrupts in addition
- * to the device IO interrupts, you don't need this.
- *
- * Sets up a threaded interrupt handler for a device that has
- * a dedicated wake-up interrupt in addition to the device IO
- * interrupt.
- *
- * The interrupt starts disabled, and needs to be managed for
- * the device by the bus code or the device driver using
- * dev_pm_enable_wake_irq() and dev_pm_disable_wake_irq()
- * functions.
- */
-int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag)
 {
 	struct wake_irq *wirq;
 	int err;
@@ -197,7 +180,7 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	if (err)
 		goto err_free_irq;
 
-	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED;
+	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED | flag;
 
 	return err;
 
@@ -210,8 +193,57 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 
 	return err;
 }
+
+
+/**
+ * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ *
+ * Unless your hardware has separate wake-up interrupts in addition
+ * to the device IO interrupts, you don't need this.
+ *
+ * Sets up a threaded interrupt handler for a device that has
+ * a dedicated wake-up interrupt in addition to the device IO
+ * interrupt.
+ *
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
+ * functions.
+ */
+int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+{
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
+}
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
 
+/**
+ * dev_pm_set_dedicated_wake_irq_reverse - Request a dedicated wake-up interrupt
+ *       with setting flag WAKE_IRQ_DEDICATED_REVERSE
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ *
+ * Unless your hardware has separate wake-up interrupts in addition
+ * to the device IO interrupts, you don't need this.
+ *
+ * Sets up a threaded interrupt handler for a device that has a dedicated
+ * wake-up interrupt in addition to the device IO interrupt. It sets
+ * the status of WAKE_IRQ_DEDICATED_REVERSE to tell rpm_suspend()
+ * to enable dedicated wake-up interrupt after running the
+ * ->runtime_suspend()
+ *
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
+ * functions.
+ */
+int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
+
 /**
  * dev_pm_enable_wake_irq - Enable device wake-up interrupt
  * @dev: Device
@@ -282,27 +314,54 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	enable_irq(wirq->irq);
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+		enable_irq(wirq->irq);
 }
 
 /**
  * dev_pm_disable_wake_irq_check - Checks and disables wake-up interrupt
  * @dev: Device
+ * @cond_disable: if set, also check WAKE_IRQ_DEDICATED_REVERSE
  *
  * Disables wake-up interrupt conditionally based on status.
  * Should be only called from rpm_suspend() and rpm_resume() path.
  */
-void dev_pm_disable_wake_irq_check(struct device *dev)
+void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
 	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
 		return;
 
+	if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+		return;
+
 	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
 		disable_irq_nosync(wirq->irq);
 }
 
+/**
+ * dev_pm_enable_wake_irq_complete - enable wake IRQ not enabled before
+ * @dev: Device using the wake IRQ
+ *
+ * Enable wake IRQ conditionally based on status, mainly used if want to
+ * enable wake IRQ after running ->runtime_suspend() which depends on
+ * WAKE_IRQ_DEDICATED_REVERSE.
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
+	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
+		enable_irq(wirq->irq);
+}
+
 /**
  * dev_pm_arm_wake_irq - Arm device wake-up
  * @wirq: Device wake-up interrupt
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index cd5b62db9084..e63a63aa47a3 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -17,8 +17,8 @@
 #ifdef CONFIG_PM
 
 extern int dev_pm_set_wake_irq(struct device *dev, int irq);
-extern int dev_pm_set_dedicated_wake_irq(struct device *dev,
-					 int irq);
+extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
+extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern void dev_pm_enable_wake_irq(struct device *dev);
 extern void dev_pm_disable_wake_irq(struct device *dev);
@@ -35,6 +35,11 @@ static inline int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
+static inline int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	return 0;
+}
+
 static inline void dev_pm_clear_wake_irq(struct device *dev)
 {
 }
-- 
2.18.0

