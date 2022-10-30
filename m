Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F86A612CE2
	for <lists+linux-pm@lfdr.de>; Sun, 30 Oct 2022 21:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ3U4A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Oct 2022 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ3Uz7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Oct 2022 16:55:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A219597
        for <linux-pm@vger.kernel.org>; Sun, 30 Oct 2022 13:55:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p8so16451945lfu.11
        for <linux-pm@vger.kernel.org>; Sun, 30 Oct 2022 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=die5s22JFGHWfLYrkKoRiqA+KQ+nwR1SmfRQBT6vj1E=;
        b=iyZTwdWtzbOBX0MsxVqwY8LOQ3siCVFy3uelSKg8X9IzOhyxMkZsk+KxkyM/fq2NDH
         aC4G85b3IGd0+1xnrCD0u/1YOGc2cSEFTU4igcy41mgI3f3BklkzMe7LP6SCmYTy10qR
         9Km0LSKdyXK0zpMkB3SnFQql6Gw4jPst4p3V3olBy1u4n+8fxfo0Angv20I0lczbZFwZ
         TCnQ8S7kPrCa6k0KcUjHBrDtFu82kC7KUUWCrphyBKnxCEQLspInkKOBGtiLSrHtINKz
         d/I0w6kNMf8mnSwTfrwxQ8JobKOy5POv78fszHencrXxmsAqdblGLu0gFv0dYT6f5CKl
         gAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=die5s22JFGHWfLYrkKoRiqA+KQ+nwR1SmfRQBT6vj1E=;
        b=pJTJZ/sjRTFQw6ukGRQzXnFjegV6Im4Do/gbxjKe3PEusXcJHLa06NUgN7KIYqcqGc
         4LD587fLHy8q4Vm4fX0J6EeJorW7vCUzluEgyVSx6uW8RqdWffotZ2xRzBTlAEt1K2wf
         32LdoPOgPcleEdWHDboZsmv/Lwhu1aEE0NNv8Pllb7KZDgcFrVlRdhtkEpT6Tgx0xFG0
         IW4k9LghvwZGZNygQ9Y8wHUV9WkiEGQUVmtUkhBfDvzMP3Ie0pwRnRg+D9R2b4R+0HCW
         eG0YWyCEoPoB5pDxS7vnPMuKOvxnyVYvFKqVUS3/WwS296Sp6yrI25mxSOPzpo2e6Qg+
         sSuQ==
X-Gm-Message-State: ACrzQf0T4cHRXuhvgb80IB+il76WoxqKiKmBhTcu+g5xo+zzGqIBhwSD
        CyFT13L3LMBIvnnrlnnMEcOXwQ==
X-Google-Smtp-Source: AMsMyM5MFGlvFQ9ho7WcB1vvjrE9G4b28qctaguEGZ5K+hKnKZosGzpRyCiG9eUgxcOUFFt8krjwkA==
X-Received: by 2002:a05:6512:318d:b0:4a2:9e80:3acb with SMTP id i13-20020a056512318d00b004a29e803acbmr4213261lfe.488.1667163356929;
        Sun, 30 Oct 2022 13:55:56 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id 190-20020a2e05c7000000b0026f9cb6d10fsm963612ljf.45.2022.10.30.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 13:55:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        phone-devel@vger.kernel.org
Subject: [PATCH] power: supply: ab8500: Defer thermal zone probe
Date:   Sun, 30 Oct 2022 21:55:54 +0100
Message-Id: <20221030205554.335633-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The call thermal_zone_get_zone_by_name() used to return the
thermal zone right away, but recent refactorings in the
thermal core has changed this so the thermal zone used by
the battery is probed later, and the call returns -ENODEV.

This was always quite fragile. If we get -ENODEV, then
return a -EPROBE_DEFER and try again later.

Cc: phone-devel@vger.kernel.org
Fixes: 2b0e7ac0841b ("power: supply: ab8500: Integrate thermal zone")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_btemp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 863fabe05bdc..307ee6f71042 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -725,7 +725,14 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	/* Get thermal zone and ADC */
 	di->tz = thermal_zone_get_zone_by_name("battery-thermal");
 	if (IS_ERR(di->tz)) {
-		return dev_err_probe(dev, PTR_ERR(di->tz),
+		ret = PTR_ERR(di->tz);
+		/*
+		 * This usually just means we are probing before the thermal
+		 * zone, so just defer.
+		 */
+		if (ret == -ENODEV)
+			ret = -EPROBE_DEFER;
+		return dev_err_probe(dev, ret,
 				     "failed to get battery thermal zone\n");
 	}
 	di->bat_ctrl = devm_iio_channel_get(dev, "bat_ctrl");
-- 
2.37.3

