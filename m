Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90DE587326
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiHAVYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiHAVYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:24:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961B247B89
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:23:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so14562wmb.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=oydBayLJLOdfVez5PzNR5ZpWIibjGHyPoAK0Vv+n04M67YVjbG8CpMlZub1u/Pnrk2
         WgGSaFaxLohalC14/V8dBWo/FkQpQHg+QLhsWOoq322ZIZj0EkrF5HUsxUx44ibOHdQo
         qHRBLwu1DVf18KGQLZc0yWUFEXEHXkiWGuD34NVToeyZvVivuvm8s132NLidGXOyb/7v
         9njGRegIYiloecDVNy9uu6WNKxwdNC8ibOSEoCNIGJQrKVpaqMRzYJuhbWYAcvk0r6h5
         jNGW51mU7cDzzaYaH2UDywTFbn0/yxmNtg8gV2NIgdncoEghI1yGvXbyaa/uy8ogOp4a
         w73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=cSHLfB5ey70XbWOsi3rcY8GFBscVD9wfQtIQeLgixbXqlAyv2U0A5xxO1IE5Bqjbfp
         B/7CPw/DwryzbMU4nIfJ+riq134QRLhoqXYsfoKp4kY29Bv+bY4mzYBQ37ETKou0WKX1
         Ef3M15X3W1Fn1fljHKSqosbv2L36InDl6oJ94K+yRylBTEq+Kl9CdacrCSIgnS0ymlI4
         dAf7xJGJ3IAiyQCXhz/zPh/vPwWu1BrGrmXuEXlBYBQzBEfHGuyBO2aAf79RHQX2mF9b
         5MC9KUMiZWiPpMKjTwM+g1risWa4dFw3Obt49m8EkOF/XBVq1VW2cvpgS+ljV5jLuQKU
         cGDQ==
X-Gm-Message-State: AJIora/4u3rlK+NWWM5YcScSHWq5aVBN7HOVzwkFdBoTJoitaI3mREEa
        Tope6YIT2E4Zuft4q0+Z8St0xA==
X-Google-Smtp-Source: AGRyM1sGxApxa+F9mK7vflnF0ElHzvTsepfFeIwyi8v6H/UIsm1+JRSKET3PpFiWZx/GCKAiF+syTg==
X-Received: by 2002:a05:600c:1c19:b0:3a3:181e:89e with SMTP id j25-20020a05600c1c1900b003a3181e089emr12260466wms.203.1659389020197;
        Mon, 01 Aug 2022 14:23:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:39 -0700 (PDT)
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
Subject: [PATCH v4 14/32] thermal/drivers/armada: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:26 +0200
Message-Id: <20220801212244.1124867-15-daniel.lezcano@linexp.org>
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
 drivers/thermal/armada_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2ebfb5be4b3..52d63b3997fe 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -420,9 +420,9 @@ static struct thermal_zone_device_ops legacy_ops = {
 	.get_temp = armada_get_temp_legacy,
 };
 
-static int armada_get_temp(void *_sensor, int *temp)
+static int armada_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct armada_thermal_sensor *sensor = _sensor;
+	struct armada_thermal_sensor *sensor = tz->devdata;
 	struct armada_thermal_priv *priv = sensor->priv;
 	int ret;
 
@@ -450,7 +450,7 @@ static int armada_get_temp(void *_sensor, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops of_ops = {
+static const struct thermal_zone_device_ops of_ops = {
 	.get_temp = armada_get_temp,
 };
 
@@ -928,9 +928,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		/* Register the sensor */
 		sensor->priv = priv;
 		sensor->id = sensor_id;
-		tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							  sensor->id, sensor,
-							  &of_ops);
+		tz = devm_thermal_of_zone_register(&pdev->dev,
+						   sensor->id, sensor,
+						   &of_ops);
 		if (IS_ERR(tz)) {
 			dev_info(&pdev->dev, "Thermal sensor %d unavailable\n",
 				 sensor_id);
-- 
2.25.1

