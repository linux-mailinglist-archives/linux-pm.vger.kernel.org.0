Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB7A0277
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 15:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfH1ND3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 09:03:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32806 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1ND2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 09:03:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id g9so2125287lfb.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qM8fl4wYquSBdbAEZPeEK0+d/HM25Lv2u5CqIuUyAuE=;
        b=rJvYwGkEvCHbRVRMcMoR1pxMyU8eb2WZAdZn29CM9d/7OegJgY+W9qZa9U2NjZvWBT
         7Ww+e1c9ShfWhfRlaf8W70MghIzFrrb7mqq5AQV1dDJHdP5bEpexa8TCb1DGeyMptVy3
         Pul82hBFV488VAaJnnPmXLwlr6YLOm1HSuKgbcYPjW1EVVXfXWdlGJ7nM3YXtlhXnuTy
         fj6f7ENP5mI3YbYwd/Biej4SQQ5IvlK3sNNkhc+0WmE7slaEQvWN/nLJe3YfOBYz4kCE
         Tqvm9PD1sjB4UXT1jcyOCDcFbm/JcpApxT7ni79Fho7JUduodk4lvxUMXTHMqvR6TYwE
         Kogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qM8fl4wYquSBdbAEZPeEK0+d/HM25Lv2u5CqIuUyAuE=;
        b=M3r4L6yX91JPFcuOhK98xmGoqL9goI/cXt99eJvIG8UsnBxNTrF1NHMaJU79iZcZJ1
         nCtmRlKdzAYhL4J/DHjbQ47aQUKGP6lw6v+7F1NPH1XD74rZ7TTYeXQaRmZsUwd9/i8h
         rp6CWGyCRCiRjVYJHEdjT67c1ePerHLz55W4d6KA6ab47ft+zSlYfHu+3Ev/o5H6liUE
         jd1Z5m7DxigmugL8mglFXynGh4TrFEhtgvqdmBKz/ukvKPpVyYZYl4iRS5ptJBk3ULHH
         VE5QpBdAxFLrtGG/fPHm2VHpOsxzZrjdM2ugC13tltPucfaU8780rbcIoPegLSavmlak
         +qUg==
X-Gm-Message-State: APjAAAUL+2vrmmefMqLk7XOWdQ8DCOEBooRLmK39mk/q5JQ3oH/i6QL0
        kwZ5atJWI0s3AOWIHJ5eN+5/lQ==
X-Google-Smtp-Source: APXvYqyya3N6ea7k/9pGxJFDY/NytXvAu22W33lakLCxiNyqAjzHFeO6JgDXQ+qFrLU8TzHsmYA/Qw==
X-Received: by 2002:ac2:4c2f:: with SMTP id u15mr2531508lfq.174.1566997406084;
        Wed, 28 Aug 2019 06:03:26 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 18sm843611lfy.26.2019.08.28.06.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:03:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3 v4] thermal: db8500: Use dev helper variable
Date:   Wed, 28 Aug 2019 15:03:19 +0200
Message-Id: <20190828130320.6174-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828130320.6174-1-linus.walleij@linaro.org>
References: <20190828130320.6174-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- No change, resending with the rest of the patches
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

