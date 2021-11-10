Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B014C44C153
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhKJMdg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:33:36 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36459 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231830AbhKJMd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:33:29 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id BD41C580877;
        Wed, 10 Nov 2021 07:30:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Nov 2021 07:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=716shbgGMma/V
        dWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=dh8VEtffq3LssMHNzjlV/I/EGGyYr
        zIg0QYHPO3O3lpv84cVukDSE5Arf4rHl+oCD8maXYgzX57JnUiE7A0A0jP9K5Fuu
        QWs867Wf+4b/cBMrtZ1xqr8jDcuBP9BnBGXGoSpFX49tuHAR7JUoTX7TZ1UoLM3U
        eLjKBgzPW9mPeM3bRCxrAGiZMaHVbIIfYVnlSzty1cCm6LaNU3rLFRmQ51xo/M73
        qglq1DtnY7PU/7R94HFvaUIHqDbqEbnzMWbbLw2BUMpAG7Ncqx4eWfh/7mXrvzfz
        Qgq3hUPTTPfpU0Um21zbrej42ZMZi/eGC+CIYCUKUMi/w+gnMnutW10iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=716shbgGMma/VdWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=hm/gEbKG
        SI6NdvdpRlMwSwXXebD+u+W3BxBNCT4BWNEOd+pmaGyAKWQtEtncdLfR6Fke6JyN
        qrPTh1wdH9yR7mUnzZMXEMgoVGoJYDWDsP/buacUfY/Kn5V3l5i5WIbs5zVrd6FL
        ovolPe1qvMb1VZy961I0tn28zv2k5L6MorEle9q5HzKQyU40NVyMvn2wE/AVFu4o
        2csq5enMnBWDA34b/bNoscPryef2VogpPn28K5PkzZJ9DNGNOKG3IccDfnBDBnHp
        cqh3qARa8Q+6NUg20AkLEmlACYMFRXu1vhHJQKo+xKunzZwqKEKDTEu4AB8NahKJ
        BSl+t/GTJQ7DBA==
X-ME-Sender: <xms:cbuLYX3sXpD8CH_Aco6pktXUBqmeJbSdqPk9M2mXTcltWdCs6TFIGg>
    <xme:cbuLYWEbFXJdlTW-fXztvGrWA_vrOPDvRgSET61ObNWs-mxV-IKurpRVeRIcWsr-G
    kPgtX03zS5-DuoAHXM>
X-ME-Received: <xmr:cbuLYX4mYtw7XRiF9GwrdC3MrwjfoAFAnn0bM-olw-vgSQhMHmYMlfE1886xGehYMudIXrWzK4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:cbuLYc0DawkSgW9roSwBQNV-R0W2GSUS9uBsAzf0qlIHdmRfi7qrpw>
    <xmx:cbuLYaGQOqu5Z3ZI9X5c_FMIuwHZqDsXpTJtX-d3Rxj9eQPb_SBSSQ>
    <xmx:cbuLYd_WMvncmgFkvdz5ebWa2blKY-E0W5cfXVDuKuyCN7I5UhDVxg>
    <xmx:cbuLYYWf4u1Gt4ewrVTXci3fzzt0OO3ga3XBky9ZjIzOczm0cG7DWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:30:35 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 7/8] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Wed, 10 Nov 2021 22:29:47 +1000
Message-Id: <20211110122948.188683-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110122948.188683-1-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
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

