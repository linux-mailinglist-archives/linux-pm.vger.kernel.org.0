Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67C4A2ABC
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbiA2Avx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbiA2Avu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9CC061748
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:49 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q127so11369653ljq.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUS6wW3yGInzGcbpUzNKgXwJz8KX3iohGyze+GjeDY8=;
        b=XHKxJLGqPN67mksmkaLurQUiVLFeBx5orDKZNCZFWBh/BKF5zQRmkbjdLpauvsM0Bs
         M9O0HW6126Xj8ZQt/GL5GM8bcu7RbMHuCuaMLQfeqKWAyHDOXpFJWd5WE0Yk6yBrq3+r
         9YWSr6umKFjZaY1CXdvr8L3nlC0B4stNUOw7dBJUvpIZjIG6QU30H8hsDjRkw6TQ/J+e
         RGvFCGx82GC3a2J5VHLNGG1RdrV/KNtPbVkHTIhRnc8G3l9aWO4YAdaETuh9kdrbhUTG
         61jABneW7jgQNFzyRCmMsJdoci/TpZM4GMcS0eOVll+SrJmXAhxUjNNz/A7E2/WKxJ79
         +HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUS6wW3yGInzGcbpUzNKgXwJz8KX3iohGyze+GjeDY8=;
        b=WgIj1+oVS2lZLukVHUrvi+8DvEXkrkjs1xDZHdseQGuHCKYvYpakZk8g82OVLPniRb
         dsDWkG/yvsd/xvTm44QAt7bPE6qNrv/ZkuudMYy65Tn7k2FgvcFYbwNFws58f8VZsvS8
         CJ7QFC9tJGBbMWVvosPVYC78LXNEihjSOb5fjwXQL2Fa7Ih7heoYuH13wvBHMK5geajs
         1A2zECtSnz9agJ27ghn3lYjAZZ2SnA8wVvaml3fNfDP96eXUzJzsf+ukCZPXRGsKWy8S
         1dRdaCccb/go9aWVi/WSl2vLNPTLNetUAcX/rf9mOvb0gywkVKaiKCth5MISeXvnAs9e
         ezHQ==
X-Gm-Message-State: AOAM532LxOO2oqTYaZcBAs/psTCeXOiXWbbYsKnhcE72tv/s9Tj9iiLs
        NcYnYufENeWACiBgRzYcJhsBnQ==
X-Google-Smtp-Source: ABdhPJxurfDAgx+6aJbvize5H1s2fragtNlZUUhaARGLaEFgaOUYFyQE9XjfxJFSPmJrhOaVmKRXiA==
X-Received: by 2002:a05:651c:212a:: with SMTP id a42mr7231431ljq.100.1643417508294;
        Fri, 28 Jan 2022 16:51:48 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/11 v2] power: supply: ab8500_charger: Restrict ADC retrieveal
Date:   Sat, 29 Jan 2022 01:49:24 +0100
Message-Id: <20220129004925.639684-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Resending with other patches, no changes.
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

