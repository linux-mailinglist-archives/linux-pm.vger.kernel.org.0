Return-Path: <linux-pm+bounces-11177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4CD932F31
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 19:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07241C20AFC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4A1A01CC;
	Tue, 16 Jul 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odpg4G1l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02419FA81;
	Tue, 16 Jul 2024 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151317; cv=none; b=Ma5GrYC2CoGhBMwPZI2fIFn+WImTPtHIYSb93nSxQWUu4NprGO2OonxrBW8kEIQdbAoL5WgQQRlBR/Wqe+X/A/Rz6EquAREC6IKh9TOIRYbTvNMf4zQ8gDxRiGTuKZ0A3c0rU/qhRaEmlc6CWc0rhyfHVjDEiSyPUTONVU71rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151317; c=relaxed/simple;
	bh=xlHRw3w2m2tg6cht4Qq290RJJ7J5SeCZAW8m9wfBb1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMKUtcn9dMlebYA3p7EbZ44Wf17YWHrquLUSRLhUk+5IOd3tWSb9MZXQfq4qmwYmizmqth0Vsqwse7UekCb970t8623tKbRCYvEz9fvBJuoxRQjB5jk1Ot1MVfZuPCamtrcB92hjmUP91EziR4mkVQHTVpVWoyg/oHsv2nAd1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odpg4G1l; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so1919402f8f.3;
        Tue, 16 Jul 2024 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721151314; x=1721756114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFZzo+h40ZkOiMih2IEE7mwoxCHvaz4i8bbYlqWEClA=;
        b=Odpg4G1lZPl9u8TEk7/tp0rUITV/8bCcuyKbohJ3/NIS8FksCDX1dvDPIzioUnuhXK
         oeOnE4ErnMb3QLbG9pVE0TqbZeb/KYBTQHv6IW2RESUgwOv/Z7M/czUPPJ2xnsq1z5Wu
         kYknGw5IY7zi5uSu4EQLP64YiCnMOAcMyoaWYLUMr9P/aNl6xbA/6twlPWZ2uiJtFRmH
         OXOkxc8kMoMuLA7nKXZ4EK6MqTidGbbaMrmcMaPH00CA3V2jAwXvgt9tC7L+xLAECQeR
         YSnjoRIS62M3TV2PGE7nEIUUGk0zmA4yLOaYhnXf4Bq6pWpFDUfzKG24wM9ZAaS9uxEO
         /MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721151314; x=1721756114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFZzo+h40ZkOiMih2IEE7mwoxCHvaz4i8bbYlqWEClA=;
        b=bfhOMYeVoMvuYC1bjyyL95Hkjgf4lT1CtbXqr0TU4tpOt7My9pJYJ4BB2a8bB4y4m3
         Uwo1eMS9JRmJB/8BHUbvTsK8hCCl8HWirDpXkp5UpyHScbfn4qbjGUGBwBRc5Tahqfq6
         LkfiL3n0tWTzfdYk44HsElnuXGaDZBZzHv71VammtHjXtLezbwPbhcRGR4kXrklYy8mY
         xvrjsSxJBsbGG5dfkgXE1B7hQk0aI7BPWyGZVoK2mfj3dOjDS2KLb+bKur3xYNnpwrRo
         MthUchkTx8b/Xjn60LIRXqZ4hr6gYUFpNvsiVW73TYiiyx2N06YQvBCAGL+tS4hajNpy
         DbiA==
X-Forwarded-Encrypted: i=1; AJvYcCVtYozKIFBikB5BtJmhmOcb92N44B2WJJH056CUDX8AbPc4GRUqRk47QMjNP6Mn3H8lFpx8a/8FuBGXpPznRnNjfJ6VQy/dULzfOlwsW/H/WVUSZnSEmqGTzWJR1iAFjn5HRxRHmaJHrQ==
X-Gm-Message-State: AOJu0YxawpHx2lKPhQ4PCisVBMKASG962DGYGOQzB5qUvciKVMn7uzld
	TVmXpCcMr/4/HxWHShhLusZkX11GYi2f8RzzaF3RdltMDPlIv/Ch
X-Google-Smtp-Source: AGHT+IE70zhsNBUYOAewbvXHcYgepuMa8i+6KzIjuE7KgPVIgmBQVK7/cIQLRs1F0enKt0xhxVITpg==
X-Received: by 2002:a5d:588d:0:b0:367:958e:9822 with SMTP id ffacd0b85a97d-36825f715c0mr2543892f8f.14.1721151313262;
        Tue, 16 Jul 2024 10:35:13 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f27877dsm167381895e9.26.2024.07.16.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 10:35:13 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Tue, 16 Jul 2024 19:34:52 +0200
Subject: [PATCH v4 2/2] thermal: sti: depend on THERMAL_OF subsystem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-thermal-v4-2-947b327e165c@gmail.com>
References: <20240716-thermal-v4-0-947b327e165c@gmail.com>
In-Reply-To: <20240716-thermal-v4-0-947b327e165c@gmail.com>
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
Changes in v4:
- Optimize dependencies
- Do not return devm_* exit code
Changes in v3:
- Fix unmet dependency when building with ARM64 compiler
  https://lore.kernel.org/lkml/202406270605.qodaWd4n-lkp@intel.com/
- Remove no more used polling_delay variable detected by kernel robot
  https://lore.kernel.org/lkml/202406270530.kN5wIswi-lkp@intel.com/
Changes in v2:
- Remove unused struct thermal_trip trip
---
 drivers/thermal/Kconfig         |  2 +-
 drivers/thermal/st/st_thermal.c | 28 +++++++++++-----------------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index ed16897584b4..b6b916e7e294 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -429,7 +429,7 @@ source "drivers/thermal/samsung/Kconfig"
 endmenu
 
 menu "STMicroelectronics thermal drivers"
-depends on (ARCH_STI || ARCH_STM32) && OF
+depends on (ARCH_STI || ARCH_STM32) && THERMAL_OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 5f33543a3a54..a14a37d54698 100644
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
@@ -197,29 +195,24 @@ int st_thermal_register(struct platform_device *pdev,
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
 
+	/*
+	 * devm_thermal_of_zone_register() doesn't enable hwmon by default
+	 * Enable it here
+	 */
+	devm_thermal_add_hwmon_sysfs(dev, sensor->thermal_dev);
+
 	return 0;
 
-tzd_unregister:
-	thermal_zone_device_unregister(sensor->thermal_dev);
 sensor_off:
 	st_thermal_sensor_off(sensor);
 
@@ -232,7 +225,8 @@ void st_thermal_unregister(struct platform_device *pdev)
 	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	st_thermal_sensor_off(sensor);
-	thermal_zone_device_unregister(sensor->thermal_dev);
+	thermal_remove_hwmon_sysfs(sensor->thermal_dev);
+	devm_thermal_of_zone_unregister(sensor->dev, sensor->thermal_dev);
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 

-- 
2.45.2


