Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD893439440
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhJYK5C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:57:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:49819 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231796AbhJYK5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:57:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id A271658052B;
        Mon, 25 Oct 2021 06:54:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Oct 2021 06:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2aOAXpeIPQR2x
        ghpp4OMQNId//edXUxPmx/LpQURmRg=; b=pZqD4+hi3r5C4z32xOCV/LV6iuzW0
        5EkwSdxAjOffReaHSG6NkJqzNfL0NnJ/8HvvNmhjtsPuOMENApFhY5hgJ9iConUP
        mrbi3D2puYBScNKZDQs2Dl7CznXcNI/ZUF5jH4dWxpbCjWv/4uW9l4IZR3wM+r70
        GsFWORLirDfQDEjy6H5bgd0Oekfr/TuHDfl3ZrqhtKbI7FrNlw8BiEvrR7jDsYiI
        FIZumTe5nlIwPL1ne6jlnjZhjjq0yAt56PACriDxm5YoPv6c6Xa1gyiRawOjzXDv
        4Pidz/RuAUO8G18qX1mAxpX27ZJMpWbNR4BbcT5/ZYRxEB7bf7LNIQrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2aOAXpeIPQR2xghpp4OMQNId//edXUxPmx/LpQURmRg=; b=D7h8Eqln
        LEwsr+YpBPdsOx+5GaFMFm/4R8ou7D5TNPtGn7R4AfpPLDUsJA0ewEXPEakkeuIr
        fx71waQuyhtlTq8Abaa5hI9Da6/hz9vYMgs6M8FkV4TPDYwmbe2VRIf0CQajNEsp
        rKwz9d/p423YMoTX4M8e16tAgylm2BcgRM3IPIodQXsfSaQdvDW/r4ElVOOwn0Wu
        AzJVhK95aEi21/H+5Dt9CRqphByjwiEnW2uo3+XQt4LFyy12bpoOq7z9D2OYNcUr
        o7XX6RMCXjZkicf9W6cHqzoTd+KgmC4Rmm/hyI8Akq3gn3X2r1yOTsbEMEqZkgoQ
        vpDGQNhcx6YZ8g==
X-ME-Sender: <xms:74x2YSoSyplQkf4OTmKms_jsy-WPj4nKLPEOaWsXotNnUz5AqNgYtw>
    <xme:74x2YQqUCXph7pfwuSMgf9PpMEsj9RRqap4CenG6NJdMNuUc82AvYar6GgLItHsY_
    RWRYKzxPkPkz2faybs>
X-ME-Received: <xmr:74x2YXNcra0olR8SOj1-M-NUa8sUV0KL3sczTe012j3OJI736GZs0Qhg9cZJ9UXE8_HS67iQ3577>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:74x2YR4bx-yTGPKBAPl5JvEoxlNChoXb5EQCT9YdVttYCurywTchJA>
    <xmx:74x2YR5ED_OiYCwyjRial02ZXcdtXawGrNxc_L6lzRf8wh6uHYSHdA>
    <xmx:74x2YRiRQYV3N-1z6d_0H106191oaM54FsjUYwJ5yTnxNSpgbVMk-g>
    <xmx:74x2YVrOyylMDGY81FIxCN4tqAXLRoaec3bdP7o80MaLMUrLNloRSg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:54:29 -0400 (EDT)
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
Subject: [PATCH v14 8/8] ARM: dts: imx7d: remarkable2: Enable lcdif
Date:   Mon, 25 Oct 2021 20:53:09 +1000
Message-Id: <20211025105309.37942-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Connect the dispaly on the reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index b66d28b30d75..fe68f6eaa2ec 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -55,6 +55,16 @@ reg_brcm: regulator-brcm {
 		startup-delay-us = <150>;
 	};
 
+	reg_sdoe: regulator-sdoe {
+		compatible = "regulator-fixed";
+		regulator-name = "SDOE";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pinctrl_sdoe_reg>;
+		pinctrl-1 = <&pinctrl_sdoe_reg>;
+		gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -63,6 +73,16 @@ wifi_pwrseq: wifi_pwrseq {
 		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
 		clock-names = "ext_clock";
 	};
+
+	panel {
+		compatible = "eink,vb3300-kca";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &clks {
@@ -99,6 +119,20 @@ reg_epdpmic: vcom {
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	lcd-supply = <&reg_epdpmic>;
+	lcd2-supply = <&reg_sdoe>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -187,6 +221,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+		>;
+	};
+
+	pinctrl_sdoe_reg: sdoereggrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x74
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

