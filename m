Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E715A5F3D6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 09:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfGDHge (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 03:36:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32872 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGDHgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 03:36:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so2549947pfq.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2019 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTgpiIcLb6LZ7kKRAHE/t5osUD04AJZqzwEpAbBmdVE=;
        b=wcY1CstAe36rGAs6ARiqZY4Evmc98ij+sTeUeI+jgm9LTWX/SN57Vqjm4CGfU5hudJ
         16/+dlH0YOzBIbZ8Ki/iGgN7UZxYEtpimbdmhMtAYkuxWVYC42lgFZrXQlJl9Wjq+nfw
         cY5G5XZndyJ9yniTl6RrP8zqoMTQSz2tLtOuJ0rctE2NxPjj/1PqZYhUSpQCXoFFAMl8
         jZo+yqA0THUt+2V2RECEGVXWT9dF5DRTag97WZ3kYh1HXrKKiXjs5fesR8HLWQhAwbRg
         EgMjdmgkkkbwrQYHyVdNp1jN7kqTfYf9gK0tyF5LWmYQ2j2JwnHGMAidJe0BFUeiAOpW
         fCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTgpiIcLb6LZ7kKRAHE/t5osUD04AJZqzwEpAbBmdVE=;
        b=Hxvo34JOsFuyNCn8S1rzq7WRcWf0WaAzH7vAh9aavjqhSiiZBxrPOhPysGDMjaPhG8
         2ZxW9GaWoQ9taNW9s7hyfv0INdlUL8aFXIy+FQR8U98WCj3gotqcbQt6EyfM9Sm69S0w
         wrx+vuC0dBDxErWjREEfL+o45iFvWL/Zn7xsFthrTzTWsSirB3xf2C4BSqIOL+AXAZZE
         bRYW+C1V4i0AGZVh+LzCWX/CTAn6F+7UO4l7N3gW6pupaQgsRt5KZG18Looix3AUK2Wr
         J8SFrw9NCgUwmdDz0GYU75pX3Z9m50tjblcZ0jmcYxHyU8LkV3KibDqBmS9lj2tkRPg4
         HMSA==
X-Gm-Message-State: APjAAAUbMGloDypXDzF8fLpWAT6bTn8sGf1DMhXZg+cZvV6AHE7wp+zn
        KLn2Qyd3Boy7n3Xbu+4x1s9quw==
X-Google-Smtp-Source: APXvYqy8r/RT7yVCzB9/j4Y7FhPpdghtIx9SCxOAGqQs40dueF1h2EvS2Wsbksl+eFOmrT+i7y8h5A==
X-Received: by 2002:a63:1a5c:: with SMTP id a28mr41931043pgm.418.1562225792243;
        Thu, 04 Jul 2019 00:36:32 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id r188sm7379288pfr.16.2019.07.04.00.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 00:36:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 1/7] PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
Date:   Thu,  4 Jul 2019 13:06:17 +0530
Message-Id: <bf880f74c0c3c68162574c27e5c70c11efe3abdd.1562210705.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1562210705.git.viresh.kumar@linaro.org>
References: <cover.1562210705.git.viresh.kumar@linaro.org>
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
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
index 6ea1ae373d77..58e8749ceac5 100644
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
+					  enum dev_pm_qos_req_type type)
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

