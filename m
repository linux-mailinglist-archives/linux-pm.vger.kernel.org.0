Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3615583484
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiG0VE2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiG0VD7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:03:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A66052A
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q18so15657491wrx.8
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=862ebCD8XkBY+/fgfesDVhZbuj5QTeks1/6fcN22nnM=;
        b=SvwhdwfsNOvuBHMMHdjl6Atc+dKlr60rsUeADqp96byBmVhAKz+XvDjiROATdcaydb
         KAckFf67sqIYlI+IcerRWqFC1AduHaG2Q0WEf10ISKxhz2RvT2OwgafCIBAZ8A0h9JmZ
         4l/yL0okOygNcS9zipOtl/0po7Bv0IxDWYE9BX6/2hFOviT1iArYWmnBBaeAzhpreLfa
         hZxdzgtHAey6F7NgnFYaza9uehhCg8XXTRZaq2DYEuKb/sJbmmJGFB4GlzMWR6LGjMyv
         vdRCginLDkUnp38PW6xmmqSMTxJpTHg/dWT8hHTjQqD0XI3+jVMroV2W5eX5YjoQm6tv
         xacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=862ebCD8XkBY+/fgfesDVhZbuj5QTeks1/6fcN22nnM=;
        b=L6u9mh65NB+hs0ye07fMswe/C32EOPHX3LSYx5FDtYyRaLuBL0OBiP+6mg/9vuNv6v
         T3hpNgvpzok4URokoE5h0GLyZHvPl/TCSIj9x2sDN4Ci008gHN3JgWRTxsxCqWRSvgNB
         pFII6/S4RpEt23pYY+EqD2YXyhKoCz+NJOhKKBwKPERjddYPk5+CSoLaX1UTK707vfXR
         ENNrcPN6AslP1RE+uoHwFZwNppLEJ0lydoCFpK1L6B8pqsuyV2R9c63Kc5dmp50B5j3C
         hwaKfd07br9/WIhlQ0ZgBtn6IiYGm9v7fr8K5FReZ0e+MYmlS8eAD5JDlpmABx9DI//l
         oiHg==
X-Gm-Message-State: AJIora/TBvWpZbHL04faopC690R/UV6M1P6KdnPvoKW1kC1tjK9SkRkP
        Voa7Qq9VrjMPB6kyATdfmeFggg==
X-Google-Smtp-Source: AGRyM1vCFOs3Tg+NWKarVvaw+S/84BMqTpdO3+ZVjHLnJEbt3fXuMn2qnUbyCyirrqqOshmwM1KaoA==
X-Received: by 2002:a5d:5986:0:b0:21e:811c:f688 with SMTP id n6-20020a5d5986000000b0021e811cf688mr12539382wri.8.1658955831996;
        Wed, 27 Jul 2022 14:03:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:51 -0700 (PDT)
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
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v3 17/32] thermal/drivers/rcar: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:38 +0200
Message-Id: <20220727210253.3794069-18-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 16 ++++++++--------
 drivers/thermal/rcar_thermal.c      | 13 +++----------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e2020c6308cc..40ec63ad0a1b 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -164,9 +164,9 @@ static int rcar_gen3_thermal_round(int temp)
 	return result * RCAR3_THERMAL_GRAN;
 }
 
-static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
+static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;
 	int mcelsius, val;
 	int reg;
 
@@ -203,9 +203,9 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 	return INT_FIXPT(val);
 }
 
-static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;
 	u32 irqmsk = 0;
 
 	if (low != -INT_MAX) {
@@ -225,7 +225,7 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
+static struct thermal_zone_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
 	.set_trips	= rcar_gen3_thermal_set_trips,
 };
@@ -504,8 +504,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-							    &rcar_gen3_tz_of_ops);
+		zone = devm_thermal_of_zone_register(dev, i, tsc,
+						     &rcar_gen3_tz_of_ops);
 		if (IS_ERR(zone)) {
 			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
 			ret = PTR_ERR(zone);
@@ -556,7 +556,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 
 		priv->thermal_init(tsc);
 		if (zone->ops->set_trips)
-			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
+			rcar_gen3_thermal_set_trips(zone, zone->prev_low_trip,
 						    zone->prev_high_trip);
 	}
 
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 1d729ed4d685..4df42d70d867 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -271,13 +271,6 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 	return 0;
 }
 
-static int rcar_thermal_of_get_temp(void *data, int *temp)
-{
-	struct rcar_thermal_priv *priv = data;
-
-	return rcar_thermal_get_current_temp(priv, temp);
-}
-
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
@@ -323,8 +316,8 @@ static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops = {
-	.get_temp	= rcar_thermal_of_get_temp,
+static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
+	.get_temp	= rcar_thermal_get_temp,
 };
 
 static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
@@ -534,7 +527,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		if (chip->use_of_thermal) {
-			priv->zone = devm_thermal_zone_of_sensor_register(
+			priv->zone = devm_thermal_of_zone_register(
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		} else {
-- 
2.25.1

