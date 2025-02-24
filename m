Return-Path: <linux-pm+bounces-22820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F7A42322
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4707A6FB8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094B25A34C;
	Mon, 24 Feb 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="B16sbLnb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OS9QTX6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4625A34B;
	Mon, 24 Feb 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407360; cv=none; b=i4aJi7TI8/5xEnKtrzHPZTMJxOxlAhx1LudtKpGCx4oRwsdoYAdSUdzpPkgH610eRZKv5LVvaNiH+Jf3FNzVIpyJ2gs9VN3olZhTkZ+lf9ouGJZ8HvRQnzaSKqi4EaUS4Rg6kG9+F3TzzP4O5FAKR0kHBgdgzjJYrlhrNYO2E7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407360; c=relaxed/simple;
	bh=FUO0LLs0oo9plVyAXCNYztcpdEY5b+pbBD6b5KvX3Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAH7Jknhy5J5jGkxzytKYM7kjo6oPhp5oxVuHmluSWEdHa4GPBXn0Pg2H3AccsXoF1jQhusDOHRnRn6Rbvs1zL2bHipwjO4NNo/n2AhYQRyRyJRSw5S8PKcsiZpvgySqxoyFbWs6zIMF/dl0jG4s4z1VkXwCt4c+Wwnnd9xO8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=B16sbLnb; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=OS9QTX6C reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740407358; x=1771943358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLc34ygsvnATaKeD70ZVzqspssNpEnJ/qBKf4FYK4ZM=;
  b=B16sbLnbPoaXi5aU4yiphShZ9fWxXYzTOKurDaCfqJZxj87nzfJRZxIx
   GFvRnV+VdmqbCv5jH9NhHWFQsYHKd+izK9l8uqyIx3je7gPUuupNfkKNW
   LnnSTGgHxYrCMtMlPvSZqlrYyarkGVKV25+RQJj1PTMtnxhS3P4sHA1qe
   M2OCJjQdNAAX3m9gNNq59Dj35794oJPOC6PnsLVnDsdCEUlHwp1545XLJ
   CpUXQD8ZtKO6cmhre+5oykrOd/BG+ck2D6fw1bzsVyxc+6cRmqWlvEZQP
   2qwTHAPv19N8Z95+0m6GfvwiXFKNjFM0WMb4VMnjIDBhQ9S3ZPAi7TutV
   A==;
X-CSE-ConnectionGUID: B3NWjcT1QjeCfNGE5kUaBA==
X-CSE-MsgGUID: 8b280ciqR5GfuoyHWVjPCw==
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="scan'208";a="42042121"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Feb 2025 15:29:17 +0100
X-CheckPoint: {67BC823C-47-C21CC984-D1047F1F}
X-MAIL-CPID: 3C058A50C1D12BEF602E39B1C2D34495_5
X-Control-Analysis: str=0001.0A00211E.67BC823B.00BB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65E83167A07;
	Mon, 24 Feb 2025 15:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740407352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLc34ygsvnATaKeD70ZVzqspssNpEnJ/qBKf4FYK4ZM=;
	b=OS9QTX6CeV3qDyAbVhe9kyz+YOpidOJJbPoB9v/pFgx6GiffOacMh/0e1CSaBSpjzHPVtU
	U3xGsIBeLe0PS5yn8LGDn9WG1FDalPaYtU9I/eF3ESTzfkQyNHhTOmat6eLudYVkQ9NHYu
	htSWyHe5KrzWkV6VIxyRdGcK7Kj/Mg5bK1qF2Ifqu39Uwq0oiJL0jfEOtVNfFqg4VPOOom
	X0ol8+NdrNwKs7NF+FEAjR1nmcOpG6J0aCvF+3yLeV7OHlAWnCtAabE2qcYmCpjskJZOXz
	Hmk++bV20528xB23maPQmG0EhKx1OL9zMywPZH/6o5wqmw9iH08pngq9Ok58hg==
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
Subject: [PATCH v2 6/6] arm64: dts: tqma9352-mba93xxca: Add LVDS overlay
Date: Mon, 24 Feb 2025 15:28:27 +0100
Message-ID: <20250224142831.485159-7-alexander.stein@ew.tq-group.com>
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
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 ...3-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso | 40 +++++++++++++++++++
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 27 +++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0af5eb771cd20..b7add640f8971 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -283,7 +283,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
+imx93-tqma9352-mba93xxca-lvds-tm070jvhg33-dtbs += imx93-tqma9352-mba93xxca.dtb imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtbo
 imx93-tqma9352-mba93xxla-lvds-tm070jvhg33-dtbs += imx93-tqma9352-mba93xxla.dtb imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtb
 
 imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso
new file mode 100644
index 0000000000000..d21e5ccca2e93
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
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
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index ebbac5f8d2b2d..e70c3995e89da 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -42,6 +42,23 @@ backlight_lvds: backlight {
 		status = "disabled";
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
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		pinctrl-names = "default";
@@ -546,6 +563,16 @@ &lpuart8 {
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


