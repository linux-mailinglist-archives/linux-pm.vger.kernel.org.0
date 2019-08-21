Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C110196ED1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfHUB0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:26:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfHUB0y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so271017pfn.10;
        Tue, 20 Aug 2019 18:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUIlWS4ZBAH1cCjNMwdLECp6SwpPOYQCnCUOnwztQcE=;
        b=mJm74y2gMr77NhNSMvpFGC6L5X2r3wVfRNiCyOJl/JGz7kgvV3L6yQfBF0u2WMIDWS
         Z3Ol9clSTZtxbhMks9H9DML3fFBqRVf4wWTEk8KtZyWMw0SgxATQCE9KRmXr94A2aszF
         sIu9d7bte1TRXt8JVWISOylxxv6a9XUk8NCSGf/SSFxgwKHw2Is9r0AosnLpg6EOzixZ
         ueTj39ExrBmPMia9tVGaI7Yi6R7cMQArWreUCY/fwWaHycOnwl25g9xhaYy/tRfbP7hV
         YDIrhb1W3BWcw/hC7GPMLyNBycceFHsa2Gl8ObzS8sB1PkUBjHgIYgmB5CR2VD/5d8t8
         zmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUIlWS4ZBAH1cCjNMwdLECp6SwpPOYQCnCUOnwztQcE=;
        b=MUKv+CtiFFYyWlZc8VpdLa+lvwbkCiHjCQnvXk/p0IpdmZYisalsbsl/ZUsBC+Ow92
         UzoI+9pJDEyI1y0uNjpkpm352qD+aMOa5gIc+Ogi7tA6m8pRmJ929ZdNWBWLxcuZROSy
         N6AQHGlNn7xRiTPicFvynbvQOC0p89R5a6klmw7yua6ADdm37Yh6oSzULeYZ9EIwface
         zJKig+9aKQ4yvifNkWjzp9JCyqQYazNR3Jxvu1b9F8QLVX5kMBRrN0+0jVo/coKCHXa5
         +BXiwjSHjP3ydGLfjgvQDhgRPHHV2gTk39SmhSbUh1pdzC8npL6qFF+iFSpG9Bh1Aq5E
         C6dA==
X-Gm-Message-State: APjAAAXlh3atlMj2D6PJCkdnZo1H6mNU/8LmuK1KemjnBmmdMdykbJ/b
        ctOnjh5W3JTj/BRoksOVd1LGTrRxhHo=
X-Google-Smtp-Source: APXvYqxAPl7HUI42txJIOPn3z2SkK+0izmF6cRrW5dqTXjkISagMbVz5/jICkgpRbfkbaW+1HxTAxg==
X-Received: by 2002:aa7:9191:: with SMTP id x17mr33134504pfa.23.1566350813243;
        Tue, 20 Aug 2019 18:26:53 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 07/12] thermal: qoriq: Convert driver to use devm_ioremap()
Date:   Tue, 20 Aug 2019 18:26:07 -0700
Message-Id: <20190821012612.7823-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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

