Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398455EE73F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Sep 2022 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiI1VET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Sep 2022 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiI1VC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2022 17:02:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4BD62F6
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 14:01:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso2063133wmk.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=QZVTEavlb0VBg8L+KAfL+BOqtjYbh1+jB9Y5bUh35EsJFclMDgQB/cnzLIkhjKULq6
         iMvXMTQZj/AJiXJc9g8rM87WL8pA7/y2kjI9UsMIqx+oS9Mwna/zWjCQGQK70zvKRwz8
         Rh2PHR/1eLPmSGiCdH7pvUzFB9kzs7AWnI20etsSr4gDPY2rNFuN6IgRnQghaVI914v9
         2Ev8DpH5JY3GC9Zw2AVeyh9gfiQW4TfCyrdYELjAJy2A9KB0/Ty6Y08EOGqRtEReR+vA
         TCVpksKLmd7bRuBfrLQI0ehzJq7D5xDcEQBwFfvhSj9PN7Jx2bsU2RE+g6N6elKDRSX+
         3Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=Z3oU/b8jSGU7wzHis9/apQxUYAeay7CzJ2HE9L3cZmW15cuvvkalgSFLKdmsrD695G
         +2nt24WQanHKvISE8r3HHg1uo70m/yaI3vrBIkXLDDxC43qQG6fB3iYGhXdrRv82uo57
         HEmrLpoRtTUTFQ5u3th8OJG82YMknuiUJg1j14MSZU5IkHxidj6ZaxVvEDOZebpm5eIP
         bzVvlWqqT/8NaQZKTO0WUNHRbHOsfUdqFK6U5Wz2RLcyWuGznfyCvNZTk/0Pn0euilVT
         ju2aMQe3Zov13FE6tCb5U+dI1BrXuNPS/YpT7N5QW1el3pKHJUA4R4ZqUqNuvVhMgX/I
         ST3w==
X-Gm-Message-State: ACrzQf26LoRPKtQM2hHRdMflZ/NAh0jgwoy1+J0LWXd4Dk7+oJq1818P
        KatQHt7xnzDSis2k8PTc1ntO1w==
X-Google-Smtp-Source: AMsMyM7QvHqUQ1S+SgNjtj7GQM2yaKFsz7JbtjgJAJADe6BEH5W/12xq0l6cSINbqxL7sPoGQsMdsg==
X-Received: by 2002:a05:600c:4f56:b0:3b4:b6b0:42d4 with SMTP id m22-20020a05600c4f5600b003b4b6b042d4mr8234359wmq.143.1664398909983;
        Wed, 28 Sep 2022 14:01:49 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:48a2:39eb:9d1b:8b8d])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003b4931eb435sm2874300wmq.26.2022.09.28.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:01:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v7 12/29] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Wed, 28 Sep 2022 23:00:42 +0200
Message-Id: <20220928210059.891387-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928210059.891387-1-daniel.lezcano@linaro.org>
References: <20220928210059.891387-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d6974db7aaf7..45226cab466e 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -482,7 +482,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
-	const struct thermal_trip *trip;
+	struct thermal_trip trip;
 
 	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
 						    sensor->id, sensor,
@@ -495,11 +495,12 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
-	trip = of_thermal_get_trip_points(sensor->tzd);
+	for (i = 0; i < thermal_zone_get_num_trips(sensor->tzd); i++) {
 
-	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
-		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = trip[i].temperature;
+		thermal_zone_get_trip(sensor->tzd, i, &trip);
+
+		if (trip.type == THERMAL_TRIP_PASSIVE) {
+			sensor->thres_temp = trip.temperature;
 			break;
 		}
 	}
-- 
2.34.1

