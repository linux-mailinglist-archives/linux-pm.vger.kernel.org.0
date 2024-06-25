Return-Path: <linux-pm+bounces-9976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94291738A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 23:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959CE1F2250A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 21:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC0917E462;
	Tue, 25 Jun 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC7Z25gX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFF1459F1;
	Tue, 25 Jun 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351198; cv=none; b=MKmLccgv8MmCo/CC9wjy7mhPB/GhtWanXWTOhzLQbhDscff6kl15pyLSUhRuX7oxk8TKqdRtTkEP/YGVTZaXcY6lBypy6b4XJtBoCmVCDViUqrinfO6qlYHCn2GOfIlpwumWtfVtcOJvQmNlMC5y0Rv4+DVfba7HovApbuDvatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351198; c=relaxed/simple;
	bh=8ugDw+DnSBdTk/4ZLKwqvutttZg+1IAeEMpbiGGjozo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWr/DUg8VbIVD+6CjGiFZHQyzQh+tuAyg1ifLEvfVrKVjjVmISArsyQxxGTszYO3cZdIekZ56crAfEvZ0LB0QTgBeMA23ndelHudr9VS9JdMSFnK2RzaA7RyCFiMozKOF2kad4PlVmu7965/f/tAA5GG9Z7Fp71FXSg3HoR2w1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC7Z25gX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424acf3226fso2174535e9.1;
        Tue, 25 Jun 2024 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719351195; x=1719955995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmhey6jWNgkoZcPsesEc/YC3gENWDbb7EazMCNZY/50=;
        b=WC7Z25gXytoTmnunHQQV9EsUPHyfI7U82yh929frbbeglMJ3LSE0EtWYpXEe8KpYEM
         +9HMvnCr4ovCqoue4527RCxfdP0bSXO1HxFiPVJyv3tprnacsL2EZzjleKBFNe4iMSwC
         6oxVu44BNHcDe+aZOho5PTdNQHAYTFcys4Ou6+S5c0YQAliLv9TJWlg8o1vQsi068rRv
         UBKH9I2vDKKn6eQPk5uXwU2C2CYlkhnM6bqeSo9gwiuRpucsecy/km/4KdDzeqRhcuIG
         fKgpiKhB2ISekvNDCBKJG3TzQordOszvqGXOEmbMTQ8JJ+2VvUK03FgDK7N/sH/QkANO
         QrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351195; x=1719955995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmhey6jWNgkoZcPsesEc/YC3gENWDbb7EazMCNZY/50=;
        b=s8t9gBsbAkHJZjXaAasnxNnlOQJ9m+t5u+lTcx3B4ZZ//5VwKNqoGTQEoHP5Jf4rcc
         bvXb+sqOtnGuGe6ZjVHepdQKJoll5bX/RcyEmJANq2Cx9fqOskGTHBraz/06fY7D4rjX
         MJEkBMHz71juZgTTciyTeSLmNhqG1nsV8ENLpbYp8L+SmToJUg4xzsDef5NJqfukfJEN
         IZr3hyIQKfQI5Z7aispkB/+BxjRvNd17AnTLcyUYBnyyFKFaQhCtG9UKFSFWwLHYfwJ4
         iZW9tLQHw3yTlCJiFqgrwCcbesMvRi+u36bndXvDOcgOhZmn9i2IBnIuePf0nes/MMdA
         /OMw==
X-Forwarded-Encrypted: i=1; AJvYcCXVoA/36+NGlajsnsqvppFVUnUwgLEW3kMxn3hnIo8ww+FLZAdqPZVLrfBcPGj6fQs35BkG2zL5m+G6ilK7tnMLXtiYXUbyGfIgCvZMnocFZv+ngI6UMHFOLKhlSnUmYIRhfs9z9WiQpA==
X-Gm-Message-State: AOJu0YwXITaji2MQAoq1szbSVtxHbbHYuN663LSuj0TzSwdxw0+6TW1I
	NJ2zwkH14cDafh9Nre1gXrkh0RgfqIyYjkx807bw2WXbzNQLPw3q
X-Google-Smtp-Source: AGHT+IHZcYPdA/oB1eqxXUZJdRHrdM0ptr8uZAvGcXG5QB+c4jay5cR1N2yLLu/ozoO9syYLBuFxfQ==
X-Received: by 2002:a5d:518c:0:b0:362:3b56:dbda with SMTP id ffacd0b85a97d-366e9463e46mr5084476f8f.9.1719351194528;
        Tue, 25 Jun 2024 14:33:14 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366e88c0c38sm9561633f8f.32.2024.06.25.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:33:14 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Tue, 25 Jun 2024 23:32:41 +0200
Subject: [PATCH v2 2/3] thermal: sti: depend on THERMAL_OF subsystem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-thermal-v2-2-bf8354ed51ee@gmail.com>
References: <20240625-thermal-v2-0-bf8354ed51ee@gmail.com>
In-Reply-To: <20240625-thermal-v2-0-bf8354ed51ee@gmail.com>
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
Changes in v2:
- Remove unused struct thermal_trip trip
---
 drivers/thermal/st/Kconfig      |  1 +
 drivers/thermal/st/st_thermal.c | 25 ++++++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

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
index 5f33543a3a54..1f2ba5c88cbc 100644
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
@@ -199,27 +198,22 @@ int st_thermal_register(struct platform_device *pdev,
 
 	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
 
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
 
@@ -232,7 +226,8 @@ void st_thermal_unregister(struct platform_device *pdev)
 	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	st_thermal_sensor_off(sensor);
-	thermal_zone_device_unregister(sensor->thermal_dev);
+	thermal_remove_hwmon_sysfs(sensor->thermal_dev);
+	devm_thermal_of_zone_unregister(sensor->dev, sensor->thermal_dev);
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 

-- 
2.45.2


