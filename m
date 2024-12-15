Return-Path: <linux-pm+bounces-19250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE19F2354
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308CA1885FDA
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8181865E9;
	Sun, 15 Dec 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="TBYKmX9H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA28148FF2;
	Sun, 15 Dec 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734261343; cv=none; b=i99lXO7qtUvbUgMVH+vZq78TRA2l0PUmsPdgQzKMMnY4bDcqICdHvmGjpJ7jVlFP2D25c/cgDrOeDaKMwVT24xkor+OXERUX+t8rx07plrAe1SDlZwu3RDAVmQS+nnTM4+gBN1romOU1e7OTvCHnwfHUR5/0HChvdYWrQsUpcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734261343; c=relaxed/simple;
	bh=+vlEsRuRA90WjAUZ/WcMhrVJbW5wZW6c20Mptd1FCbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sP3I8Nq0fx9+CrWgmpDRcuOdGkhZN0s5sUKNk2V5PHQRGoodynuxbeLf6JdBRa1ulgfNPfvUuB3o7XnyQag1Lv4chHG3OxAdBgw8l37q5qEjFlPcrbRAcBWeciViL/g4IpAaO13uo+w/LuzwUR3+Rx6tQpWn3QDh7e/5+GYgjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=TBYKmX9H; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.220] (catv-176-63-31-221.catv.fixed.vodafone.hu [176.63.31.221])
	by mail.mainlining.org (Postfix) with ESMTPSA id 8F537E482E;
	Sun, 15 Dec 2024 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734261333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JebZjIU/uQ7XPZxbJ6FIZkac76ADMpKJeJrX5Tck+VA=;
	b=TBYKmX9HYo4xT1n0k9ij0GGwE9o0bsDquTP0vIDAyqCPFmNUj/ikUgMhadrSO9HnLhlgLh
	sjFiExUe6aiGB+xMvgpA9Sg8sRzCg1dDPfMtDGCfjTjXMs5/0kuLykouojI9kwh79pFlaz
	YzANbdTz/TXgSdHxPS9avAc3IvIorIY/V1O6DzU3xSimvsdBIuUDPACOHF56RlFNGglNoc
	A0LWSKrnSq4uZn4SndU2Bo4g3Wvif805v5QEzU8piXdvrrq4E56VOa4YEJZjyJ1upkCP4v
	noSESzhSl/TmpiI1CQypcLsrkKimpR9D34o7W72EAc9WW5PmOrz9g1kzPp74xw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sun, 15 Dec 2024 12:14:57 +0100
Subject: [PATCH v9 2/8] dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-msm8917-v9-2-bacaa26f3eef@mainlining.org>
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734261329; l=6643;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=+vlEsRuRA90WjAUZ/WcMhrVJbW5wZW6c20Mptd1FCbw=;
 b=fUpF8xH/BrSLRs4RZWrUFVTpc5LwSUSynzgb1pIVulmoUhEPaG2aeA3N31qwTJF53O2xJluYe
 lvj0wYrh23FBlhbZ1Skuv0PCGVLNNrg70hCQjWmQif8gxpjEMLgpOEZ
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add device tree bindings documentation for Qualcomm MSM8917
pinctrl driver.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../bindings/pinctrl/qcom,msm8917-pinctrl.yaml     | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8917-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8917-pinctrl.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..16d0c010e5818f67bf73eecc36da23705382f121
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8917-pinctrl.yaml
@@ -0,0 +1,160 @@
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
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 66
+
+  gpio-line-names:
+    maxItems: 134
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-2][0-9]|13[0-3])$"
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
2.47.1


