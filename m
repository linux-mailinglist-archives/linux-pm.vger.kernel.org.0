Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540F76E0CF7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDMLrP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDMLrE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 07:47:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D489740
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so5992662wmq.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681386417; x=1683978417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbml5Nrapy5QlhDSKkv8bYmTatCmq94onluE6T97zsI=;
        b=oUIsocyL2eyfnEeDvSc9kP3wwycSa02zBdAcFMEkP/t0DZN9lw5k6CW9PCJNHY+nsc
         Yf8BlS6E3qC63VRrIcs7fY6N5QxIYG4QDW3GxIxROJ7WDVEkUnbvp+s+b4mjgPFwjRHc
         AYgzoBLIpFoOtunYrxgbZCrl0ebWWqzZrqlw0/BFPaX7rTYzQlboPUAejctfBGcJpQ3s
         YKqCShVRSa73RDqO8GXZDQAxcT7teUem1aD8t7kz84AxySvwiMcsl/LY/MnVsdX+KP4v
         wFL2a0ES9TgYKi0+4nnh+AzU+DbB+r/uHYFOJqY2nr+hB2ydVpM2RpW2jC5rJCNg593s
         ymEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386417; x=1683978417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbml5Nrapy5QlhDSKkv8bYmTatCmq94onluE6T97zsI=;
        b=imLeJ6iR0lK6zqyuk3oQBKSY5vvJZpZJ/CTW8uhw1G1LF8z/Q+J1f3lRxGLVCzwxk7
         Ccd6oxRxsqa1HHp0gPQsPm0B1tlGPMjHzEqLjxlWYBn/gWK2sJrwREGik+v3ojBVgezN
         OSZTnTWLr/e4b6A5o1Skeg6uEeoN+gy2L60+wZCv4WDO5XSxSaFr2k2cH5NwA+hWw2fd
         1fjuBA9Pw/kdAaejtyOUaT1Ra719G0XbfQs8iS20vkWxHiZBJrLHqgOcaINzvI/NQcxf
         CeKVeqFoxudsG51npF5FURmEyv+a66kgF0aa3oFKFKBNLDcHle17k0ysstbtYDlGKm7r
         U7FA==
X-Gm-Message-State: AAQBX9dvAzCgrJUW76MpCBYLR1aFvCv4MN1R0E+ycYwnljuRZEpB+fmL
        IBMv049gZW1j46VWMwXT4GW1mzxzHqj2bKCnHOg=
X-Google-Smtp-Source: AKy350bIGUoozacl+l+8gvBRdFdOz3o88Qdy24W8pggqTU9BDd8RDdYNFJ6KeFxbEwXg7xB1OL3lCw==
X-Received: by 2002:a1c:6a14:0:b0:3f0:3ce6:9b0e with SMTP id f20-20020a1c6a14000000b003f03ce69b0emr1683021wmc.13.1681386417430;
        Thu, 13 Apr 2023 04:46:57 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm6730590wmb.1.2023.04.13.04.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:46:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI)
Subject: [PATCH v3 5/6] thermal/drivers/acpi: Make cross dev link optional by configuration
Date:   Thu, 13 Apr 2023 13:46:46 +0200
Message-Id: <20230413114647.3878792-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ACPI thermal driver creates a link in the thermal zone device
sysfs directory pointing to the device sysfs directory. At the same
time, it creates a back pointer link from the device to the thermal
zone device sysfs directory.

From a generic perspective, having a device pointer in the sysfs
thermal zone directory may make sense. But the opposite is not true as
the same driver can be related to multiple thermal zones.

The usage of these information is very specific to ACPI and it is
questionable if they are really needed.

Let's make the code optional and disable it by default. If it hurts,
we will revert this change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/Kconfig   | 13 +++++++++
 drivers/acpi/thermal.c | 62 ++++++++++++++++++++++++++++--------------
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccbeab9500ec..7df4e18f06ef 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -336,6 +336,19 @@ config ACPI_THERMAL
 	  To compile this driver as a module, choose M here:
 	  the module will be called thermal.
 
+config ACPI_THERMAL_SYSFS_ADDON
+       bool "Enable thermal sysfs addon"
+       depends on ACPI_THERMAL
+       def_bool n
+       help
+	 Enable sysfs extra information added in the thermal zone and
+	 the driver specific sysfs directories. That could be a link
+	 to the associated thermal zone as well as a link pointing to
+	 the device from the thermal zone. By default those are
+	 disabled and are candidate for removal, if you need these
+	 information anyway, enable the option or upgrade the
+	 userspace program using them.
+
 config ACPI_PLATFORM_PROFILE
 	tristate
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5763db4528b8..30fe189d04f8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -787,9 +787,44 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.critical = acpi_thermal_zone_device_critical,
 };
 
+#ifdef CONFIG_ACPI_THERMAL_SYSFS_ADDON
+static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
+{
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	int ret;
+	
+	ret = sysfs_create_link(&tz->device->dev.kobj,
+				&tzdev->kobj, "thermal_zone");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&tzdev->kobj,
+				   &tz->device->dev.kobj, "device");
+	if (ret)
+		sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+
+	return ret;
+}
+
+static void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
+{
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	
+	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+	sysfs_remove_link(&tzdev->kobj, "device");
+}
+#else
+static inline int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
+{
+	return 0;
+}
+static inline void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
+{
+}
+#endif
+
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
-	struct device *tzdev;
 	int trips = 0;
 	int result;
 	acpi_status status;
@@ -821,23 +856,15 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
-	tzdev = thermal_zone_device(tz->thermal_zone);
-	
-	result = sysfs_create_link(&tz->device->dev.kobj,
-				   &tzdev->kobj, "thermal_zone");
+	result = acpi_thermal_zone_sysfs_add(tz);
 	if (result)
 		goto unregister_tzd;
-
-	result = sysfs_create_link(&tzdev->kobj,
-				   &tz->device->dev.kobj, "device");
-	if (result)
-		goto remove_tz_link;
-
+	
 	status =  acpi_bus_attach_private_data(tz->device->handle,
 					       tz->thermal_zone);
 	if (ACPI_FAILURE(status)) {
 		result = -ENODEV;
-		goto remove_dev_link;
+		goto remove_links;
 	}
 
 	result = thermal_zone_device_enable(tz->thermal_zone);
@@ -851,10 +878,8 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 acpi_bus_detach:
 	acpi_bus_detach_private_data(tz->device->handle);
-remove_dev_link:
-	sysfs_remove_link(&tzdev->kobj, "device");
-remove_tz_link:
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+remove_links:
+	acpi_thermal_zone_sysfs_remove(tz);
 unregister_tzd:
 	thermal_zone_device_unregister(tz->thermal_zone);
 
@@ -863,10 +888,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
-	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
-	
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
-	sysfs_remove_link(&tzdev->kobj, "device");
+	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
-- 
2.34.1

