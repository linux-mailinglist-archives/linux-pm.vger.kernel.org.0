Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8E58731B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiHAVYA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiHAVXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:23:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE02F652
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:23:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v3so14694387wrp.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=R5oSbHV8oTmGJ+RpdUXnBgYi3FlnkyzDbzIR65x2xePfQ52ka9iCZeJhnXXhKAEeuw
         p8CVTYNrxyd3ySzQiiQIjw9f9qjuPXxHrlnvWE5VUHSw3LNnJ6VYc57Ckbvd7D7/A3PT
         9a9ETMgvm+YY538yVtNkz25hbtAhYLnPiqXJ5uAxzpFPBhFgQ9sbKbkYjgBfdwcwJlC3
         u03nawxKCIjPErh4A8//Qhg4YaDOowqBBX6jB2V14BbtWmLGpC6UGd1vuQQZuSlfzqM4
         b2LnaUgbVJazJ+oH5Je/zetA/+TPHwfmjMnp8MP9NeaOuoGX0YuX98OGi1jWI3pD/e7W
         wUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=kIQDDt0HerODrNlTKPuSufumCWnxM2qiwiwVgX5Ir248RVbdlDuEPU8xZh6Cpklxqc
         l4RJ8QnL9KLWZ1/xqsTVexejy+eXb/6kxaSgXDJwmug2gCsB670OqZNQy4x2HH9l93k1
         f5QJw9b3xUXT0amik/Bg7yHZ35IowhweRAP+fsupoWX3CcYr052mOewYMsbHtBaACJjc
         5gVDNp+jcvF2+9K4T1r3y/tfFpvn6J13eKcuv4UBrNTWHP0MPTHpJaIVhIW4aKnDpjhF
         C5HbQLJMC4hpIaBCa/Kx1IW50Wcp4KqskidsH6sJppX2hloA16UwaCgedJCmADVtDtSU
         w90w==
X-Gm-Message-State: ACgBeo38Zf+lr+4HPi4o+pMSlRUGg7EMGYSPxB1NE43VT8fe+Uzh/jrA
        e2neXg13JXMHQHvjkv9EGp6mIg==
X-Google-Smtp-Source: AA6agR6TMtIEZ4jBfCGPYA7UhexuZ24osNcon1qpYn3szlzr/dzcrBdX2zR1U0BFRPrOYhFjuVOWrg==
X-Received: by 2002:a5d:59a5:0:b0:21d:abc4:29ec with SMTP id p5-20020a5d59a5000000b0021dabc429ecmr11101716wrr.666.1659389004037;
        Mon, 01 Aug 2022 14:23:24 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:23 -0700 (PDT)
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
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v4 09/32] thermal/drivers/sprd: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:21 +0200
Message-Id: <20220801212244.1124867-10-daniel.lezcano@linexp.org>
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
---
 drivers/thermal/sprd_thermal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index fff80fc18002..ac884514f116 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -204,9 +204,9 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
 }
 
-static int sprd_thm_read_temp(void *devdata, int *temp)
+static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sprd_thermal_sensor *sen = devdata;
+	struct sprd_thermal_sensor *sen = tz->devdata;
 	u32 data;
 
 	data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
@@ -217,7 +217,7 @@ static int sprd_thm_read_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sprd_thm_ops = {
+static const struct thermal_zone_device_ops sprd_thm_ops = {
 	.get_temp = sprd_thm_read_temp,
 };
 
@@ -408,10 +408,10 @@ static int sprd_thm_probe(struct platform_device *pdev)
 
 		sprd_thm_sensor_init(thm, sen);
 
-		sen->tzd = devm_thermal_zone_of_sensor_register(sen->dev,
-								sen->id,
-								sen,
-								&sprd_thm_ops);
+		sen->tzd = devm_thermal_of_zone_register(sen->dev,
+							 sen->id,
+							 sen,
+							 &sprd_thm_ops);
 		if (IS_ERR(sen->tzd)) {
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
@@ -523,8 +523,8 @@ static int sprd_thm_remove(struct platform_device *pdev)
 
 	for (i = 0; i < thm->nr_sensors; i++) {
 		sprd_thm_toggle_sensor(thm->sensor[i], false);
-		devm_thermal_zone_of_sensor_unregister(&pdev->dev,
-						       thm->sensor[i]->tzd);
+		devm_thermal_of_zone_unregister(&pdev->dev,
+						thm->sensor[i]->tzd);
 	}
 
 	clk_disable_unprepare(thm->clk);
-- 
2.25.1

