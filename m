Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1F26D1B8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 05:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIQD31 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgIQD2C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 23:28:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F8C0611C3
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:35 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so757087qtp.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01gqkFqr4FQwurKmO2Ck7GaScSK2pTFzpmpWBR1KqGU=;
        b=DjZr4sFDsbbUKj1uaHdAF9W4Ujbhv51Un18j9AS9uMZoLIwXHcZVEsoQ/3LUjLF37R
         kOzz8lsiUt9OGW4LKz8auX6fNumu1PA+PhrYM6M/GBek07tO30zzwpcWrbWiZZR2xZ0u
         sNtL6h8igfE0yYQQDktkCP7xALhwKdwBLXtb4ibt+9Vrlu0lLevRIoc9Mhq/MWVcK8y+
         Xi8V5dj0CsAtOF6oPFFuxi+ViYpNojY7kYNS1hxEmAsopv8P79u3u56FpHNW13dCZgRS
         FeauQl4ILt0cQ7oSFWBTmubdxfvmll8AHyXyXfLwajcoBf5mPWb9dAiRQQMga2qGiHL8
         dT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01gqkFqr4FQwurKmO2Ck7GaScSK2pTFzpmpWBR1KqGU=;
        b=heTAjKeqCBamdmnyimx1qL8WB0/p3+G8/JxJ62/TY47xlonfoUgYxNTiThZvPo+aVL
         +NgDPcjIF1YBkFnMlZy2gLMUsacwNZoTr7OBvn3zG1hi38HA88qd45GZgjvYJy/diZ7u
         JXYkWxcGb/Hy+fhjxkbtoSZXNXP3R8aRY8cS2IUmQ++g6EXVktTHgfBb87V5MHAvr4p6
         ElABfri+fB5enRYgQLsRZZm/Kf23CUD3E12/pdioiO6xQ4+aYLUe1vPSCZaewclyLfei
         1hiOEErBEooKV8Hx+P6iOXHYsNvHlarKsqEZ+lEP0yNowp5FaXdXpmporPKDEsH099iD
         9kQg==
X-Gm-Message-State: AOAM531Oysrx1nWoHQG4ggPGX11y7gEgE7YGOOJtJK471DqHwOUur+HQ
        Z10mFi18Uxks6XWFhPG6u42bpQ==
X-Google-Smtp-Source: ABdhPJxAksp2eSmEPqN5uQeMl3cPNkYvy+YewZ8cg9q71F5mEGRa405mrOEZhL5wL6RqHhxDNGYHPg==
X-Received: by 2002:ac8:39a7:: with SMTP id v36mr27385800qte.140.1600312954185;
        Wed, 16 Sep 2020 20:22:34 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g45sm21370801qtb.60.2020.09.16.20.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:22:33 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, amitk@kernel.org
Subject: [PATCH RFC 7/8] thermal:core: Add is_warming_dev and supporting warming device api's to the cooling dev framework.
Date:   Wed, 16 Sep 2020 23:22:25 -0400
Message-Id: <20200917032226.820371-8-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917032226.820371-1-thara.gopinath@linaro.org>
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a variable is_warming_dev to indicate if a "cooling" device is
actually a warming device or not. Also introduce api's to register and
unregister warming device.

This is a temporary patch. If we agree to replace the term "cooling" with
"mitigating" (or any other appropriate term) in the thermal framework, this
patch can be dropped. Also I have not added warming_device_register api for
all the versions of cooling_device_register because
devm_thermal_of_warming_device_register is the only api needed in the
kernel today as is evident by the next patch in this series.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.c | 88 +++++++++++++++++++++++++++++-----
 include/linux/thermal.h        |  7 +++
 2 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bfd436379408..4aae48a80e00 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1101,7 +1101,8 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
  */
 static struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
-				  const char *type, void *devdata,
+				  const char *type, bool is_warming_dev,
+				  void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
@@ -1134,6 +1135,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
+	cdev->is_warming_dev = is_warming_dev;
 	thermal_cooling_device_setup_sysfs(cdev);
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
@@ -1178,7 +1180,7 @@ struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(NULL, type, devdata, ops);
+	return __thermal_cooling_device_register(NULL, type, false, devdata, ops);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
@@ -1202,7 +1204,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-	return __thermal_cooling_device_register(np, type, devdata, ops);
+	return __thermal_cooling_device_register(np, type, false, devdata, ops);
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
@@ -1242,7 +1244,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
+	tcd = __thermal_cooling_device_register(np, type, false, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
@@ -1255,6 +1257,49 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
 
+/**
+ * devm_thermal_of_warming_device_register() - register an OF thermal warming
+ *					       device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @np:		a pointer to a device tree node.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
+ *
+ * This function will register a warming device with device tree node reference.
+ * This interface function adds a new thermal warming device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+devm_thermal_of_warming_device_register(struct device *dev,
+					struct device_node *np,
+					char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device **ptr, *tcd;
+
+	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tcd = __thermal_cooling_device_register(np, type, true, devdata, ops);
+	if (IS_ERR(tcd)) {
+		devres_free(ptr);
+		return tcd;
+	}
+
+	*ptr = tcd;
+	devres_add(dev, ptr);
+
+	return tcd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_warming_device_register);
+
 static void __unbind(struct thermal_zone_device *tz, int mask,
 		     struct thermal_cooling_device *cdev)
 {
@@ -1265,14 +1310,8 @@ static void __unbind(struct thermal_zone_device *tz, int mask,
 			thermal_zone_unbind_cooling_device(tz, i, cdev);
 }
 
-/**
- * thermal_cooling_device_unregister - removes a thermal cooling device
- * @cdev:	the thermal cooling device to remove.
- *
- * thermal_cooling_device_unregister() must be called when a registered
- * thermal cooling device is no longer needed.
- */
-void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
+static void
+__thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 {
 	int i;
 	const struct thermal_zone_params *tzp;
@@ -1319,8 +1358,33 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	thermal_cooling_device_destroy_sysfs(cdev);
 	put_device(&cdev->device);
 }
+
+/**
+ * thermal_cooling_device_unregister - removes a thermal cooling device
+ * @cdev:	the thermal cooling device to remove.
+ *
+ * thermal_cooling_device_unregister() must be called when a registered
+ * thermal cooling device is no longer needed.
+ */
+void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
+{
+	__thermal_cooling_device_unregister(cdev);
+}
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
+/**
+ * thermal_warming_device_unregister - removes a thermal warming  device
+ * @cdev:	the thermal warming device to remove.
+ *
+ * thermal_warming_device_unregister() must be called when a registered
+ * thermal warming device is no longer needed.
+ */
+void thermal_warming_device_unregister(struct thermal_cooling_device *cdev)
+{
+	__thermal_cooling_device_unregister(cdev);
+}
+EXPORT_SYMBOL_GPL(thermal_warming_device_unregister);
+
 static void bind_tz(struct thermal_zone_device *tz)
 {
 	int i, ret;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a50ed958d0bd..455120f485dd 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -96,6 +96,7 @@ struct thermal_cooling_device_ops {
 
 struct thermal_cooling_device {
 	int id;
+	bool is_warming_dev;
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
 	struct device_node *np;
@@ -393,7 +394,13 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
 				char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops);
+struct thermal_cooling_device *
+devm_thermal_of_warming_device_register(struct device *dev,
+				struct device_node *np,
+				char *type, void *devdata,
+				const struct thermal_cooling_device_ops *ops);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
+void thermal_warming_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
-- 
2.25.1

