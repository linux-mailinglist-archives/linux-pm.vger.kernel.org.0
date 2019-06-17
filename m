Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED174889F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfFQQPl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38995 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfFQQPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so6090460pgc.6;
        Mon, 17 Jun 2019 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3ThpDDnRPQKbzTx4rzAtkgeF/0VhzJtrp8/5fptPe8=;
        b=RPz8tTkcCddONQzDMT/q8CqZNTRdbPgka+mvvwfyWNxbVk/nBYOe1BSKv/Q3sKVsnL
         dbyq1yQrHo6sJb3dhzUiRnDhn0YAZBRfVaAM1QnEnt0l48jnsoGw+QaV1e4xRcTthR9n
         bSvDpCxAvMDYKQWlmEFBM6i+6gX0xusJdmtL93AWFrpDWBZ+vB/JHcCI3iKXTN6vbxVh
         dZRBst4on0cVViSCYeKAnvMJ6GrkkT8/YKA2sK6PRADGuGp2ilMl6LCaSCI54OVWlsmI
         qpGU5ciHwfLQy9obEuXQ/sXC8D52ac238kiw1FESOyb8ILMxw9dnoSNEZcgDYWxh6EZN
         5fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3ThpDDnRPQKbzTx4rzAtkgeF/0VhzJtrp8/5fptPe8=;
        b=DZ366Tgif/ZSxWNbn9mOocSQ1DZEPeLm4wMnZ6HwCOarf4n40B4v665QjXiueRXp9t
         G1w6F26QFMYEmgpI6xhoGxPQ8BvRO8az3NwCn+I2Y8M3jKgOt8OxxOi3U4zMh0JEJRs1
         HkNk0MJy1FPD2z4uyrbZZVhLzGhaqJGGX4zS3SSyZCTNLQRqicZD+U6pxOc4tOZ68Dgx
         fkKTdFbUTIyoDCRi4R+zCzUU4rguQVt2eqHGEkXDPSurgnnGfjQVU9mV1NhHwKtzjc+Q
         coz1ugcl4ijLegkpf9YySejimS6p47W4q3sA8TFUcNM3ATbk3eDAaPUImr/IonLc+9X6
         87bA==
X-Gm-Message-State: APjAAAUFWBaHeAv+3vR39CusEta2C4OxZdrKDDknf0KrsuDcVm4HPhke
        t+hEO6Q10gupxWHrD1aLTyZ5fssoL9w=
X-Google-Smtp-Source: APXvYqwLOy1KkTD5XkOBbNePjArm5QKg4neNceOt7dCkNDi6hpa9pR2n3MsaXoGIEmCaysp4fuueQA==
X-Received: by 2002:a63:81c6:: with SMTP id t189mr48956019pgd.293.1560788115581;
        Mon, 17 Jun 2019 09:15:15 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:14 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/12] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Mon, 17 Jun 2019 09:14:52 -0700
Message-Id: <20190617161458.3754-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
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
and consequently would be able to drop the "err_iomap" error path.

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
 drivers/thermal/qoriq_thermal.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 61700881d9f0..62d7a0efb837 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -140,16 +140,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
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
 
@@ -161,7 +161,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-		dev_err(&pdev->dev, "invalid calibration data.\n");
+		dev_err(dev, "invalid calibration data.\n");
 		return -ENODEV;
 	}
 
@@ -199,20 +199,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
-
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
-	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
+	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
 		goto err_tmu;
 
@@ -220,17 +217,16 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-		goto err_iomap;
+		goto err_tmu;
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 
 err_tmu:
 	iounmap(data->regs);
 
-err_iomap:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
-- 
2.21.0

