Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475E2DC5B9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgLPRwJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 12:52:09 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:14724 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgLPRwJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 12:52:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608141105; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=j5jhJprTObWGrrzO7bLScPsPeoAqEcdBaw0JRAlx5eU=; b=HieHD5fSax4dniaGjXZUSAWEhbKRBVKVqFBwMqRK5X3EGHKTrv0Qk9+WxyA5kHPQnJMxCqWZ
 iEHaWQqTaZ8OZTLvHhSbBN/0SJ6ge2q1sC+ypDym/RYHwKyvE4TUo712IMTna7bFKOTt+xMK
 d5ZxQkZULDceqkFNLirmQ9P/Y8k=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fda490df5e9af65f86cda5c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Dec 2020 17:51:09
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08747C433C6; Wed, 16 Dec 2020 17:51:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99046C433C6;
        Wed, 16 Dec 2020 17:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99046C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     ulf.hansson@linaro.org, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] PM / Domains: allow domain idle states to be disabled
Date:   Wed, 16 Dec 2020 10:50:56 -0700
Message-Id: <20201216175056.19554-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to debug critical domain and device power issues, it may be
necessary to disallow certain idle states at runtime. Let the device
disallow a domain idle state before suspending.The domain governor shall
check for the 'disabled' flag while determining the domain idle state.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/domain.c          | 30 ++++++++++++++++++++++++++++
 drivers/base/power/domain_governor.c |  3 +++
 include/linux/pm_domain.h            |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 191539a8e06d..e4e7ab75bdea 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1926,6 +1926,36 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
 
+/**
+ * dev_pm_genpd_disable_idle_state - Disallow a PM domain's idle state
+ *
+ * @dev: device attached to the PM domain
+ * @idx: index of the PM domain's idle state to be disabled
+ * @disable: enable/disable idle state
+ *
+ * Allow a PM domain's idle state to be disabled. Disabled idle states will
+ * be ignored by the domain governor when entering idle. Devices would
+ * invoke this before calling runtime suspend.
+ */
+int dev_pm_genpd_disable_idle_state(struct device *dev, unsigned int idx, bool disable)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (idx >= genpd->state_count)
+		return -EINVAL;
+
+	genpd_lock(genpd);
+	genpd->states[idx].disabled = disable;
+	genpd_unlock(genpd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_disable_idle_state);
+
 static void genpd_free_default_power_state(struct genpd_power_state *states,
 					   unsigned int state_count)
 {
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2afb7fa90d5d..8decd17c5a6a 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -175,6 +175,9 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
 
+	if (genpd->states[state].disabled)
+		return false;
+
 	off_on_time_ns = genpd->states[state].power_off_latency_ns +
 		genpd->states[state].power_on_latency_ns;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a41aea9d1c06..3d251b5b461a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -101,6 +101,7 @@ struct genpd_power_state {
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
 	void *data;
+	bool disabled;
 };
 
 struct genpd_lock_ops;
@@ -233,6 +234,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
 void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable);
 int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
+int dev_pm_genpd_disable_idle_state(struct device *dev, unsigned int idx, bool disable);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -300,6 +302,11 @@ static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
 	return -EOPNOTSUPP;
 }
 
+static inline int dev_pm_genpd_disable_idle_state(struct device *dev, unsigned int idx, bool disable)
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

