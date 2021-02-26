Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70005326828
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBZULn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhBZUL3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:11:29 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3527C061786
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 12:08:57 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 461A81FAB6;
        Fri, 26 Feb 2021 21:06:58 +0100 (CET)
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
Subject: [PATCH 32/41] arm64: dts: qcom: sdm630-nile: Add USB
Date:   Fri, 26 Feb 2021 21:04:02 +0100
Message-Id: <20210226200414.167762-33-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable and configure DWC3 and QUSB2 PHY to enable USB
functionality on Nile and Ganges boards.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 34a38bff09b8..e17a0f0b1e06 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -148,6 +148,15 @@ removed_region@85800000 {
 			no-map;
 		};
 	};
+
+	/*
+	 * Until we hook up type-c detection, we
+	 * have to stick with this. But it works.
+	 */
+	extcon_usb: extcon-usb {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&tlmm 58 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &blsp_i2c1 {
@@ -182,6 +191,14 @@ &blsp2_uart1 {
 	/* HCI Bluetooth */
 };
 
+&qusb2phy {
+	status = "okay";
+
+	vdd-supply = <&vreg_l1b_0p925>;
+	vdda-pll-supply = <&vreg_l10a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l7b_3p125>;
+};
+
 &rpm_requests {
 	pm660l-regulators {
 		compatible = "qcom,rpm-pm660l-regulators";
@@ -536,3 +553,12 @@ cam_vdig_default: cam-vdig-default {
 		drive-strength = <2>;
 	};
 };
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	dr_mode = "peripheral";
+	extcon = <&extcon_usb>;
+};
-- 
2.30.1

