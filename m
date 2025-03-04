Return-Path: <linux-pm+bounces-23420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D7A4E561
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04ED424A03
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B9F2C2CA0;
	Tue,  4 Mar 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="TVNFWT5G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BnY/7fFu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED813277815;
	Tue,  4 Mar 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103411; cv=none; b=fBPbDoBqMpBIK9o5gUNXq/c0ISitwVrjDFDPfspOdXrvv0yqlq4oE1DVVC9wY+Zv0si9bvXTuN8hUta8xX1b7ug2vgSpqrEOGdiRSimhurqJOnA5bVMOfr2dc4M68ipaQLjzneK3kYbLXao48rcOC35+4KCDPX9/vVoiwDfhHGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103411; c=relaxed/simple;
	bh=kLsiO+6XRjWuZSBNb3eoyDVYeIB0/HVPi1Xdv+Vpl7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNCOmE8l22PctPGDj5Keudg2iRljRXRtdmW21/L1MSk4jN/xRYCgyTyyorxt9QcqoWJh/Ji0ydy3zJbkA1otOZFMM2ve97fSCr70UJigN/px1dlXKMuPCf/cOtsNQCxUIypn/abG8mRTH8xL8cXSCFG0drJMNJc66auxoK7Z4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=TVNFWT5G; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BnY/7fFu reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741103409; x=1772639409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JyqufnNntJt7vbpN4qCJdGub3m2IYSpcdFWV0lv7HeY=;
  b=TVNFWT5GICWbI0fHfPAJF8LqiqxBiEXrDX4Yh+5lyFMEWW8uIqc6toIl
   1GhzEz35sWoP76LUqBnh4eGj92aeqWsf6oY/oQX8kYOGYLjEfwxMFQa59
   HjJXvO0E8mVfgeNFO40Rc3I6jz6iIvyP1X2/fCXCIPkpl3YSJIn7Pdyzs
   GWALtaGW1l0VFkcEYyz3Y/EeGRbq4IVHfwNTdySO/NJAysxrN7uwQING7
   YzjxuD5OdZ7n7BrA5lyyt2K3ckBjTYXxxOC+oJbn+LzJbAt1rJDaIhpbS
   11t9n6WezQ61uHauVNH7QoiyG1JU1asLKEDDXZ4FlJqy6eg3XpBV3dnlV
   w==;
X-CSE-ConnectionGUID: RnRBH7uAQ5qZK7AQFBu60g==
X-CSE-MsgGUID: BjGsonlfSu+2xRBkhC/lLg==
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="42272749"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 16:50:08 +0100
X-CheckPoint: {67C72130-E-B1D34AC3-DEA5B19F}
X-MAIL-CPID: 7B5B58FE919B8CF66131755B05686F47_4
X-Control-Analysis: str=0001.0A006366.67C72132.00E1,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D76CC16324C;
	Tue,  4 Mar 2025 16:50:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741103403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyqufnNntJt7vbpN4qCJdGub3m2IYSpcdFWV0lv7HeY=;
	b=BnY/7fFuSytrQIWdFQTKARB3cM5OblyxNFwwbEbnhlbdmOdbudFNAdRIIVd4vbYYY7NSuo
	p+rhijLBeYRP6pBQ4namw9g34Pb+Ufzlgy5lfjrJtmGJ3wkASAGUjw5kpXRpVj0ybB1DgZ
	icVWp5m1OkipWdECwUHiwo07Rvx6g0jWcAmCkCvKREnZ1TRy6IWT65vB7eIPtu/uxATEgB
	Qmwm0YejFPIsH69KIpKzmPRXEPgRhpa76IKwZDXMcwbtgIsNXRt4cUo3UYFFMU+jkRPSKs
	E8dWNkPObMQNK9CnG8ztAlC8NZPQ7DLKlnKetCyQ3AYxO+iG5wiiDZFSOaaRjA==
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
Subject: [PATCH v3 5/6] arm64: dts: tqma9352-mba93xxla: Add LVDS overlay
Date: Tue,  4 Mar 2025 16:49:24 +0100
Message-ID: <20250304154929.1785200-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
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
index be6ef4c56fbf4..ac4f14c69cdd8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -300,6 +300,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
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


