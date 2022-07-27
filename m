Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC758348C
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiG0VFO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiG0VEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:04:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E83606A3
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b26so26104556wrc.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQwrODMneSzL3hNZushZmArM7t54Sdd+4j1p+OO3JS8=;
        b=ffvsBioqqTK3v5XHBc8wI1FNEys0b05prCWWYQB0YJfH9vPoQpT9lM3vMc/YC8uktE
         Pc6Qzclhv74Iw7MB3B1YV2A6dh6SiTlrsBy8PcgGbcH/83f2GOV2vertbN1WNQTr9Vs8
         CukW8ksaHHH9JkkO+VMC9v91wH54fFHkhjWwGKpTugpoz34qqsmYNINA3tz0yGCKv1s5
         U4t0JQ1tKsvAJ5DbhgPacyAdzGft7eST0CIltom+ojNJZaD5vijOITQ7YqjEDcPqE/g1
         19ip07LGGtVB0UeTk24pdVbtb+623Q/kghSkVcrxJeiFawwAkVY6R3cha1liIyR2Pswj
         0b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQwrODMneSzL3hNZushZmArM7t54Sdd+4j1p+OO3JS8=;
        b=28Btti5GHVaG8WqEy1nqDSoUa4IT410HqUddLaSNPIihP7S1C1OxtYwUuOa2zESKRa
         z6iuU35a/5+zU6Xr0Z32GDT3GpzRn28O/lYf/9vHpRXdT3aI8aB3nhWb849Q5+hxV12H
         b5jK+/MXMnFh6kFrcO8fp/o+4g4lw6FCexwMHYYsnRofHJ6nlBKFD0dBSt5pMZGQ3GEZ
         1w0feJGPN332He4ZKATAsXeefO1J3tDU9xThVnaFb1sfi8QEeErwSIbryCOSUuyJUMqE
         51oB1jCd0vp/snZorrAqqKLqrqpPZ9zekKoP4XMF5tKWZPC/T5x4/cMth98z+8pdj2eW
         yJtw==
X-Gm-Message-State: AJIora9HGIDTO5wl7JHOaQFYay7AaykwbMXdDsM11bjIwY/+TGSwYhmC
        Jc8wpuTFUGy4KJgPw5xESsub+g==
X-Google-Smtp-Source: AGRyM1vmg4NqC67WxLFEzrZYmRP8JolVODWDtBaJFUKKAuwQ9/Dl5us4zOVnKhcNZ/8q2xZppD91xg==
X-Received: by 2002:a05:6000:1548:b0:21d:acfc:29f5 with SMTP id 8-20020a056000154800b0021dacfc29f5mr14745388wry.520.1658955846994;
        Wed, 27 Jul 2022 14:04:06 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:06 -0700 (PDT)
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
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH v3 24/32] thermal/drivers/ti-soc: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:45 +0200
Message-Id: <20220727210253.3794069-25-daniel.lezcano@linexp.org>
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
 .../thermal/ti-soc-thermal/ti-thermal-common.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 703039d8b937..8a9055bd376e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -65,10 +65,10 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 
 /* thermal zone ops */
 /* Get temperature callback function for thermal zone */
-static inline int __ti_thermal_get_temp(void *devdata, int *temp)
+static inline int __ti_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct thermal_zone_device *pcb_tz = NULL;
-	struct ti_thermal_data *data = devdata;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
 	int ret, tmp, slope, constant;
@@ -85,8 +85,8 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 		return ret;
 
 	/* Default constants */
-	slope = thermal_zone_get_slope(data->ti_thermal);
-	constant = thermal_zone_get_offset(data->ti_thermal);
+	slope = thermal_zone_get_slope(tz);
+	constant = thermal_zone_get_offset(tz);
 
 	pcb_tz = data->pcb_tz;
 	/* In case pcb zone is available, use the extrapolation rule with it */
@@ -107,9 +107,9 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
+static int __ti_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct ti_thermal_data *data = p;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	int id, tr, ret = 0;
 
@@ -130,7 +130,7 @@ static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
+static const struct thermal_zone_device_ops ti_of_thermal_ops = {
 	.get_temp = __ti_thermal_get_temp,
 	.get_trend = __ti_thermal_get_trend,
 };
@@ -170,7 +170,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return -EINVAL;
 
 	/* in case this is specified by DT */
-	data->ti_thermal = devm_thermal_zone_of_sensor_register(bgp->dev, id,
+	data->ti_thermal = devm_thermal_of_zone_register(bgp->dev, id,
 					data, &ti_of_thermal_ops);
 	if (IS_ERR(data->ti_thermal)) {
 		dev_err(bgp->dev, "thermal zone device is NULL\n");
-- 
2.25.1

