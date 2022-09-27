Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F225EC656
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiI0Odz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiI0OdI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4991D04
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bq9so15328554wrb.4
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7e6ctEATW9s/XP6ppX0yJV3WjnU6tGYDDticrBE+dlY=;
        b=SEmC5HLruQb91q4xBajU66upItPLiebtVT+iFt8mtN7HOClv+DHAX4ENbahzbJnTwb
         SEdAu8gmbCLC6NEOOseU4HT3h/Yq+/aPIFuNY2b0Rl14tTKlF2KAwOHr2wcE7+8Mss66
         +mybXU0pcrFQ5Z/pd0kQJ01p5cm9UwtTgjZUAWh+7YrcP3DF3XF4JmaeLwMMscQG9oKv
         1F8ywgXTIUVnl/BL0XYojIghFRujPhMOaPy6ASX4QsLgzPp4tFXsX0sfG8zRYWbfVihU
         Y3pBO0vq+Cyqa3j5R5kU+FkNc32w8niSCS1RKh9aLwDsBITjQ6VFxjsrsu3fNOLE2UyI
         R0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7e6ctEATW9s/XP6ppX0yJV3WjnU6tGYDDticrBE+dlY=;
        b=dT7snNRJzEuvRUn0yX7JSSsZdRJbkjHdgT+1FpT+49EiJoTnq6C8r/7vGAUuqT2IR/
         cX3TcRp/FLnCodLbrH4Uav+3zQCiWit1OgQBe973vUGtpPZQ1XhUojxznSCzyxfljpA7
         k91V7yPE9O6B5VITeob5w+5fhpli5qf5nti8mY0kfKLAYkdv2WmVLIhZ97d9rsCORJDR
         C9rVyljAhUeB2CzmBeHF1hTAKTcYOLJjgbl2s4EMdsk0+7aKxkpDseI0n7JGZ0B9iekn
         Lw0DGKWdNo8P8NVYofw9n2UBbsGnNN/cZZns6iUfPa3iaL5z7/9Aoz3bGjHRLKzqL62u
         7JJQ==
X-Gm-Message-State: ACrzQf3LMX/T88ak0wHgQgiYS8jW779m2YATI9FM43Z+qaWAwAZDsl/l
        zgJ82sU9X8O5AtQZTDp//ID2xw==
X-Google-Smtp-Source: AMsMyM6+gMUdLIWCRExVkHM3ZcD1DnU1ZN99swSZ69fg1w96jdY+BmwDhRzTfea+KoLj36DG3IUmAw==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr8180737wrn.251.1664289183486;
        Tue, 27 Sep 2022 07:33:03 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v6 09/29] thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by thermal_zone_get_trip()
Date:   Tue, 27 Sep 2022 16:32:19 +0200
Message-Id: <20220927143239.376737-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

The thermal_zone_get_trip() does the same check as
of_thermal_is_trip_valid(). Replace the call to
of_thermal_is_trip_valid() by thermal_zone_get_trip().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 91e6860b5ec4..34b460092308 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -554,13 +554,14 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_trip trip;
 	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
 		for (i = 0; i < data->ntrip; i++) {
-			if (!of_thermal_is_trip_valid(tz, i))
+			if (thermal_zone_get_trip(tz, i, &trip))
 				continue;
 
 			interrupt_en |=
@@ -584,13 +585,14 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_trip trip;
 	unsigned int con, interrupt_en = 0, pd_det_en, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
 		for (i = 0; i < data->ntrip; i++) {
-			if (!of_thermal_is_trip_valid(tz, i))
+			if (thermal_zone_get_trip(tz, i, &trip))
 				continue;
 
 			interrupt_en |=
@@ -615,13 +617,14 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
+	struct thermal_trip trip;
 	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
 		for (i = 0; i < data->ntrip; i++) {
-			if (!of_thermal_is_trip_valid(tz, i))
+			if (thermal_zone_get_trip(tz, i, &trip))
 				continue;
 
 			interrupt_en |=
-- 
2.34.1

