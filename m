Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB858734F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiHAV1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiHAVZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:25:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0548EAA
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:24:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a11so6357441wmq.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NA8ooyNHoaigd+w7aJNo47HL4zS61/xJOAD4qh1CGLU=;
        b=w2jDUzgwNchvSs1v6tRvBFqVca8W4hWNEqDy9Caw1BTZeGxpymLL+b3nJIYGBCfh5g
         d1jrcEGFgZpkAe0XVN8JaXr6pakwRasqfRVNPunGdWql56Cyqwo6MSDoqe+OuHgHr9ov
         YKP1Kvojuyv6gNw/MDdXRY3EpM2mB7pjVEJ76GpV2enW2nnDvnOoWs+lFXISe0nG6Euz
         qw/l6iKTNDg+K+Lg+zFdIyPkTA/aM0G8ZPPYM9nQF51T2YXdKHnjEocL3dIBbUSF2/p/
         KnwY0UT0oKdxYbhUG3maQvcEjkV4JfDUNKsTKihV4MYXC2Llwpolngnn05plA1LJJt6E
         0pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NA8ooyNHoaigd+w7aJNo47HL4zS61/xJOAD4qh1CGLU=;
        b=CQxjgYTfAozGLLDX5pLGDrILo76JSnr0lZssNOHtxizAooMcdDXUKnb542AEJNwzL2
         lRG41klkeuwp4qa4uYXthgHcq8xVwJPbwmLzkTCJe/6+47TxsewPU6EtGTnRJLPuAP32
         wiqc2TnFmvDQ1FPw04j0LeHxixxy4Fv/zsubWPFeAUWSgw0FBwtmlZbN03kkSljIcc9m
         w0ww9TjY0VXeC6CRLi1LYNaO/nUZXTWGRIjvLG++6xrtQiBi2MzL3EaRUjoFpf1Ll32t
         fSW/pw6bk51T8kdsCdUFGGz9f4AoYw2amhwF0pqSX3qcz7E9bhhmXkzyNKc0N3ibLGVC
         t10g==
X-Gm-Message-State: AJIora8D6iCIYfq7rIrF+Oh5Pym6Y4PYI434ZniHvxZv6HliBo0RCmNj
        dFnLUuyVWegzdMR+V1xoI9n28Q==
X-Google-Smtp-Source: AGRyM1vcT/J+/2tZaRsL7E9rIXxYSnSTyRRZcgmRdxV+FoQ9aITTaFpKM86GONYvq2VESgAN+qdqrQ==
X-Received: by 2002:a05:600c:4313:b0:3a3:2c86:9b5c with SMTP id p19-20020a05600c431300b003a32c869b5cmr12165938wme.65.1659389058774;
        Mon, 01 Aug 2022 14:24:18 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:24:18 -0700 (PDT)
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
Subject: [PATCH v4 31/32] thermal/core: Move set_trip_temp ops to the sysfs code
Date:   Mon,  1 Aug 2022 23:22:43 +0200
Message-Id: <20220801212244.1124867-32-daniel.lezcano@linexp.org>
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

Given the trip points can be set in the thermal zone structure, there
is no need of a specific OF function to do that. Move the code in the
place where it is generic, in the sysfs set_trip_temp storing
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c    | 23 -----------------------
 drivers/thermal/thermal_sysfs.c |  5 ++++-
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 07bde07ddc04..403064fed438 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -288,28 +288,6 @@ static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
-				    int temp)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	if (data->ops && data->ops->set_trip_temp) {
-		int ret;
-
-		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
-		if (ret)
-			return ret;
-	}
-
-	/* thermal framework should take care of data->mask & (1 << trip) */
-	tz->trips[trip].temperature = temp;
-
-	return 0;
-}
-
 static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int *hyst)
 {
@@ -350,7 +328,6 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 static struct thermal_zone_device_ops of_thermal_ops = {
 	.get_trip_type = of_thermal_get_trip_type,
 	.get_trip_temp = of_thermal_get_trip_temp,
-	.set_trip_temp = of_thermal_set_trip_temp,
 	.get_trip_hyst = of_thermal_get_trip_hyst,
 	.set_trip_hyst = of_thermal_set_trip_hyst,
 	.get_crit_temp = of_thermal_get_crit_temp,
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5018459e8dd9..3c513561d346 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -115,7 +115,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	int temperature, hyst = 0;
 	enum thermal_trip_type type;
 
-	if (!tz->ops->set_trip_temp)
+	if (!tz->ops->set_trip_temp && !tz->trips)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
@@ -128,6 +128,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	if (tz->trips)
+		tz->trips[trip].temperature = temperature;
+
 	if (tz->ops->get_trip_hyst) {
 		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
-- 
2.25.1

