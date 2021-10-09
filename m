Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E34279E4
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbhJIL7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:59:41 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40625 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244876AbhJIL7k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:59:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5D135580A0F;
        Sat,  9 Oct 2021 07:57:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 09 Oct 2021 07:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=ReThg5ZGo1o5jqJWFdVfwe8Jjp
        jq33hX/M+b6dnDGuI=; b=sLu8nNcMGanwtLsII36vPFgM7F1DQUUc3hir2+g0kI
        8pvqGepmuBp4DQZgq5CZCfZH8N1DugVcO23eeGtMc2yOn2y9QCZFEIz96aJM55CB
        WNEmXkOV9woHWGhxEyImfWTa4Z1dCponu+zbx9GCxA1SLYsgoEscrTXI6c5b43Bj
        MohTtixF3IALd/Z96srurcWGaU5AcrkLWIcgUk0SIVkbvs/fg2KujcFsWlEsyaZQ
        A6Xz9H5H/DO+miuL2LjDu/J32hFGcu2i092FSwEAmqMbXBp7HnDb4lYxnjbhs/D7
        frcmhqkHSBg5BC57B+bDHKMrNWGop1mLCp/eAsyhER2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ReThg5ZGo1o5jqJWF
        dVfwe8Jjpjq33hX/M+b6dnDGuI=; b=QN8Ys11dYxzubZmJ4Mx4gQG5+owDcHO+v
        pTSIsdRMeCP554ZY42w1zv3RDDkakSGKkihQkjscGGIahzXCGYyZ42z541tG+6K4
        rRyF3mrMEVPIPEtOf36sk2KYkHjsyhUvAPy2M8AkR6byobnfuwilqE6AzgoMfjFl
        awv8QqQ/7UHTlUogYcrlFWoZdjZC5Zh0WQ4MuLFelkUtugJDd8SYtmraNyczLNVx
        tDW3fwCGbAyRa754W3XxUDxNNwjcr1FOJ6Q92B8gfUa6/ck4tMWILGlK4HzZ3ATw
        uhICvhKBwRGbXKWi+wRustcFbyX1ZAN9EEtPHoQU+YYypDHHiJG7Q==
X-ME-Sender: <xms:toNhYdicV8n4lLW8tGEalp39mIFk0bksJNDOau4vZJn66a2hIEHIfA>
    <xme:toNhYSD0TaDGj8qMcpw8FWxnt4w0w1H7nPwswHvuSJwwDURSFv5FUMDqH-O5Jwi1Z
    3QJRLLBaDJOT4UbtG4>
X-ME-Received: <xmr:toNhYdEJZg8n95H46iH-mNKe4CCxWrutW_Y4iAZ1h35oOiAu1t3akdZBb6KgDkKSa6ZV0BsxF1h6xh8CzggeB4fdumdR_06CyFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:toNhYSRg08r8fAusxsZW03nB_AYqzwu_5qU8HnPVkh8Ahwp0A7lWFQ>
    <xmx:toNhYawL1FmycW0lo9H9lx7DfvACYdN2n0FdZPPBuxx-CObqPfKyQg>
    <xmx:toNhYY4cPC3n4sY25WfCfM5xfsOnWskjNauRrHi0Mibdq2uwyEMALw>
    <xmx:t4NhYeDBkiq5tk8D9L9H4nx6mXMEDeyq8Ffx90yqnft_t5vrYIEPmw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:57:36 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 10/10] ARM: dts: imx7d: remarkable2: Enable lcdif
Date:   Sat,  9 Oct 2021 21:57:32 +1000
Message-Id: <20211009115732.19102-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
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
index 1b49c26816cd..5f32c216c3fd 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -47,6 +47,16 @@ reg_digitizer: regulator-digitizer {
 		startup-delay-us = <100000>; /* 100 ms */
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
@@ -55,6 +65,16 @@ wifi_pwrseq: wifi_pwrseq {
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
@@ -114,6 +134,20 @@ reg_epdpmic: vcom {
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
@@ -228,6 +262,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
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

