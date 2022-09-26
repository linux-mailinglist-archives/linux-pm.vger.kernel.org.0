Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F332A5EAA3D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiIZPTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiIZPTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:19:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15708284B
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso7605204wma.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7e6ctEATW9s/XP6ppX0yJV3WjnU6tGYDDticrBE+dlY=;
        b=yXgAz7fHswCIEtOIYeo9cgpLiiJBWfgvR4uHjBK+K3qUYbnA8Y++ovFczH2C2Z7gtU
         N9C2D/iFJgdiYBdSN8O/VHkxCnNTG45plxKso6KCjXls1Jyot4+M4i82ezxMXH6d7U24
         TG2E+oksIjDAputjsIhcsdUgxOX8SKFQYt+8WdKoC13fpMeTX/VQDK/tFu/VJfWdG+ny
         snjNU2/Xgz7PLDUjyfNwSLF+WOOoiJXEJVo0Qyuky86Wm2qjhG1STdPTdjEUJPIAe/uB
         hHZqWe/jK0wKdeMATM2ltoobIgkwpjo5Uwra5cIi8i4cE1ARfJYc01OvLEFAW9NF2j5c
         R1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7e6ctEATW9s/XP6ppX0yJV3WjnU6tGYDDticrBE+dlY=;
        b=UvT0LJASMVfc7bWNrxa+FOdTcUTS1ZdzvgAiKF+VdrrVPhkx3n5C3qr5SBYpyrt9qr
         bs4G56L4qt1FGJRzW2IwhXrilTJ3pXbNy6wV7iCjJEySMyj8VrKTpuWITMN7otDzjxpS
         lU590I1gWWhf0seuBJnhaI88pp5b+E9J9p2WSdXCA2Aupp47mZXsTzog6kte+XorM9Ph
         aN+Wj3JFAuxCY1nXnW3ZkYTjRboq+E/XMdZcJZQI3j6hiF8hdOx7gHVu8dz1dCtp04zg
         U5Zzdbr8gpF2TFbbS9YQZU0euiD/oBYwS5bTpt1J/o+o5rw1H96vOUbkAoyQLVukoZQw
         J4/g==
X-Gm-Message-State: ACrzQf3pnpeihoyuBKff4Mdfqin8WAEZAn9V78JYbu4l2KkF9YDScqaI
        hdgxdfk9z0Rlbo6M2z55dDXzig==
X-Google-Smtp-Source: AMsMyM7TAKm/5G7gkn7KlWPaE8c2DactDCCCu5Mc+JzPmPF6T54v2Ql/KNI5i3Xl9udNqwWnFigHQQ==
X-Received: by 2002:a7b:c050:0:b0:3b4:fae1:6bce with SMTP id u16-20020a7bc050000000b003b4fae16bcemr14732183wmc.131.1664201190192;
        Mon, 26 Sep 2022 07:06:30 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:29 -0700 (PDT)
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
Subject: [PATCH v5 10/30] thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by thermal_zone_get_trip()
Date:   Mon, 26 Sep 2022 16:05:44 +0200
Message-Id: <20220926140604.4173723-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

