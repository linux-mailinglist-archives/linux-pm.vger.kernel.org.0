Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC6488A5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfFQQPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfFQQPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id s21so6063892pga.12;
        Mon, 17 Jun 2019 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/Aa9vwcoAMXBLeFkFUyEGUfoQF1uTYSZwVAiF+3Oqc=;
        b=GlT2ug/HSjv4GGon437P/ehTwiRLbxG6v5lCkV5vMKCNl0qO+mvmfX7iEM9KIooYdt
         KGXYW2jaN3sITlepnDl5qKIrHTF+C2gn6jutz4WgIvAWHjXTy3hknf5Owo4jiIQECcuf
         nTer61WeBlfYOSzGsMiZ646Dn2OfFLfHO6doVlvgT3Z5tikR7QWHbpTYSnUlUBvp2CDT
         Jce2VIWwhSv7aq4HiEJGiJqPt5jlka8t+NoOqFKdNeJ67SfdqMkrbfuOBeXV4gKn4DuP
         4QhKbVQT1aV0uq8ZRrGNYOjWJtkgtes1OvvNl2wbU7rUG/ccsYSnj0R0iqFAZzW0Jmwh
         ysaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/Aa9vwcoAMXBLeFkFUyEGUfoQF1uTYSZwVAiF+3Oqc=;
        b=DZkYPQf3H3LUOOUfBKZeSO/6JcxQH72kXRRKrMoih32yevAJKR4WlNIAvahvT4vRMH
         gZ5sUMyz3v5nWbyxhHB95dUVpDxA/l+OszHLKIMHZFuke6S+CTA+5AsrRDMYso3Qdrd6
         1IqfQokN/h9+XqZ7LMLltp4EvsAS/RA9h//HgZKOPR32JzhBZlH7+T8LgsW1SO+OXD5a
         zWMPwcpdQrULVYHNyaxmT0yWhnwR/a+zI0HNSViDw2WMMO5twIzKwslPyb/6/GWAnho6
         ch9u88b5beQXEXPJyTPTlTB5sZ1PmsWA2jqu6Jc7OEyq5oWU6F2R+YkXN3BpjkRsFQLh
         qhNA==
X-Gm-Message-State: APjAAAUfdRDYo6Duill+lZZWXQ8l4NjgmlFYS/WmQytfODi1a/BVPADX
        X/aEjjwRDJR5ANO7uAFPMSuy0VAY79U=
X-Google-Smtp-Source: APXvYqyBLDInGrf+gDcwc8xUoXlwkGbgBzs80bwXB54WWnxwZECvnFj7lUaXPwumdRxpgpIC4R8DAQ==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr27367435pjb.115.1560788108703;
        Mon, 17 Jun 2019 09:15:08 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:08 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/12] thermal: qoriq: Add local struct device pointer
Date:   Mon, 17 Jun 2019 09:14:47 -0700
Message-Id: <20190617161458.3754-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
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

