Return-Path: <linux-pm+bounces-10870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B592BA51
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EE91C22BF2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833F316C87B;
	Tue,  9 Jul 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/3kMqmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A516A934
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530010; cv=none; b=qy1PPHrriS1UwqfhTj6sFRQo+IcjhpaZ4MYkPF226LOpAXj5SXPGJ/s0MRDj9gomWMJIksACMzKq47OyoXQnldg6CcImMIkr430uAHO2GjCPjPeZZTJJzkSU33EcjNF1pzWxR41iBgs0nEKgc2XK43xQdFwkaWUw4+ZJrNt9qmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530010; c=relaxed/simple;
	bh=fOrJbRqwoNL/mBzSZDplHqrI4pWk/WZ0qa2hUqE6xXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6yzUhQyjiXyZFw/wtsb484bEeZ/BcdC+IwsPkPr6toOrC1LQ2Wuz2buJSi2IxPyekc6miLG8GiJbaU0+mND+yvjmxYhB2o4sOG9Zz2UvfkNqJqaaRhumcJl3JL9S3Hw3ToPlVNH87mY827K2xZn/uvvXnoVj3rwOfFjW2eL6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t/3kMqmY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso740781066b.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720530007; x=1721134807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiWnHmVQfyhxRnOCy/rrdaP34wGwyHEY70ZKIG7Xyt4=;
        b=t/3kMqmYgntgr0k7y/Hi7av7puZg/6Feu+EXUWU2O9ZTSdXq/Uacd34L/Rq2Zg2m1i
         Mx/0h903ml8VL9u2qr6l32+xYlUysfFeAj6v+SUCC6b/5FxbrMfKO5Z8NHq/KSNrNdFL
         cGbAKTu1InNzmnsDqUA5L5lq6cJFiUQ8eBHX9Cvc5PsAb06qRTEdBScMXhcrqTFvCuAA
         IX1e0BaVkWXg+4glr0iCb6S0MY0aXi47lJh6pHMBUdKTp6nUrQkBT2MrP7WdBxSRkRSY
         ArXoDVu0k6/8GQGIwkrIzKwfW1djSpEZ1USvkeR1+lGXOahjHhvACibFtXpDPCYsb+Xt
         dr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530007; x=1721134807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiWnHmVQfyhxRnOCy/rrdaP34wGwyHEY70ZKIG7Xyt4=;
        b=BfJGwQM1rUKl3i5/Zz5UWHtw239dz1XuMj7wEjnK8fvlQ9qEALtmI/78a7V3bWnS6x
         sI1Z9/+LlJqYn/MmYwlWBDLPf/7ERhRZaIGnZMvXIzRV1MB7ehSy6rT27cu2zpvNsJ7/
         qF5lSrSc84ZGccYoikmnQ5yFzR9Ep0BgZU8qRNA4RN/fqZJCvV+J85tK/bXZGPkO1ZKd
         /6RLzw2Sji0Lq2Zztb1myd/CWSPACvIxz6GfhKUGEmnIrLPrY1KcnvUydNRIXZDaxzEE
         lmt5N3bLkJvoUFXTgowjQAqctks8CqNCQfHlVFz+cnJ1KtwuND56hBQYdBe3X3uZzcOP
         lMcQ==
X-Gm-Message-State: AOJu0YyZW/mO7RQilxMtPBrtnV7ueQGWV6CyLMCpgDhz0R9IPEDXRdS1
	QS8mnlIjeqBkIL/Aeh5dfpBFvj3YS76ZStf9EwVw4XgX+i0q9tEH3dbcBlZw1Bc=
X-Google-Smtp-Source: AGHT+IEOHPQKtfTU5lqsq5SqdLNwXEKpRHu6JIdoqZhw2lgHgU/t68cvEhBj2tknv9L6i4EcohZFdA==
X-Received: by 2002:a17:906:7953:b0:a77:c043:5b59 with SMTP id a640c23a62f3a-a780d250153mr192202666b.20.1720530006772;
        Tue, 09 Jul 2024 06:00:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:00:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Jul 2024 14:59:37 +0200
Subject: [PATCH 07/12] thermal/drivers/imx: simplify probe() with local dev
 variable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-thermal-probe-v1-7-241644e2b6e0@linaro.org>
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
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4730;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fOrJbRqwoNL/mBzSZDplHqrI4pWk/WZ0qa2hUqE6xXg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTRC+wuSOQmMAgf0HTOGQ+3cbiEzTu+qndTQX
 XrnO/ZmR8yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00QgAKCRDBN2bmhouD
 1z6jD/wLwXfsB0BUjQImBAY0jUoaEwMbZsLzkKkXxWYMSEJJsBMorYJRBMHvLx+SgY+vuAVABOL
 Ok+8YBvyDADjY7rZzniYS3hbd+07x0sZSANnK5Q+hLd8IWMeUBYk4uxDYVlS8QtHVK6ppHlzRPj
 5GZH6iBKphDTn5JkY/2kzUXaeTTsKf+D29Wo7e1/6TXsRr66JjKJ1vW0G21hWXv+BXt/r5nnVeS
 tczZFn5mt1nKxNTmzQV1fFgxU7kkckCjvmPastSo9zJEBwUwyYAXl1wfuZZ0t2jVpCkSNJKxMuM
 lJKnj74/RmBrYAcszQA5DKJ59U+HzLnUBuZ/NbtPcF6aqvDFChPJSjm9ozqfvJTwT11Mo7fzut+
 3OhqeXCRiooQ02P8oGkgN+7kyVMwGkeYW9jcqtKaqsntNd9WKXIl5zEsyz8QJTR6ux4pKFA28V9
 HZYosyl2YtFes88sArhx/+vPZPrREun1NtSrKbafkxD8aLO2UYYQ4QCpWnXWRYww3buSXcMnLMz
 qfKenG7CsOKgwsDIEFQyIpxLpt+zDRgikK9azFdr1PkBhikB+epzAXkZcXYfXNWF2j5XnZYmGQb
 /xAdoZhKOG9FcXK30AByegtnDBW7AH2wFXgnt2vZ6ciV/e/f5A0w65CpkgxjMEs1U9Y5Clz9B3z
 qlOOtwrivf/GPsw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify the probe() function by using local 'dev' instead of
&pdev->dev.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/imx_thermal.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 83eaae5ca3b8..05c24be5343f 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -601,28 +601,29 @@ static inline void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data
 
 static int imx_thermal_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct imx_thermal_data *data;
 	struct regmap *map;
 	int measure_freq;
 	int ret;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->dev = &pdev->dev;
+	data->dev = dev;
 
-	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempmon");
+	map = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,tempmon");
 	if (IS_ERR(map)) {
 		ret = PTR_ERR(map);
-		dev_err(&pdev->dev, "failed to get tempmon regmap: %d\n", ret);
+		dev_err(dev, "failed to get tempmon regmap: %d\n", ret);
 		return ret;
 	}
 	data->tempmon = map;
 
-	data->socdata = of_device_get_match_data(&pdev->dev);
+	data->socdata = of_device_get_match_data(dev);
 	if (!data->socdata) {
-		dev_err(&pdev->dev, "no device match found\n");
+		dev_err(dev, "no device match found\n");
 		return -ENODEV;
 	}
 
@@ -645,15 +646,15 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	if (of_property_present(pdev->dev.of_node, "nvmem-cells")) {
+	if (of_property_present(dev->of_node, "nvmem-cells")) {
 		ret = imx_init_from_nvmem_cells(pdev);
 		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "failed to init from nvmem\n");
 	} else {
 		ret = imx_init_from_tempmon_data(pdev);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to init from fsl,tempmon-data\n");
+			dev_err(dev, "failed to init from fsl,tempmon-data\n");
 			return ret;
 		}
 	}
@@ -673,15 +674,14 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	ret = imx_thermal_register_legacy_cooling(data);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "failed to register cpufreq cooling device\n");
 
-	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
+	data->thermal_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
 		ret = PTR_ERR(data->thermal_clk);
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to get thermal clk: %d\n", ret);
+			dev_err(dev, "failed to get thermal clk: %d\n", ret);
 		goto legacy_cleanup;
 	}
 
@@ -694,7 +694,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	 */
 	ret = clk_prepare_enable(data->thermal_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
+		dev_err(dev, "failed to enable thermal clk: %d\n", ret);
 		goto legacy_cleanup;
 	}
 
@@ -707,12 +707,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
 							   IMX_POLLING_DELAY);
 	if (IS_ERR(data->tz)) {
 		ret = PTR_ERR(data->tz);
-		dev_err(&pdev->dev,
-			"failed to register thermal zone device %d\n", ret);
+		dev_err(dev, "failed to register thermal zone device %d\n",
+			ret);
 		goto clk_disable;
 	}
 
-	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
+	dev_info(dev, "%s CPU temperature grade - max:%dC"
 		 " critical:%dC passive:%dC\n", data->temp_grade,
 		 data->temp_max / 1000, trips[IMX_TRIP_CRITICAL].temperature / 1000,
 		 trips[IMX_TRIP_PASSIVE].temperature / 1000);
@@ -736,7 +736,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	usleep_range(20, 50);
 
 	/* the core was configured and enabled just before */
-	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_active(dev);
 	pm_runtime_enable(data->dev);
 
 	ret = pm_runtime_resume_and_get(data->dev);
@@ -748,11 +748,11 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto thermal_zone_unregister;
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
+	ret = devm_request_threaded_irq(dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+		dev_err(dev, "failed to request alarm irq: %d\n", ret);
 		goto thermal_zone_unregister;
 	}
 

-- 
2.43.0


