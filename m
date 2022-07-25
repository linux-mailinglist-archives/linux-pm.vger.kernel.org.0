Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6245806A5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jul 2022 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiGYV3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 17:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiGYV20 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 17:28:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27387240A6
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k11so17261792wrx.5
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+4pPbHoJuz+mVWdzAPQM0rRrJIgIdixEMQHV/ZC2Bo=;
        b=ybgq1bQw5JTchd8a23+QTuXwRK92Wz4uj6aBKpdF2CjDPZvoPh1AhpM07Vfmh4dMc9
         +tRqx6rBEv16XPq5nh6iX8HC3JyYRshmsE60ihz2r8O+CqI2ol93GArWwQMNrkBH6W+m
         2ePcLAhTwaIumi7L06v3eb9pOqxjmey+jBW6XddLcAyz3j1KwRL6ZLYq2v8dxPzpTfc7
         2SrtgSPNtG+T7It9Vdb/E/KOZ8crbZVMl4ov7bkEYTqNmaOC1/8h6KRfIwCF46QQfN6j
         hVXA8WON6RQn+Mu82nrUm4XVYx6Xkl52eomujzkl6kaagqE8VBZZaKKKuf065ykyWQEB
         NVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+4pPbHoJuz+mVWdzAPQM0rRrJIgIdixEMQHV/ZC2Bo=;
        b=37WVShUmrdSgLElyOlH9InNpDk2GO4XytIlPrrOLOu5VLALTidRSL3hqac4wrqojGU
         xDQW+WJ1IWbfZgBIMmxtIfFO13WRT1q3HEXIRjw7xY9AcUhLT0z9fEjHAJW1J83UzIJY
         he1YkjRYnbnstmcHM3aTVwtU0cfBsFdcFsdvv9idtRJu/9ohJ07U9hkaj0fMSSj+tdyT
         6iF3Lh9lXF9eNe2XXKQqFdPJTVYbFgwgikPP9ZlVz3aAiWid8GuGL7XLscATJV0Iyu7Q
         g7k4nT+74TUfkhSL0wbcJ6SqYiiLJ/Ey7FQ4Eq60roN2l0vM4tZQagB+aI+IzfqAhUAu
         G2VQ==
X-Gm-Message-State: AJIora9mJW5HguHFbecqLgh4EnDTW+tjmbTxMB7cjzLHpNL2gzcnaFIm
        veHtm6rCqt1JaTUTY3Mpgte+qA==
X-Google-Smtp-Source: AGRyM1tVVTPgbv6m/PfwEAw+Q3+sp9/OXWPj7BXkkTzeL9SI/ci+YdWF7OjntDndJ+hlHcYZWICbpA==
X-Received: by 2002:a5d:604a:0:b0:21e:6b84:a4d8 with SMTP id j10-20020a5d604a000000b0021e6b84a4d8mr8479548wrt.187.1658784464351;
        Mon, 25 Jul 2022 14:27:44 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:44 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v2 20/32] thermal/drivers/mtk: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:25 +0200
Message-Id: <20220725212637.2818207-21-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/mtk_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..8440692e3890 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -679,9 +679,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	return max;
 }
 
-static int mtk_read_temp(void *data, int *temperature)
+static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 {
-	struct mtk_thermal *mt = data;
+	struct mtk_thermal *mt = tz->devdata;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -700,7 +700,7 @@ static int mtk_read_temp(void *data, int *temperature)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
+static const struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
@@ -1082,8 +1082,8 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-						     &mtk_thermal_ops);
+	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
+					      &mtk_thermal_ops);
 	if (IS_ERR(tzdev)) {
 		ret = PTR_ERR(tzdev);
 		goto err_disable_clk_peri_therm;
-- 
2.25.1

