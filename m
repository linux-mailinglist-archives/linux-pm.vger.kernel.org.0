Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6013B6B6B1
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfGQGes (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:34:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32769 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQGer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:34:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so15619737lfc.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 23:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RneXg/3PcSiBdiN1Yij+yIhb511n0iX+fkkd6qMaq/c=;
        b=GaXmGqUcaeItB1qbHommjcNkWXhHLsbY8+iv9qwigbYeYhFjrKbnC4TM7f9XOsGkgu
         /urZAsaE/V051u+boHI+IV1BAtXoE9SB71R7lT8ZZdRJKPAmPlrWodDq7YZ6Ujw/epcm
         KzfPxLFGEMQZcs2hybydZc3jEeYLVw/RLjLqE/DSiCa+Z3YsIuNXpwcY+fUaMmHp3p2V
         N66Kz12XPE1aKM3WgWgjFtSW+2u2cxvRjuwVE+97FK8vnrxSCss3jjCnQpQhiupUhOI9
         AGvOL7dyuKOsbeahrIO3KkdXB8EIIDXkTuvwpRBm8k/PkKnY+AnTsmACxJPBK6jEDtC0
         aneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RneXg/3PcSiBdiN1Yij+yIhb511n0iX+fkkd6qMaq/c=;
        b=LXaGcx5QWhNDwDsurXbBxuy23Hyc00lKWWT3LiACc9/pkHwttKSjEduO+pNV3Jk5N3
         Ng0QOaa4hGl6q+K340UDyoLITgtNB2yl6GjXX9hed21DzfCdfd/tJ/WYFhqinTLSvM/W
         LnpVzxOu6O/CDtbzoQtTRlm32qbvyu9fwTD4DU54CkdcminbTWsAchpf3kAAOOOteX+B
         NZkVzoxiKwBOBcE1F4QxP8lqPJjyYKPUQAMJfCKTVNI+I/s+2FYDHf9H4PwVaTyJd2bL
         OXk0cc/ztrLShKrMDmkacGXjVbWUnQUU3cA+UQbmwXiOzdd6VEgzgnB6ttMIqdf4pc+5
         oLzg==
X-Gm-Message-State: APjAAAVvZGR4vHtenLvfQjiZ54JCHPkepq5Cv7gTYpFHQrRXRTpvCztq
        WxG0OHMbeADXMA3V70QGNTJCChiQGeI=
X-Google-Smtp-Source: APXvYqx9hF4VJ+vzqac4RGqUC1OAiTvXFqPrSSGqWdg/90JVYfy2AnEswwo2f+sYA9JYr6s1cBLhUw==
X-Received: by 2002:a19:f806:: with SMTP id a6mr3365442lff.102.1563345285056;
        Tue, 16 Jul 2019 23:34:45 -0700 (PDT)
Received: from localhost.localdomain (c-22cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.34])
        by smtp.gmail.com with ESMTPSA id z22sm4277827ljz.20.2019.07.16.23.34.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 23:34:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] thermal: db8500: Use dev helper variable
Date:   Wed, 17 Jul 2019 08:32:22 +0200
Message-Id: <20190717063222.5902-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717063222.5902-1-linus.walleij@linaro.org>
References: <20190717063222.5902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code gets easier to read like this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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

