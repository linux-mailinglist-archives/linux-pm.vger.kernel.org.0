Return-Path: <linux-pm+bounces-16012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A69A4D5F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46151F24245
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E141E1A0F;
	Sat, 19 Oct 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VHFgg5HR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC31E0B90;
	Sat, 19 Oct 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338655; cv=none; b=NpFg+VHaYuzX8ez7d6TOtKP7xpZa1ClOT4I1qjlX6FclIvsgOzymGY7tZgfnVpTvvwUrOlVWOKqVt284UkOVuRFrlxjHYUHkxxeBCoold+XEXVs4gsk97ZIzy18PmyUU1dfLtQBpULdkxRiTw+6Kllo4jYVc1K+aD1crD1isW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338655; c=relaxed/simple;
	bh=nKRAjGHplcBjSY8FGUHOTB8ghGJrx7beTyIEn7gCe/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKFtffj5Lu9vwKErDheLbHG8skSchSWDIoBB3d1/IOyZKnvamRetzX0ZOix82DKuYgOhhyT5tCZQaU587ftSrmdbqI1MaVMjLxm77E4am+0+7KRxdmhmR0ZdmFfmkFc2tTrdr8b2wqTqMtisMiA9GWqVc1eWms9N722Q6jCl4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VHFgg5HR; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 4ACCAE45A2;
	Sat, 19 Oct 2024 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Olj9iYH7LcbphKshwr7qao2rM+CM/q0woKUYsmasCt4=;
	b=VHFgg5HRelXRx4/0GeYJYtiz7nwdpx54jfSybbwcPDW+lQuyiluE4JQHMWWaFi04qhUR7c
	Y2lPWs4SpSJtVy0kCNtIEPpoK0ULqsLsUr8INnkBcFFhZKyBwu1xk4/wtcSOvBRe2FiZHa
	i/CBFWEdmwZHe5P2iZWNTgnzGJ1c8/wiHMyI0d0lKjqHyinckE39Z064dNIfgRU1vKKeki
	HD4mHF5dxAK8oJW8VOq9SVB9Q0tcpF3aatxJUIVu2lTwdIhNqKF+BPppMDodzlulyEqD9g
	k9GTSybtCd6WC0HjW3xqtnV7iAd5uPNvQKwI+7ZtSJ+ke3JQ9aq0//suKr6wzA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:43 +0200
Subject: [PATCH RFC 06/14] dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
 bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-6-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
In-Reply-To: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=6514;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=nKRAjGHplcBjSY8FGUHOTB8ghGJrx7beTyIEn7gCe/4=;
 b=SBR0UiMI0qHJlKfLm+epe47EkvvVA+1HiDd+BDkKcox8Se5LV4+xWYcw4aCRXHdDIvLAqFpU4
 qSN69ovB04eDjQoi2Celt+VeQs7cmEG/tp9ft5/bEWvq2c3lFybP6nR
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add device tree bindings documentation for Qualcomm MSM8917
pinctrl driver.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../bindings/pinctrl/qcom,msm8917-pinctrl.yaml     | 155 +++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8917-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8917-pinctrl.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..41349ce9898aaaf68a10f30ffe611dcedc1e9311
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8917-pinctrl.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8917-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8917 TLMM pin controller
+
+maintainers:
+  - Barnabas Czeman <barnabas.czeman@mainlining.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8917 SoC.
+
+properties:
+  compatible:
+    const: qcom,msm8917-pinctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8917-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8917-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8917-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[01])$"
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
+                      sdc2_cmd, sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data0,
+                      qdsd_data1, qdsd_data2, qdsd_data3 ]
+        minItems: 1
+        maxItems: 16
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ accel_int, adsp_ext, alsp_int, atest_bbrx0, atest_bbrx1,
+                atest_char, atest_char0, atest_char1, atest_char2,
+                atest_char3, atest_combodac_to_gpio_native,
+                atest_gpsadc_dtest0_native, atest_gpsadc_dtest1_native,
+                atest_tsens, atest_wlan0, atest_wlan1, audio_ref,
+                audio_reset, bimc_dte0, bimc_dte1, blsp6_spi, blsp8_spi,
+                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5,
+                blsp_i2c6, blsp_i2c7, blsp_i2c8, blsp_spi1, blsp_spi2,
+                blsp_spi3, blsp_spi4, blsp_spi5, blsp_spi6, blsp_spi7,
+                blsp_spi8, blsp_uart1, blsp_uart2, blsp_uart3, blsp_uart4,
+                blsp_uart5, blsp_uart6, blsp_uart7, blsp_uart8, cam0_ldo,
+                cam1_rst, cam1_standby, cam2_rst, cam2_standby, cam_mclk,
+                cci_async, cci_i2c, cci_timer0, cci_timer1, cdc_pdm0,
+                codec_int1, codec_int2, codec_mad, coex_uart, cri_trng,
+                cri_trng0, cri_trng1, dbg_out, dmic0_clk, dmic0_data,
+                ebi_cdc, ebi_ch0, ext_lpass, forced_usb, fp_gpio, fp_int,
+                gcc_gp1_clk_a, gcc_gp1_clk_b, gcc_gp2_clk_a, gcc_gp2_clk_b,
+                gcc_gp3_clk_a, gcc_gp3_clk_b, gcc_plltest, gcc_tlmm, gpio,
+                gsm0_tx, key_focus, key_snapshot, key_volp, ldo_en,
+                ldo_update, lpass_slimbus, lpass_slimbus0, lpass_slimbus1,
+                m_voc, mag_int, mdp_vsync, mipi_dsi0, modem_tsync, nav_pps,
+                nav_pps_in_a, nav_pps_in_b, nav_tsync, nfc_pwr, ov_ldo,
+                pa_indicator, pbs0, pbs1, pbs2, pri_mi2s, pri_mi2s_mclk_a,
+                pri_mi2s_mclk_b, pri_mi2s_ws, prng_rosc,
+                pwr_crypto_enabled_a, pwr_crypto_enabled_b,
+                pwr_modem_enabled_a, pwr_modem_enabled_b, pwr_nav_enabled_a,
+                pwr_nav_enabled_b, qdss_cti_trig_in_a0, qdss_cti_trig_in_a1,
+                qdss_cti_trig_in_b0, qdss_cti_trig_in_b1,
+                qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
+                qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
+                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
+                qdss_tracedata_a, qdss_tracedata_b, sd_write, sdcard_det,
+                sec_mi2s, sec_mi2s_mclk_a, sec_mi2s_mclk_b, sensor_rst,
+                smb_int, ssbi_wtr1, ts_resout, ts_sample, uim1_clk,
+                uim1_data, uim1_present, uim1_reset, uim2_clk, uim2_data,
+                uim2_present, uim2_reset, uim_batt, us_emitter, us_euro,
+                wcss_bt, wcss_fm, wcss_wlan, wcss_wlan0, wcss_wlan1,
+                wcss_wlan2, webcam_rst, webcam_standby, wsa_io, wsa_irq ]
+
+    required:
+      - pins
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,msm8917-pinctrl";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&tlmm 0 0 134>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        blsp1-uart2-sleep-state {
+            pins = "gpio4", "gpio5";
+            function = "gpio";
+
+            drive-strength = <2>;
+            bias-pull-down;
+        };
+
+        spi1-default-state {
+            spi-pins {
+                pins = "gpio0", "gpio1", "gpio3";
+                function = "blsp_spi1";
+
+                drive-strength = <12>;
+                bias-disable;
+            };
+
+            cs-pins {
+                pins = "gpio2";
+                function = "gpio";
+
+                drive-strength = <16>;
+                bias-disable;
+                output-high;
+            };
+        };
+    };

-- 
2.47.0


