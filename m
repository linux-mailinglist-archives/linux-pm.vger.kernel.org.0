Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D02D8622
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 11:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392765AbgLLK6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 05:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgLLK6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 05:58:40 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD1BC0617A6
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:27 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a8so17982129lfb.3
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMHfnSbcVaDTuxTUMrUrYnMsvW1YjEn1yWzITGlL+i4=;
        b=MrHBFnkjxFT5sTku71LBP8cbf4gFqim5hKRuOYkUylL+cEL5C6Ogg60eDgYv5zY0Bp
         SNt+AwulO/d9Qo4GCYM1+HMkdzXuq/aIAjBY7+Zn7u44Vi9ijXnvt9SObs9AJxcE3olk
         JOtB16I4A1KRgsaxbOKSHkZMEZ0drMvv3MleIR4sQu7Pj7Zm4yRgZ5VgYR050OSJEWIA
         yX0vOw3JsVnf3cAR0hWaPI4Pwyl5pDWEFHc+LL3xk2H/lpRZ2RLSUjIBAFYkivfKLZzR
         NXRAncOhEDRhK15FspCP89by0hZrnGNF8xYcYvvVxUso0X9Ut2FVIJILyNqPXuyWewQD
         X4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMHfnSbcVaDTuxTUMrUrYnMsvW1YjEn1yWzITGlL+i4=;
        b=OeobMBiiBtPcdRe/ZsTfaf3WNEt+HjpBlHBmD3NdXNFNMQV9f8Q6m8p4kCiDVxueyw
         oZ32MkH/rZkh6rUd5Wh3vnrGqpu5/c2BSgShnrWS7vG5O4oNw9ey2AZuO36bGtYX1w4J
         JTxCH45IYS/6lt1M5LyTgA5lh0PDodJlguYeZw/002GzJVrC64WKkYwoJ3c9Y9G+AGlz
         XOR+RNxtOwz1YFPtDnijXgGUCMsxjiyezm4808edhVhLQOTC82n3WL0yqmyfQtp7lWtx
         s4b82r0PBovnWp22ykqBsOXLduEbrpWrqF/mgy4w7tRicAw4h3CKkuF38aBTC5lTKFdP
         yp9g==
X-Gm-Message-State: AOAM533zJSsbgYJrhgd9uCrVI5GphMklUKE1tMqPT0VWnvKVQuq4ny+e
        Td4iU1sqepQapxmxjvdFD0n9gg==
X-Google-Smtp-Source: ABdhPJxl/7Rvg48+HNZJ08G6i67sx4NpV5DdxcVih+bQ7klApoN7KM+7W88ADKKpj7Yb841P436nFA==
X-Received: by 2002:a05:651c:3db:: with SMTP id f27mr6927728ljp.494.1607770646463;
        Sat, 12 Dec 2020 02:57:26 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j2sm490674lfe.213.2020.12.12.02.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 02:57:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] power: supply: ab8500: Use dev_err_probe() for IIO channels
Date:   Sat, 12 Dec 2020 11:57:12 +0100
Message-Id: <20201212105712.2727842-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201212105712.2727842-1-linus.walleij@linaro.org>
References: <20201212105712.2727842-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code obtaining the ADC channels is outdated: it is
trying to work around the IIO subsystem not returning
the right -EPROBE_DEFER error code. Fix this up
by using the dev_err_probe() helper so we defer silently
where appropriate and not bail out if the IIO core
returns -EPROBE_DEFER as happens now.

Cc: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_btemp.c   | 14 +++++-----
 drivers/power/supply/ab8500_charger.c | 37 +++++++++++----------------
 drivers/power/supply/ab8500_fg.c      |  7 +++--
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 1f8fded47b2e..a9e53fe0244b 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -1023,17 +1023,15 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	/* Get ADC channels */
 	di->btemp_ball = devm_iio_channel_get(dev, "btemp_ball");
 	if (IS_ERR(di->btemp_ball)) {
-		if (PTR_ERR(di->btemp_ball) == -ENODEV)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to get BTEMP BALL ADC channel\n");
-		return PTR_ERR(di->btemp_ball);
+		ret = dev_err_probe(dev, PTR_ERR(di->btemp_ball),
+				    "failed to get BTEMP BALL ADC channel\n");
+		return ret;
 	}
 	di->bat_ctrl = devm_iio_channel_get(dev, "bat_ctrl");
 	if (IS_ERR(di->bat_ctrl)) {
-		if (PTR_ERR(di->bat_ctrl) == -ENODEV)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to get BAT CTRL ADC channel\n");
-		return PTR_ERR(di->bat_ctrl);
+		ret = dev_err_probe(dev, PTR_ERR(di->bat_ctrl),
+				    "failed to get BAT CTRL ADC channel\n");
+		return ret;
 	}
 
 	di->initialized = false;
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index d4b7bd68451b..ac77c8882d17 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3375,36 +3375,29 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 
 	/* Get ADC channels */
-	di->adc_main_charger_v = devm_iio_channel_get(dev,
-						      "main_charger_v");
+	di->adc_main_charger_v = devm_iio_channel_get(dev, "main_charger_v");
 	if (IS_ERR(di->adc_main_charger_v)) {
-		if (PTR_ERR(di->adc_main_charger_v) == -ENODEV)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to get ADC main charger voltage\n");
-		return PTR_ERR(di->adc_main_charger_v);
+		ret = dev_err_probe(dev, PTR_ERR(di->adc_main_charger_v),
+				    "failed to get ADC main charger voltage\n");
+		return ret;
 	}
-	di->adc_main_charger_c = devm_iio_channel_get(dev,
-						      "main_charger_c");
+	di->adc_main_charger_c = devm_iio_channel_get(dev, "main_charger_c");
 	if (IS_ERR(di->adc_main_charger_c)) {
-		if (PTR_ERR(di->adc_main_charger_c) == -ENODEV)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to get ADC main charger current\n");
-		return PTR_ERR(di->adc_main_charger_c);
+		ret = dev_err_probe(dev, PTR_ERR(di->adc_main_charger_c),
+				    "failed to get ADC main charger current\n");
+		return ret;
 	}
 	di->adc_vbus_v = devm_iio_channel_get(dev, "vbus_v");
 	if (IS_ERR(di->adc_vbus_v)) {
-		if (PTR_ERR(di->adc_vbus_v) == -ENODEV)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to get ADC USB charger voltage\n");
-		return PTR_ERR(di->adc_vbus_v);
+		ret = dev_err_probe(dev, PTR_ERR(di->adc_vbus_v),
+				    "failed to get ADC USB charger voltage\n");
+		return ret;
 	}
-	di->adc_usb_charger_c = devm_iio_channel_get(dev,
-						     "usb_charger_c");
+	di->adc_usb_charger_c = devm_iio_channel_get(dev, "usb_charger_c");
 	if (IS_ERR(di->adc_usb_charger_c)) {
-		if (PTR_ERR(di->adc_usb_charger_c) == -ENODEV)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to get ADC USB charger current\n");
-		return PTR_ERR(di->adc_usb_charger_c);
+		ret = dev_err_probe(dev, PTR_ERR(di->adc_usb_charger_c),
+				    "failed to get ADC USB charger current\n");
+		return ret;
 	}
 
 	/* initialize lock */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index d1b68acac427..3873e4857e3d 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3059,10 +3059,9 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 
 	di->main_bat_v = devm_iio_channel_get(dev, "main_bat_v");
 	if (IS_ERR(di->main_bat_v)) {
-		if (PTR_ERR(di->main_bat_v) == -ENODEV)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to get main battery ADC channel\n");
-		return PTR_ERR(di->main_bat_v);
+		ret = dev_err_probe(dev, PTR_ERR(di->main_bat_v),
+				    "failed to get main battery ADC channel\n");
+		return ret;
 	}
 
 	psy_cfg.supplied_to = supply_interface;
-- 
2.26.2

