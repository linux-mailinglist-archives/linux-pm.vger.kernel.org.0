Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9340B17497C
	for <lists+linux-pm@lfdr.de>; Sat, 29 Feb 2020 22:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgB2VHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Feb 2020 16:07:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43911 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgB2VHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Feb 2020 16:07:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id e3so7294761lja.10
        for <linux-pm@vger.kernel.org>; Sat, 29 Feb 2020 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pmCCLLeFby061uzvWmm7bOkE7y8qiya2C+8xwEKg3vQ=;
        b=ClSC1Nbaxdx+T3FFYWNlBtwk1H+p1PPHhAAIAYoDCtKj6QZS+3ENlcUbsmR+yd4Pks
         E5Y2ysaClelsIdXc/TEEGkWV2Gq7sIiP0pzc3BZ6GqnQnCwxTeEFoqW2odSmkrVe0H+g
         0TdIhlIK0mxngB/BrxnaU667b+wIqRvrO0DPJTSeaU0/OxGVgKFCF/WGgwB2FwZJ1HVW
         AkLgsgj8BLcAqN2jBhoxakrWAq8qZaMny1I0OaBgl/nSKOMmzY4//9zEgSPzGPRuGOyC
         CjCfJdaahUrQvBHTUv7R7IBK7EF5GniUf3ZqUazIo9Tuvex5qZBaIN9N0XwJTGAiuOOn
         CXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pmCCLLeFby061uzvWmm7bOkE7y8qiya2C+8xwEKg3vQ=;
        b=LT6+JSLrVimLPEvdUm03+MTfYR6cwBOZH78tbGIT3KwIdy4LzAPs/qJShTE4Eu/pRK
         Kof1ac9gLPepOAEpxuCV+Gx14fGoxRDbE9BQGXujegRMPEoTI2LOSzDeGUTnn9iKuDTP
         tRebRWjhsW117S4X5q89JIIcLH5pTnYLn823P9gKXrMfyU7W8VmX34VFN3ozPgJ2DTKW
         Ti8sjUCxIor9sCJ3jap84r6j550PXJmjQlnW7foHbsE7nbJkUC2ObtqTZhDLCTfEbybR
         HYTfS6pPSyu+RueibpjVTDqU/t+azMt+2DRzSo5aNbLFUS5nSkqyXTfG3gXLgc0x1DKn
         3AyA==
X-Gm-Message-State: ANhLgQ3qkjoHMdEDQ0SlyS+B4b2IxYZAtVeIKxWOFfoqHxPa8bttzH5F
        zPYObJ+aPzJm/XSSVtzMWnU62aCB3Do=
X-Google-Smtp-Source: ADFU+vtRcYKaUzY1HmA0PEOSPLbBrqc2W7EXTrFjt5B6sR5IlS5RaNSgEXbisl5uvWOOxKJSPJjFAw==
X-Received: by 2002:a2e:8e31:: with SMTP id r17mr7230452ljk.211.1583010455809;
        Sat, 29 Feb 2020 13:07:35 -0800 (PST)
Received: from localhost.localdomain (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id s8sm8678137ljs.45.2020.02.29.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 13:07:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH] thermal: ti-soc-thermal: Use GPIO descriptors
Date:   Sat, 29 Feb 2020 22:05:32 +0100
Message-Id: <20200229210532.173430-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This switches the TI SoC thermal driver to use GPIO
descriptors instead of retrieveing a GPIO number from the
device tree and requesting the GPIO separately.

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 44 ++++++---------------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h |  4 +-
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..263b0420fbe4 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/types.h>
@@ -24,7 +24,6 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/io.h>
 
 #include "ti-bandgap.h"
@@ -743,27 +742,13 @@ int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend)
 static int ti_bandgap_tshut_init(struct ti_bandgap *bgp,
 				 struct platform_device *pdev)
 {
-	int gpio_nr = bgp->tshut_gpio;
 	int status;
 
-	/* Request for gpio_86 line */
-	status = gpio_request(gpio_nr, "tshut");
-	if (status < 0) {
-		dev_err(bgp->dev, "Could not request for TSHUT GPIO:%i\n", 86);
-		return status;
-	}
-	status = gpio_direction_input(gpio_nr);
-	if (status) {
-		dev_err(bgp->dev, "Cannot set input TSHUT GPIO %d\n", gpio_nr);
-		return status;
-	}
-
-	status = request_irq(gpio_to_irq(gpio_nr), ti_bandgap_tshut_irq_handler,
+	status = request_irq(gpiod_to_irq(bgp->tshut_gpiod),
+			     ti_bandgap_tshut_irq_handler,
 			     IRQF_TRIGGER_RISING, "tshut", NULL);
-	if (status) {
-		gpio_free(gpio_nr);
+	if (status)
 		dev_err(bgp->dev, "request irq failed for TSHUT");
-	}
 
 	return 0;
 }
@@ -860,11 +845,10 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
 	} while (res);
 
 	if (TI_BANDGAP_HAS(bgp, TSHUT)) {
-		bgp->tshut_gpio = of_get_gpio(node, 0);
-		if (!gpio_is_valid(bgp->tshut_gpio)) {
-			dev_err(&pdev->dev, "invalid gpio for tshut (%d)\n",
-				bgp->tshut_gpio);
-			return ERR_PTR(-EINVAL);
+		bgp->tshut_gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
+		if (IS_ERR(bgp->tshut_gpiod)) {
+			dev_err(&pdev->dev, "invalid gpio for tshut\n");
+			return ERR_CAST(bgp->tshut_gpiod);
 		}
 	}
 
@@ -1046,10 +1030,8 @@ int ti_bandgap_probe(struct platform_device *pdev)
 put_fclock:
 	clk_put(bgp->fclock);
 free_irqs:
-	if (TI_BANDGAP_HAS(bgp, TSHUT)) {
-		free_irq(gpio_to_irq(bgp->tshut_gpio), NULL);
-		gpio_free(bgp->tshut_gpio);
-	}
+	if (TI_BANDGAP_HAS(bgp, TSHUT))
+		free_irq(gpiod_to_irq(bgp->tshut_gpiod), NULL);
 
 	return ret;
 }
@@ -1079,10 +1061,8 @@ int ti_bandgap_remove(struct platform_device *pdev)
 	if (TI_BANDGAP_HAS(bgp, TALERT))
 		free_irq(bgp->irq, bgp);
 
-	if (TI_BANDGAP_HAS(bgp, TSHUT)) {
-		free_irq(gpio_to_irq(bgp->tshut_gpio), NULL);
-		gpio_free(bgp->tshut_gpio);
-	}
+	if (TI_BANDGAP_HAS(bgp, TSHUT))
+		free_irq(gpiod_to_irq(bgp->tshut_gpiod), NULL);
 
 	return 0;
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index bb9b0f7faf99..fce4657e9486 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -13,6 +13,8 @@
 #include <linux/types.h>
 #include <linux/err.h>
 
+struct gpio_desc;
+
 /**
  * DOC: bandgap driver data structure
  * ==================================
@@ -199,7 +201,7 @@ struct ti_bandgap {
 	struct clk			*div_clk;
 	spinlock_t			lock; /* shields this struct */
 	int				irq;
-	int				tshut_gpio;
+	struct gpio_desc		*tshut_gpiod;
 	u32				clk_rate;
 };
 
-- 
2.24.1

