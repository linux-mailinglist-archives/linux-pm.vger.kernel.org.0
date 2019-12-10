Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685CE118DFD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLJQms (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37236 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfLJQmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so95716plz.4;
        Tue, 10 Dec 2019 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsWFQ3Z6EFYQnpUSOkIidynsctL0yAXSVPN00DmSMSU=;
        b=RR/KqD97Nx8ISod240BNcDjZXFkKcI0DWk6K49ikM67NadPyaq/H7rGl6G2+dg3NR3
         I3TIpjyFvX4cpzLkwPah6kiozSbk9KCqHuMx/Fk3e591bY3CYakTWJi7rhrjbKXZo+mV
         Bbw75Qxxamx9g58hQ/77KwRR5HzA9VfOUJAnO3fTGP3rZtxKjveJ18GIphcY9+v+yWkx
         RZ1L2Zo4AGUp1eNeFegOfY4nDPAVdBsbX0ycAu3xI6R+Hvj5Kn+xbs5OLkqhr5AxCgye
         l15W5iS8fEMJ3tRJIkMo2lOio0gK8NfjmU5/L2DYvo9Nb+EkofqJ0goGjt2Up4t+B/Ed
         jbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsWFQ3Z6EFYQnpUSOkIidynsctL0yAXSVPN00DmSMSU=;
        b=UIf+Xafjt6+JCL5Xe+M8BgAwtAU8EVUgEY48SPJo8g04qR2HWDmmpX+gLcAxbSe5zh
         IipqHbAZANMhwsDQaYq+3yHXW6eKH1YRieSA4Do7MXgM6B/l4UnlzobR7Wvrix8kAIK0
         Km7IvAq7juBkueBUbO7g4u26iZVyRIl+ChTim+EFAm5KyXWsj0SiZ1oA2sFiOrWqwxYe
         7ZOxu5yRJ22cn5QpzDGKJ9wAxbA+zA157yLpCtdef4G1DUJTNzxaPcKPeA8lQj0gHu15
         e3h7FF7t4UD/f77HVtCQ/J9Cc2kPlTdD9fze1VeuTNmXeWwZDFtSLodbWRE2dqnRlgHx
         29uQ==
X-Gm-Message-State: APjAAAXgN/9zN5Qa5GzAmNgGiLJ3dE9uM7l+5f957IiGUPAR6IOgKush
        soQ5Sj3Ib9FtoDjq1VecBkE=
X-Google-Smtp-Source: APXvYqzRGi+EksK6arKc90+mQhmy0P0yiIltqzJBfTr2fQ97XZupoJeod/TKokNSS4J+V4eeJ8FegA==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr6310012pjs.51.1575996138248;
        Tue, 10 Dec 2019 08:42:18 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:17 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/12] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Tue, 10 Dec 2019 08:41:47 -0800
Message-Id: <20191210164153.10463-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index f024ac68e2ed..de8c9cd115aa 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -201,23 +201,23 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
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
 
 	len = of_property_count_u32_elems(np, "fsl,tmu-range");
 	if (len < 0 || len > 4) {
-		dev_err(&pdev->dev, "invalid range data.\n");
+		dev_err(dev, "invalid range data.\n");
 		return len;
 	}
 
 	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
 	if (val != 0) {
-		dev_err(&pdev->dev, "failed to read range data.\n");
+		dev_err(dev, "failed to read range data.\n");
 		return val;
 	}
 
@@ -227,7 +227,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-		dev_err(&pdev->dev, "invalid calibration data.\n");
+		dev_err(dev, "invalid calibration data.\n");
 		return -ENODEV;
 	}
 
@@ -271,8 +271,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
-
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -299,7 +297,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
-	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
+	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
 		goto err;
 
@@ -310,11 +308,12 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
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

