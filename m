Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF21B0677
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfILB3s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:29:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39241 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfILB3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:29:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id i1so5992617pfa.6;
        Wed, 11 Sep 2019 18:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4mUcB54nLpC+ZyoXZt/bHFq0eABhEI73lwHSpgg/qk=;
        b=c2BUH1/WZdaQ/0RJOJAOzl530zehwT5imK4EkAXnf9SvCSQ5hCz/xqzkmkep7rst0C
         5x8ww8SV2SHzUzs2ahS4PcXA8PotgVTsBg7p+1aIscyRx3I8Eel7zZceEkQeK6pa31wn
         3Di/hLdmw7hnmw97++7XoOyU6FKeRM9LHEWN4WBgwwTznkF9XTHS/nKpZ8lhAH1k81dt
         8CJZKiR7UOSIRqgg7ubOgluknL2MhGYgm2Dg8UkP4ZMSmMRUaLLx/FBvYFTEeKL0NKfn
         5P6nn38Vz1YpiYvG5bVPm6Pwoc+QvwcMfdO2nK5DyENO9iqgalDhyG0TKPcbfmZdZ9qc
         TbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4mUcB54nLpC+ZyoXZt/bHFq0eABhEI73lwHSpgg/qk=;
        b=mOOc/uzzy6oxij06fSna7drgOB/h7nRAEyKUu60cj7x75iTGwS7GFpc6T8PKFCwuaT
         B9i8eVLV0I+CxIXQs5YkErphHJn1v4KG0ct6OUZlS9GrIj6ydNy8ppbX4LHamF5OpXcK
         pzlZu6QOAhwp8Fm3rDgMVtFKoGxXpCvIDPel+d+1TX6jEbJb+XYBhL1arf7ZemlIhQc0
         lTnpdw90FM43XAbulj01VC5aHM8HRUtB7+sner6RsIu6qjNnXURlFUq9Ru7smCOXFP/L
         83Q5mxiqJlYqpuoOkUouRDcUiC+r7/J6cI/ja52/6srlydsLy1I/hKGGq+paRSU6xwOW
         OG8g==
X-Gm-Message-State: APjAAAVZ4CieVoK4EdG9YWahioiyYXfw8ImU5D4KmFyUl7BLuYNfUsnr
        b/6nbFGz5s9pTYyj+/gb/xE=
X-Google-Smtp-Source: APXvYqwEwXi3Rjrj05uOLgVAxkeT8p3RCn3kmIDEqM4ou4ZhBLSaJ/+GEuEFklwR3CUFZ9M2yL2LGQ==
X-Received: by 2002:a17:90a:37d1:: with SMTP id v75mr8907481pjb.33.1568251787307;
        Wed, 11 Sep 2019 18:29:47 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u4sm20781699pfh.55.2019.09.11.18.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:29:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/12] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Wed, 11 Sep 2019 18:29:14 -0700
Message-Id: <20190912012920.29601-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can simplify error cleanup code if instead of passing a "struct
platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
pointers from it, we pass those pointers directly. This way we won't
be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
and need to have "platform_set_drvdata(pdev, NULL);" in error path.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 5b9f2a31d275..af596c3342d0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -144,16 +144,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 	return 0;
 }
 
-static int qoriq_tmu_calibration(struct platform_device *pdev)
+static int qoriq_tmu_calibration(struct device *dev,
+				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
 	u32 range[4];
 	const u32 *calibration;
-	struct device_node *np = pdev->dev.of_node;
-	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
+	struct device_node *np = dev->of_node;
 
 	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
-		dev_err(&pdev->dev, "missing calibration range.\n");
+		dev_err(dev, "missing calibration range.\n");
 		return -ENODEV;
 	}
 
@@ -165,7 +165,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-		dev_err(&pdev->dev, "invalid calibration data.\n");
+		dev_err(dev, "invalid calibration data.\n");
 		return -ENODEV;
 	}
 
@@ -203,8 +203,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
-
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -225,7 +223,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
-	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
+	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
 		goto err;
 
@@ -236,11 +234,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 
 err:
 	clk_disable_unprepare(data->clk);
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
-- 
2.21.0

