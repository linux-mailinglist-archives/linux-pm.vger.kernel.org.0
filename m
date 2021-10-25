Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02DD43943B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhJYK4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:56:52 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58119 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232702AbhJYK4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:56:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EBC5B58052B;
        Mon, 25 Oct 2021 06:54:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Oct 2021 06:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=716shbgGMma/V
        dWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=B9RUgkzMkLn4rCLMAv+ZnQ7sIPOAE
        l9P3lw4VSJqlIwCaadlYLpKQYPtJ7TthgY30zoPu1QpEo5uxuqasIyvbbbucdpxE
        TqcROz8xTT6gxrPMJ88Ywb5uAXURlX46kb8lnyuWhgwFBaIMc626OssrlaHduZPz
        NJTpEhK7Xsr8LVFB7vV2i4FWEF6pyZoiBv4Z7Raq6bAP//XTOhPSjgYJLNFJBSmg
        O6O7FRufHGISlQiL2GSr3TqMsp9ysX1coF1cOFbBVl2R+iBuG8QqTUZau6vs9dmY
        WsId9O2k8x85Ez2B2EpLXErYviytaZ3aETQp0BG9Ecrcew30rquZBBvcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=716shbgGMma/VdWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=icaaKrvE
        VIW4jlwvE+NTDaViHcESPEvwprQkLV7zFNakg3u7XxlWF3LYeNya2rB8AP2rOPKM
        /0JjGpfiFqIhSwBJE+afdv2PH7jetISLn9biarIZvxMxwpgSUzvRlAV+TTX2h+/k
        QU3BgDQyRESvEcGJoVh6TxrXYd1ZnA60+AbhL7ohdbxHN689eyQCxRZwQDn6dCV1
        LLb9g8G0qxICOVabSu3BZLdthO3XqXu2fqS9oZAh2mQhsqmkPbCdbSnerpQX0tdc
        aQ9d4XkUbvjYahaWAtWQRxtt1SFHgTUst2j0EsTsP0F6lfEZYcpRuLiSVrUkP/W7
        IhCuk5iVOBgLGA==
X-ME-Sender: <xms:5Ix2YVITWEW7UJCFXNzQbNWyHPuKUMXZMMIqCoqnyUwC90qlLE3vbw>
    <xme:5Ix2YRICatvYZEFQApF2ZfFwvbJRlk9_gyDjyy-xG_6hAGlbbCjgo3jcZXUexJK45
    JYP4kFiRTiHekjlJVk>
X-ME-Received: <xmr:5Ix2Ydtl9yU3ap6lL6-AWe-glFNNRTmBJnni-CAIkKHrby_wvj5npk50BrXRXy61iNWr0VuWRTsi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:5Ix2YWaMoIT7WPWOcV-2mE7GfwKNt2erpy9nttkpmx0JhgDGJ8Q35Q>
    <xmx:5Ix2YcYvy9TR9oRtAnR5SyXogTR6SAuCeqZvP-qjPVpMoHhvHaJgug>
    <xmx:5Ix2YaDX3WZaHHUjPjHoqBQtvs83Q3YpgICPjqHdmJ4UDLQPCpuhGg>
    <xmx:5Ix2YcIGp1Km-Se-Ow-1RJyWm2Cxkj1ho4gxRBCU5upVl_yVvlrUFg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:54:20 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     s.hauer@pengutronix.de, rui.zhang@intel.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        amitk@kernel.org, shawnguo@kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        andreas@kemnade.info, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v14 7/8] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Mon, 25 Oct 2021 20:53:08 +1000
Message-Id: <20211025105309.37942-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 89cbf13097a4..b66d28b30d75 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -22,6 +22,27 @@ memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
+	thermal-zones {
+		epd-thermal {
+			thermal-sensors = <&epd_pmic>;
+			polling-delay-passive = <30000>;
+			polling-delay = <30000>;
+			trips {
+				trip0 {
+					temperature = <49000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	reg_brcm: regulator-brcm {
 		compatible = "regulator-fixed";
 		regulator-name = "brcm_reg";
@@ -51,6 +72,33 @@ &clks {
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	epd_pmic: sy7636a@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_epdpmic>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#thermal-sensor-cells = <0>;
+
+		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		regulators {
+			reg_epdpmic: vcom {
+				regulator-name = "vcom";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -125,6 +173,20 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

