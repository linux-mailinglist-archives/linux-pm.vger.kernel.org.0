Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335092A99CF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFQsd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 11:48:33 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:54211 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFQsd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Nov 2020 11:48:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604681311; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vbVqxdfpXgPQ9hKPEOY6L3TJ3+uw4ScU+tZxEf/suMY=; b=hqiLAP5Cwn/DMaEziEY2fe8+bcme/SNPP/QhDOZ7tBHFz73vxoZVdrlAeycREe0vhiIrUuod
 tll4q3fyvmxvbUdYSgwa7BKddZXzhgUsu2kPSyedwu3/HNPu2wiZydaJ9fBbybNu8ogvXbaj
 Vd63sBQXwjiDyimXxJ4CFHjx2ec=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fa57e57c6df09e2f22a8c5f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 16:48:23
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1802AC433FE; Fri,  6 Nov 2020 16:48:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8D93C433C6;
        Fri,  6 Nov 2020 16:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8D93C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v5 1/2] PM / domains: inform PM domain of a device's next wakeup
Date:   Fri,  6 Nov 2020 09:48:10 -0700
Message-Id: <20201106164811.3698-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201106164811.3698-1-ilina@codeaurora.org>
References: <20201106164811.3698-1-ilina@codeaurora.org>
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
expecting to wake up. If devices could inform PM frameworks of their
next event, the parent PM domain's idle duration can be determined.

So let's add the dev_pm_genpd_set_next_wakeup() API for the device to
inform PM domains of the impending wakeup. This information will be the
domain governor to determine the best idle state given the wakeup.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v5:
	- Fix commit text as pointed by Ulf
	- Use -EOPNOTSUPP
Changes in v4:
	- Use PM domain data to store next_wakeup
	- Drop runtime PM documentation
Changes in v3:
	- Fix unwanted change
Changes in v2:
	- Update documentation
	- Remove runtime PM enabled check
	- Update commit text
---
 drivers/base/power/domain.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 743268996336..34b90e77e0cd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -408,6 +408,41 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
 
+/**
+ * dev_pm_genpd_set_next_wakeup - Notify PM framework of an impending wakeup.
+ *
+ * @dev: Device to handle
+ * @next: impending interrupt/wakeup for the device
+ *
+ * Allow devices to inform of the next wakeup. But, if the domain were already
+ * powered off, we will not wakeup the domain to recompute it's idle duration.
+ */
+int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
+{
+	struct generic_pm_domain *genpd;
+	struct generic_pm_domain_data *gpd_data;
+	int ret = -EINVAL;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (WARN_ON(!dev->power.subsys_data ||
+		    !dev->power.subsys_data->domain_data))
+		return ret;
+
+	genpd_lock(genpd);
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+	if (ktime_before(ktime_get(), next)) {
+		gpd_data->next_wakeup = next;
+		ret = 0;
+	}
+	genpd_unlock(genpd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -1431,6 +1466,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->next_wakeup = KTIME_MAX;
 
 	spin_lock_irq(&dev->power.lock);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1ad0ec481416..d7875bfde7f4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -9,6 +9,7 @@
 #define _LINUX_PM_DOMAIN_H
 
 #include <linux/device.h>
+#include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/err.h>
@@ -191,6 +192,7 @@ struct generic_pm_domain_data {
 	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
+	ktime_t	next_wakeup;
 	void *data;
 };
 
@@ -217,6 +219,7 @@ int pm_genpd_remove(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
+int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -275,6 +278,11 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
+{
+	return -EOPNOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

