Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C958305E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfHFLMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 07:12:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54224 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730676AbfHFLMg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:12:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C18A1A01DD;
        Tue,  6 Aug 2019 13:12:34 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F06F1A00B7;
        Tue,  6 Aug 2019 13:12:34 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B1E02205DD;
        Tue,  6 Aug 2019 13:12:33 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-pm@vger.kernel.org
Subject: [RFC 4/4] PM / QoS: Add dev_pm_qos_get_curr_value
Date:   Tue,  6 Aug 2019 14:12:28 +0300
Message-Id: <9d1620026842209841a122e17fa7686d02fa23e9.1565089196.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1565089196.git.leonard.crestez@nxp.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1565089196.git.leonard.crestez@nxp.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new API for fetching the value set with dev_pm_qos_add_request by
refactoring __dev_pm_qos_update_request.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/base/power/qos.c | 59 ++++++++++++++++++++++++++++------------
 include/linux/pm_qos.h   |  1 +
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 6c90fd7e2ff8..f171a7137c5d 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -402,10 +402,49 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
 
+/**
+ * __dev_pm_qos_get_curr_value - Modify an existing device PM QoS request.
+ * @req : PM QoS request to query
+ */
+static int __dev_pm_qos_get_curr_value(struct dev_pm_qos_request *req,
+				       s32 *curr_value)
+{
+	if (WARN(!dev_pm_qos_request_active(req),
+		 "%s() called for unknown object\n", __func__))
+		return -EINVAL;
+
+	switch(req->type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+	case DEV_PM_QOS_LATENCY_TOLERANCE:
+	case DEV_PM_QOS_MIN_FREQUENCY:
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		*curr_value = req->data.pnode.prio;
+		return 0;
+	case DEV_PM_QOS_FLAGS:
+		*curr_value = req->data.flr.flags;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+int dev_pm_qos_get_curr_value(struct dev_pm_qos_request *req,
+				     s32 *curr_value)
+{
+	int ret;
+
+	mutex_lock(&dev_pm_qos_mtx);
+	ret = __dev_pm_qos_get_curr_value(req, curr_value);
+	mutex_unlock(&dev_pm_qos_mtx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_get_curr_value);
+
 /**
  * __dev_pm_qos_update_request - Modify an existing device PM QoS request.
  * @req : PM QoS request to modify.
  * @new_value: New value to request.
  */
@@ -416,31 +455,17 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	int ret = 0;
 
 	if (!req) /*guard against callers passing in null */
 		return -EINVAL;
 
-	if (WARN(!dev_pm_qos_request_active(req),
-		 "%s() called for unknown object\n", __func__))
-		return -EINVAL;
+	ret = __dev_pm_qos_get_curr_value(req, &curr_value);
+	if (ret)
+		return ret;
 
 	if (IS_ERR_OR_NULL(req->dev->power.qos))
 		return -ENODEV;
 
-	switch(req->type) {
-	case DEV_PM_QOS_RESUME_LATENCY:
-	case DEV_PM_QOS_LATENCY_TOLERANCE:
-	case DEV_PM_QOS_MIN_FREQUENCY:
-	case DEV_PM_QOS_MAX_FREQUENCY:
-		curr_value = req->data.pnode.prio;
-		break;
-	case DEV_PM_QOS_FLAGS:
-		curr_value = req->data.flr.flags;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	trace_dev_pm_qos_update_request(dev_name(req->dev), req->type,
 					new_value);
 	if (curr_value != new_value)
 		ret = apply_constraint(req, PM_QOS_UPDATE_REQ, new_value);
 
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 2aebbc5b9950..ae42e58d02bb 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -149,10 +149,11 @@ enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
 s32 __dev_pm_qos_resume_latency(struct device *dev);
 s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value);
+int dev_pm_qos_get_curr_value(struct dev_pm_qos_request *req, s32 *value);
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
 int dev_pm_qos_remove_request(struct dev_pm_qos_request *req);
 int dev_pm_qos_add_notifier(struct device *dev,
 			    struct notifier_block *notifier,
 			    enum dev_pm_qos_req_type type);
-- 
2.17.1

