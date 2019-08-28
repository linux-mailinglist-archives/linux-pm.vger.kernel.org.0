Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF6A0182
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 14:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfH1MVj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 08:21:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38455 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfH1MVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 08:21:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id c12so1984764lfh.5
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCEPqwkyv5mxLSiR3Fyva9Ue1AaKxtIqAK2Kh9KGYgs=;
        b=G/5OdVSlh/iFkBjiu7fMgz6P+9PxJR+eLI4laZId7vCa135nPEkeRfvJz52opoolgw
         LXQcgCFdLoD6xlbTTOssxfBly+O4aJidEDNcfiO8Im0B872jrjvrD00Htpfs+5KNHyEs
         7etFYsrK6G+pkkTEwfxPw5slLEJMmwiKaP0nh2Tn23exq2RtFxdOnAakNWIIYzIw0k4O
         YoOfgypU9oUiUyjCF8/2IFNDQfeNVGs+Bwh6WujkheVGPX4gbKFVU/IMP4yl/iIx27Y8
         8kbGccMzXiRiomPwzhveZYPwBGLnvRCoOD/td4I9k1ifl2XFtB+fTmGVFjSFEtwiBgVZ
         1H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCEPqwkyv5mxLSiR3Fyva9Ue1AaKxtIqAK2Kh9KGYgs=;
        b=ndZ9rzh2pUbNykYKDfmg4mD7LcUBcU0H2P7QnrXc910nLvBey2oMXxMyUgb4jhTDSO
         /vJ9mziGtqbav9AydYiZukw2x0fICuk5ARRbRmt6kKTpDC/V1Sm0dkzgNvdsgXUytRUv
         SK8O6n2Spwlv12s2TJHf8TJlNcJH8PtiX0M1BkK4tHQoiWRlbu6Ey2FS2cGkmY4Ff+iq
         L17jA0gvg/qNo9rYWAutHylmp/5HuGFUwHnse8e9yUWc/2jZ81bSpt2fJ0mMmPjsHNdy
         R9E8CuO0nStxossILs+x+rTDiZpEg/Jc94J01KVVq9L9uKHfG52ZG73HHZd+EnieC6dG
         /WsA==
X-Gm-Message-State: APjAAAWhR4JFEC62/3krpDmUg8BakasnqeFa8I5Vzg3g7dsua/b1ULKo
        q6WUK6H05vcbbOijFnAK6LSglg==
X-Google-Smtp-Source: APXvYqyMnSLeyJkP7LaCsYr4j8GxuOW3cDrzLmvAihrCLTY7tV1JNt5+32Yhj5Y6zfT9tcbsmdPScQ==
X-Received: by 2002:ac2:528c:: with SMTP id q12mr2492352lfm.135.1566994896254;
        Wed, 28 Aug 2019 05:21:36 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z18sm743961ljc.45.2019.08.28.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 05:21:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3 v3] thermal: db8500: Use dev helper variable
Date:   Wed, 28 Aug 2019 14:21:30 +0200
Message-Id: <20190828122131.23547-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828122131.23547-1-linus.walleij@linaro.org>
References: <20190828122131.23547-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code gets easier to read like this.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Collected Daniel's ACK
ChangeLog v1->v2:
- No change, resending with the rest of the patches
---
 drivers/thermal/db8500_thermal.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index d650ae5fdf2a..d250bcf3c10c 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -313,16 +313,16 @@ static void db8500_thermal_work(struct work_struct *work)
 }
 
 static struct db8500_thsens_platform_data*
-		db8500_thermal_parse_dt(struct platform_device *pdev)
+		db8500_thermal_parse_dt(struct device *dev)
 {
 	struct db8500_thsens_platform_data *ptrips;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	char prop_name[32];
 	const char *tmp_str;
 	u32 tmp_data;
 	int i, j;
 
-	ptrips = devm_kzalloc(&pdev->dev, sizeof(*ptrips), GFP_KERNEL);
+	ptrips = devm_kzalloc(dev, sizeof(*ptrips), GFP_KERNEL);
 	if (!ptrips)
 		return NULL;
 
@@ -377,7 +377,7 @@ static struct db8500_thsens_platform_data*
 	return ptrips;
 
 err_parse_dt:
-	dev_err(&pdev->dev, "Parsing device tree data error.\n");
+	dev_err(dev, "Parsing device tree data error.\n");
 	return NULL;
 }
 
@@ -385,18 +385,19 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 {
 	struct db8500_thermal_zone *pzone = NULL;
 	struct db8500_thsens_platform_data *ptrips = NULL;
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	int low_irq, high_irq, ret = 0;
 	unsigned long dft_low, dft_high;
 
 	if (!np)
 		return -EINVAL;
 
-	ptrips = db8500_thermal_parse_dt(pdev);
+	ptrips = db8500_thermal_parse_dt(dev);
 	if (!ptrips)
 		return -EINVAL;
 
-	pzone = devm_kzalloc(&pdev->dev, sizeof(*pzone), GFP_KERNEL);
+	pzone = devm_kzalloc(dev, sizeof(*pzone), GFP_KERNEL);
 	if (!pzone)
 		return -ENOMEM;
 
@@ -410,31 +411,31 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
 	if (low_irq < 0) {
-		dev_err(&pdev->dev, "Get IRQ_HOTMON_LOW failed.\n");
+		dev_err(dev, "Get IRQ_HOTMON_LOW failed.\n");
 		ret = low_irq;
 		goto out_unlock;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, low_irq, NULL,
+	ret = devm_request_threaded_irq(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_low", pzone);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to allocate temp low irq.\n");
+		dev_err(dev, "Failed to allocate temp low irq.\n");
 		goto out_unlock;
 	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0) {
-		dev_err(&pdev->dev, "Get IRQ_HOTMON_HIGH failed.\n");
+		dev_err(dev, "Get IRQ_HOTMON_HIGH failed.\n");
 		ret = high_irq;
 		goto out_unlock;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, high_irq, NULL,
+	ret = devm_request_threaded_irq(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_high", pzone);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to allocate temp high irq.\n");
+		dev_err(dev, "Failed to allocate temp high irq.\n");
 		goto out_unlock;
 	}
 
@@ -442,11 +443,11 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 		ptrips->num_trips, 0, pzone, &thdev_ops, NULL, 0, 0);
 
 	if (IS_ERR(pzone->therm_dev)) {
-		dev_err(&pdev->dev, "Register thermal zone device failed.\n");
+		dev_err(dev, "Register thermal zone device failed.\n");
 		ret = PTR_ERR(pzone->therm_dev);
 		goto out_unlock;
 	}
-	dev_info(&pdev->dev, "Thermal zone device registered.\n");
+	dev_info(dev, "Thermal zone device registered.\n");
 
 	dft_low = PRCMU_DEFAULT_LOW_TEMP;
 	dft_high = ptrips->trip_points[0].temp;
-- 
2.21.0

