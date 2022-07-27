Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1EF5834AB
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiG0VFL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiG0VES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:04:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5B5F13C
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u5so26091899wrm.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=KhulOyTousD2CUBzCgLLxv19Gyw5zkhF7Wr1dkHa1qa89xjJZwjIjB1g53ZD1gBuST
         aVRSG5mJY2FJrAhNun6AWmwI65rJIOx/L4wAf/oMb6Wuwr9RrXHxVsCCFcXFXjV26aEY
         jBPqs0biNeu/X4HmIkZQ11+bNl0UJ5LG+FkPTAWIbo57QPjxA1x4tsODIa80HiusV7k3
         eOdjROrkhXPC4Kj6Cdidx/5XtTEvhnOHUoSPpgVGQn6cfpuV3aGeX1SqRun3t6uyFktX
         8kj1lpYxXRVQF50QhfOsQAQlgVo52FjkkV09qoBiYYSoLSqRQn3usAOtjbrOgTs5gvqL
         yOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=vcILn4i1/h88la1nH4vB/YqnwU7XRRdvTaU9EJZ3i0WtZ6prhI3LOs6L3mGhOiGk7N
         w+geg/U0PrMUq4AYPkmm3c8o1gYpw6nPqzDIpI2vNXXnjkQLwbnhMh5M0JyMkUHgd11p
         X9+ACrj+EAAPDqFgJkjiYmp16SETbbR7NENjOUdnbO2G+ZzEY3Wqq9HwVPE4zk4Fb+/Q
         Fz1avOR0c5X/2Eb9OjH+uuAufh4nf75dLKtO8MV3IwamWTWJ726Vn5R5F7AsvWkWMnyR
         NcLHmMaojowkB8ip2+OZv9UH9ceDzdzQm3uOcs2sZqozh2/O8Zk6VgsY1OE+CD9MwDZA
         vhCw==
X-Gm-Message-State: AJIora/YxsvgkZwoO4kwaGG73N9gdUaxG4xHmUJEDnKZQSBHWi3d98vo
        uMpTRhMUglhDV4I3/T5mJKqVrg==
X-Google-Smtp-Source: AGRyM1vXYm6BrBXO6KwH969uExGdm1BhoPtU7z+e1GfJfnhQQ87BdJeG0siLi3U2IfDBnf20jG7K+w==
X-Received: by 2002:a05:6000:1a8b:b0:21d:9ae8:f8d9 with SMTP id f11-20020a0560001a8b00b0021d9ae8f8d9mr14494612wry.686.1658955844784;
        Wed, 27 Jul 2022 14:04:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:04 -0700 (PDT)
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
Subject: [PATCH v3 23/32] thermal/drivers/hisilicon: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:44 +0200
Message-Id: <20220727210253.3794069-24-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/hisi_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index b29ab09040d5..cc5da71b6f55 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -442,9 +442,9 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	return 0;
 }
 
-static int hisi_thermal_get_temp(void *__data, int *temp)
+static int hisi_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct hisi_thermal_sensor *sensor = __data;
+	struct hisi_thermal_sensor *sensor = tz->devdata;
 	struct hisi_thermal_data *data = sensor->data;
 
 	*temp = data->ops->get_temp(sensor);
@@ -455,7 +455,7 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
+static const struct thermal_zone_device_ops hisi_of_thermal_ops = {
 	.get_temp = hisi_thermal_get_temp,
 };
 
@@ -467,7 +467,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 
 	data->ops->irq_handler(sensor);
 
-	hisi_thermal_get_temp(sensor, &temp);
+	temp = data->ops->get_temp(sensor);
 
 	if (temp >= sensor->thres_temp) {
 		dev_crit(&data->pdev->dev,
@@ -492,9 +492,9 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 	int ret, i;
 	const struct thermal_trip *trip;
 
-	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							   sensor->id, sensor,
-							   &hisi_of_thermal_ops);
+	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
+						    sensor->id, sensor,
+						    &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
 		sensor->tzd = NULL;
-- 
2.25.1

