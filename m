Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C696ED0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfHUB0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:26:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37614 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfHUB0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id bj8so387351plb.4;
        Tue, 20 Aug 2019 18:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3ThpDDnRPQKbzTx4rzAtkgeF/0VhzJtrp8/5fptPe8=;
        b=OlzGL1HmjsNys68Q5xVKMVXWgE8kFHWgVuwUM/iJn0s11XjN+ZX8pA22Ig6b8zD/82
         s0f21GK9rRZYmGiMPBG1clN1D0fc1Iw/n35NpZPgRVzbozfJ5QjFSo3OacNJ7CePtBLc
         rD+Kmt56t5jhJtVm5wkeRRuaWQ1/rk6xtcH0PISLcLRjSeqeE4FZqCeAxfOTPciDwyky
         2wQuVMCEQQC/uT5urEpfc/ZQwHkPy2xFGY+Wl4KYp/tcZzL7/NPLd+YoSS9EVLjoc9JG
         W0CSHDTMd5SRhoKjqHj49tJYujKD3U4a/VNYtiZMO2oKj1Lvum3yv1A6uQuyFq3Ve7fj
         R2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3ThpDDnRPQKbzTx4rzAtkgeF/0VhzJtrp8/5fptPe8=;
        b=TGFxS9NdNw4c712zPTRQqZT0RuzeFIdbxwj/mMu+arDUTTgb58sPS1nUdz3HkzKJqf
         4n3HzOqx16DyyaLuuFVwvgpEYuU+e8LLTU4Ci/4urB7VIUJ6rZtCbJung85i8MZoNmKY
         Jhz2InWQGJosjwKxbw8nBi4tBtT1qothKsFfXOyfcI9fanwDe08mvMYRBe5xi2Pdpdxk
         jt2poo1oACjHAmYSUvROG0/lRDXFk33VCIaJwUzb3opKfX82jDOQ+foz0Y1//5Wjl8X+
         njSN0L/q9hlsI/rMWF4SHk1W425amvmlKERsvPr8Mplp8Xj2qLJ8OUW9lU7uEZaI/K2e
         xj0A==
X-Gm-Message-State: APjAAAXJkl/5jafsqKe+n9nM6IjLXAsmvycCjMxqOL5Gx1vq2ir1qW9c
        m66nJP1BMFVnbdt0gYGNMQQplYq4CF0=
X-Google-Smtp-Source: APXvYqydvvxochp3aT/AKNQvC61LdEXbZDfhrrdqA0dX2cBChJq7Jmz4USwN+/0P8yHfrqswD+2+Gw==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr1545786plc.189.1566350811964;
        Tue, 20 Aug 2019 18:26:51 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 06/12] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Tue, 20 Aug 2019 18:26:06 -0700
Message-Id: <20190821012612.7823-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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

