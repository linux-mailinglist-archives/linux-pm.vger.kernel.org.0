Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32B56D160
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGJVYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGJVYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:24:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A01054E
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o8so2053305wms.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HjRFmpGybbr7CcVNDUXcigDJ5VrNfuY+c1EB/6AHNWI=;
        b=OxjhRHGwv3JxchWDTPUu1T+zywciRVphtTvXEmU6mUP2Q9Of5MXMuHJY5jKgJ6vOj5
         0FkeqDfjT/IT/xDaqYBzID/YeazVI30mFF4P5pEUJxCKFt1lqN5GhLAyfDCgXZZJaV2K
         dDfhBRDUjsb+PsEVfJszUYZM3197zydiypebSIPcqBt4cUhP+JV+xuPrRncSvDMKWF2/
         p/dTWys6Fe4NJQKArT17uycj3ES1nZJi8EO6o2/Jg5QJMl33K1QqSOkETVJK6m6IT0GL
         PtBaI7T9ekSbYG++sokQO3C4N5hDmtfflXY+DWamHH+PQP+iaua08bc9WYB0yvJY8Tec
         OFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HjRFmpGybbr7CcVNDUXcigDJ5VrNfuY+c1EB/6AHNWI=;
        b=wlthIuVUZarFOffi1eBFgS02MXkhLtgiyjXWTFdrtINq7rN9v4Pg+sWCbkVAtY9QQl
         1nOEQzd1OqXHIvcWPi6+6mTMGhbQOGNKrJ203uo/Puip1xfgRS8BS1/Sa+8++YCDbuOQ
         7LGGw7bDYKCy3LAWJXfjgGth23ayh30zaZR3mGsSdnExy3+mEuHtMo/USDBYrYlJ4qcJ
         RLDC5HcmNfKlpXvHzKKosQl/6rba7Z31v/Nz6a+fdrKubgoF3Ld8xemISME2ixKycU3n
         oY2n2YAsVAyHb7WZKVKi893Du3tJRjARabdpppP0TmLO0Ks7KJCzNVALdORtv4FkWcEM
         uWwQ==
X-Gm-Message-State: AJIora/b4+pfzkBNco0sysWSwaj6/4aiF7QYQoAF2XqK7c/mBQJknGUP
        3Qmp5UXOjyS9c/QnIDp1/z6aIg==
X-Google-Smtp-Source: AGRyM1usBJbr5Lkiq7/hO35XDewZS0GFLE3KDQw4iUzv5twxxD1w/8r2ebUW/ye7FMkxIGG534Tm/Q==
X-Received: by 2002:a05:600c:1c93:b0:3a0:579e:9f44 with SMTP id k19-20020a05600c1c9300b003a0579e9f44mr12373763wms.82.1657488278918;
        Sun, 10 Jul 2022 14:24:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v1 03/33] thermal/drivers/rockchip: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:53 +0200
Message-Id: <20220710212423.681301-4-daniel.lezcano@linexp.org>
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
 drivers/thermal/rockchip_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index dc3a9c276a09..ea3abfb8e6c8 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1211,9 +1211,9 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
+static int rockchip_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct rockchip_thermal_sensor *sensor = _sensor;
+	struct rockchip_thermal_sensor *sensor = tz->devdata;
 	struct rockchip_thermal_data *thermal = sensor->thermal;
 	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
 
@@ -1224,9 +1224,9 @@ static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
 				     sensor->id, thermal->regs, high);
 }
 
-static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
+static int rockchip_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct rockchip_thermal_sensor *sensor = _sensor;
+	struct rockchip_thermal_sensor *sensor = tz->devdata;
 	struct rockchip_thermal_data *thermal = sensor->thermal;
 	const struct rockchip_tsadc_chip *tsadc = sensor->thermal->chip;
 	int retval;
@@ -1239,7 +1239,7 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
 	return retval;
 }
 
-static const struct thermal_zone_of_device_ops rockchip_of_thermal_ops = {
+static struct thermal_zone_device_ops rockchip_of_thermal_ops = {
 	.get_temp = rockchip_thermal_get_temp,
 	.set_trips = rockchip_thermal_set_trips,
 };
@@ -1326,8 +1326,8 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 
 	sensor->thermal = thermal;
 	sensor->id = id;
-	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
-					sensor, &rockchip_of_thermal_ops);
+	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev, id, sensor,
+						    &rockchip_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		error = PTR_ERR(sensor->tzd);
 		dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
-- 
2.25.1

