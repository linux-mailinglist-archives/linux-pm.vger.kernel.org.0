Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E02D8621
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 11:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393911AbgLLK6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 05:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392765AbgLLK6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 05:58:40 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F94C06179C
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:26 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 23so17962733lfg.10
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlBoKDqFhqpfZF4qBQ5hZ7IttfE84hn1sKPugi2k9fY=;
        b=oP4cJ/slP1g9dOQiY6DJb76V3JMwSW1GI+BBD09qEu+ZpWXtp87AYxMip5zkv1Tgk/
         D7ffU4b8hNkWf8te3yq4lcAog0Rm3TmtnYe+F4GYrY7gim6atbtjV0UE3mFd7/L19Ich
         VxZ8HcQPKV6VDE/dtBUInb5T7UJe48gaQhgFACC13k93pYOo0FmEGuLDaRX66CjgEOjs
         4dcDcEw3PYxXyN4rV3WQg3LoJlsk6YvgLFteRRMuk0xZXf9aGPzjX/ch7c0sgN47gOfq
         OahzxtCF7ZN/c5PntXLuhPXEWkcXE/yDhhcTjhQ1rLnQnNxV4uIDpSynCuP+v3xvFSb/
         F43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlBoKDqFhqpfZF4qBQ5hZ7IttfE84hn1sKPugi2k9fY=;
        b=ZntXI0bbIp6FzwzBoyIhQIjLab+E5OZHpbIwfMjTlF8okOOmeFDk992tfabtC1fQ96
         cMI5BJklQ+XlY56T5OxbFPCwnieRwTNIFMAeW4NjvyC9CJW29CCQIg2wc4j+P8pjIi8a
         23xiVL/+IGYfu9TzCOrMckj90IMKrYDjQmspdA+vHRDA3yMmP2cOUEHJGHdKMO5hQJy5
         pes4PinAl37R/WLrf+00jtrkRg/5Se4S3ORz2VudybXvgMjkv7x9sHcvjWWxyqow/Fo3
         Oyka3t4RJyUq8u27fzuEWSGwEd/wz9im9Sb2fbQRW2dLdVJdfU+WKSyEWmHDPvyW+hDp
         Qskw==
X-Gm-Message-State: AOAM5301vDfTpU6WnjOK0uDAo1ncuyuk9dWCr7qu1GWyG+AmvU9sc5P6
        PcMM9hS6zLj0uwqnXp6qPIbsav2aLVGRT1bO
X-Google-Smtp-Source: ABdhPJz0o7a/30MID8QxrktjXzTT5qwl4diZC4Rw6WcjONXsdZRyVSSUOVfEan4dMdUvFhGfNCJ00w==
X-Received: by 2002:a2e:3a04:: with SMTP id h4mr4364607lja.156.1607770645130;
        Sat, 12 Dec 2020 02:57:25 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j2sm490674lfe.213.2020.12.12.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 02:57:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] power: supply: ab8500_fg: Request all IRQs as threaded
Date:   Sat, 12 Dec 2020 11:57:11 +0100
Message-Id: <20201212105712.2727842-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201212105712.2727842-1-linus.walleij@linaro.org>
References: <20201212105712.2727842-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since these IRQs are cascaded from a nested IRQ, the
generic IRQ system detects this and refuse to deliver
a fastpath IRQ in response to request_irq():

  nested = irq_settings_is_nested_thread(desc);
  if (nested) {
          if (!new->thread_fn) {
                  ret = -EINVAL;
                  goto out_mput;
          }
   (...)

Threaded IRQs work just as well so let's just request
threaded IRQs. One of the IRQs are alread requested
as threaded anyways.

Cc: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_fg.c | 47 ++++++++------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index ba8dba0d6395..d1b68acac427 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3001,14 +3001,11 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 }
 
 /* ab8500 fg driver interrupts and their respective isr */
-static struct ab8500_fg_interrupts ab8500_fg_irq_th[] = {
+static struct ab8500_fg_interrupts ab8500_fg_irq[] = {
 	{"NCONV_ACCU", ab8500_fg_cc_convend_handler},
 	{"BATT_OVV", ab8500_fg_batt_ovv_handler},
 	{"LOW_BAT_F", ab8500_fg_lowbatf_handler},
 	{"CC_INT_CALIB", ab8500_fg_cc_int_calib_handler},
-};
-
-static struct ab8500_fg_interrupts ab8500_fg_irq_bh[] = {
 	{"CCEOC", ab8500_fg_cc_data_end_handler},
 };
 
@@ -3149,44 +3146,25 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	init_completion(&di->ab8500_fg_complete);
 
 	/* Register primary interrupt handlers */
-	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
-		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
+	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq); i++) {
+		irq = platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
 		if (irq < 0) {
 			ret = irq;
-			goto free_irq_th;
+			goto free_irq;
 		}
 
-		ret = request_irq(irq, ab8500_fg_irq_th[i].isr,
-				  IRQF_SHARED | IRQF_NO_SUSPEND,
-				  ab8500_fg_irq_th[i].name, di);
+		ret = request_threaded_irq(irq, NULL, ab8500_fg_irq[i].isr,
+				  IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
+				  ab8500_fg_irq[i].name, di);
 
 		if (ret != 0) {
 			dev_err(dev, "failed to request %s IRQ %d: %d\n",
-				ab8500_fg_irq_th[i].name, irq, ret);
-			goto free_irq_th;
+				ab8500_fg_irq[i].name, irq, ret);
+			goto free_irq;
 		}
 		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
-			ab8500_fg_irq_th[i].name, irq, ret);
-	}
-
-	/* Register threaded interrupt handler */
-	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
-	if (irq < 0) {
-		ret = irq;
-		goto free_irq_th;
-	}
-
-	ret = request_threaded_irq(irq, NULL, ab8500_fg_irq_bh[0].isr,
-				IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
-			ab8500_fg_irq_bh[0].name, di);
-
-	if (ret != 0) {
-		dev_err(dev, "failed to request %s IRQ %d: %d\n",
-			ab8500_fg_irq_bh[0].name, irq, ret);
-		goto free_irq_th;
+			ab8500_fg_irq[i].name, irq, ret);
 	}
-	dev_dbg(dev, "Requested %s IRQ %d: %d\n",
-		ab8500_fg_irq_bh[0].name, irq, ret);
 
 	di->irq = platform_get_irq_byname(pdev, "CCEOC");
 	disable_irq(di->irq);
@@ -3223,12 +3201,9 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 
 free_irq:
 	/* We also have to free all registered irqs */
-	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
-	free_irq(irq, di);
-free_irq_th:
 	while (--i >= 0) {
 		/* Last assignment of i from primary interrupt handlers */
-		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
+		irq = platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
 		free_irq(irq, di);
 	}
 
-- 
2.26.2

