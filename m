Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE42C103A6C
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfKTM4x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:56:53 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37276 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfKTM4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:56:52 -0500
Received: by mail-qv1-f68.google.com with SMTP id s18so9652030qvr.4
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wtD/eNE9TAmXsnR2IF1O0WWLLWtlBArf0uI74fbpZrc=;
        b=I6Y1ofWcZLyq/uKNmdCCl9/kv6h14tQOGMfF99XIcPBr2zXYHDnctewepPWDp45hWX
         34HWqvhN/ZLdDC4eL2yFrqN4yMwpNuPs2gY325lwOdWhGvbVEWeInv79vO8V8BfpLlkX
         9JEpTyJJiI9ai+op+ZgJtoCD6l2BW8uOj5m+SZi84oFxc+s1N36WSISTqqDbSR4SkY6a
         tfA/Vovqqcwynhv5sqOdWM5nYh3U1PpHaSsYTvrcJq1FDcTgw41q2YDf8j/3KvRSqifa
         WQPZ9h2Zo2akBqX6c5sZPSkQ1wzwlOGpsiC5eE8v458CijsaEqC1+rSHLeM+GfHVRbN1
         vovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wtD/eNE9TAmXsnR2IF1O0WWLLWtlBArf0uI74fbpZrc=;
        b=btm+4zvFgb0UiUGtPMLbLqwe1tKekDX67cLVW17g0FzTOP867f/khNjbkilU2TBsBa
         nKbl9NLvpR9FjURkGy3TwchTMTNgAskS35HpXnJ15ut/7EfRQC4ebEqfRuBjNsjCL+Nn
         T0+V7Y/6DlEICctWddF7Huq5kCB1iIWXyyMshzyYhHJESRitM7NCpJaqt27piXta8qwR
         94sDpItkRS0hFoJKLjY6OfwCLvMIpIfRLSeCrDeWV6bV2+2MpIM1HWM8YFnbnGbBNEqU
         AgM7Db32bgLzIWRaboFHM1ngCShXeTCBpWLWmCZ2Pw5Bj0JsQjlrV/6SjiNvKwlT3n2m
         bFyQ==
X-Gm-Message-State: APjAAAWDDY/sQP+Q9xSDdyIWiHxp6tGOkWjvoBliaJ5eekyeDk7H3qi7
        nAw6KPDYhsN3am6rn1OFuyDuiA==
X-Google-Smtp-Source: APXvYqw24dE4Bpb6W+86oKmxzS/1gF4C2jq50860GAtv08Qo7BSTHHHRkgr+WA3BAD0STf18ppHdfg==
X-Received: by 2002:ad4:404e:: with SMTP id r14mr2428885qvp.4.1574254609837;
        Wed, 20 Nov 2019 04:56:49 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:48 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 3/7] thermal: core: Allow cooling devices to register a parent.
Date:   Wed, 20 Nov 2019 07:56:29 -0500
Message-Id: <1574254593-16078-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With introduction of power domain warming devices, devices that control the
power domain are registered as the parent of the cooling device so that the
device-genpd hierarchy in kernel is maintained intact. To enable this,
introduce a new API thermal_of_cooling_device_parent_register that takes a
parent device pointer as input. Also, modify
__thermal_cooling_device_register to register parent of a newly created
cooling device, if specified.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.c | 22 +++++++++++++++++++---
 include/linux/thermal.h        | 15 +++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4481cc..912ba75 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -947,6 +947,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
  */
 static struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
+				  struct device *parent,
 				  const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
 {
@@ -979,6 +980,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
+	if (parent)
+		cdev->device.parent = parent;
 	cdev->devdata = devdata;
 	thermal_cooling_device_setup_sysfs(cdev);
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
@@ -1024,7 +1027,8 @@ struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(NULL, type, devdata, ops);
+	return __thermal_cooling_device_register(NULL, NULL, type,
+						 devdata, ops);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
@@ -1048,10 +1052,22 @@ thermal_of_cooling_device_register(struct device_node *np,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(np, type, devdata, ops);
+	return __thermal_cooling_device_register(np, NULL, type, devdata, ops);
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
+struct thermal_cooling_device *
+thermal_of_cooling_device_parent_register(struct device_node *np,
+					  struct device *parent,
+					  const char *type, void *devdata,
+					  const struct
+					  thermal_cooling_device_ops *ops)
+{
+	return __thermal_cooling_device_register(np, parent, type,
+						 devdata, ops);
+}
+EXPORT_SYMBOL_GPL(thermal_of_cooling_device_parent_register);
+
 static void thermal_cooling_device_release(struct device *dev, void *res)
 {
 	thermal_cooling_device_unregister(
@@ -1088,7 +1104,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
+	tcd = __thermal_cooling_device_register(np, NULL, type, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c..ac5f268 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -448,6 +448,11 @@ struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
 				   const struct thermal_cooling_device_ops *);
 struct thermal_cooling_device *
+thermal_of_cooling_device_parent_register(struct device_node *np,
+					  struct device *parent,
+					  const char *, void *, const struct
+					  thermal_cooling_device_ops *);
+struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
 				char *type, void *devdata,
@@ -508,6 +513,16 @@ static inline struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
 	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
+
+static inline struct thermal_cooling_device *
+thermal_of_cooling_device_parent_register(struct device_node *np,
+					  struct device *parent,
+					  const char *, void *, const struct
+					  thermal_cooling_device_ops *)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
-- 
2.1.4

