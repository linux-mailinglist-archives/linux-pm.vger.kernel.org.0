Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA2524CB5
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353667AbiELMYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353659AbiELMYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 08:24:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A5823BB67
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 05:24:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f2so10845wrc.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=befZQ9FS23fWMFZgR26WPFKtinCTSI/vcnKTdqrsD2I=;
        b=3BHa3XT/PM1d1Fqi4xdlw28bRsyHbtLMKPZ3xkV1jdTvwnDc4q2bNcQ7kJkdQqg2PG
         ooi6aQOfiOzLrON7fQvWJQHbOEFE1bXmTqDtJfD2uhBwfqsTPcwh23AVpQ2qO0zH/O3/
         AV4mGC+ARmcDMVCotPPZkyyvkqbjDeVluw7uOg6vG95WukWDTm76nWqLWuiqvPFZCkSK
         a/+8/aQicU0gw32smoTPprxZLzqH5r8x5vGutquYVlUh38sRJ2K9G4S+UnfSijBUP0Ey
         8dlgbR/MCauaFiOLg5bBREaJz3FqgsXlqhf7Ew1Ghva9ZT6WTCSbrrZ1/N/dJBtXbpZL
         8+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=befZQ9FS23fWMFZgR26WPFKtinCTSI/vcnKTdqrsD2I=;
        b=3Mmi3+l5NVs7P6puJGgVZae51S6vVN2FNTQJdnHB4pJ/MMMX3U5lNPJF1tN6+D1was
         K2WubakKpOnEwgB6DFf8iQ2PSaW30xnEP0V629Clx9B3Dn5dwwCsUC8tfXIV1taqzxfh
         mF3CCqWIxQzrt4Ox+7bNqSHLPcQ2zuSPN9zoOrElxw8WqA0WfQ7izgkv2ILCYyuwHo85
         pDeprt3RTINdqhNT1dp0riwdDDF9vAeVj9V9juff7U3MA7033ia2nfdtOd+nvns59nt4
         b90UreYoTJ5MdM/T/4B36n6ryOqUvcJNuNUw9weFCvsYYc3vfB/3I9Po47p0AgIY2vHU
         oJJQ==
X-Gm-Message-State: AOAM532BE0wLfbYR2kiRvyIfhZqC8C7pP+HeH+2v7yolQg6OekiDfH+/
        b113CSJ4YOYKhHMcPqX1FkT52A==
X-Google-Smtp-Source: ABdhPJzl2RnwuKtjp0w2JW5qr0wn4jOfQ9nztXnOxQtRwboK1PADSs7vYj8oT4mnuqSVmq7o/fDkmA==
X-Received: by 2002:a5d:47ca:0:b0:20c:72c9:d3be with SMTP id o10-20020a5d47ca000000b0020c72c9d3bemr26671903wrc.114.1652358283467;
        Thu, 12 May 2022 05:24:43 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc156000000b003942a244f30sm3047819wmi.9.2022.05.12.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:24:43 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v6 6/7] arm64: dts: mt8195: Add efuse node to mt8195
Date:   Thu, 12 May 2022 14:24:32 +0200
Message-Id: <20220512122433.1399802-7-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512122433.1399802-1-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
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

This adds the efuse node. This will be required by the thermal driver
to get the calibration data.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 416d37e07324..12887fb4d0d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
 #include <dt-bindings/reset/ti-syscon.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -1248,6 +1249,23 @@ nor_flash: spi@1132c000 {
 			status = "disabled";
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,efuse";
+			reg = <0 0x11c10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			lvts_e_data1: data1 {
+				reg = <0x1bc 0x14>;
+			};
+			lvts_e_data2: data1-1 {
+				reg = <0x1d0 0x38>;
+			};
+			svs_calibration: calib@580 {
+				reg = <0x580 0x64>;
+			};
+		};
+
 		u3phy2: t-phy@11c40000 {
 			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
 			#address-cells = <1>;
-- 
2.35.1

