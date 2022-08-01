Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE993587313
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiHAVXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiHAVXS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:23:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5E422D7
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:23:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m41-20020a05600c3b2900b003a4e094256eso176999wms.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4gLdF8Z9GXjLkyxJDJeMcMe40YjZXEY+RZQOYoJu4Mg=;
        b=vO8Ilb0dq5FhkB8ZJX05O+SM60PEh1a4YUFLqkiw/nmOQbr1W0aUOPZVB+PWQjDIUn
         l18/mvOwMzUyyd6GKKujuKaZht5y96ZaBda7hckKMzJvmr1k7h+LojPFtKMqieq2NXcv
         zEcI9/0sjY2xFGFsncG3bXixFuB9Ikl/dfhGtssClnlTg1loNYN12GTkdpaIyOx8yl0c
         dKofEba+OUVBvh4ZyoDphouE2/6OJICh9Gn4CE9NaO+iPT8noxpmVEn6NSE1otMD4lDs
         dVGJqkBzwQX3OXc4h0Ogao+D/p4ccJTZN8rvSkBKfk6z0Ik4pOtXPT7cVbZQul2OoyHU
         nCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4gLdF8Z9GXjLkyxJDJeMcMe40YjZXEY+RZQOYoJu4Mg=;
        b=1pP3ZnjtFSSaWUNyikPNcOsQJtgnbuvLSaXyCGZ2w69vYpje4fvLQkpnmaiX2xoXXA
         SBk454Gx8B0Vomt7vqYu5G4HjsH0G5laLAhxh2tLjz3qJjGro3ifaEtlU5FI1BAU6EsJ
         nAZJ70sCGR7lRIl2U+9hzjGMDfGaB9hkCsHIa3S6oKCIIVEXf1i4fpRnsFbdLLpY45VF
         mvAwf9WFAsFbpXp8hNDPVKYiWS22pFKxV0ROodyFf1kEdT3HXBCaOOV6Avmv9u4Vg+El
         Q/Eyx/hStae4z6BNvwtwA4reNdWKfnMxQNu8+2eMBaGHuhNpXQEGavrUDs43SvppD2PW
         rRhw==
X-Gm-Message-State: AJIora8GiQICNoIImTkDvbA7bzGMJejHiuByMQBbSsjYQEn3Kdi0dXCs
        1uBcI6n5IZ6YRCdiWOCW5uptGQ==
X-Google-Smtp-Source: AGRyM1tgF7LQOcTSaLCjgZDnSb0OgwfyHCapgtM5ENuxy0i+NRwBCGKLZkl4uZqKqUXi5gtWopwZKg==
X-Received: by 2002:a05:600c:4f49:b0:3a3:2717:27fc with SMTP id m9-20020a05600c4f4900b003a3271727fcmr12573327wmq.36.1659388992537;
        Mon, 01 Aug 2022 14:23:12 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 06/32] thermal/drivers/mmio: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:18 +0200
Message-Id: <20220801212244.1124867-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Talel Shenhar <talel@amazon.com>
---
 drivers/thermal/thermal_mmio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 360b0dfdc3b0..1bf1a16533da 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -20,11 +20,10 @@ static u32 thermal_mmio_readb(void __iomem *mmio_base)
 	return readb(mmio_base);
 }
 
-static int thermal_mmio_get_temperature(void *private, int *temp)
+static int thermal_mmio_get_temperature(struct thermal_zone_device *tz, int *temp)
 {
 	int t;
-	struct thermal_mmio *sensor =
-		(struct thermal_mmio *)private;
+	struct thermal_mmio *sensor = tz->devdata;
 
 	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
 	t *= sensor->factor;
@@ -34,7 +33,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
+static const struct thermal_zone_device_ops thermal_mmio_ops = {
 	.get_temp = thermal_mmio_get_temperature,
 };
 
@@ -68,10 +67,10 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							    0,
-							    sensor,
-							    &thermal_mmio_ops);
+	thermal_zone = devm_thermal_of_zone_register(&pdev->dev,
+						     0,
+						     sensor,
+						     &thermal_mmio_ops);
 	if (IS_ERR(thermal_zone)) {
 		dev_err(&pdev->dev,
 			"failed to register sensor (%ld)\n",
@@ -79,7 +78,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		return PTR_ERR(thermal_zone);
 	}
 
-	thermal_mmio_get_temperature(sensor, &temperature);
+	thermal_mmio_get_temperature(thermal_zone, &temperature);
 	dev_info(&pdev->dev,
 		 "thermal mmio sensor %s registered, current temperature: %d\n",
 		 pdev->name, temperature);
-- 
2.25.1

