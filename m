Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0043B4AB7
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jun 2021 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFYWuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 18:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFYWug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 18:50:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8EC061766;
        Fri, 25 Jun 2021 15:48:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i24so15512974edx.4;
        Fri, 25 Jun 2021 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9129PTw2ZRrh3YVetP+EXrB693QAxfAKWuMYosFITBg=;
        b=pOiZMcJ4MTH4QgF4f5U5T5fNdQY0i41364aWCgGWxvq1kkVbmwhhayL/lwrbfjL17R
         E3hKTLVD9Xk+UyAcwHqDE8I0SZqoExWbBT83D19KL/Bvhe2G08QvQsU0cgk4NcKMoxPp
         /MP5pzVjt1txwXy1CTPOUEVcV7MFKTRUsoBg6vo14GjuEcC6EcPQEW4Rf6xYDZJVVpt1
         l6sglbSFsDzL5rf6gEYew/Y/uXUXOrH9epXtlQKKNH9A9JTeDsc7e8o+L2fgCDlt65MT
         BOBN6O4Vb7OcI3Pur6/9NUBiCf0Xbr2Mfv6rYnAaRfBBquDhoZWc3HzgCy7H4VAlJpuh
         OyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9129PTw2ZRrh3YVetP+EXrB693QAxfAKWuMYosFITBg=;
        b=Tkjse5lT0iaT/PoQ5lXYTtWKNq1IdF+vw4FdTDO+ioC2lVmBokPrayg5/F2iBWOJ8S
         iqb12p95Gu/e+YcI6ADtTMI0TbBe45jlal3/0yr92miY+KKaLPSoHKf3w4q6bsXIWkZB
         RqKoF7zfkc9m+ToUwcztQ6rS0QLRqsYzEf9vFM1PpvMgLCxHluK8YS7jXZ+TzNAj9lDd
         edmeI7bawHNvWPI6IbXB+Uo8yafNVtsJiqbmJ1Xu06iDuwiaXGQqnMhg5mBOzMiPXFJD
         Is3q4q5cdXkr9vqxNJgkDY7YjHnoSZDDRrbEzZ8BzBpBVAT8Oc793RnaAff5VWIgSeG0
         puQQ==
X-Gm-Message-State: AOAM530d/CrlzvrOYj847XxfkMVwGGP0Ce80bTPD9bCbtK1KFoMaCBtU
        s4KTKkzvcVvwn/utXq6tWdI=
X-Google-Smtp-Source: ABdhPJxuyDbNQKWawLtABu+CIYZnfRVJJ5hMTBm6nv4pDzo6ru5ruP3Vn3JgJOua6+2QxKut9fu2Bg==
X-Received: by 2002:a05:6402:313b:: with SMTP id dd27mr17836572edb.85.1624661292144;
        Fri, 25 Jun 2021 15:48:12 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id w1sm4719399edr.62.2021.06.25.15.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:48:11 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Date:   Sat, 26 Jun 2021 00:47:43 +0200
Message-Id: <20210625224744.1020108-3-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625224744.1020108-1-kernel@esmil.dk>
References: <20210625224744.1020108-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
the SoC, but it is still useful to be able to reach the PMIC over I2C
for the other functionality it provides.

[1] https://github.com/beagleboard/beaglev-starlight

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
 drivers/mfd/tps65086.c                        | 21 ++++++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
index ba638bd10a58..4b629fcc0df9 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
@@ -87,9 +87,6 @@ additionalProperties: false
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
   - gpio-controller
   - '#gpio-cells'
   - regulators
diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 341466ef20cc..cc3478ee9a64 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -100,29 +100,30 @@ static int tps65086_probe(struct i2c_client *client,
 		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
 		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
 
-	ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
-				  &tps65086_irq_chip, &tps->irq_data);
-	if (ret) {
-		dev_err(tps->dev, "Failed to register IRQ chip\n");
-		return ret;
+	if (tps->irq > 0) {
+		ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
+					  &tps65086_irq_chip, &tps->irq_data);
+		if (ret) {
+			dev_err(tps->dev, "Failed to register IRQ chip\n");
+			return ret;
+		}
 	}
 
 	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65086_cells,
 			      ARRAY_SIZE(tps65086_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
-	if (ret) {
+	if (ret && tps->irq > 0)
 		regmap_del_irq_chip(tps->irq, tps->irq_data);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int tps65086_remove(struct i2c_client *client)
 {
 	struct tps65086 *tps = i2c_get_clientdata(client);
 
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
+	if (tps->irq > 0)
+		regmap_del_irq_chip(tps->irq, tps->irq_data);
 
 	return 0;
 }
-- 
2.32.0

