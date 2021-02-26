Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8024326836
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBZUMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhBZUMG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:12:06 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A3C061225
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 12:09:15 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 1F0FB1F578;
        Fri, 26 Feb 2021 21:07:16 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 36/41] arm64: dts: qcom: sdm630-nile: Add Synaptics touchscreen.
Date:   Fri, 26 Feb 2021 21:04:06 +0100
Message-Id: <20210226200414.167762-37-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Delete the node on Ganges devices, as they use a different one.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../qcom/sdm630-sony-xperia-ganges-kirin.dts  |  2 ++
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     | 36 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
index aea949265a2d..a4e1fb8ca52d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
@@ -20,4 +20,6 @@ framebuffer@9d400000 {
 	};
 };
 
+/* Ganges devices feature a Novatek touchscreen instead. */
+/delete-node/ &touchscreen;
 /delete-node/ &vreg_l18a_1v8;
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index deadd8f6ff3a..5f1202ae954b 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -161,7 +161,29 @@ extcon_usb: extcon-usb {
 &blsp_i2c1 {
 	status = "okay";
 
-	/* Synaptics touchscreen */
+	touchscreen: synaptics-rmi4-i2c@70 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts-extended = <&tlmm 45 0x2008>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_active &ts_lcd_id_active>;
+
+		syna,reset-delay-ms = <200>;
+		syna,startup-delay-ms = <220>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f11@11 {
+			reg = <0x11>;
+			syna,sensor-type = <1>;
+		};
+	};
 };
 
 &blsp_i2c2 {
@@ -552,6 +574,18 @@ &sdhc_1 {
 &tlmm {
 	gpio-reserved-ranges = <8 4>;
 
+	ts_int_active: ts-int-active {
+		pins = "gpio45";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_lcd_id_active: ts-lcd-id-active {
+		pins = "gpio56";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
 	imx300_vana_default: imx300-vana-default {
 		pins = "gpio50";
 		function = "gpio";
-- 
2.30.1

