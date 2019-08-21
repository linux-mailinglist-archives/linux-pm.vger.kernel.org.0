Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFE96EE3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHUB0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:26:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35999 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUB0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so330621pgm.3;
        Tue, 20 Aug 2019 18:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/Aa9vwcoAMXBLeFkFUyEGUfoQF1uTYSZwVAiF+3Oqc=;
        b=NiRm4AddEOV5OZcFzN6/dbub2RbA+oAGxlFb0dTxj/bKrRF/7gkN73fHJNVx09oIed
         XGI+wXvuxHLaj8vWbfjqKouV7KewPoagi1xiNXY4QAOsaYL1pP6jvoJvcZPNFRH5uH+9
         pdvDqQRO5rdNgaJMHtCbog1CdHJpzfatSd72keqSF+Hu+z3I3xt+kdeXtZ3fa5wKd5np
         NMZKORSjNLId0xGoTiXrB94T4/FsKKm9Lj4K1KHAgfirjSZW9Hz0pHlAQHvRaG5SyYyK
         D8MwMDHbWrE8aIdkOpIdJJyGzHxZtbckSglgZUigOfeXj3GaFCS8eA/wseQk8NQVilbu
         h2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/Aa9vwcoAMXBLeFkFUyEGUfoQF1uTYSZwVAiF+3Oqc=;
        b=hDtOrs6XbVGkAkjwbt5mhIIQHYKFOMzQMvz2a6CvpJblRy82WYRCDIs8TarjZWskaH
         t9A4+dZExToF4kEkLoi1BjUETllhPn7kyCs654PXfNMIX96iS5j8+AefXi32DWQknd3p
         dnoxrQQo0Se8+tIArQYYOmuaCikGxg9CeYBNuD4Sb+ll86gBBqi6kGULbun9IuWnKaBu
         uD5RkA87OBrjpFsmubx0AgdGhZ33YI525to8uH5Din9UxAtF6NOIW7fHXHyEUjwo7gCw
         T0dIWMIbnUStVlUhOxGsfuZPMKedalHHbgQ6JPjzsQSarWdhKlVS3LG5vM6EW6LiyXDG
         /jKw==
X-Gm-Message-State: APjAAAUD6b1mNroO0nHWZWvJoGN5ckpkZbIGXZDAREVdij4JWmPtQXHP
        7c5lot+Ur11tQRgBeBKKkWr2iAZdUsw=
X-Google-Smtp-Source: APXvYqxSlgsBQ93MTfwfxErQCaf02KBNyvK13ve/GW+UZvYzK1v0i0gMlLyExLzgMr1FdolpEtudIA==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr2944127pjw.15.1566350805284;
        Tue, 20 Aug 2019 18:26:45 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:44 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 01/12] thermal: qoriq: Add local struct device pointer
Date:   Tue, 20 Aug 2019 18:26:01 -0700
Message-Id: <20190821012612.7823-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use a local "struct device *dev" for brevity. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
 drivers/thermal/qoriq_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7b364933bfb1..91f9f49d2776 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -192,8 +192,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -204,7 +205,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
@@ -217,7 +218,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_register_tmu_zone(pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register sensors\n");
+		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
-- 
2.21.0

