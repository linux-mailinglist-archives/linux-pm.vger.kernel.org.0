Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A780B3EDB21
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhHPQm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhHPQmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:42:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF1DC06179A
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 09:41:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q10so24575506wro.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ri5K1Xpjc4a4zjNHt8k/tccc7l+lexuuCDCYomtiW64=;
        b=fsWJKH+0VfSp4+mk99VbiWU+aOxWRQF1uKnQBKOdUacrT9mpUf8NrFQ0ZSeFt0hb0M
         SEp6y8StXl7ZDdCbR75BdMp2ImU551lmP/MO6LTRG2YMHS0M4DeyzRZOGUUnWR4fVBlR
         urHnvSMVl5eDS8YiEEEkmRjO7mqbBQ+nd5/RAvsA44nMq2Qv54BjmIO3Z+nhk4T3Zehv
         N6umhJlCVWeZY/qeXAhrhBLeoub3qUYFVkK9uVtIOawpC0MglXH0XASyiBs+l8NLlD59
         me6UqnfXCliq/Y1U4jXpoV/+PxYDk0jx2le0q9h9XREHdPFf3bKI4iYoZV3+BHYkRuyb
         6mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ri5K1Xpjc4a4zjNHt8k/tccc7l+lexuuCDCYomtiW64=;
        b=HEOSMG9rP3NJEuzW5904UZ6f614usod/7GVoujZqg7cGPU4Yo6XtExDcs3D+7k2Dur
         qQI/meqycRhRW76FBnd3cvpAnIKEOlrZUQv1GoJOnGspHUlHhq9Ptt3txbUOse1yJLtO
         lBSyK3fewp2W58TQbVcGb9x8BStzpPYrhlU85Sa1W/exHslSHA86xanmbcsw8be0truy
         j7yhRKnpNjaKeKrBa50L1A4sNIllMoSk6a/UKcivfa/qb3QikRY1JnxQpTzye1MU+pDM
         wysndvmb20Gw8JfojJdfLKZGrJLQLk8pZm4pyenid8LJxA6rah03Crml1QfDcPIjl8jG
         BmOw==
X-Gm-Message-State: AOAM532bvbCAj+8G4G2HkD4V5N4wyVyjsAwq0wtLbS3Ng5pIdUs3P1lf
        wr75qeBRYGojEraEUzxSaYp6Lg==
X-Google-Smtp-Source: ABdhPJwp1/e6QTN+KaNFg1J0WU8Yg38zk3IRnsteKkDATQXEImuAmK8bkrejDz6ojc+sXaEzYbdYeA==
X-Received: by 2002:adf:c044:: with SMTP id c4mr4686867wrf.275.1629132110579;
        Mon, 16 Aug 2021 09:41:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id m10sm15211730wro.63.2021.08.16.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:41:49 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     ben.tseng@mediatek.com, michael.kao@mediatek.com,
        ethan.chang@mediatek.com, fparent@baylibre.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: mt8195: Add thermal zone and thermal policy
Date:   Mon, 16 Aug 2021 18:43:07 +0200
Message-Id: <20210816164307.557315-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816164307.557315-1-abailon@baylibre.com>
References: <20210816164307.557315-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tinghan Shen <tinghan.shen@mediatek.com>

1. Add SoC and board thermal zones.
2. Add thermal throttle policy

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 164 +++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d05492ff8f190..62d0944dea4db 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/reset/ti-syscon.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -475,6 +476,21 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts: lvts@1100b000 {
+			compatible = "mediatek,mt8195-lvts";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100b000 0 0x1000>,
+				<0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+					<GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			clock-names = "lvts_clk";
+			resets = <&infracfg_rst 1>,
+					<&infracfg_rst 2>;
+			nvmem-cells = <&lvts_e_data1 &lvts_e_data2>;
+			nvmem-cell-names = "e_data1","e_data2";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8195-spi", "mediatek,mt6765-spi";
 			reg = <0 0x11010000 0 0x100>;
@@ -830,4 +846,152 @@ vdosys1: syscon@1c100000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		soc_max {
+			polling-delay = <1000>; /* milliseconds */
+			polling-delay-passive = <1000>; /* milliseconds */
+			thermal-sensors = <&lvts 0>;
+			sustainable-power = <1500>;
+
+			trips {
+				threshold: trip-point@0 {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: target@1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				soc_max_crit: soc_max_crit@0 {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu0
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+								<&cpu1
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+								<&cpu2
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+								<&cpu3
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <3072>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&cpu4
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+								<&cpu5
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+								<&cpu6
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+								<&cpu7
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+		cpu_big1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 1>;
+		};
+		cpu_big2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 2>;
+		};
+		cpu_big3 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 3>;
+		};
+		cpu_big4 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 4>;
+		};
+		cpu_little1{
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 5>;
+		};
+		cpu_little2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 6>;
+		};
+		cpu_little3 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 7>;
+		};
+		cpu_little4 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 8>;
+		};
+		vpu1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 9>;
+		};
+		vpu2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 10>;
+		};
+		gpu1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 11>;
+		};
+		gpu2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 12>;
+		};
+		vdec {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 13>;
+		};
+		img {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 14>;
+		};
+		infra {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 15>;
+		};
+		cam1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 16>;
+		};
+		cam2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 17>;
+		};
+	};
 };
-- 
2.31.1

