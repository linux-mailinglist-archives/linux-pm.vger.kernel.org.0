Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E80054C87E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfFTHfy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 03:35:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44239 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbfFTHfy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 03:35:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1101985pgp.11
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLaNaNEqpEZ8RJPh9tk4QDLad7h0DvU5BxSRq4ruwcY=;
        b=yY1ZZsuyKdtPw903JxGgNQsy2aDPxahuWxuhCKMkAf1zXMSkpedA43zQqof3czMSeI
         jughIv+YkgL57nI9Auug2CM2nVPSihI12ob6EkWe+/Uf5ISFMFvG/XsnECj58XlQgdT8
         P+E+H/uCyZ7Uattuhucgm9g/Pp0P0qbmrnKi0E87E6pVCW1m6Je8lAWhCcYOhehZYT8M
         pwntS8wGLiX5JPP5npbS0hhK2fAfX8AbAvtC+9HMsV5F7rjZX8aaNxXfjEC7jjxFZihs
         x0wnD3rb5VZN/K2HMzn2uaf5Z97fN/bMKNYUYppxJ6nph9Rci/LNrDctmQpBgeLPjJru
         EUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLaNaNEqpEZ8RJPh9tk4QDLad7h0DvU5BxSRq4ruwcY=;
        b=akjZMV99A6d6EXrxeYi9QGchBYRMTjCjVRmDkz85WuA9VTqgeDa0Do6It+VCVFvhTV
         BeshXEVJ9LLN59dbML9eJD04ML9cH7I/cGsQY5nPX8fkOC6VxVyFO/6TN/bEwdcmBh1q
         xhNrNu4YRGqyF4O+JjsfYirz/hTfyS4oQ28vrwwOS79InVuhiyAoyFx466jiPw2NU2dJ
         R/yLIfZFMU0aBvLMuSLhY37VAmplKTv373w1AeW5PYmVbE0VdJNonv00rpMUOtA9j9Ce
         MfJynXJLA7d/BwmHOjuUfR1+tKOsHD5XS3Tz+/NfMtwjvtLZ3n3uYV6LQlqLfW6TrfVf
         VkwQ==
X-Gm-Message-State: APjAAAUtnVVYTnLanfRORGPaAJs2qiErPgbMQFiHTDM7Lf828VLtcMv3
        Qt1k6eZmGbH6CHe4H/zAggENDw==
X-Google-Smtp-Source: APXvYqwWVvWdwm4X/3YPJNB40maewYuJwA/5BGhDJ3kR5fN8bbzD5ebzC+jgG1qhxnE0wx/Emno7lg==
X-Received: by 2002:aa7:9092:: with SMTP id i18mr14045331pfa.101.1561016153151;
        Thu, 20 Jun 2019 00:35:53 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id e16sm27403304pga.11.2019.06.20.00.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/6] PM / QoS: Add support for MIN/MAX frequency constraints
Date:   Thu, 20 Jun 2019 13:05:27 +0530
Message-Id: <b18ee34c8ce38c9550dd7d7557857f7658372837.1561014965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561014965.git.viresh.kumar@linaro.org>
References: <cover.1561014965.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch introduces the min-frequency and max-frequency device
constraints, which will be used by the cpufreq core to begin with.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/qos.c | 111 ++++++++++++++++++++++++++++++++++-----
 include/linux/pm_qos.h   |  12 +++++
 2 files changed, 109 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 2461fed0efa0..6c90fd7e2ff8 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -120,6 +120,14 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
 			: pm_qos_read_value(&qos->resume_latency);
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE
+			: pm_qos_read_value(&qos->min_frequency);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
+			: pm_qos_read_value(&qos->max_frequency);
+		break;
 	default:
 		WARN_ON(1);
 		ret = 0;
@@ -161,6 +169,14 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 			req->dev->power.set_latency_tolerance(req->dev, value);
 		}
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = pm_qos_update_target(&qos->min_frequency,
+					   &req->data.pnode, action, value);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = pm_qos_update_target(&qos->max_frequency,
+					   &req->data.pnode, action, value);
+		break;
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
@@ -189,12 +205,11 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	if (!qos)
 		return -ENOMEM;
 
-	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
 	if (!n) {
 		kfree(qos);
 		return -ENOMEM;
 	}
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
 
 	c = &qos->resume_latency;
 	plist_head_init(&c->list);
@@ -203,6 +218,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 	c->notifiers = n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
 
 	c = &qos->latency_tolerance;
 	plist_head_init(&c->list);
@@ -211,6 +227,24 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	c = &qos->min_frequency;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->default_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->type = PM_QOS_MAX;
+	c->notifiers = ++n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
+	c = &qos->max_frequency;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->default_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->type = PM_QOS_MIN;
+	c->notifiers = ++n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -264,11 +298,25 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+
 	c = &qos->latency_tolerance;
 	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+
+	c = &qos->min_frequency;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
+	c = &qos->max_frequency;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
 	f = &qos->flags;
 	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
@@ -380,6 +428,8 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
+	case DEV_PM_QOS_MIN_FREQUENCY:
+	case DEV_PM_QOS_MAX_FREQUENCY:
 		curr_value = req->data.pnode.prio;
 		break;
 	case DEV_PM_QOS_FLAGS:
@@ -492,9 +542,6 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 {
 	int ret = 0;
 
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
-
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (IS_ERR(dev->power.qos))
@@ -502,10 +549,28 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 	else if (!dev->power.qos)
 		ret = dev_pm_qos_constraints_allocate(dev);
 
-	if (!ret)
+	if (ret)
+		goto unlock;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
 		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
 						       notifier);
+		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = blocking_notifier_chain_register(dev->power.qos->min_frequency.notifiers,
+						       notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = blocking_notifier_chain_register(dev->power.qos->max_frequency.notifiers,
+						       notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
 
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
 }
@@ -526,20 +591,35 @@ int dev_pm_qos_remove_notifier(struct device *dev,
 			       struct notifier_block *notifier,
 			       enum dev_pm_qos_req_type type)
 {
-	int retval = 0;
-
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
+	int ret = 0;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
 	/* Silently return if the constraints object is not present. */
-	if (!IS_ERR_OR_NULL(dev->power.qos))
-		retval = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
-							    notifier);
+	if (IS_ERR_OR_NULL(dev->power.qos))
+		goto unlock;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
+							 notifier);
+		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->min_frequency.notifiers,
+							 notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->max_frequency.notifiers,
+							 notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
 
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
-	return retval;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
 
@@ -599,6 +679,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
 		req = dev->power.qos->flags_req;
 		dev->power.qos->flags_req = NULL;
 		break;
+	default:
+		WARN_ON(1);
+		return;
 	}
 	__dev_pm_qos_remove_request(req);
 	kfree(req);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 5ce1c310373e..17132b10b233 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -40,6 +40,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
 #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
+#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
+#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	(-1)
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
@@ -58,6 +60,8 @@ struct pm_qos_flags_request {
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
+	DEV_PM_QOS_MIN_FREQUENCY,
+	DEV_PM_QOS_MAX_FREQUENCY,
 	DEV_PM_QOS_FLAGS,
 };
 
@@ -99,10 +103,14 @@ struct pm_qos_flags {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
+	struct pm_qos_constraints min_frequency;
+	struct pm_qos_constraints max_frequency;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
 	struct dev_pm_qos_request *flags_req;
+	struct dev_pm_qos_request *min_frequency_req;
+	struct dev_pm_qos_request *max_frequency_req;
 };
 
 /* Action requested to pm_qos_update_target */
@@ -197,6 +205,10 @@ static inline s32 dev_pm_qos_read_value(struct device *dev,
 	switch type {
 	case DEV_PM_QOS_RESUME_LATENCY:
 		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 	default:
 		WARN_ON(1);
 		return 0;
-- 
2.21.0.rc0.269.g1a574e7a288b

