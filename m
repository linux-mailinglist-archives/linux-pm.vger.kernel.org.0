Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F2A58A3A5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 00:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiHDWyl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 18:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbiHDWxm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 18:53:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E16A4BC
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 15:52:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l4so1308547wrm.13
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=ONlXQ4NqB3vgSX4uSliFdY3yNlFX4bZpvvDzZwFlFyr3ZLlO88lqPwrXqS55YesZ8e
         DTNI6aZvNZa2na35TxUOXs3x3d49FOgnNOoYfs/vJILt0dYPqOf4ABwjmHtSgR0D7FpC
         WycjoVoygBDjT52fGODVRcdVJzy1YQ2V+Nw8Rqa7NIEoqq4gXVPLR9RRsV/3+vhGBTqd
         L3IJqGo6PjzX0ddEmVsYl0sWpZXATF6aXd6drTHsACjXMHaaJB/jNfq2YQin+4IhhxBb
         +GqCpqocpp7NCuRG/ZvpnxDqD0gJM3/uSpyXLNj3Sp4cJRsENgfSb2c5USnGVYkeXte+
         MH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=yIXQcTjHEAHS7P7TgG+/vx6u6V2vhWODTGklDGp7vrtCFaGdgE+1QkSRDp8axsjyDu
         pPCyHlQLiEx5OFkj9dBiLFsMKtjS7+S/79pgv6/9R3jQPGFs1xrr74AFx3T1Dz8OMOZL
         234LRs5L58KOBwLTpM8MpqtpF1GvEHeznM+AgJAyejhUtdH5sMZBk0/2eNqpmgto+z0B
         TfIpB1QcRRcjsGXsWHYabghp4/dFEbNlKmE//996sh42sdXL8N6lOGSkxyJ5E2dXj0X9
         CVeIKIFykPAl7c+NPUDhPFdoH5W92efpzJaR1480ULBZBKmZ3o4Fd2GIU1lqBz2Ffx3O
         6WtA==
X-Gm-Message-State: ACgBeo0HLgioLSkRr8X+Fu6+cBV9zd1iAmYMDIwJJnDyu1B5dKob58rf
        e8hJhawiNDSW4M5tOQCcjy9MIA==
X-Google-Smtp-Source: AA6agR4g6r3oo/+sIPWsD7u5j6HFVbp0preuyhSD5qWUNZsEWfYRsGmZe6bMtIT4YaLiq7NckvDkzQ==
X-Received: by 2002:a5d:64e2:0:b0:220:7dfb:ab6f with SMTP id g2-20020a5d64e2000000b002207dfbab6fmr2549880wri.664.1659653570191;
        Thu, 04 Aug 2022 15:52:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:49 -0700 (PDT)
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
Subject: [PATCH v5 23/33] thermal/drivers/hisilicon: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:39 +0200
Message-Id: <20220804224349.1926752-24-daniel.lezcano@linexp.org>
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

