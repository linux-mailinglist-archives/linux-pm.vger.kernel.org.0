Return-Path: <linux-pm+bounces-11076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7AA9309CB
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 13:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613441F21528
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC2763EC;
	Sun, 14 Jul 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfZ7auB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D749659;
	Sun, 14 Jul 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720957398; cv=none; b=Hnrrxi2TnUUH4DIxNvZMFXzKpll/76gth0CJGcgbk0qysIvo2QtYWzzmmWHiX4TdWKPsCzT7kk+pb3wVdIalc1k14ps9rkA5ZIrKphbStRBfVRmQd2kwO+k8Mts5qqnlmrng4oN7JMIe9LMSXZhZlmqCzTwAY7oOCsFLLsFlpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720957398; c=relaxed/simple;
	bh=HuwYDUb5SQOgo/cDQX5AI/oFUdtLP4Rc4FBtLd0C2zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kp635Zdd2HRKXgz2bt2HzHWuFU+UU0vqp4sb3TOOPLKMM0oz1HUWB3wBZprrA4F9NwbUqFk8xygFOsZd1zeKA3lDI2Bz3ibWJTFEOb3D9UkvkrPajVGbus4NeTPZPsN5V03HwgyAdAPU1GjSctS1A1VM1JK9FsNbMwzmyq8+U2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfZ7auB8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36805befd01so1062300f8f.2;
        Sun, 14 Jul 2024 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720957395; x=1721562195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voezqBRIqgR1xMbzJXPZuwUUHTRBRdZ/+JwyhtZNvfc=;
        b=nfZ7auB8iWwOITJFoU7hhAZqLv9NzZP+oN6qDhUGCKS5cEX6Fb9aordsptq+l9nv8X
         8Xd/51xcMB6PO3XjxLro2XCbT5BICDLXZo/l0EL1LhqQdXVpVqqgyWOuivb40VjeKeA+
         aSa9Y5R3HR2ssd2YDhuQ+kYUXLGY7+MFAS9pluu21t1omQz4GFaWoKtVO/JUpKlz0v0c
         7laY5QUpv4ZJyXppKd3SUqZhuscewm0I6VYmmexm79itmlqeTC+PEgeugBC9Dw2uLCVa
         op6jIRUv1R+QAiHD0bpcleAml43gXyTZpiDWtwELZPsFj2Ldv6LfI5qVuNN09TurSQpO
         96lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720957395; x=1721562195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voezqBRIqgR1xMbzJXPZuwUUHTRBRdZ/+JwyhtZNvfc=;
        b=DonLM+EgUrVKJbPASGsApPL/REaeksw7cG3X72sMwLgt/pJfJuOmjO7DNCz2IetZuJ
         FCK4ulBE5lP6Z0D/8+F5en3EEO0dW6IsI/0L42DrUlyW7wYWuRTOQ9DuxFa+1qbYj5nW
         OkBsPXYU/R+ezFWnhbSlPpTPTMgpn89W6gMxLETjisNZU6f6Zb+6cRytTAH14WjJnhWx
         mlywiQ7j52Hg2JHwwGRz7vBRPePNrvJfJludaAZ/uB1W6XeB/VCdQJNen35sZXdXl+kQ
         GhNhli0mMw+9CLG8WDrurOUs+TKnO2hzbxVbCNWb0sWMX3VAuIwly9xM4gKcHdSOLIPW
         Jb0A==
X-Forwarded-Encrypted: i=1; AJvYcCXLSS1OCPj+1zZJcL7OD9dwYHUt4cqk0Nu2CCGvzG6aP5afIn9tLkTx3N2kpIGG+zW38Wo4MJTJOBXME43Qafrf7y2axLDngmsZpVvM87JvsHGckJAYCFQ2eKqfwGs08jlpGz+2NHAbNQ==
X-Gm-Message-State: AOJu0YzjSYtmAJpAukhEr8cDaDQwp/dLdyQxvEguu8grKgNwBXoeZmm9
	E/QdzD4egsi0G8BuZra26EG+n8MK8gunAj+GSFEbMp/caoNeViHj
X-Google-Smtp-Source: AGHT+IHznxvk3jGNuxACzlPePqJZsFU4Gm7h8xaiwzJni80Kfh+rpr363DBOkzF8Q4inWF6XdCSGjw==
X-Received: by 2002:a05:6000:1814:b0:364:d2b6:4520 with SMTP id ffacd0b85a97d-367ce5df304mr10897937f8f.0.1720957394652;
        Sun, 14 Jul 2024 04:43:14 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db0492asm3624096f8f.103.2024.07.14.04.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 04:43:14 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 14 Jul 2024 13:42:46 +0200
Subject: [PATCH v3 2/2] thermal: sti: depend on THERMAL_OF subsystem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-thermal-v3-2-88f2489ef7d5@gmail.com>
References: <20240714-thermal-v3-0-88f2489ef7d5@gmail.com>
In-Reply-To: <20240714-thermal-v3-0-88f2489ef7d5@gmail.com>
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
X-Mailer: b4 0.14.0

Switch to thermal_of_zone to handle thermal-zones. Replace
thermal_zone_device_register() by devm_thermal_of_zone_register() and
remove ops st_thermal_get_trip_type, st_thermal_get_trip_temp.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v3:
- Fix unmet dependency when building with ARM64 compiler
  https://lore.kernel.org/lkml/202406270605.qodaWd4n-lkp@intel.com/
- Remove no more used polling_delay variable detected by kernel robot
  https://lore.kernel.org/lkml/202406270530.kN5wIswi-lkp@intel.com/
Changes in v2:
- Remove unused struct thermal_trip trip
---
 drivers/thermal/st/Kconfig      |  2 ++
 drivers/thermal/st/st_thermal.c | 28 ++++++++++------------------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
index ecbdf4ef00f4..95a634709a99 100644
--- a/drivers/thermal/st/Kconfig
+++ b/drivers/thermal/st/Kconfig
@@ -5,12 +5,14 @@
 
 config ST_THERMAL
 	tristate "Thermal sensors on STMicroelectronics STi series of SoCs"
+	depends on THERMAL_OF
 	help
 	  Support for thermal sensors on STMicroelectronics STi series of SoCs.
 
 config ST_THERMAL_MEMMAP
 	select ST_THERMAL
 	tristate "STi series memory mapped access based thermal sensors"
+	depends on THERMAL_OF
 
 config STM32_THERMAL
 	tristate "Thermal framework support on STMicroelectronics STM32 series of SoCs"
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 5f33543a3a54..23597819ce84 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 
 #include "st_thermal.h"
+#include "../thermal_hwmon.h"
 
 /* The Thermal Framework expects millidegrees */
 #define mcelsius(temp)			((temp) * 1000)
@@ -135,8 +136,6 @@ static struct thermal_zone_device_ops st_tz_ops = {
 	.get_temp	= st_thermal_get_temp,
 };
 
-static struct thermal_trip trip;
-
 int st_thermal_register(struct platform_device *pdev,
 			const struct of_device_id *st_thermal_of_match)
 {
@@ -145,7 +144,6 @@ int st_thermal_register(struct platform_device *pdev,
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
 
-	int polling_delay;
 	int ret;
 
 	if (!np) {
@@ -197,29 +195,22 @@ int st_thermal_register(struct platform_device *pdev,
 	if (ret)
 		goto sensor_off;
 
-	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
-
-	trip.temperature = sensor->cdata->crit_temp;
-	trip.type = THERMAL_TRIP_CRITICAL;
-
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
 
@@ -232,7 +223,8 @@ void st_thermal_unregister(struct platform_device *pdev)
 	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	st_thermal_sensor_off(sensor);
-	thermal_zone_device_unregister(sensor->thermal_dev);
+	thermal_remove_hwmon_sysfs(sensor->thermal_dev);
+	devm_thermal_of_zone_unregister(sensor->dev, sensor->thermal_dev);
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 

-- 
2.45.2


