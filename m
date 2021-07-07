Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB03BE890
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhGGNQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhGGNQX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 09:16:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4EC06175F
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 06:13:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l7so2076603wrv.7
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/t4CGD6lK/wI3C8RkHXXrZaiSgvDd9+19bQ4kCEFaU=;
        b=RADpEqNaVLlpROdv1XXCYl2UPFMcx1pM6fbmXGmH+gKqX+9n9pUAgw2G16blT2kcIS
         ETYb0GOrTGPtISo9U0s8HeDHgHf51VIc/oJlXZ5idYdbWpQ58L/X4ccgm1mxD3sP+pc8
         3LscWHNBHdA3OF3K0HgEyEOfU+5PnHOrJc7rHIhquJw/t9R2kG6H9EMJES55ElWwxwc7
         dRYBUj0MiUPWXPbH2nfu9WwAZqKSUekTrK/jIGC27H+15YbPYnMqSVQA6TU18NZeiM74
         5Rkr46OpspsGC+APoo87gar0TDzQvEXyRD8htfYp5VXOih8i1y8GoTCPuxf4hB1p3ze3
         d2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/t4CGD6lK/wI3C8RkHXXrZaiSgvDd9+19bQ4kCEFaU=;
        b=EGcrde4u09boOknlnlemWFmhkboNMjhCPZRA/4STdbMJ8HQi/Qyqt6J/aUP8sg1vUi
         hTBech/A/y3roPrJ3HNuwgionf2xgU/HLAfYLSLifzYkAKcdje5amMUw8J/NNyH79WVH
         q5mJ7a3BnrA6pS4HGLnFnqYKikNUh1gu7ZVqjRJGd9dI71D/YVuPfa+BEnqYLH4dHDY4
         4+zr+U9Z+Keuu0+guP37HXkFZQ+3O2jJViFvHRnWHHbqPYdj+LwBZ5O5JTMPoR4WEn/v
         mjQpNp0V1tfvNgzsVEJN1+QuZ/ErOk3woHWDAGvVpqcBQNGpOMTzwkJ6i9Hvgbh74sIg
         NoqA==
X-Gm-Message-State: AOAM533jL21r2uQzNRnwVtnpvsc1tb2QEINc1jPhmOUWO9+u2kNQZEdO
        N1DZ+kFqnor8Lff2LqMkb9oG0g==
X-Google-Smtp-Source: ABdhPJydMuikwObnVEYluJdDMfadZYhP/Slwd47Db8z14t/7v79rjFofEaclJbDU+LAWDrfa4J/TEw==
X-Received: by 2002:adf:ce84:: with SMTP id r4mr15207462wrn.397.1625663620725;
        Wed, 07 Jul 2021 06:13:40 -0700 (PDT)
Received: from bismarck.berto.se (p4fca2710.dip0.t-ipconnect.de. [79.202.39.16])
        by smtp.googlemail.com with ESMTPSA id l20sm19233670wmq.3.2021.07.07.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:13:40 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/3] thermal: rcar_gen3_thermal: Create struct for OF match data
Date:   Wed,  7 Jul 2021 15:13:04 +0200
Message-Id: <20210707131306.4098443-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prepare for storing more information in the OF match data by using a
struct instead of a single integer value. There is no functional change.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 39 +++++++++++++++++++----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index fdf16aa34eb470c7..770f1daae5379053 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -79,6 +79,10 @@ struct equation_coefs {
 	int b2;
 };
 
+struct rcar_gen3_thermal_info {
+	int ths_tj_1;
+};
+
 struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
@@ -88,6 +92,7 @@ struct rcar_gen3_thermal_tsc {
 };
 
 struct rcar_gen3_thermal_priv {
+	const struct rcar_gen3_thermal_info *info;
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	unsigned int num_tscs;
 	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
@@ -243,44 +248,50 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
-static const int rcar_gen3_ths_tj_1 = 126;
-static const int rcar_gen3_ths_tj_1_m3_w = 116;
+static const struct rcar_gen3_thermal_info rcar_gen3_thermal_gen3 = {
+	.ths_tj_1 = 126,
+};
+
+static const struct rcar_gen3_thermal_info rcar_gen3_thermal_m3w = {
+	.ths_tj_1 = 116,
+};
+
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	{
 		.compatible = "renesas,r8a774a1-thermal",
-		.data = &rcar_gen3_ths_tj_1_m3_w,
+		.data = &rcar_gen3_thermal_m3w,
 	},
 	{
 		.compatible = "renesas,r8a774b1-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_gen3,
 	},
 	{
 		.compatible = "renesas,r8a774e1-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_gen3,
 	},
 	{
 		.compatible = "renesas,r8a7795-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_gen3,
 	},
 	{
 		.compatible = "renesas,r8a7796-thermal",
-		.data = &rcar_gen3_ths_tj_1_m3_w,
+		.data = &rcar_gen3_thermal_m3w,
 	},
 	{
 		.compatible = "renesas,r8a77961-thermal",
-		.data = &rcar_gen3_ths_tj_1_m3_w,
+		.data = &rcar_gen3_thermal_m3w,
 	},
 	{
 		.compatible = "renesas,r8a77965-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_gen3,
 	},
 	{
 		.compatible = "renesas,r8a77980-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_gen3,
 	},
 	{
 		.compatible = "renesas,r8a779a0-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_gen3,
 	},
 	{},
 };
@@ -307,7 +318,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	const int *ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	int ret, i;
@@ -320,6 +330,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->info = of_device_get_match_data(dev);
+
 	priv->thermal_init = rcar_gen3_thermal_init;
 	if (soc_device_match(r8a7795es1))
 		priv->thermal_init = rcar_gen3_thermal_init_r8a7795es1;
@@ -352,7 +364,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i],
+					     priv->info->ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
-- 
2.32.0

