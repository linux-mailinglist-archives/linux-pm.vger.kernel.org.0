Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962C342F0EA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhJOM35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:29:57 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35555 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238914AbhJOM3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:29:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 87ED5580EC5;
        Fri, 15 Oct 2021 08:26:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 15 Oct 2021 08:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2aOAXpeIPQR2x
        ghpp4OMQNId//edXUxPmx/LpQURmRg=; b=c0PVLObD0yYrSxS+mmqlLJ/i4cRXt
        xmI3Y6zBJ3n4kXpGap7sIeiJ0WSiOThbwXOSKaLx1j0tFIClJHQ9T7lU/41AYHlM
        Y9+8CnrakMCxiMEn2bzlxu/VWIT4pn1UJIB1jKwgSiCY/dYK9HPT53EZvy7hmUeZ
        cxdNCnHA5O3Xh8CAxaVk9Ewtws+vYpnfLyyKkgWU5/xtEG/Rlf1YPA0B/C8H0L3y
        ZpaLGklLlyOWKMRxcDsiWQr+ItVxVg3kK6KwttgnxKQ7R4RvCUlqh+276QrTnoba
        6giGPKS1FiACU4K+V1OMf6fc6bW4kq149kNmcV9lD8uq8y7dhNVJE6V9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2aOAXpeIPQR2xghpp4OMQNId//edXUxPmx/LpQURmRg=; b=iUtBto3Z
        OdloZKdcv/M2ZWVMRLFrA3GcAws9bWFsKHuUpmfxMijzKggwRuOMcQhA7dwBxnJd
        PXru1WfYweUvIfPiVQgl4PkjVsOfXZf6SFsVOdvC8jwD0yZchREXTk0xnw1ZOqF8
        nTZ6A0w/PH1yII11WfPlwDE94EFN0ct01Sq2M9uvmWvU7EtXilCyEeohDIu/nKaE
        ismBNw6CsI9lNK0BW9MXDpS0rBzNsC1tf/x19xudePpyERd5V9lg9nGS/k4nAykO
        bcPnSrL0OWw1QJXLmYugIgSIBj4CmaTouimz/Ign4eOqRZXg401hvlX3KMayqhJC
        MiCJ0vOCR8/wlQ==
X-ME-Sender: <xms:kXNpYWz48UyCr-BZPoMDjsb4iKd84tnhRRinVy3hiFkzIzC7O96BOw>
    <xme:kXNpYSTqvRsipPLEpZUBr25gxB9nBRMs9QqWLL_Wo1sCyDl40GVTOc-2t_fo9VVt1
    RGnZSB2s6dq1BlU7eE>
X-ME-Received: <xmr:kXNpYYVhyXiEyeSOzevaH2Rj9ltnq2N6elSQCF9Ada-MJi3tpRICm_jqVFYrA8Gfp8mhXAGJZGiV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:kXNpYchv29xkLzKuzkfrrLzSC_O6MiYgovDn-st11WgPHBtES5aC7Q>
    <xmx:kXNpYYAMgOgxrWtSmHK5dgshPqdilpmXlvH9FeWQHBZrgB3LW6DxEA>
    <xmx:kXNpYdLuphB5IGWlIt6XZxUpjyTvYZccV8G9uQt3fFHz-snvRDdUvQ>
    <xmx:kXNpYWSdYx7NSckKmMH2BIDFCEYByGm-AT6eQkFX_j_kKpsBwOhmwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:51 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 9/9] ARM: dts: imx7d: remarkable2: Enable lcdif
Date:   Fri, 15 Oct 2021 22:25:51 +1000
Message-Id: <20211015122551.38951-10-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
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

