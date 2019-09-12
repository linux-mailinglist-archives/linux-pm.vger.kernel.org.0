Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2310BB0670
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfILB3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:29:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42599 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfILB3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:29:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so923079pgp.9;
        Wed, 11 Sep 2019 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VJy9i5pIbM5WNGgof53pW2sqA3Pbpe145dB7ml+l1o=;
        b=izFFHNSKXEvD/z+1VtUk2pWkt+Nw7qu9AdqbgJ/ORutcw2oAkpkVLrqCk1PaNJYE1n
         toszDkDjwvt8dyvkaaWbAeNqLIAiJZzpEW770dmzObOPydQ1bbvVqvGpr1m/oA9eKV2g
         kbx7Vh2tIWH4Ng6Z1V3Tdpa0YQBmY1SdSJ2HmfpnmXK1oNhGNnyhhqvzx2kl03YgLYhg
         derYNSF354CR7GtdMA2gz7auNwg0mYfOJRqkAlaAPc1u8NStZ9X0yOMXEJE1xUArnasM
         khw73pM8rCKGP1ZyU99GjrWggz6JOMqO/Nb6taN67FP1045UuCNdwZCCNc0+bT8C8nV0
         fEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VJy9i5pIbM5WNGgof53pW2sqA3Pbpe145dB7ml+l1o=;
        b=ZEuz0q5+ThqCS0AHsGX9F5DU9KSbocpK6Zw+Ue5j13YEaOWoUpIPeDXt+S14VMdERH
         +fZqMFFyQo6VqhHSDYuCZzJ+W4j6bBUBu1BVPpMfLPRKXxDlyMWCe4s4zrdF2i7RvLqn
         WVK49mMzXmoC5NismvHmTDYSJvGkpqyQEOFmCNJEXe+o4puQ+CaeIx50nXBs/IsPNwLs
         3WMFLUD3fGhpip7x5Sp3v8SbAq1MugyeP+exA3iM5DEvOCeH/kXy97103OB6yenjskAN
         jCszk0fh8G9o+loJ4lQyiWn7OkBgzww7huqDHascCIwc52cH+hRj9LBZypql1dESXzRn
         9lPg==
X-Gm-Message-State: APjAAAUjJJwI6zQT8DkKBFRqInNM2SGEhydILFgkOq8hT2yOziBRV7OS
        ddRMLxqmwkC0moJtM0KSvQU=
X-Google-Smtp-Source: APXvYqxwfFsxJG8YLlAlSab0VGffBXj7Rxlfopl95n5LXHm+9R9euoL2j4wSwehIq3yrVVpDugO5ag==
X-Received: by 2002:a63:2a87:: with SMTP id q129mr36582485pgq.101.1568251779423;
        Wed, 11 Sep 2019 18:29:39 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u4sm20781699pfh.55.2019.09.11.18.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:29:38 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/12] thermal: qoriq: Add local struct device pointer
Date:   Wed, 11 Sep 2019 18:29:09 -0700
Message-Id: <20190912012920.29601-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 39542c670301..5df6267a5da0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -194,8 +194,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -206,17 +207,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		return PTR_ERR(data->regs);
 	}
 
-	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	data->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
 	ret = clk_prepare_enable(data->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to enable clock\n");
+		dev_err(dev, "Failed to enable clock\n");
 		return ret;
 	}
 
@@ -228,7 +229,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_register_tmu_zone(pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register sensors\n");
+		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
 		goto err;
 	}
-- 
2.21.0

