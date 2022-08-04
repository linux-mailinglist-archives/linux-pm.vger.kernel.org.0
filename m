Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA758A369
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 00:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiHDWwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiHDWwC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 18:52:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B03F314
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 15:52:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk11so1320362wrb.10
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=uulocpG76CYBWxwLA5GEXzKdDuKGpYq9LwU4SDLA8pxC41uy9gzVFVcJJI69zANnHU
         ldxRzTvckXpDK76LQ8K+UTsGtHOd1l2H5aGcZ5MtxoAyW6ymJlgCfSsoKWilg6zkP8H4
         LfYGDZkcqlHNgo9xDsl5Cvr+wSVju+bBWSKGmsdOCOqBwcMIyMgN7iFPgE4y4DLeCFOJ
         73g5s/7rkNoknPQxJrEqi+PJAnv5h0D2B92fADbgyTWOr+wmneoLuwVIg8qJjg44b/u6
         c76AP/EbWH9DTMnGw9dqKlF/RQwJf7mofuHLhOExnsZhJ2TBy7uASYcOE/CqOXYIgDwK
         WFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=xrSynN5joGopb+VHZGn8CbvUgDyWHnOTash5Jnz30QLRBJMigF4B57I1PLND5jpLUe
         uypxCvhwuftuVtPoC0q8Ge2kZzDaYtc2HrBbjHx92HhNBcQHeNApoOymwPXhHt3FGp99
         2dNGw5kwa/5OK3519npNL/0cWIii66Ak+8g4Q0NNS/GhVHBZhe6ppTSluQkHgBGB46PA
         iUvQtYaiRjkXDDk/lmeg4K/u6GdnWNVwP65mbpDrD8Ft6uDqb9PoHhu0cxGp2WdSs4Lv
         1C//rZ4dS3VVPZfZZfNzuUZnUlOiouBlIrXahrsF+kj8hykhg6Vz1J8KRW4tX1PByCnN
         5rbg==
X-Gm-Message-State: ACgBeo3QM2oX3qHQ5gx8eaYUl1I61cBVk31QXN3PuFQu+ISSUDlPkYEj
        xJzZBC/1GNmaGV1+vJJpY2lYvw==
X-Google-Smtp-Source: AA6agR6HvXFtI57ltAEhsG8lThHVAc2eG2lOpuZr9RKn9yTuCAcxSLLJgoF5FO4a22lPVSu83bX+yw==
X-Received: by 2002:adf:fe42:0:b0:21f:8df:2239 with SMTP id m2-20020adffe42000000b0021f08df2239mr2524670wrs.644.1659653519299;
        Thu, 04 Aug 2022 15:51:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:51:59 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v5 04/33] thermal/drivers/uniphier: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:20 +0200
Message-Id: <20220804224349.1926752-5-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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
---
 drivers/thermal/uniphier_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4cae5561a2a3..4111d99ef50e 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -187,9 +187,9 @@ static void uniphier_tm_disable_sensor(struct uniphier_tm_dev *tdev)
 	usleep_range(1000, 2000);	/* The spec note says at least 1ms */
 }
 
-static int uniphier_tm_get_temp(void *data, int *out_temp)
+static int uniphier_tm_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct uniphier_tm_dev *tdev = data;
+	struct uniphier_tm_dev *tdev = tz->devdata;
 	struct regmap *map = tdev->regmap;
 	int ret;
 	u32 temp;
@@ -204,7 +204,7 @@ static int uniphier_tm_get_temp(void *data, int *out_temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops uniphier_of_thermal_ops = {
+static const struct thermal_zone_device_ops uniphier_of_thermal_ops = {
 	.get_temp = uniphier_tm_get_temp,
 };
 
@@ -289,8 +289,8 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tdev);
 
-	tdev->tz_dev = devm_thermal_zone_of_sensor_register(dev, 0, tdev,
-						&uniphier_of_thermal_ops);
+	tdev->tz_dev = devm_thermal_of_zone_register(dev, 0, tdev,
+						     &uniphier_of_thermal_ops);
 	if (IS_ERR(tdev->tz_dev)) {
 		dev_err(dev, "failed to register sensor device\n");
 		return PTR_ERR(tdev->tz_dev);
-- 
2.25.1

