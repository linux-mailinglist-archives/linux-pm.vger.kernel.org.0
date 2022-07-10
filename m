Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BBF56D190
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiGJV0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGJV0I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:26:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8D167C2
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2016068wmb.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Aunvp/iYMS8pcoGvhfIfGnTYbyHokkHTs118eswSpg=;
        b=w3hpVkQHlKdu2FNgs5CqaEdMDRWw8bypxs3lYUQaPMfhjwtp67Ase0c5cc+9euWkZK
         PqydKmrl1qG9jxOsyimgCQzFz7JwRMiAHwncz3eth9b3NnVIKC++F2+ilD+4nXli/3+z
         LE6ls0jC3L1WmSczRx4QJ5P1ItA4P5gFIru2PCNpWwKRz45UIGsNytNdkfXIxj62ZPE9
         EMqlxuzzlKnBZ6paXDuM1vTW8EU44nyVz4CPAPlN/X8MJIOs7fYF0nOvHOJpPb3XkLwU
         A3alzVw9QdmkjllSJP9rQqFODOPvKCejvyTYb6Ht6vVal1CzVWSWDG4VxQ4icHaJRDTy
         q/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Aunvp/iYMS8pcoGvhfIfGnTYbyHokkHTs118eswSpg=;
        b=Sjsas1aNc/GKyTkKXLfWSEs+dJcPbitgqyiasB14vqZYAqbIWU1QGs3BxseNJnGuuk
         3X+Rs5KWu1Ti9/MAi05j4CjRnu97NM8hI4BnDPkkLC9LgLmvR+JOxUciYqEMB4+9IIO8
         SV1a/4rncb9RAZDwmD6WTomR570xC1RIuIWWkyIool5tHBt++UIBVGlq19ZqpbsDioxI
         IWkNICzok3aTWahey2465Y3iBzQ3FgMcPTliL/USJZ98DZIWzocjh/Hiy94azsn4NGcl
         /JwBApmfc5ZcPIxWV0XhP6LDku9I1HDCwOaO/K6xjmNe9LVUsJS4qVsIzUMWPugfK5cQ
         Xm0Q==
X-Gm-Message-State: AJIora8lCpoasK4uM74wHzwRm9Rwn0paftF474PxcMnWkpTSDTKplGEd
        /n1PgRg8syCOd+aZkmBak1P/XQ==
X-Google-Smtp-Source: AGRyM1uNKZQ3H9umrHP9IZ+HKT3YIJqmLCKPFJOqqPQG1gwI4h1VW7wlx7hom6nNQgThL6DCQeqaOQ==
X-Received: by 2002:a05:600c:3592:b0:3a1:9e9d:2595 with SMTP id p18-20020a05600c359200b003a19e9d2595mr12531906wmq.76.1657488313198;
        Sun, 10 Jul 2022 14:25:13 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 23/33] thermal/drivers/hisilicon: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:13 +0200
Message-Id: <20220710212423.681301-24-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/hisi_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index b29ab09040d5..a0911d31555f 100644
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
+static struct thermal_zone_device_ops hisi_of_thermal_ops = {
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

