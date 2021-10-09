Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6714279CA
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbhJILxs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:48 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43545 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244820AbhJILxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 643AE58055A;
        Sat,  9 Oct 2021 07:51:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Oct 2021 07:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XiqTZKl1McPns
        kC+dsf8QVzxlqYLoghf8xc3andbQlc=; b=qRFtx2kR06CVDRGF+zN8ihSZfCIjW
        YuSf37CnflE31Q+lNI2bPmCQpjkKKjej6zER92QOvJp82OA4d22Jyu1R1UeiSOEx
        SAv1niYx+SCPP6Q1IymldzRRLcYNLIV0T+1o+YEk4L0OzKOuVZRDrFJLfO96gHrK
        I7nP2+5Op52LfmQI4+H67gjE6CQffSKlQ5oy+38pt1qJIBISakED2dJWXLgOkIfn
        2ueH2gGnT0uwyof7JU2/pnXndgiyNK3jwTv3PSHoc3P/kmnloCZDUAYBh6iUXJKD
        //+5hmZPCqvb6HJ+x1hqVG8geiXnjf3b7E1XTwMDP7phuH1soOdmrI4uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XiqTZKl1McPnskC+dsf8QVzxlqYLoghf8xc3andbQlc=; b=MCZu76iT
        StWrmP0VJoW7XiwAsIo0zlFjgqZlHu31p1pl2zQDURXcSzoIta/hdFm+girT32Yn
        kPvq9kB/UjNejbKsPm6MbYZZChQe1r14o+Eaqm4snbPq+A7Ph7MAnPo3Vg3xi/E+
        KxHfiE40T9Q37kRugnMabhBRQ5gHjDcFTkRTf4Te2rdWn9EBQrHJzdhyLjQuYIpq
        xQ7xJoNLfYaYytu7dF106zuMtSEa9sI/Ej7R9I8Z6DWxz/l46ryGT7+2O8sZzE6g
        yqArghXjsLoCd0P4CSGjsyg6UcXUS5WC5OspxtpgRx4E0vt0ZrKvGig25sogyp5i
        if7bartooPycZw==
X-ME-Sender: <xms:UoJhYb6Qska9IVRA_NldwhbQFGM60mq-dnRI0pXxXjCLIVLF7T5Dmw>
    <xme:UoJhYQ5xMAPVqbUKrUrvF_POhqKcWc2SboWg9gnzu0jbK0r871NHtnb2-ixvTfyya
    Z5TCDyvd0jf7x2sboc>
X-ME-Received: <xmr:UoJhYScPezUxpCZJ65Rc818ndpb22RDJ1kEPX0cdOx__kTPiPZt9kCQf3CMqCP5FGKqrdQyqAaEYpF9SqVwBYXv4bQLViQcsglo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:UoJhYcLp2WOG6OAMKwvXwqDJ0DAuTXRVdndJx-Z5ZUm0B9xE9y0IDw>
    <xmx:UoJhYfKX6ELPvKDW5NH12POk0qWX9kyO0reyyvVU6clIGBZ78b-psg>
    <xmx:UoJhYVy6iuW87IkeOT19aJNdGSum0nwgSn--CbGjZS0T3c1DUwCrLA>
    <xmx:UoJhYQ42byASWot994gYxH4BZyFaNmfeLbVrYbaJWE9IH4JR2Qd_hA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:41 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 08/10] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Sat,  9 Oct 2021 21:50:30 +1000
Message-Id: <20211009115031.18392-12-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 2099784d6515..1b49c26816cd 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -87,6 +87,33 @@ wacom_digitizer: digitizer@9 {
 	};
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
@@ -180,6 +207,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -187,6 +221,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
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

