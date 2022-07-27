Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E4A583481
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiG0VEV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiG0VD6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:03:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0683560514
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so1569957wme.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=V7yaFACE5hTXUY3vwg+qJkPtyJ2cQ8+XSeLwV9kbSc4ZzzLQEvyTfj0DfZtSb6d9p3
         oM3fAVxhv4zezMh+ptz0sW99WmAwoOKMSHSyCk/s+3oy923V1JWTapa/IVpl+wtenomM
         6JhVMLqxpEUVijBkPZLAkjz6aJeRouAUnf6UzRrp002X+2rlkvt8UHXXxK7H2hQ7xOQQ
         efOwY2RaaU0Sw2Y19Bu3kQQlhky4OuBu9y9DpZ7W70K2dHVz8Vu+6sEb1ruAVIrFuPyK
         gXbLiqluupRBibw/8Hj9l1q6+DvNXaVLpqbEK0FiT5pr30MZWL6jVcd/zdpq1N3Dog3k
         uavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=BaY1Iw3rgTycsHjNVbcnN2yp2ouxsBMCcU8Z47D/PQ9o6Xrf33E+GvyzRahq3Er7Ep
         C6QnB+nGQtF926XxPekaIG9ngpIcoJTONJIp5hwLiiPniQZpd42VHD2KxkbFp88Zo6yG
         64HGvP9TYqdd7BWQu/VzCmsu471KDRAKBda5s7fReNFBUfDnPA1aUgQRad4KIQ2R0B05
         AHw3TJP1mk8AVyg6GaOqd6ng2OrBJVVWjRInlScClWxcbD7R4IZB5ofGrjZLZJg3JqgA
         fiVVyNXdXntE4bulG20biP8/CFNOWn9l53tmJyUU6kZEzU8FFJqFvgsqgYRfJg3GO0mA
         bRSQ==
X-Gm-Message-State: AJIora/t4ZUPOr2lfFw7fxxTwCLYXV4SaOukhI7qeFbWNiJDsZ1YMCvB
        1zi/xCrLMOr9HAq1Tx3Gm+mzbw==
X-Google-Smtp-Source: AGRyM1sfhlNYnnudG/aE1My4jnn/eb0g6rD0Z7xtvdVbreWKJ8vXOG88PYSi2QPtG6jkfHI7jAPj8A==
X-Received: by 2002:a05:600c:1f16:b0:3a3:214c:a85e with SMTP id bd22-20020a05600c1f1600b003a3214ca85emr4324187wmb.95.1658955827276;
        Wed, 27 Jul 2022 14:03:47 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:46 -0700 (PDT)
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
Subject: [PATCH v3 15/32] thermal/drivers/db8500: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:36 +0200
Message-Id: <20220727210253.3794069-16-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 drivers/thermal/db8500_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 121cf853e545..cb10e280681f 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -58,9 +58,9 @@ struct db8500_thermal_zone {
 };
 
 /* Callback to get current temperature */
-static int db8500_thermal_get_temp(void *data, int *temp)
+static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
@@ -72,7 +72,7 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thdev_ops = {
+static const struct thermal_zone_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
 };
 
@@ -182,7 +182,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
 	if (IS_ERR(th->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(th->tz);
-- 
2.25.1

