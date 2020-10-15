Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4475628F99B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 21:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391793AbgJOTiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 15:38:17 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:17648 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391788AbgJOTiR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 15:38:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602790695; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+7QBCxKGdejB03bZtuAiEQh1dYEk8xx/JcoCbYRQQOk=; b=VR+3I2bHxqF9eIOyqy/493IChmcPTaFAmexJ3uE9Lkfxgb2nBFF/vLbbaSkgsvMUcIN3XjZb
 gPy683gWV9Qy132kEtY0Xb2mgmL/Gk3mturIEmPhUz9E6odthau+HttiB498x4CdYQXtoEcz
 6aL9iPTTlu/9UKuurBx/t5eyVIU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f88a526d6d00c7a9ea86815 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Oct 2020 19:38:14
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84094C43387; Thu, 15 Oct 2020 19:38:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79DEAC433FF;
        Thu, 15 Oct 2020 19:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79DEAC433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 1/2] PM / runtime: inform runtime PM of a device's next wakeup
Date:   Thu, 15 Oct 2020 13:38:06 -0600
Message-Id: <20201015193807.17423-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015193807.17423-1-ilina@codeaurora.org>
References: <20201015193807.17423-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices may have a predictable interrupt pattern while executing
usecases. An example would be the VSYNC interrupt associated with
display devices. A 60 Hz display could cause a interrupt every 16 ms. If
the device were in a PM domain, the domain would need to be powered up
for device to resume and handle the interrupt.

Entering a domain idle state saves power, only if the residency of the
idle state is met. Without knowing the idle duration of the domain, the
governor would just choose the deepest idle state that matches the QoS
requirements. The domain might be powered off just as the device is
expecting to wake up. If devices could inform runtime PM of their next
event, the parent PM domain's idle duration can be determined.

So let's add the pm_runtime_set_next_wake() API for the device to notify
runtime PM of the impending wakeup and document it's usage.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v2:
	- Update documentation
	- Remove runtime PM enabled check
	- Update commit text
---
 Documentation/power/runtime_pm.rst | 17 +++++++++++++++++
 drivers/base/power/runtime.c       | 24 ++++++++++++++++++++++++
 include/linux/pm.h                 |  2 ++
 include/linux/pm_runtime.h         |  1 +
 4 files changed, 44 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 0553008b6279..f6aaef15a511 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -515,6 +515,12 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       power.use_autosuspend isn't set, otherwise returns the expiration time
       in jiffies
 
+  `int pm_runtime_set_next_event(struct device *dev, ktime_t next);`
+    - inform runtime PM of the next event on the device. Devices that are
+      sensitive to their domain idle enter/exit latencies may provide this
+      information for use by the PM domain governor. The domain governor would
+      use this information to calculate it's sleep length.
+
 It is safe to execute the following helper functions from interrupt context:
 
 - pm_request_idle()
@@ -545,6 +551,7 @@ functions may also be used in interrupt context:
 - pm_runtime_put_sync()
 - pm_runtime_put_sync_suspend()
 - pm_runtime_put_sync_autosuspend()
+- pm_runtime_set_next_event()
 
 5. Runtime PM Initialization, Device Probing and Removal
 ========================================================
@@ -639,6 +646,16 @@ suspend routine).  It may be necessary to resume the device and suspend it again
 in order to do so.  The same is true if the driver uses different power levels
 or other settings for runtime suspend and system sleep.
 
+When a device enters idle at runtime, it may trigger the runtime PM up the
+hierarchy and if device has a predictable interrupt pattern, we can even do a
+better job at determining the parent's idle state. For example, a display
+device gets a VSYNC interrupt every 16 ms when running at 60 Hz. When it's PM
+domain is powering down and happens to be at the boundary of the VSYNC
+interrupt, it may not be efficient to power off the domain. Knowing the next
+wake up (when available) for devices in the domain we can determine the idle
+duration of the domain. By comparing idle duration with the residencies of the
+domain idle states, we can be efficient in both power and performance.
+
 During system resume, the simplest approach is to bring all devices back to full
 power, even if they had been suspended before the system suspend began.  There
 are several reasons for this, including:
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8143210a5c54..5d2ebacfd35e 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -122,6 +122,27 @@ u64 pm_runtime_suspended_time(struct device *dev)
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
+	spin_lock_irqsave(&dev->power.lock, flags);
+	if (ktime_before(ktime_get(), next)) {
+		dev->power.next_event = next;
+		ret = 0;
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
@@ -1415,6 +1436,9 @@ void pm_runtime_enable(struct device *dev)
 	     "Enabling runtime PM for inactive device (%s) with active children\n",
 	     dev_name(dev));
 
+	/* Reset the next wakeup for the device */
+	dev->power.next_event = KTIME_MAX;
+
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
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

