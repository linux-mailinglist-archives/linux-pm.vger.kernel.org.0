Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E940058A37F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 00:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiHDWxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 18:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbiHDWw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 18:52:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5887390F
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 15:52:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v3so1428205wrp.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=Hapj0n4cQ17IpR6CaDW8h880hkcV9+OjY0LG1WLlOnTq9iPkGKning/o3qI8Lk7UyC
         GuVOYAcnUSAc3X5VY9fkZb2Xo78TbnWnZ7MggW/1QwVqV69WryDDC/uzEqU0M+HBY5eL
         o6j3m6UKDfZH3qjYVOya76HsKWNBVhnzOY9BOlMemIio0+hw9CVQAFEXxHdH37cu0Mvh
         omO3oDYiU1sVcZqV713g+4RK3asDdc00GK0FbnuQpzZZOMafRqvP5vmq00U1ZkuIEDxm
         EYIQbbe/kIrh9/tluD0++4AC4MtFuTCJLJB1In/KsYZel4Mzk2Mrvm3HyY+d6Hr4DFva
         X0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=M0CV03kTN+tirU/kYsFC2fOohkeOczRURyr/u2bqAB84D+eNmiuIlAsBEB/aFVU0ZJ
         T++AqskabVs9+ncKf7RYGX3TFQmYambC+mhUEH5n8T90tnD7Suk9K7iEuSviU3GfOREH
         GX6dcsOGPz0hIls/zkQqe3VUrZiuearAbdBKTdQGYlrFnxdRlstQwKwslMpM+AIM+2Pi
         zvU2LNHX9mxwp7FDoHBgZLLedx41gwY40Rby+b7TOe0uc7GV2KI9IuP7BNlDsCvnT/OF
         d93f2A6eGUbstTU8+0pfXJ3kxHggKj/quTfOuP076EM7DJ4CyhJPFC7w9yuQH2ENeuA4
         CyQg==
X-Gm-Message-State: ACgBeo3TAZa6UaiedFG5+7UG4m2a2tcemNG8hBCu7PvIbthrw+VzF3K4
        r9wgfDfucWuHcmaK8+DzyE3Kig==
X-Google-Smtp-Source: AA6agR6XBzG5opbz+XZ7m4ZPUXzByIn/JHHEjCOPcZvW6A6LV2ZqB627kacVLnmaJT2AhBc3d3lkhQ==
X-Received: by 2002:a5d:47a1:0:b0:21d:a4c6:352b with SMTP id 1-20020a5d47a1000000b0021da4c6352bmr2529176wrb.365.1659653551042;
        Thu, 04 Aug 2022 15:52:31 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:30 -0700 (PDT)
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
Subject: [PATCH v5 14/33] thermal/drivers/armada: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:30 +0200
Message-Id: <20220804224349.1926752-15-daniel.lezcano@linexp.org>
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

