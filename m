Return-Path: <linux-pm+bounces-22819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D140A42362
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48498441824
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662A25A326;
	Mon, 24 Feb 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OOu57PFF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MRShQOhH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11A18A924;
	Mon, 24 Feb 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407354; cv=none; b=dmp1xK4+ncg7eTvHAF7y+lyukI6f4/7QAD4/2cDZaVPodonEPwoVANC7cQPBVdwhht1MtUZe3FBJNZEOi2UAjMDS4St90t7sKxDld0thBY8iRBwrQ8ETCHurb/tQmEu8k+f6k2HtsS9GurZBKyPAsQzcBkHWZAxsySPPKgaLWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407354; c=relaxed/simple;
	bh=Vs2cF0fD5zfDcgYiYCj3O2Hx7uCdcdI/WmYNJEFXD/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suQk6tsAWhF2FZjupWmyOQ83DsrfwOU7avYZIhuMZT6GgX5ptzbpJZJ0GXLlK9m8DX9/ha5viamYtSaiLW9R9z4bFijk+eTgqvU+FKvPHgssCV+4sfx6+NFAUzBIRdYKUaJ/1699vZW1SJgkb6bXYDYTmXGK13VJ1Q/oavWcTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OOu57PFF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MRShQOhH reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740407352; x=1771943352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CUkqkuTIwhC2+9PZFF/aB3sVN+0mfxsHSo7RXL2lq9I=;
  b=OOu57PFFmaAIn/QRGhwDYesx+yns2Ns31XniI3pOUYtQDa/1LtTaPST4
   rqCHk+xlnwiDTS5upxZ20A1slCCbpRW9CUbzxtN2BG+5NclIBg0PywjFe
   06S0kNt3c/fpvs6zRCOiLtWIhiZx2LRMe8hKVFm1veXNIFx76cWGFw/Yn
   4HD7zLAr8mYaESzvaeV8jGMigB84K2LBDn5mQxdsvbt8JBJZu9X62gGON
   GLhJEEYjLJT/Jn9ulRF/u357A3PpR9qnAvMt7JvC/VDy7kjogsPd7wPy+
   cg5PPuE+kUVuYHBrPrCLtjVsUtfSNc91onO/PB2N4qbnaYmIHBP/nK4Xn
   A==;
X-CSE-ConnectionGUID: C0HWLf+vSuu5ANnE6nllVw==
X-CSE-MsgGUID: nMahwhb8S8qvlAkhBUUM0w==
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="scan'208";a="42042115"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Feb 2025 15:29:10 +0100
X-CheckPoint: {67BC8236-13-EBA888C4-C1AC8B84}
X-MAIL-CPID: 86687CF51B2ED7B3A3B04EA061549701_0
X-Control-Analysis: str=0001.0A002104.67BC8237.0026,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1841E1679AE;
	Mon, 24 Feb 2025 15:29:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740407346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUkqkuTIwhC2+9PZFF/aB3sVN+0mfxsHSo7RXL2lq9I=;
	b=MRShQOhHZfE2gBmMznhNhPKNhfgWsTVRA29WhbT06TshiHUxeIiRODgTXjVMccg4Dn6f0D
	0rnCm7UCnjQaHaQnxmhzQNeeUmHfHhbor8VKzD1zfAeFYzEn66MhEBDO+jti/dUki3lEby
	+CCq6L04yJW03NhLWsWGDGOzx0ZReRb0yGsE/mG1Yg3s9WDtFc/OuDNhRU/Jvh2YFvnrGQ
	UuIL8itLxZ9WJ+oXUQzU++Br0Z47agGTe9/SgBFUwzZH0KAp6t6DjHRBugJIGJ4yJRoyha
	jlOgjFQ/KsuAEPObev2iRzIo+ErL9CdslhIwNMF98ggMSW03vmzykc3u/+7QrA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: tqma9352-mba93xxla: Add LVDS overlay
Date: Mon, 24 Feb 2025 15:28:26 +0100
Message-ID: <20250224142831.485159-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
References: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds the overlay for the Tianma TM070JVHG33 LVDS display.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  3 ++
 ...3-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso | 40 +++++++++++++++++++
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 27 +++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 839432153cc7a..0af5eb771cd20 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -283,6 +283,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
+imx93-tqma9352-mba93xxla-lvds-tm070jvhg33-dtbs += imx93-tqma9352-mba93xxla.dtb imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtb
+
 imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso
new file mode 100644
index 0000000000000..c723a19f03d63
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+
+#include <dt-bindings/clock/imx93-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds {
+	status = "okay";
+};
+
+&display {
+	compatible = "tianma,tm070jvhg33";
+	status = "okay";
+};
+
+&lcdif {
+	assigned-clocks = <&clk IMX93_CLK_VIDEO_PLL>,
+			  <&clk IMX93_CLK_MEDIA_DISP_PIX>;
+	assigned-clock-rates = <477400000>;
+	status = "okay";
+};
+
+&lvds_bridge {
+	status = "okay";
+};
+
+&media_blk_ctrl {
+	status = "okay";
+};
+
+&tpm5 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 9e88c42c3d170..4618f836345fc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -48,6 +48,23 @@ clk_dp: clk-dp {
 		clock-frequency = <26000000>;
 	};
 
+	display: display {
+		/*
+		 * Display is not fixed, so compatible has to be added from
+		 * DT overlay
+		 */
+		power-supply = <&reg_3v3>;
+		enable-gpios = <&expander2 1 GPIO_ACTIVE_HIGH>;
+		backlight = <&backlight_lvds>;
+		status = "disabled";
+
+		port {
+			panel_in_lvds0: endpoint {
+				remote-endpoint = <&ldb_lvds>;
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -509,6 +526,16 @@ &lpuart8 {
 	status = "okay";
 };
 
+&lvds_bridge {
+	ports {
+		port@1 {
+			ldb_lvds: endpoint {
+				remote-endpoint = <&panel_in_lvds0>;
+			};
+		};
+	};
+};
+
 &pcf85063 {
 	/* RTC_EVENT# from SoM is connected on mainboard */
 	pinctrl-names = "default";
-- 
2.43.0


