Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24A48899
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfFQQPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42107 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfFQQPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so6071754pgh.9;
        Mon, 17 Jun 2019 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUIlWS4ZBAH1cCjNMwdLECp6SwpPOYQCnCUOnwztQcE=;
        b=j57PaWe8f2HQwJIOYT9m1j5+oiTOKbhhzP7Ozk376nM+n+Ls/puznRCeBv7W333drA
         IaYsFgkX8QyDlD3FMfOwOK6hHn/FBbS/0tncMjXmet8AkakkYItNITaG2D33VXbDbOaj
         /wBDdyMVR9vtgDXKSCLo6CN8DI7pNp9uTSpyiRoOBf5/jm8lVQu3vbnABG5NxdEQrkQq
         SkfVW4m1ZIN/P4UZe3ZlLrzLh/eysa8W0tr05jH7WoQj4F9QcIR0ry8ut4D3IDfnsG4R
         Ebb403JTeg+Pgt58vuakR6N67dR9ndDXCoPoUkyX+EPjD4T3Yo66bmOXzYt9Y2gjpv8Q
         S2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUIlWS4ZBAH1cCjNMwdLECp6SwpPOYQCnCUOnwztQcE=;
        b=R42wPPFAWohyTvgdIHnKEuMYI3mEyjfvL+dxu31d3/pWmeHOVD8n9ombswZVEdQgvZ
         TlRngLuTsGgX1k38CkWO24qZwnzbX3V13QUuDvKNG5NNgUzqSAQDml7p0I/QBkceV1Cs
         WAdOYpXcdI9kWryoGfyFlZvqap6m2LkkA5EMws+MtQhjcH96kYiJPSboK9Uth8RiAnIS
         kZrS9yfVfdHsRBUfeCHqikH78ZwTHcLHknza4qLM8SXvVLLxd5ly4Q8HjqpsTybREKlL
         VEDS1d5QPyWL1Plan2IgbM8u2TYI9EcAHhp0I1G0auJTS2dEE+MuHEy1FNepi3pVQupV
         KKVw==
X-Gm-Message-State: APjAAAX1vhbZTuv7MzrHOfmKdgHhcqNjz6X7u0Vcy64iFMgc4YMy5Uf+
        RvkRht+xuYrne+XrQh48lAS6NGb+XHM=
X-Google-Smtp-Source: APXvYqwkerfFt6cakaHg8ZDVj307zJCQpqVA783kXNJ3k6RBBcXucdcuy1juvFY6vatC438NjAfLqg==
X-Received: by 2002:a63:306:: with SMTP id 6mr37099567pgd.263.1560788116897;
        Mon, 17 Jun 2019 09:15:16 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/12] thermal: qoriq: Convert driver to use devm_ioremap()
Date:   Mon, 17 Jun 2019 09:14:53 -0700
Message-Id: <20190617161458.3754-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert driver to use devm_ioremap() to simplify memory deallocation
and error handling code. No functional change intended.

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
 drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 62d7a0efb837..80fe9adcc313 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -193,6 +193,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct resource *io;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
@@ -201,7 +202,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
-	data->regs = of_iomap(np, 0);
+	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!io) {
+		dev_err(dev, "Failed to get memory region\n");
+		return -ENODEV;
+	}
+
+	data->regs = devm_ioremap(dev, io->start, resource_size(io));
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
@@ -211,23 +218,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
-		goto err_tmu;
+		return ret;
 
 	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
-		ret = -ENODEV;
-		goto err_tmu;
+		return -ENODEV;
 	}
 
 	platform_set_drvdata(pdev, data);
 
 	return 0;
-
-err_tmu:
-	iounmap(data->regs);
-
-	return ret;
 }
 
 static int qoriq_tmu_remove(struct platform_device *pdev)
@@ -237,7 +238,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-	iounmap(data->regs);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.21.0

