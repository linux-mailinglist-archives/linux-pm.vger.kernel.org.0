Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245406EE30B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Apr 2023 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjDYNbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Apr 2023 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjDYNbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2023 09:31:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4ACC0A
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2023 06:31:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso19184455e9.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2023 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682429459; x=1685021459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq0Tzb/6a3anZ+5hVLWzd7fxcPh8QyeD7i5WUl3be1Q=;
        b=G0DxFSM0MGUZgi68opGBruVz+4pdlOFZ3xTM8qFcRz/bn5+zpe/eeKp/wWzXi4s0uu
         LkAWAznJz23Uc9kZmuzkxxDx7ErKYj0Y5vJnivei4GL5Pnxh+ZkAVKF48aYg4/a4eb/s
         gHq4KLaoVfbFLcxz1Q2B1K4Ys/OTF7PspXTOj/r/JBIaNjfGTVeIcMASST6Ad3QolY2I
         FzuiHWaYOPNNXeER0ooFYS1l+2OCEWENjW0ziso2GU2ZUk51UuXQMCmmwD74Y76XVEf5
         DW9Z/uWZJh1GQg8eajnBG0qtg2XTEvF8Pyt3sVd0470xlU9DUGc574ZueysL8wm0EfJE
         oFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429459; x=1685021459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq0Tzb/6a3anZ+5hVLWzd7fxcPh8QyeD7i5WUl3be1Q=;
        b=Z68h57F1LnpdDreNNmA3tTKPb/oi2XTO1N+b0CdUcPqaUDtRfpIRK9yepNOZVAmVj+
         fA6cm9w6b6VcX1Gnpr5FT1FzYNLgbkkfa1pECMthu/n+6dKeUyac/hv229TUQ8yfyyHN
         orIb/isLQCjOgg8wALWcZqLo+7zQFJZczU0FHXvra3L2XVDsjzkVqb68SIVP5AKOgrde
         p4GcBKQz8M70jm+JTBvTk0viB5wrG3gERL8jYNhVTA0AVHD2R/xFCfYN/vlUqw0eNQvC
         PAiuJfQOHJUkO3fbX638G5vVx3MeSx35Clfb7TdXwq/33OnEK0fGZ2z9jEn4fvsPGygu
         gi0Q==
X-Gm-Message-State: AC+VfDyum1tM9FHdTfcDxELf+7/6nN+BVG1WmpEQgp7Nx2cNArRwNjUd
        fMJSDzbYOu91hngrdYnvc+qy8A==
X-Google-Smtp-Source: ACHHUZ7vM+TZ5l+7ymu+S40B5ZUWmH+2pXtLFMbUPJn1KS96YEXQh8zX+OzHhZBNBDhjkx9Qz9mXcw==
X-Received: by 2002:a1c:f613:0:b0:3f2:5a60:a03e with SMTP id w19-20020a1cf613000000b003f25a60a03emr1034282wmc.14.1682429458963;
        Tue, 25 Apr 2023 06:30:58 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm18575434wmq.38.2023.04.25.06.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:30:58 -0700 (PDT)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v2 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
Date:   Tue, 25 Apr 2023 15:30:50 +0200
Message-Id: <20230425133052.199767-4-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425133052.199767-1-bchihi@baylibre.com>
References: <20230425133052.199767-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS Driver support for MT8192.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Co-developed-by : Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 92 +++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 5ea8a9d569ea6..8df7b4c72a658 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -80,6 +80,7 @@
 #define LVTS_MSR_FILTERED_MODE		1
 
 #define LVTS_HW_SHUTDOWN_MT8195		105000
+#define LVTS_HW_SHUTDOWN_MT8192		105000
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int coeff_b = LVTS_COEFF_B;
@@ -1280,6 +1281,85 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
+	{
+		.cal_offset = { 0x04, 0x08 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU0 },
+			{ .dt_id = MT8192_MCU_BIG_CPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x0c, 0x10 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU2 },
+			{ .dt_id = MT8192_MCU_BIG_CPU3 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_LITTLE_CPU0 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU1 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU2 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU3 }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	}
+};
+
+static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
+		{
+		.cal_offset = { 0x24, 0x28 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_VPU0 },
+			{ .dt_id = MT8192_AP_VPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x2c, 0x30 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_GPU0 },
+			{ .dt_id = MT8192_AP_GPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x34, 0x38 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_INFRA },
+			{ .dt_id = MT8192_AP_CAM },
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x3c, 0x40, 0x44 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_MD0 },
+			{ .dt_id = MT8192_AP_MD1 },
+			{ .dt_id = MT8192_AP_MD2 }
+		},
+		.num_lvts_sensor = 3,
+		.offset = 0x300,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	}
+};
+
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
@@ -1290,9 +1370,21 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_ap_data_ctrl),
 };
 
+static const struct lvts_data mt8192_lvts_mcu_data = {
+	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+};
+
+static const struct lvts_data mt8192_lvts_ap_data = {
+	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+};
+
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
+	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lvts_of_match);
-- 
2.34.1

