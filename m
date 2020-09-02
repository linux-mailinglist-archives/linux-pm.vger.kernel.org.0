Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD125B746
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 01:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIBX1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 19:27:17 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:60556 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgIBX1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 19:27:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599089236; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jXEY6z5/Ir9K9+hi+VNDv+eb6ICgVav+y77gSTmbm+4=; b=Dc1SzsidQ/c6hTkwbVxLongSv/6bPuz42EdQdrgFbh8DKhdN2cnfsVLk+POxTzNIrRpXKcGl
 jFskC1NSJRxWGH/WfCE0k7yYdVVZf8C5GQKJEs1RUEAzQGgY9nSF7S+dXPVwnKAw1Llcsl68
 WoWGrFwW+dMZ9oYrYxoDu4waXZ4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f502a3e885efaea0a4e22d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 23:26:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D53B9C433A0; Wed,  2 Sep 2020 23:26:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 990F9C433CA;
        Wed,  2 Sep 2020 23:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 990F9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [RFC PATCH 1/2] PM / runtime: register device's next wakeup
Date:   Wed,  2 Sep 2020 17:25:45 -0600
Message-Id: <20200902232546.31240-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902232546.31240-1-ilina@codeaurora.org>
References: <20200902232546.31240-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices have a predictable interrupt pattern while executing a
particular usecase. An example would be the VSYNC interrupt on devices
associated with displays. A 60 Hz display could cause a periodic
interrupt every 16 ms. A PM domain that holds such a device could power
off and on at similar intervals. But when the domain is a supplier for
multiple such devices, the idle pattern for the domain is bit muddled,
but still deducible.

If the next wakeup is known for all devices in a domain, it becomes easy
to find out the sleep duration for the domain. By allowing drivers to
notify runtime PM of their device's future wakeup, we can make better PM
domain governor idle state decisions when powering off the domain.

For now, let's allow updating the device's next wake up as long as
runtime PM is enabled. If the device is runtime suspended, the domain
could be as well and we don't want to wake up the domain to recompute
the domain idle state. As a first step, the onus is on the drivers to
update their device's wakeup correctly before the device and the domain
enter runtime idle.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/runtime.c | 31 +++++++++++++++++++++++++++++++
 include/linux/pm.h           |  2 ++
 include/linux/pm_runtime.h   |  1 +
 3 files changed, 34 insertions(+)

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

