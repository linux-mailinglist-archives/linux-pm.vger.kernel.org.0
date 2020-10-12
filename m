Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6338628C4D5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 00:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbgJLWej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 18:34:39 -0400
Received: from z5.mailgun.us ([104.130.96.5]:55521 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390279AbgJLWei (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 18:34:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602542077; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=CAA8HtrnxV68z7xJ7H069hnJ4UKgoDlQuitgfOh24BQ=; b=kfIleEMfX/jEj0XwSt/psS73/Xj5zmMEVcDWieYlKQOKjG34KrwL4vpZMplK5Tgim5zW37Vs
 Y1jCIx73MZRajk9CHuuEssR0unWaLoHkN6DMh+jmyzIsEjwVikKpOUcG2rGm6tYazdWGNTX/
 weHi21MyVpTko6SHnwtZka1JXTs=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f84d9fbef891f1ee26dfea6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Oct 2020 22:34:34
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FAA8C43391; Mon, 12 Oct 2020 22:34:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03746C43382;
        Mon, 12 Oct 2020 22:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03746C43382
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 1/2] PM / runtime: register device's next wakeup
Date:   Mon, 12 Oct 2020 16:33:59 -0600
Message-Id: <20201012223400.23609-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012223400.23609-1-ilina@codeaurora.org>
References: <20201012223400.23609-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices have a predictable interrupt pattern while executing a
particular usecase. An example would be the VSYNC interrupt on devices
associated with displays. A 60 Hz display could cause a periodic
interrupt every 16 ms. A PM domain that holds such a device could power
off and on at similar intervals.

Entering a domain idle state saves power, only if the domain remains in
the idle state for the amount of time greater than or equal to the
residency of the idle state. Knowing the next wakeup event of the device
will help the PM domain governor make better idle state decisions.

Let's add the pm_runtime_set_next_wake() API for the device and document
the usage of the API.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 Documentation/power/runtime_pm.rst | 21 ++++++++++++++++++++
 drivers/base/power/runtime.c       | 31 ++++++++++++++++++++++++++++++
 include/linux/pm.h                 |  2 ++
 include/linux/pm_runtime.h         |  1 +
 4 files changed, 55 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 0553008b6279..90a5ac481ad4 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -515,6 +515,14 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       power.use_autosuspend isn't set, otherwise returns the expiration time
       in jiffies
 
+  `int pm_runtime_set_next_event(struct device *dev, ktime_t next);`
+    - notify runtime PM of the next event on the device. Devices that are
+      sensitive to their domain idle enter/exit latencies may provide this
+      information for use by the PM domain governor. The governor may determine
+      if it worthwhile to enter a domain idle state. If the residency of the
+      domain idle state is not met, the domain would waste more power entering
+      and exiting the said idle state.
+
 It is safe to execute the following helper functions from interrupt context:
 
 - pm_request_idle()
@@ -545,6 +553,7 @@ functions may also be used in interrupt context:
 - pm_runtime_put_sync()
 - pm_runtime_put_sync_suspend()
 - pm_runtime_put_sync_autosuspend()
+- pm_runtime_set_next_event()
 
 5. Runtime PM Initialization, Device Probing and Removal
 ========================================================
@@ -639,6 +648,18 @@ suspend routine).  It may be necessary to resume the device and suspend it again
 in order to do so.  The same is true if the driver uses different power levels
 or other settings for runtime suspend and system sleep.
 
+When a device enters idle at runtime, it may trigger the runtime PM up the
+hierarchy. Devices that have an predictable interrupt pattern, may help
+influence a better idle state determination of its parent. For example, a
+display device could get a VSYNC interrupt every 16ms. A PM domain containing
+the device, could also be entering and exiting idle due to runtime PM
+coordination. If the domain were also entering runtime idle, we would know when
+the domain would be waken up as a result of the display device waking up. Using
+the device's next_event, the PM domain governor can make a better choice of the
+idle state for the domain, knowing it would be be woken up by the device in the
+near future. This is specially useful when the device is sensitive to its PM
+domain's idle state enter and exit latencies.
+
 During system resume, the simplest approach is to bring all devices back to full
 power, even if they had been suspended before the system suspend began.  There
 are several reasons for this, including:
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8143210a5c54..53c2b3d962bc 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -122,6 +122,33 @@ u64 pm_runtime_suspended_time(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
 
+/**
+ * pm_runtime_set_next_wakeup_event - Notify PM framework of an impending event.
+ * @dev: Device to handle
+ * @next: impending interrupt/wakeup for the device
+ */
+int pm_runtime_set_next_event(struct device *dev, ktime_t next)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	/*
+	 * Note the next pending wakeup of a device,
+	 * if the device does not have runtime PM enabled.
+	 */
+	spin_lock_irqsave(&dev->power.lock, flags);
+	if (!dev->power.disable_depth) {
+		if (ktime_before(ktime_get(), next)) {
+			dev->power.next_event = next;
+			ret = 0;
+		}
+	}
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_set_next_event);
+
 /**
  * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
  * @dev: Device to handle.
@@ -1380,6 +1407,9 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 	/* Update time accounting before disabling PM-runtime. */
 	update_pm_runtime_accounting(dev);
 
+	/* Reset the next wakeup for the device */
+	dev->power.next_event = KTIME_MAX;
+
 	if (!dev->power.disable_depth++)
 		__pm_runtime_barrier(dev);
 
@@ -1609,6 +1639,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.deferred_resume = false;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
+	dev->power.next_event = KTIME_MAX;
 	dev->power.timer_expires = 0;
 	hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	dev->power.suspend_timer.function = pm_suspend_timer_fn;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index a30a4b54df52..9051658674a4 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_H
 #define _LINUX_PM_H
 
+#include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
@@ -616,6 +617,7 @@ struct dev_pm_info {
 	u64			active_time;
 	u64			suspended_time;
 	u64			accounting_timestamp;
+	ktime_t			next_event;
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 6245caa18034..af6d35178335 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -59,6 +59,7 @@ extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device *dev);
+extern int pm_runtime_set_next_event(struct device *dev, ktime_t next);
 
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

