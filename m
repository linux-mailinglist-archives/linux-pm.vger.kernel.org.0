Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756294C87B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFTHfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 03:35:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42459 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfFTHfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 03:35:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id l19so1106649pgh.9
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZHoXqHDnWQNNxjeBIgVIp/1BFcAyIjpzOAOe/B47LU=;
        b=cD8fnPFbjnlUcmEq/d+FBOHDffPKPfMy/d2kvSq77Vua582eT8LCrDSAp9hlwJR4AZ
         zxa/VGNkp8W6/Fv0ozb6t67/DDp9dxYR6iKdRYrPBXk6XEXrsjIHRiLR9Qm89e5xCwyC
         rBWVsWZa6QIkZI9Y3wbB8eTA0L/6ae9JTUvD0z0ZITIoGdFrarDXGlifMpUloS++VWUA
         8WLizucE8MFI11UUaA4AQSxQY8oVCqzjpEXLQ9bva2fz68lsZlySzdiORYrTa8jHtGmr
         atfb4z2VakxSUBV7ui7f7s/yVx0gHQDc00Q2i2PivUwJd+63wd+lnSaHsI9oMYVkY4pe
         br3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZHoXqHDnWQNNxjeBIgVIp/1BFcAyIjpzOAOe/B47LU=;
        b=GT96OURAQ9ryhGBAET/hWu8e3ixUpBtQqXtEkT0CW2DPwyuIbFD6vFwWayDNcFPmeY
         22rSNLOA5maEJmdSNyhk92iKgbjlTkaVMbBVNJZ2xRYEUYgLqzoPmX0ILJpLuGaJ33ej
         cMahbdWYgwZSbslY5G5Q2ucGticsFZWvQfItuwChJGuAT16t5iaYBTSmSWyoKIXPMLOs
         nWttxgL0KhKOmqlt6qr8WRHlTq3qGhV97HnMLqP2SePPMp2Lettwq42+2h66XB47C0eV
         GvvRIgdvmOPlFZAQiD8EHOCLQumgAjSsA1Zj7zh9TcP4E7GBlJTUNqh4b15vDF3+D7vi
         3fBQ==
X-Gm-Message-State: APjAAAV2VIWxWf1RnzTjVKl9siZA+C+W+cEIcI1IIUKF0Juj9Id09P8Y
        Uv4NP9cVMYTzwyodm4jgzzW5fg==
X-Google-Smtp-Source: APXvYqwCnN7Uk12c574/LNHUAEvJfUF2vqiU6LIXnK4FoPCBeBWpKs7QeB9fQv7Dfo56ZjQJapUeHQ==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr5976672pgd.198.1561016144144;
        Thu, 20 Jun 2019 00:35:44 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id c129sm23187235pfa.106.2019.06.20.00.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/6] PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
Date:   Thu, 20 Jun 2019 13:05:24 +0530
Message-Id: <9c6f189e4853b332ac3e28d40d7ef6e310501e9e.1561014965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561014965.git.viresh.kumar@linaro.org>
References: <cover.1561014965.git.viresh.kumar@linaro.org>
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

For now, it only supports resume-latency request type but will be
extended to frequency limit (min/max) constraints later on.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
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

