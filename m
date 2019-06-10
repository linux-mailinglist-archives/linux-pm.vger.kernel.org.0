Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0023B374
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbfFJKvz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:51:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34674 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbfFJKvz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 06:51:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so3514059plt.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JRbT8rh7sDm+oNJ6ocQbxCOgIqvtm/Aqgj/m99h5BA=;
        b=p3FNt15mcrxakgcro+qKJsvQeLa2qEBRrg69SYwrm3gOt1dylEYx2Jt7bz/VpWIFWj
         VcJUWXux64BdZp3sAOq1jAFSWfuHVSmLoOAnfEdnbuvQmWFPKWA09krhB3PJ+22ULTjS
         v9WfD4gAsT4rzY2WchpMJKdFJMstInFgtGno+cSbqjBITPdkzXMGiekkxNhMWy45HT4L
         MnnxqIoka147M6vI/PwBvObVXpizTJL/grWRVDVBABpzsHLrr0aW2rNwzh8uFpvhu9pR
         5PFexHjw9dDpJRRk1LMaHMrFAp+wIRU722RsV/m0tS9DKfc1zJpVpRc49zjbX0IO9/Iu
         QpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JRbT8rh7sDm+oNJ6ocQbxCOgIqvtm/Aqgj/m99h5BA=;
        b=jOZip6TqBAQNeI4cPSJk3MTQxw9QT5ac+XqCEI78XDmozqjMsHEXnOPl0myb/gNcQ/
         gS3mDmOvmAZkf3AAiuDG+eZABI5GBFrGMpdmXxXZ95HoVj2HYd/mQcIxPSvoyhBJ1Vw1
         lGrKHQ20qScm8KesnLvFBcvR7Bzx0ZOnq2th71EYR5+KRBPmKFgYB7f1S8qw8EZ7STbf
         yvkIbiqU88fL817i6R1Jjz3EiEdCeAKNlyLiSY4EHEtVzTeZMhX/a5dDA6synHf3xe11
         ACQyv573/EmT4iPd/x6N8fb8AaQJPwkczi4RA8ueWzku26g5P3sdAtw4ixzrmVXXcLSm
         YJ3w==
X-Gm-Message-State: APjAAAUVIbP34NP7Pl6oDnlt0PzYoEyQSvWVkNYpX2sPBGzjXJ7Aqux+
        QNW5jqw5MU5Lhhc/73neIbgWhw==
X-Google-Smtp-Source: APXvYqzAIFmE89eFL/S5xp+edRUcyzzFiMfCmP44aGy3RkjRo4tiuXzSuCWtLGzi6hFEBoqFtasYwQ==
X-Received: by 2002:a17:902:868b:: with SMTP id g11mr67709631plo.183.1560163914404;
        Mon, 10 Jun 2019 03:51:54 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id v64sm10322956pjb.3.2019.06.10.03.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:51:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
Date:   Mon, 10 Jun 2019 16:21:32 +0530
Message-Id: <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to use the same set of routines to register notifiers for
different request types, update the existing
dev_pm_qos_{add|remove}_notifier() routines with an additional
parameter: request-type.

For now, it only supports resume-latency request type.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/pm_qos_interface.txt | 10 ++++++----
 drivers/base/power/domain.c              |  8 +++++---
 drivers/base/power/qos.c                 | 14 ++++++++++++--
 include/linux/pm_qos.h                   | 12 ++++++++----
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index 19c5f7b1a7ba..ec7d662d1707 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -164,12 +164,14 @@ directory.
 Notification mechanisms:
 The per-device PM QoS framework has a per-device notification tree.
 
-int dev_pm_qos_add_notifier(device, notifier):
-Adds a notification callback function for the device.
+int dev_pm_qos_add_notifier(device, notifier, type):
+Adds a notification callback function for the device for a particular request
+type.
+
 The callback is called when the aggregated value of the device constraints list
-is changed (for resume latency device PM QoS only).
+is changed.
 
-int dev_pm_qos_remove_notifier(device, notifier):
+int dev_pm_qos_remove_notifier(device, notifier, type):
 Removes the notification callback function for the device.
 
 
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33c30c1e6a30..b063bc41b0a9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1536,7 +1536,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
 	else
-		dev_pm_qos_add_notifier(dev, &gpd_data->nb);
+		dev_pm_qos_add_notifier(dev, &gpd_data->nb,
+					DEV_PM_QOS_RESUME_LATENCY);
 
 	return ret;
 }
@@ -1569,7 +1570,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
-	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
+	dev_pm_qos_remove_notifier(dev, &gpd_data->nb,
+				   DEV_PM_QOS_RESUME_LATENCY);
 
 	genpd_lock(genpd);
 
@@ -1597,7 +1599,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
  out:
 	genpd_unlock(genpd);
-	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
+	dev_pm_qos_add_notifier(dev, &gpd_data->nb, DEV_PM_QOS_RESUME_LATENCY);
 
 	return ret;
 }
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 6c91f8df1d59..cfd463212513 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -467,6 +467,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
  *
  * @dev: target device for the constraint
  * @notifier: notifier block managed by caller.
+ * @type: request type.
  *
  * Will register the notifier into a notification chain that gets called
  * upon changes to the target value for the device.
@@ -474,10 +475,14 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
  * If the device's constraints object doesn't exist when this routine is called,
  * it will be created (or error code will be returned if that fails).
  */
-int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
+int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
+			    enum dev_pm_qos_req_type type)
 {
 	int ret = 0;
 
+	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
+		return -EINVAL;
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (IS_ERR(dev->power.qos))
@@ -500,15 +505,20 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
  *
  * @dev: target device for the constraint
  * @notifier: notifier block to be removed.
+ * @type: request type.
  *
  * Will remove the notifier from the notification chain that gets called
  * upon changes to the target value.
  */
 int dev_pm_qos_remove_notifier(struct device *dev,
-			       struct notifier_block *notifier)
+			       struct notifier_block *notifier,
+			       enum dev_pm_qos_req_type type)
 {
 	int retval = 0;
 
+	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
+		return -EINVAL;
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	/* Silently return if the constraints object is not present. */
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6ea1ae373d77..1f4d456e8fff 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -146,9 +146,11 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
 int dev_pm_qos_remove_request(struct dev_pm_qos_request *req);
 int dev_pm_qos_add_notifier(struct device *dev,
-			    struct notifier_block *notifier);
+			    struct notifier_block *notifier,
+			    enum dev_pm_qos_req_type type);
 int dev_pm_qos_remove_notifier(struct device *dev,
-			       struct notifier_block *notifier);
+			       struct notifier_block *notifier,
+			       enum dev_pm_qos_req_type type);
 void dev_pm_qos_constraints_init(struct device *dev);
 void dev_pm_qos_constraints_destroy(struct device *dev);
 int dev_pm_qos_add_ancestor_request(struct device *dev,
@@ -202,10 +204,12 @@ static inline int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 static inline int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
 			{ return 0; }
 static inline int dev_pm_qos_add_notifier(struct device *dev,
-					  struct notifier_block *notifier)
+					  struct notifier_block *notifier,
+					  enum dev_pm_qos_req_type type);
 			{ return 0; }
 static inline int dev_pm_qos_remove_notifier(struct device *dev,
-					     struct notifier_block *notifier)
+					     struct notifier_block *notifier,
+					     enum dev_pm_qos_req_type type)
 			{ return 0; }
 static inline void dev_pm_qos_constraints_init(struct device *dev)
 {
-- 
2.21.0.rc0.269.g1a574e7a288b

