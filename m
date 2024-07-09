Return-Path: <linux-pm+bounces-10864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499C92BA33
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C774287829
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC215ECD3;
	Tue,  9 Jul 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3p18c5+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180215B116
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529998; cv=none; b=jW9zKTN4noi26WZZ6NQ62VQeLroKClXDochus+Kp2rc/nuzFuds1MHj6vNHkjnmwbV9Kew9HrIBiese9hw1/Fx6CXoZyucD3eBPT6YihMzfT8eAbSrImyXO4k8MW8iIJa2JP8eRgkRT5EV0KeXuspejByr6i7+ENfWs7eqtadYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529998; c=relaxed/simple;
	bh=iOmmg+031BO+zTgqj4Da5Rimz0tYxzcZBtos8xp+M6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPGl1oVHl/cZ6fQlquqqivtoZlhZWy0LwxUFUIN14iBBDJi2yBrB1kymuT7uC3PljqLfJNA1ZCImT33ZVLrzFq2FFQOC6LkiVfyED8kSTUUjjk5FYoU7s+7Qe4YyimVIpjcSxodRorzkC9eKehjCbW4YvzWnEVOMLpVgfQQqbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3p18c5+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b3fee65d8so5694102a12.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720529995; x=1721134795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hpq15xCFbtYALDYFY4KDY3RIliIQDLzZlDT5dVHuf9o=;
        b=r3p18c5+wh7LfWBepgVgu2EyR5nasCnEG41JkyIj/nzLfBc5hXwJPb6oOv5Vnh4tMA
         zTOJu8NPoV0apuCbvClJgOSZIdz/yOQXg9R+Cnu0/6Y6CrGKiLB7OBzVr9bv3m1PUZF1
         ejclrxDBfNcTLO4B/53B1sjR2WlgrAyJE8SIiCZLI5IYpbgwQ/ylLLGphyJyEp4Y4MEo
         tJCp6WG76IrNlN9HmdCJ9bOGeOiFyXotqXbYPvFp7ekmbo4EUNsxqSepPEqpV0pROAKH
         9hHdWlDylFRK7ib62APSaAD/pTTG2GtumSBBqLQzUcv0jhnIznXA/9xyF48Dw9JaUNIh
         YdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529995; x=1721134795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpq15xCFbtYALDYFY4KDY3RIliIQDLzZlDT5dVHuf9o=;
        b=R/chppdRTg4UPFhcuKD5EoJ3GX54ceAvjOMFF5L7kAn+tHbn4MY0DMUtYferWxnjqP
         A5qrc3hWlMv+Bf+zVCSFiiyPv6/hSptY5Jx00ErURCngr54odHk160Xjp+G+d6ycQsjn
         D0G1An4g4eHiL8Z7fOhz9hNhFxMSfbwZFjBTAhMNbjP/0yvJqVkB8oKo7CN8UoxM8cE9
         sgPc0DQ56YtCfitWIUYx2V3nApynzVTy3qbFt4Q2AU2tWjBTFlFplbWchew6yyHS/lpo
         e2JOzT8hFo6wHTKp7veLtngZKN273VhuRzfscJbQN9cR+Cw7YGGIlXAgt/7C+b32rg3u
         Ja6w==
X-Gm-Message-State: AOJu0Yx9AJDWa8/SYJz9v6rgyvYMF7/HLFqfWbW0jevxIfKJ/AaMzP/r
	OxzyiW83tcBtWj75Un+VkAdSkVSP7/ZCfm4nj/NpknXk2VRTOlXAL113fN1xmIw=
X-Google-Smtp-Source: AGHT+IEnBykQHOg72vb+3a+PwqhhC6nKKTeE5KfSm0UJxuh/0+T6xpvhz21MgJnNUb9TuX3+w8AJwQ==
X-Received: by 2002:a05:6402:5256:b0:58d:eca:b9bf with SMTP id 4fb4d7f45d1cf-594bcab156emr1744682a12.37.1720529995591;
        Tue, 09 Jul 2024 05:59:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:59:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Jul 2024 14:59:31 +0200
Subject: [PATCH 01/12] thermal/drivers/broadcom: fix race between removal
 and clock disable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-thermal-probe-v1-1-241644e2b6e0@linaro.org>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
In-Reply-To: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3012;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=iOmmg+031BO+zTgqj4Da5Rimz0tYxzcZBtos8xp+M6k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTQ83IPlStNA8YpS9fGSEe7VT+gKCvXpGdAfJ
 5hWjtkURB6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00PAAKCRDBN2bmhouD
 117aEACEcxeLvNx+Ph7F3Sf3xCVkyz8ERxrRXQXccTRTOYxedP0TJzaaKHlqyz+OlCmtcu9wKpm
 WRjmQxWKqPDDFmWgr4Y04n4SFXB05HI6p/7z3w+Qythc9voHFnPIezcyDwyr0H0DR+jZ1HLki57
 pixbSiu1Oh7tFR6L/Za/4zrtmS0BDmJqfKOyUciOuKmucNdB5o2lOEIG5pGuaTP95+3pVvbGYoO
 ECPivYLlIIgzh4JRpRQdSKVewxs5TqSOc7Fjq9LI/I9XylD0k3GwhSVwvYdKAPJ6fhQcCIyeagv
 uX+tI+vwiGKZIXEGskAnZfwjacFGXNFY8hQKwXSiBooGOi5Bmdqh7FwGlomD0+XPFzSqUkyLJ4u
 qqUQ13wRtzhsc7FhtAlIHw2yrME7IeTNrORvMj9NSD1BEixkbPEN6uc22OqcVS/+bF+PyFVIL4j
 NEJbL+MzL5fhn176g4N+LyG+L7fpLqJvjWwgHOOmOZk0CTwie+3BOocSd40x7giMK+RhpOJPiDQ
 v0SF1Cy6EIdDlduw+X5sl681DnxfiPWMg3FZ1Sy2OGhh7M0UKc20QG3ecnPvMZys7AmalVQY14E
 8ywJEmETlZS04IXHms1rYHSYGBL2DP4tNxOGJNNE4Prn+GgvrOltn4hs5agcW27LEZSHJsj9d7N
 8KUwp2YTb4FzNfQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

During the probe, driver enables clocks necessary to access registers
(in get_temp()) and then registers thermal zone with managed-resources
(devm) interface.  Removal of device is not done in reversed order,
because:
1. Clock will be disabled in driver remove() callback - thermal zone is
   still registered and accessible to users,
2. devm interface will unregister thermal zone.

This leaves short window between (1) and (2) for accessing the
get_temp() callback with disabled clock.

Fix this by enabling clock also via devm-interface, so entire cleanup
path will be in proper, reversed order.

Fixes: 8454c8c09c77 ("thermal/drivers/bcm2835: Remove buggy call to thermal_of_zone_unregister")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 5c1cebe07580..3b1030fc4fbf 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -185,7 +185,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
+	data->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(data->clk)) {
 		err = PTR_ERR(data->clk);
 		if (err != -EPROBE_DEFER)
@@ -193,10 +193,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = clk_prepare_enable(data->clk);
-	if (err)
-		return err;
-
 	rate = clk_get_rate(data->clk);
 	if ((rate < 1920000) || (rate > 5000000))
 		dev_warn(&pdev->dev,
@@ -211,7 +207,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Failed to register the thermal device: %d\n",
 			err);
-		goto err_clk;
+		return err;
 	}
 
 	/*
@@ -236,7 +232,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Not able to read trip_temp: %d\n",
 				err);
-			goto err_tz;
+			return err;
 		}
 
 		/* set bandgap reference voltage and enable voltage regulator */
@@ -269,17 +265,11 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 */
 	err = thermal_add_hwmon_sysfs(tz);
 	if (err)
-		goto err_tz;
+		return err;
 
 	bcm2835_thermal_debugfs(pdev);
 
 	return 0;
-err_tz:
-	devm_thermal_of_zone_unregister(&pdev->dev, tz);
-err_clk:
-	clk_disable_unprepare(data->clk);
-
-	return err;
 }
 
 static void bcm2835_thermal_remove(struct platform_device *pdev)
@@ -287,7 +277,6 @@ static void bcm2835_thermal_remove(struct platform_device *pdev)
 	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(data->debugfsdir);
-	clk_disable_unprepare(data->clk);
 }
 
 static struct platform_driver bcm2835_thermal_driver = {

-- 
2.43.0


