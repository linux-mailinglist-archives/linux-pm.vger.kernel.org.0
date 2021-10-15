Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3142F0DC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhJOM3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:29:01 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:55931 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238862AbhJOM26 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8CF81580EC5;
        Fri, 15 Oct 2021 08:26:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Oct 2021 08:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=716shbgGMma/V
        dWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=Ru6khllnQ4IuIBgA1VRdo19q6m679
        DeRw2i2lYm/NMDK50+Xsj5c/y84rCmXBtfygTgxzbVACXtev5bstvCETSlL9Xs+L
        afwmcLr1rHqA64tt8OPXcxvItAki7ARlpi3scrZDP1+GPZdo5Zw7zfzQqgqC2GFo
        itucjKzuP14tkl8foWiKetBD+NWAvs8I01GAroBOWCuAmPg9JGKNHzATO6wcdMvg
        iOT7xBciLDyTX8UgYRsuMWUO+eZ3qDjdwNOQMzwEWzrHsePWaJktgcua6g6dPX5d
        smzZMNV6LV9J01zymG2DmQZhXCfp02Rin6JLxvIK8sVwnrv9QWCSbVP5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=716shbgGMma/VdWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=B/0al/VE
        BMi5VtEJpSHPaAP9CfxFNJNikwRXZZb0TMWYCRBNSg2Mvmxv2vTNEKnU9MelOOId
        f00We1LXyztjhPgKRxdIwCRUHyaufNJWNNDDyIDtGw2fHBzU31hSTUpSGMqN5mJP
        9lfCyhd2aaFvmsYiFK3tZ4cJPfrUGgdjJAbisMCnbDA1vqyYNXH39+Nom3/sdugm
        pGk6DEXfhsDIcMrFvcGTjTQz54ZoxFIjNJbrl1eNnNC8e5S/ihBponGfQoRNY1GO
        jR3zXLgxaD9+zMjkSSEWEbCmNu2iv5DX1PfqPCawZfxWHuv7xWT/S6PsLZLs5RVe
        3t8HBZcKfbELRg==
X-ME-Sender: <xms:i3NpYVBBMjgUbrLtljM_YVzJv2rrfYPrINWDgFQ_GMOjZyCZ58Rm1g>
    <xme:i3NpYTjLyfHKQYUV9nkwlsDjqBf1qBkIeTWHtoGmVsbjPq86zEYdDuHsJ1JI941dJ
    xW1Fsn8kHkzRyjs4GQ>
X-ME-Received: <xmr:i3NpYQkvgB7Y91TXSe-4xnZm9wlvqoUwWkm5aNIfpsRlJdL1K8P6G-fXQK7mNNIrbSt44AnDCMR5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:i3NpYfyIBZaUDID2JYOE2tksym217FolHr0PxjTmpXw_voP1xlD4GA>
    <xmx:i3NpYaR_Aea0mkDXoy_vC32b9ADn0wfIjGAgN23LfPxRk0LJ2thFTg>
    <xmx:i3NpYSZNZ6sz_u4w1bkWJTmikPoD0TrMywLDAKFecgNhYL-ezq2pMQ>
    <xmx:i3NpYfgZZpaIyhKDlZu0Gka5pe0jrwKMn5FgZu1gAf_1EooIgzy9XA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:45 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 8/9] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Fri, 15 Oct 2021 22:25:50 +1000
Message-Id: <20211015122551.38951-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
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

