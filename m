Return-Path: <linux-pm+bounces-7963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1C8C90C1
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 14:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13A31C21291
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEBC3AC2B;
	Sat, 18 May 2024 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoREmVsX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2634CDE;
	Sat, 18 May 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716034374; cv=none; b=qac0wDCIzPwzcrJQ8B1laMNOPtiTdcXRr7ubHHkfZgVL1a/KMtkVuVcJkiFTqIO66NBwu8j1p5U48f8b1gAncGem5yql4ip1mUqcLqoLBml7sU94Y/z/ZiRdAwxRA2qoYk8B7E6hWJLtW6bKAR0WoKDeEzPWtxpfjkyL6i+wt9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716034374; c=relaxed/simple;
	bh=WRxhGYiTKb94c2UADnH+lMucCo+wriGkpGMAo7KQlbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efQSHkt3/1wRi6BX4GhmE2rTD5blUBkQbmKzHQElatRTHxPiZ2+uL73YPFtIzLoujA5CsGnV4j4qUZt0+5VdRTJ1Cdt/OenWPaad5Pk4IS4jTesJG8nTKgudxdkLB9+c08EfifTywCvv6ej9zACjBuF1rIqBsPuKivh8Xb7+yGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoREmVsX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202cea98daso8365075e9.0;
        Sat, 18 May 2024 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716034371; x=1716639171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGJsrqgkoxohMyaFQCRQCQrzlTAn771GcCI5VxzoLbQ=;
        b=XoREmVsXlivbxihwyTeIpgVLZoH0tol9/0nb6obX5HZ5sTi5LF4hDKAxKRgmxqraV3
         CzeHaimLWAlK815wENXMREKski1ZrC86+aV2G6SaqactN3YDk7UUkGiFXesjC9BJivv8
         tR67HhUS8s2aZuLOALrdlZRCsel880W2onwd5zg+7Wd3StnitIBtfM4SDBcM3Mnd6gtc
         jLyDSAJd/hpODGp4WhSmJSKOfP7V4G3oMHzmyOsOZpU4uIbg9VnoNOh0FBNLd5PDel9T
         CtPW+w379vg9P8/frSWqKVHo+aJvXQsbphv2sFirtdBiQ2kljSnOUhOloW0EULMKIWib
         vbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716034371; x=1716639171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGJsrqgkoxohMyaFQCRQCQrzlTAn771GcCI5VxzoLbQ=;
        b=vWag/Cb1fS37sv5gT/QwqN4YYRrsvAVqYkv596T4Op+4p8UvW7ey7eOPaNgQVv121t
         VHFI0wMAPI5Z7mH4nKilIq5U9IeOmvO8+MYpJv2/7lqwz0A3pdiXc6rVAY0bP+xtnq0J
         DC95mDBl/1U4HoR6QlofI7rmgC98HGr770Ys30wewzBTk/C6Rpd5miSkjeQJ7uMuaX4r
         vg1G481nD4TMBbCDUGXWPAzY8+WccroJI3pRWrNbo7aSEV2EOmhx3y09Tz5a3/wBI5cv
         5DpaU2CbA5ZI/RWQj33dkbKcDherEr1a+9homGvCceBy3mFfqlA1X+qNUZiS2pDnMMDv
         gE4g==
X-Forwarded-Encrypted: i=1; AJvYcCVcyETG6joEv6hLIr2+n5SEU3iDhF03/W+dXKnHehpwh8qKM+IjAB1pWQSTW/sRKfc5k4WT/I2FM+aUiVotZRwUBwtvJ3TQFWwBjMRRAw/4lfITUxF8rpoSh3YpYWxSYhc2MzsdYqhV0w==
X-Gm-Message-State: AOJu0YyW+UKMSA4xakbxtAq/G4ZsI/KmtUW+5pi6fZugmGUrlfRWShfB
	3poiaALR99NVB2zwtpIeqHXSrmK1x7KqP5Vx0DMdiegwXYHFrLwX
X-Google-Smtp-Source: AGHT+IE/IhYubC0E9IZHEWKwQe0B3qG0jCm6OSbLvY0zrTBrXxj/mkuhSbi+Le/nYtJXLiXMiTQwEw==
X-Received: by 2002:a05:600c:3144:b0:420:1db0:53c1 with SMTP id 5b1f17b1804b1-4201db054a9mr89916045e9.41.1716034370365;
        Sat, 18 May 2024 05:12:50 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42017166c64sm215580105e9.8.2024.05.18.05.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 05:12:50 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sat, 18 May 2024 14:12:05 +0200
Subject: [PATCH 2/3] thermal: sti: depend on THERMAL_OF subsystem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-thermal-v1-2-7dfca3ed454b@gmail.com>
References: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
In-Reply-To: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.13.0

Switch to thermal_of_zone to handle thermal-zones. Replace
thermal_zone_device_register() by devm_thermal_of_zone_register() and
remove ops st_thermal_get_trip_type, st_thermal_get_trip_temp.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/thermal/st/Kconfig      |  1 +
 drivers/thermal/st/st_thermal.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
index ecbdf4ef00f4..2d08147876ee 100644
--- a/drivers/thermal/st/Kconfig
+++ b/drivers/thermal/st/Kconfig
@@ -5,6 +5,7 @@
 
 config ST_THERMAL
 	tristate "Thermal sensors on STMicroelectronics STi series of SoCs"
+	depends on THERMAL_OF
 	help
 	  Support for thermal sensors on STMicroelectronics STi series of SoCs.
 
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 5f33543a3a54..60e70de724d4 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 
 #include "st_thermal.h"
+#include "../thermal_hwmon.h"
 
 /* The Thermal Framework expects millidegrees */
 #define mcelsius(temp)			((temp) * 1000)
@@ -203,23 +204,21 @@ int st_thermal_register(struct platform_device *pdev,
 	trip.type = THERMAL_TRIP_CRITICAL;
 
 	sensor->thermal_dev =
-		thermal_zone_device_register_with_trips(dev_name(dev), &trip, 1, sensor,
-							&st_tz_ops, NULL, 0, polling_delay);
+		devm_thermal_of_zone_register(dev, 0, sensor, &st_tz_ops);
 	if (IS_ERR(sensor->thermal_dev)) {
-		dev_err(dev, "failed to register thermal zone device\n");
+		dev_err(dev, "failed to register thermal of zone\n");
 		ret = PTR_ERR(sensor->thermal_dev);
 		goto sensor_off;
 	}
-	ret = thermal_zone_device_enable(sensor->thermal_dev);
-	if (ret)
-		goto tzd_unregister;
 
 	platform_set_drvdata(pdev, sensor);
 
-	return 0;
+	/*
+	 * devm_thermal_of_zone_register() doesn't enable hwmon by default
+	 * Enable it here
+	 */
+	return devm_thermal_add_hwmon_sysfs(dev, sensor->thermal_dev);
 
-tzd_unregister:
-	thermal_zone_device_unregister(sensor->thermal_dev);
 sensor_off:
 	st_thermal_sensor_off(sensor);
 
@@ -232,7 +231,8 @@ void st_thermal_unregister(struct platform_device *pdev)
 	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	st_thermal_sensor_off(sensor);
-	thermal_zone_device_unregister(sensor->thermal_dev);
+	thermal_remove_hwmon_sysfs(sensor->thermal_dev);
+	devm_thermal_of_zone_unregister(sensor->dev, sensor->thermal_dev);
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 

-- 
2.45.1


