Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3D5EE796
	for <lists+linux-pm@lfdr.de>; Wed, 28 Sep 2022 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiI1VD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Sep 2022 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiI1VCz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2022 17:02:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D9D4DFE
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 14:01:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m4so7263508wrr.5
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2022 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=wZV2rEDwrDw5kpAU9+Bi9dO9ZBdeVO8J/+L+RijbP1djAwa+2xn+Y12ZGq1moDyERY
         5ir5QR5AurdNpU95A/SrJ11fv0cWt+FB2m7hdjb1F+7aoIYlYtIxSJ70dGTjp39mhSAm
         EDG9q2/XGan2YiYfzRDm1yTPpzdA4shtv63P90POOS8+2ZhQ4zrspnYeNge35+tTXSum
         J0nkc1RO8S+Jjrna4Ap3ZxU3fNBMBaiEzLZnB+6LjiHpkK91sdtKiuatFzg853H4Acdl
         1BRQrycuByu4yBf1cATx0bEcc1ZNnPCsmKjHoc9hpBCdX6tPASFnMqQBRN5pgl+2dqjl
         hX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=NgMN24XnX2CTFHBRpRkKL7Xrdbe2/ca426ULeLWiTuH0CP5Qpl4DbhVgfOk4AYeYyE
         m2NefCIMTDMumbTQ5b9WMFlrQ8fpGgjekLoFOejuaRMkWAuTCDrw2wplWNSOLKF+LM9m
         Q0K95vHCsy9aITP86Eq6Qy3pdEGYkXMZ4pU9DJbZPSqa8rPNvRRwb8PZ53M2E0KIpMvd
         AJikQCb5xXiMjAR4JeYKD78PEIlbzr03J9QNUwBCmYuCik+nPW6EjkxlAWq0B+Wxmf/y
         ttTWphpYv+B4lzy0q+2g+InMHbTjTQYfSIOYs+oIT85Nhes0iruDB7o0bUPBSIiqOxI3
         KgCA==
X-Gm-Message-State: ACrzQf1shFxc1UgLUze8AcmhLZ1kspW0OYIiUR/mCYHmCKCjA+TW3XCl
        pP/7f73aJmhCeM3ap1BZvFG3Vw==
X-Google-Smtp-Source: AMsMyM7dDhqDgJcRydwoWSV7TZyxv5/63dGHFdLNlrhleVzpuEP1jMN50d18uCFk2zSz1cxZ6D39gA==
X-Received: by 2002:a05:6000:78a:b0:22a:c9d9:4449 with SMTP id bu10-20020a056000078a00b0022ac9d94449mr21102804wrb.189.1664398906644;
        Wed, 28 Sep 2022 14:01:46 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:48a2:39eb:9d1b:8b8d])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003b4931eb435sm2874300wmq.26.2022.09.28.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:01:46 -0700 (PDT)
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
Subject: [PATCH v7 11/29] thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
Date:   Wed, 28 Sep 2022 23:00:41 +0200
Message-Id: <20220928210059.891387-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928210059.891387-1-daniel.lezcano@linaro.org>
References: <20220928210059.891387-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/thermal/uniphier_thermal.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4111d99ef50e..277ae300c5b1 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -248,8 +248,7 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct device_node *parent;
 	struct uniphier_tm_dev *tdev;
-	const struct thermal_trip *trips;
-	int i, ret, irq, ntrips, crit_temp = INT_MAX;
+	int i, ret, irq, crit_temp = INT_MAX;
 
 	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
@@ -296,20 +295,18 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	/* get trip points */
-	trips = of_thermal_get_trip_points(tdev->tz_dev);
-	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
-	if (ntrips > ALERT_CH_NUM) {
-		dev_err(dev, "thermal zone has too many trips\n");
-		return -E2BIG;
-	}
-
 	/* set alert temperatures */
-	for (i = 0; i < ntrips; i++) {
-		if (trips[i].type == THERMAL_TRIP_CRITICAL &&
-		    trips[i].temperature < crit_temp)
-			crit_temp = trips[i].temperature;
-		uniphier_tm_set_alert(tdev, i, trips[i].temperature);
+	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
+		struct thermal_trip trip;
+
+		ret = thermal_zone_get_trip(tdev->tz_dev, i, &trip);
+		if (ret)
+			return ret;
+
+		if (trip.type == THERMAL_TRIP_CRITICAL &&
+		    trip.temperature < crit_temp)
+			crit_temp = trip.temperature;
+		uniphier_tm_set_alert(tdev, i, trip.temperature);
 		tdev->alert_en[i] = true;
 	}
 	if (crit_temp > CRITICAL_TEMP_LIMIT) {
-- 
2.34.1

