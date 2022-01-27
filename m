Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0149D765
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiA0BPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiA0BPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:15:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD242C06173B
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:15:04 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o12so2179282lfg.12
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haRFNa2MOuGGx+qiHY4rYq2fcJJPvI8NSUcWdSM3M9o=;
        b=ZxBLmP94C2g/0rl+XNyh6ZIQ1WIHp1DCoDrqMU+zlkNlMNH5KTmib/Dy3XCE+LbLXr
         3ni0qldNPP/pTNNdEij1n9z4g5KX6DW/tlwtrfemRse/h5EXaS28sf0jCIpl9iNO/njj
         CU/AOSwwiFHa2mru41YsTKZ4pqVfN/P5R5rDxg1Fy71lIY4q/wiY/XEDhmAxJvJhe2L/
         ZpDwFyGqYqBIdqJHbD5MKRd93VieDLxcs9L1VyvNU4osUV85kK/FWRu4PsMDR5GBUnBf
         Q2MFmPdUhg3G90sf23HV2k5S9B5+X3EDf2nHndA90fvkb5PmJur6NEfE6U0/7dRURLzM
         Kn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haRFNa2MOuGGx+qiHY4rYq2fcJJPvI8NSUcWdSM3M9o=;
        b=xj41JoMKpL3hgh9zPxIe+pnywAoxAKMbKGpRXB7HUFuUSZg2Cytbxkwuz2gae4CLH+
         8scjDXH9wUgoNsxY1EAE1fOjGz+5lPE2Aoo/5q/3PzswyA6lL8Vvr3DPK9uc+0k2ZasH
         X0JvUBmuTxM83BehJcmtTUPu1BqUbCsqgQbABcr4jmYb842lLjqeg8YAfhaC9mBuPHGn
         okOTCGH+PwvRLSjngkjUjmL+xhVs4B0qYPAzvbJxQR63eITiTHsrBI0OthdiztQhealE
         pkT0oErNKkjGftbhroxK6BTWXK9rS/lXdjSO/w0oM5IYlWCdwVEg/tLu638SnHqL/EDe
         PbKg==
X-Gm-Message-State: AOAM5315eVAAkxTuKZH9gJfuGtN+ExkgrJzw9d4gwYg28ugiMi2rmXO5
        mKzQ7+XwQteg/jrtMYHH54jsgg==
X-Google-Smtp-Source: ABdhPJztp4pcWK0oUBNBH0iA2LHgVCrevSIUo1onUQt/yOGNW8a++8eWI5+ARJ9Esgh/SAFdljmtjg==
X-Received: by 2002:ac2:4e89:: with SMTP id o9mr1276366lfr.246.1643246103170;
        Wed, 26 Jan 2022 17:15:03 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:15:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/11] power: supply: ab8500_charger: Restrict ADC retrieveal
Date:   Thu, 27 Jan 2022 02:12:35 +0100
Message-Id: <20220127011236.332687-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AB8505 only has two ADC channels: the voltage and current
provided from VBUS (USB). It does not support AC charging at all.
Make sure we don't try to retrieve the non-existing channels.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_charger.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ce074c018dcb..681b53bb0df0 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3443,17 +3443,19 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 
 	/* Get ADC channels */
-	di->adc_main_charger_v = devm_iio_channel_get(dev, "main_charger_v");
-	if (IS_ERR(di->adc_main_charger_v)) {
-		ret = dev_err_probe(dev, PTR_ERR(di->adc_main_charger_v),
-				    "failed to get ADC main charger voltage\n");
-		return ret;
-	}
-	di->adc_main_charger_c = devm_iio_channel_get(dev, "main_charger_c");
-	if (IS_ERR(di->adc_main_charger_c)) {
-		ret = dev_err_probe(dev, PTR_ERR(di->adc_main_charger_c),
-				    "failed to get ADC main charger current\n");
-		return ret;
+	if (!is_ab8505(di->parent)) {
+		di->adc_main_charger_v = devm_iio_channel_get(dev, "main_charger_v");
+		if (IS_ERR(di->adc_main_charger_v)) {
+			ret = dev_err_probe(dev, PTR_ERR(di->adc_main_charger_v),
+					    "failed to get ADC main charger voltage\n");
+			return ret;
+		}
+		di->adc_main_charger_c = devm_iio_channel_get(dev, "main_charger_c");
+		if (IS_ERR(di->adc_main_charger_c)) {
+			ret = dev_err_probe(dev, PTR_ERR(di->adc_main_charger_c),
+					    "failed to get ADC main charger current\n");
+			return ret;
+		}
 	}
 	di->adc_vbus_v = devm_iio_channel_get(dev, "vbus_v");
 	if (IS_ERR(di->adc_vbus_v)) {
-- 
2.34.1

