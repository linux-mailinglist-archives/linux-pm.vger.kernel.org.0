Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D913F9FDBE
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfH1JAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 05:00:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46240 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1JAK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 05:00:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id n19so1440287lfe.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVhz1OO0ZxhBZubMddXQ3Emt8VJvFbqDjLyJ6vpWrIk=;
        b=mrE67/FATNYTkbwcyvOftkVNn3ekurlAE7PcNkTdGSxnIKJGmd5expXHgSP26S1Uji
         jGOMyBAFVge4mBggchTNvfHVV1DCAgTVxuy6IFmSWlBOvLNNVtyPrb9CLvjEmYKQ9W1e
         RxQ5ZCr/6V9DxgNqi4A3Q2lhSeck7hYL0EIj9Iyz3L9t8U74SmzyxJ9ga5FFCfEEheT+
         Nh6KHmW9BTTr5OD/IS+8brdfNNWQh8QFr2A2E1Te48GiaiP2VJsuzXi0PYXGGFeyiCRq
         tho0LDtXnTayP40aOs76mHj/hNYMXIe4gjcQpwlZFq9mmqvAJLiOO/O4ACRwqLbX7/L+
         ufwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVhz1OO0ZxhBZubMddXQ3Emt8VJvFbqDjLyJ6vpWrIk=;
        b=k3AMmFHZk1+FC0wr70c53mInfXkLPsfxLFoHr4qzS1wevxOLWwYmm6q9OpxMvgN4/Q
         D7XMI1oUoctKSi0DLL1jTHhB7w6wALNDsF/ascIT54NoQNMD72RNgEzLUTnKMzQnjmf3
         dz0Fwv1rT4QoOKw/Xux7DSucAVm2BlVERUZHF2YKFAkaH+9lfyl5lu7YLj9vdfZf6eMi
         IQOZ7d70Jq56FowJRJaBlesEuisAAi/RARxBQRLbwv/IEFfcH7Yfhb61w+DWSE7IUK1b
         tm68SGUg6Ki73saWeMmWvDpTFPvAGfvlTBJQk5mnFjRmMxfl8cKivL6sG/ZNFwHrPds3
         b3gg==
X-Gm-Message-State: APjAAAX1KvbM0n5reXsP0SYMJRJASQ9RGyLVXP712W1NDk8LY8n2sr1d
        c9uzD4H/f+YwgKNSv3+L51r8dPtBk3U=
X-Google-Smtp-Source: APXvYqwvhWXE3moSZqqiA86wdO47BchvG758g8iR3bH39ujOTqHk0LmsrvMJWw4o5gyBL0DV8V/Mng==
X-Received: by 2002:a19:bed4:: with SMTP id o203mr1844927lff.110.1566982807463;
        Wed, 28 Aug 2019 02:00:07 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c23sm449653ljf.105.2019.08.28.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 02:00:06 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3 v2] thermal: db8500: Use dev helper variable
Date:   Wed, 28 Aug 2019 10:59:58 +0200
Message-Id: <20190828085959.11510-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828085959.11510-1-linus.walleij@linaro.org>
References: <20190828085959.11510-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code gets easier to read like this.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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

