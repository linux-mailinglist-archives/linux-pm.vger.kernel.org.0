Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC543326D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhJSJir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbhJSJip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 05:38:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B9C06176A
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y16-20020a05600c17d000b0030db7a51ee2so1629166wmo.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPR+h/6eM3ZX03Np34xb39M/9vUCOohBgw0tAFYVvnI=;
        b=AlhVW9hgjnNo39uedKxH3u/l7uXlvHUiWRAtDIywHDFbDxoH9XM514c6T010eEV0Gw
         Hx3eh5o1avyNyUnJerOvt/yuNRKPYauKG8VMR1Svm7rPUAIkAa+d71SrM50oUZffW67T
         tNjHhv4o+BYdq9I1Ko2yde5jj7WuONT4DXXpY8Y2FWtlRD+5tzkH42qaYaGyGAtiIcth
         AOO3Bj5S0a40Wa3GuMd/h+GVBjH1/zw15FQIyUj6zUFcWXXw9PJoO/I7XMo7ngcxPG0A
         0qgTUbknsGi3as/uoTS/AJdecefZ82mLCFZ4Fx/Y0BcL2Q0TdY2MkqDdwtliHYfMWYpm
         Z8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPR+h/6eM3ZX03Np34xb39M/9vUCOohBgw0tAFYVvnI=;
        b=xaA2UQDOtlafXUIV0syMHNwpwv/7JUxWYTRRXd1qZuAdnbA6LbcvStKMt0kuvIa0my
         RU2pml5O6Sjq5+lRK4PhYXPrvlg8EvQQ6iD5RmAkKQ5B2xIBBouEbL8wL+SCEtVnvZZC
         bCKpv1skwPG7pO0OAup4cdJLtQBK0J0gtyGthfky4gjKEs112z+pvt09VkUk2S4ddHAj
         MsZT8zPuy2ku/8sRgJpOwwaFquuvcqqekmy/OLCayPnREVWvl59D7TZaJzbYzWqCcirG
         qRMsq6R8WcG+OFkXp31CuP1ynxED3/+Uv+7dIvOzaKr2ptHkCWcLkP9LfZfY7/UBzeqy
         xZeg==
X-Gm-Message-State: AOAM533qyDVtSZ/LBwl1pn7kGpQ0YQ2fn6zPtx24TXzHmFO9SPPK8BWQ
        FS3pKP5IOtUgsDkpX2kCynnAUw==
X-Google-Smtp-Source: ABdhPJwifFC0iTsTwueKnvIl8ODRc0aF//CslFuTXsMtJAk4sgpmd+AnEWyhwpfRTCFq/rxKEA2hrw==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr4826223wmq.118.1634636190220;
        Tue, 19 Oct 2021 02:36:30 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900:5142:5fbb:5821:5dc3])
        by smtp.gmail.com with ESMTPSA id o23sm1765765wms.18.2021.10.19.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:36:29 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 4/4] thermal: mediatek: add MT8365 thermal driver support
Date:   Tue, 19 Oct 2021 11:34:04 +0200
Message-Id: <20211019093404.1913357-5-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019093404.1913357-1-msp@baylibre.com>
References: <20211019093404.1913357-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

mt8365 is similar to the other SoCs supported by the driver. It has only
one bank and 3 sensors that can be multiplexed.

Additionally the buffer has to be enabled and connected to AUXADC
similar to the V2 version but at a different register offset. That's why
I added three new configuration values to define the register, mask and
bits to be set to be able to use it for both V2 and mt8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
[Added apmixed control register logic]
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Changes v1 -> v2:
    - Use of ARRAY_SIZE to avoid NUM macros.
    - Remove (void*) cast.
    - Use macros for mt7622 buffer_ctl operations.

 drivers/thermal/mtk_thermal.c | 90 ++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index af6cd11eb221..fc4ea58d00ec 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -31,6 +31,7 @@
 #define AUXADC_CON2_V		0x010
 #define AUXADC_DATA(channel)	(0x14 + (channel) * 4)
 
+#define APMIXED_SYS_TS_CON0	0x600
 #define APMIXED_SYS_TS_CON1	0x604
 
 /* Thermal Controller Registers */
@@ -212,6 +213,8 @@ enum mtk_thermal_version {
 #define MT7622_NUM_SENSORS_PER_ZONE	1
 #define MT7622_TS1	0
 #define MT7622_NUM_CONTROLLER		1
+#define MT7622_BUFFER_CTL_MASK		~0x37
+#define MT7622_BUFFER_CTL_SET		0x1
 
 /* The maximum number of banks */
 #define MAX_NUM_ZONES		8
@@ -245,6 +248,14 @@ enum mtk_thermal_version {
 /* The calibration coefficient of sensor  */
 #define MT8183_CALIBRATION	153
 
+/* MT8365 */
+#define MT8365_TEMP_AUXADC_CHANNEL 11
+#define MT8365_CALIBRATION 164
+#define MT8365_NUM_BANKS 1
+#define MT8365_TS1 0
+#define MT8365_TS2 1
+#define MT8365_TS3 2
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -271,6 +282,9 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	u32 apmixed_buffer_ctl_reg;
+	u32 apmixed_buffer_ctl_mask;
+	u32 apmixed_buffer_ctl_set;
 };
 
 struct mtk_thermal {
@@ -386,6 +400,25 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
 static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
 static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
 
+/* MT8365 thermal sensor data */
+static const int mt8365_bank_data[] = {
+	MT8365_TS1, MT8365_TS2, MT8365_TS3
+};
+
+static const int mt8365_msr[ARRAY_SIZE(mt8365_bank_data)] = {
+	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
+};
+
+static const int mt8365_adcpnp[ARRAY_SIZE(mt8365_bank_data)] = {
+	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
+};
+
+static const int mt8365_mux_values[ARRAY_SIZE(mt8365_bank_data)] = { 0, 1, 2 };
+static const int mt8365_tc_offset[] = { 0 };
+
+static const int mt8365_vts_index[ARRAY_SIZE(mt8365_bank_data)] = { VTS1, VTS2,
+								    VTS3 };
+
 /*
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
@@ -460,6 +493,39 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
 	.version = MTK_THERMAL_V1,
 };
 
+/*
+ * The MT8365 thermal controller has one bank, which can read up to
+ * four temperature sensors simultaneously. The MT8365 has a total of 3
+ * temperature sensors.
+ *
+ * The thermal core only gets the maximum temperature of this one bank,
+ * so the bank concept wouldn't be necessary here. However, the SVS (Smart
+ * Voltage Scaling) unit makes its decisions based on the same bank
+ * data.
+ */
+static const struct mtk_thermal_data mt8365_thermal_data = {
+	.auxadc_channel = MT8365_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT8365_NUM_BANKS,
+	.num_sensors = ARRAY_SIZE(mt8365_bank_data),
+	.vts_index = mt8365_vts_index,
+	.cali_val = MT8365_CALIBRATION,
+	.num_controller = ARRAY_SIZE(mt8365_tc_offset),
+	.controller_offset = mt8365_tc_offset,
+	.need_switch_bank = false,
+	.bank_data = {
+		{
+			.num_sensors = ARRAY_SIZE(mt8365_bank_data),
+			.sensors = mt8365_bank_data
+		},
+	},
+	.msr = mt8365_msr,
+	.adcpnp = mt8365_adcpnp,
+	.sensor_mux_values = mt8365_mux_values,
+	.version = MTK_THERMAL_V1,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON0,
+	.apmixed_buffer_ctl_mask = ~(u32)GENMASK(29, 28),
+};
+
 /*
  * The MT2712 thermal controller has one bank, which can read up to
  * four temperature sensors simultaneously. The MT2712 has a total of 4
@@ -514,6 +580,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = MT7622_BUFFER_CTL_MASK,
+	.apmixed_buffer_ctl_set = MT7622_BUFFER_CTL_SET,
 };
 
 /*
@@ -958,19 +1027,27 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 	{
 		.compatible = "mediatek,mt8183-thermal",
 		.data = &mt8183_thermal_data,
+	},
+	{
+		.compatible = "mediatek,mt8365-thermal",
+		.data = &mt8365_thermal_data,
 	}, {
 	},
 };
 MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
 
-static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
+static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
+				       void __iomem *apmixed_base)
 {
 	int tmp;
 
-	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
-	tmp &= ~(0x37);
-	tmp |= 0x1;
-	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
+	if (!mt->conf->apmixed_buffer_ctl_reg)
+		return;
+
+	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
+	tmp &= mt->conf->apmixed_buffer_ctl_mask;
+	tmp |= mt->conf->apmixed_buffer_ctl_set;
+	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
 	udelay(200);
 }
 
@@ -1070,8 +1147,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
-		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
-- 
2.33.0

