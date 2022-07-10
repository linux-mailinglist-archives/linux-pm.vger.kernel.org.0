Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BAE56D17C
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGJV0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGJVZ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CC15FEE
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l68so2052505wml.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IoU0PuNuCRcBh+gum4Wd5t5Tge49JrI8fmxQkb2xQI=;
        b=VHvF9bowyvjKbhs3nKAQr0yL/YBT0FIp4Fpto86reo5w9jDV5TBOxiWH93V1G4UenW
         Eqp1O+ORe8DqWkkcTrZZuSpbp5BlxGr7LMzm1MT5bsVkpljWUqI9+GM3kZzdqsJ7u322
         PkQ0qIKn3KAf9Ig9YeMmxQIPZ1o4558waWmxz2P9TE0Y40JifHASUmsajnjQvWqNJk5R
         71uam9+sSqF1QTu8ZSDfUrfjrPbI/AeChPArx40sl16b20FXzqhXXWTU5597OTnfOR36
         nG4Hyahg4H6OlL9BCUvwkZBczE/wbO0QsxUwGK8b5k95y58++P6PKJXponhL8LOaOU/k
         tKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IoU0PuNuCRcBh+gum4Wd5t5Tge49JrI8fmxQkb2xQI=;
        b=KiGM6Yhk6M8s+dtLtp1IlCRZwPNhThRMTEzsYB8g33/LK/661TKg1onLX4yKTlx6M5
         RGxgL4S80bFtC4PjdWil0is6CMAfBmPApQpY8FDA2ka7OFMKLswX669zGfc36utyxzSD
         LPW/3U5cXQI1AT0R0A9E4HRFMhicztM9AsXZnt7HLEhUb+Og7yMutULFazxbe1kWOZGm
         FFBpGqLxHeHoakxMJCnVsHcz16zMfmm1RY2g23ud9Cc0bs7/2AuzhQMfKQ+4HFhw0rH/
         k0BQDLmpL7WBS7TLJ3abvULZYT8Naz2dFLAjCmu1AIApm1mLVaxf+H3kQng1hsiYr6YS
         gLjA==
X-Gm-Message-State: AJIora98aDSx8q50ZmI4+sro5WD8LBC1hoJC/60fjT9n5Sb0EQ4CghYo
        Tg17w3Q4Zu7F4cypFX1/QBsZTQ==
X-Google-Smtp-Source: AGRyM1spXhMkMTmmqCi49PMudOLtGq3ZW+qNmbnk9hVYAcyFndJGxL+k0SSuo+aTO25YzIS1GQm9lQ==
X-Received: by 2002:a05:600c:2059:b0:3a2:e5a4:ef8 with SMTP id p25-20020a05600c205900b003a2e5a40ef8mr4081389wmg.146.1657488300613;
        Sun, 10 Jul 2022 14:25:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH v1 12/33] thermal/drivers/st: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:02 +0200
Message-Id: <20220710212423.681301-13-daniel.lezcano@linexp.org>
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
 drivers/thermal/st/stm_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 5fd3fb8912a6..e4ca0d504a4f 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -302,9 +302,9 @@ static int stm_disable_irq(struct stm_thermal_sensor *sensor)
 	return 0;
 }
 
-static int stm_thermal_set_trips(void *data, int low, int high)
+static int stm_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct stm_thermal_sensor *sensor = data;
+	struct stm_thermal_sensor *sensor = tz->devdata;
 	u32 itr1, th;
 	int ret;
 
@@ -350,9 +350,9 @@ static int stm_thermal_set_trips(void *data, int low, int high)
 }
 
 /* Callback to get temperature from HW */
-static int stm_thermal_get_temp(void *data, int *temp)
+static int stm_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct stm_thermal_sensor *sensor = data;
+	struct stm_thermal_sensor *sensor = tz->devdata;
 	u32 periods;
 	int freqM, ret;
 
@@ -474,7 +474,7 @@ static int stm_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
 			 stm_thermal_suspend, stm_thermal_resume);
 
-static const struct thermal_zone_of_device_ops stm_tz_ops = {
+static const struct thermal_zone_device_ops stm_tz_ops = {
 	.get_temp	= stm_thermal_get_temp,
 	.set_trips	= stm_thermal_set_trips,
 };
@@ -539,9 +539,9 @@ static int stm_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	sensor->th_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
-							      sensor,
-							      &stm_tz_ops);
+	sensor->th_dev = devm_thermal_of_zone_register(&pdev->dev, 0,
+						       sensor,
+						       &stm_tz_ops);
 
 	if (IS_ERR(sensor->th_dev)) {
 		dev_err(&pdev->dev, "%s: thermal zone sensor registering KO\n",
-- 
2.25.1

