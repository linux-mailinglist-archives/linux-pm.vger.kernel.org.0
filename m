Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE59A56D17F
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiGJV0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiGJVZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB516580
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so1708850wmj.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIrYHdunDMNAaNv/cr2l2s9gzRoDCmmdOZhp9vHA0Pg=;
        b=xzuExPhLyZNT9Zy3FaJg94nYwhOlAT4SfKQiZUdd3fGjB7HzxRTlbiOJXjulUcfBHZ
         IZFIbV5UR9MpAPz6L5RXc/1LFwUbIfY/mDvZl8TlrG0tcWPU6/9TZ+IB0uwW4JXRdyVp
         DOWzb3doIR5w7in3sFPD7mbWEHK+rzFtsOh+LbcAOOL0BNgvUYQ25YHSOldWRkkIOjgc
         RkEm5UVwMeudS4OBhOhP4yf+HA7iJmCXSv5+WfUcwq5SwoHVNVR70MaTvtW9POVr44JU
         t3BRQqRVay5ADbzx95wU0M0BHxvdCvgCXYnKqvnlRg7CFXy8dCR2IMlFbUk6TGquiJ10
         kAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIrYHdunDMNAaNv/cr2l2s9gzRoDCmmdOZhp9vHA0Pg=;
        b=byk3dBjWXvqKKmtBWB/t8eBTrRzWb9WH4wEe9d6xQl2Ve6ZWXbkfqQ3wMCWZJZzjI0
         eLLaDz2jChLIOpvuFpsQOskG+9p2oA0hefNG+8Lw8Ni/omVdPJ84+XxsbllHK+pJErXF
         dnwfofdd3VDWI99BYfydTDSzAyopqhssmOb9OTVIYeOxC83AGlGdzCwMWI5SQEQeyvAb
         jptzx1VQpDN3QGYhK2KtuG3Twfqw+XvbGZFkcoHjeUaaJIG61bMjaxNuUbtLxOAaDZLC
         H+1FYJPe3lvTHlEJcLjJyVVjBixuW6Z8NcZMhg8IQ6NKqNQPUTsWnn1m9iQ8EfS+LLIF
         hz5g==
X-Gm-Message-State: AJIora8HZkYuM8WcCvbZn4+e9ysg+XYW2pKL9/7gZKVrjamoo7LRqPs8
        zTJ22sNb5m4cMh4MCKxfM6krlA==
X-Google-Smtp-Source: AGRyM1uvzqJzJtxgyDE2ree8aDA6PbCq068TJrnL8apJqaRJojcR9D3XiSKrrlMvu0IWqqL2SLiqgA==
X-Received: by 2002:a05:600c:1d94:b0:3a0:4e09:122f with SMTP id p20-20020a05600c1d9400b003a04e09122fmr12765276wms.190.1657488314376;
        Sun, 10 Jul 2022 14:25:14 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH v1 24/33] thermal/drivers/ti-soc: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:14 +0200
Message-Id: <20220710212423.681301-25-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../thermal/ti-soc-thermal/ti-thermal-common.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 703039d8b937..89a2bd46ebcf 100644
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
+static struct thermal_zone_device_ops ti_of_thermal_ops = {
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

