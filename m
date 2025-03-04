Return-Path: <linux-pm+bounces-23419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F7A4E519
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03ECF7A3A40
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE482C1556;
	Tue,  4 Mar 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pdzEjLFq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="d0ZpTXW+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C02C1551;
	Tue,  4 Mar 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103405; cv=none; b=jAgckpCZh6n1/scqJJyJvtloaj3XTGf1DtKGY+Tt+mQHJSgjY1Ewwe4fHM/B94iblqBztQCLvIa2vIzRxOc5OfrRdkcI/Ygm3JU52xhRHkkbSGflTNikdaeKDuSvcMJQrfAlzkMw7J4sDgnAXj84ZPRmXXeVr+T8gCu+OHIXYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103405; c=relaxed/simple;
	bh=mo2wO7MPP0MNUW9jvEInGL4vAwScrsCq6W3n24mnDYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+DlZkQ1ZienbIZ5If6GcjBKWo3Ikz5vXuHZ03ITbyBYpzTWIGYjKRyub4L7LObjGpc2/IIndBh270mvlmcwelHS4lmq2hk5aAeIQwiVDtAcFcKCLwUlZAsLREeqHZfmK12Vdu//bMj05VTwWZoSu2FbNd7H3l6E3pVsTmZQlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pdzEjLFq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=d0ZpTXW+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741103403; x=1772639403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VoAaV45utjStyReGTSKahDfsHoCThtjhDMr40/ZGtg=;
  b=pdzEjLFqnOT/gzQyrKHq7YyzTlwe+2lh9QoWTeExTYMR4IHvmI6MIB8I
   ugssbLpCGZXmbmXF7dPO1ssXAXorwNV8ej7qy4FRdTB/axnH9XdyRprRn
   ASOVwbdaxHYVyP7sP/0K9QnUdK2LTUvRAhn1Z++e4AP1bQBKME4QII1wH
   oRf8hKfWNhYPnZQGmkmZroxo6eaQDWm2QmEVn0Nayl6DcJu45Q7ltUeTq
   1ZHs/ZgwZSeMFRJ5dAQJ1wGaLuh/2dbp3bG6X3hnRGxfLmT+vQFZ02osN
   Fh2Y1sRmKYE0G9KKzO98bAE477kBnIaqOwUkEFRFsiMMbuiLiOXIdXTaV
   w==;
X-CSE-ConnectionGUID: LfRjySMJQHuFg6AXqcHyxg==
X-CSE-MsgGUID: gPukJPRnS7SFRHjQMPPMPQ==
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="42272746"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 16:50:02 +0100
X-CheckPoint: {67C7212A-0-2417938-F0170C2B}
X-MAIL-CPID: CC92DBED37CA786F3092364A9E7C0752_2
X-Control-Analysis: str=0001.0A006367.67C7212D.0028,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B14E016180C;
	Tue,  4 Mar 2025 16:49:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741103397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VoAaV45utjStyReGTSKahDfsHoCThtjhDMr40/ZGtg=;
	b=d0ZpTXW+XW9H0wxY7wcgCEQ6dljQ3Hv6H59YAmhYbAlONxHn98m9h4qO39IiCd0/nSlRhL
	EOxEmadDTzRmdGCszjiduenMDxtl6rz7SUqda64s0ghINesnyORHLr8UWplBOnzScNN0A1
	3QQGhM9tfTdAlj6XCWCVFKndIgrW48VuyS/ixmZC5LnzQ0Y9XZJswb33jID4xVNx4nO+zG
	q3k6hSX+EeGPxTa7nQ6E/awEDjpGMRJIJwrGLC2Qz2Omdsigsh2zUjxXFRTYG0/rTiB5Bz
	t7iGzADX/ov3ns8Q55S3DckdYzKo+z/T33rmmXaSegWfDCPdLZVfFYsAGxhGWg==
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
Subject: [PATCH v3 4/6] arm64: dts: imx93: Add LCDIF & LDB nodes
Date: Tue,  4 Mar 2025 16:49:23 +0100
Message-ID: <20250304154929.1785200-5-alexander.stein@ew.tq-group.com>
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

LCDIF port 1 is directly attached to the LVDS Display Bridge (LDB).
Both need the same clock source (VIDEO_PLL1).

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 77 ++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 56766fdb0b1e5..69a639a8c833f 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1273,6 +1273,9 @@ s4muap: mailbox@47520000 {
 		media_blk_ctrl: system-controller@4ac10000 {
 			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
 			reg = <0x4ac10000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x4ac10000 0x10000>;
 			power-domains = <&mediamix>;
 			clocks = <&clk IMX93_CLK_MEDIA_APB>,
 				 <&clk IMX93_CLK_MEDIA_AXI>,
@@ -1286,8 +1289,82 @@ media_blk_ctrl: system-controller@4ac10000 {
 				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
 			clock-names = "apb", "axi", "nic", "disp", "cam",
 				      "pxp", "lcdif", "isi", "csi", "dsi";
+			assigned-clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+					  <&clk IMX93_CLK_MEDIA_APB>,
+					  <&clk IMX93_CLK_VIDEO_PLL>,
+					  <&clk IMX93_CLK_MEDIA_DISP_PIX>;
+			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD0>,
+						 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
+						 <&clk IMX93_CLK_24M>,
+						 <&clk IMX93_CLK_VIDEO_PLL>;
+			assigned-clock-rates = <333333333>, <133333333>, <0>, <200000000>;
 			#power-domain-cells = <1>;
 			status = "disabled";
+
+			lvds_bridge: bridge@20 {
+				compatible = "fsl,imx93-ldb";
+				reg = <0x20 0x4>, <0x24 0x4>;
+				reg-names = "ldb", "lvds";
+				clocks = <&clk IMX93_CLK_LVDS_GATE>;
+				clock-names = "ldb";
+				assigned-clocks = <&clk IMX93_CLK_MEDIA_LDB>;
+				assigned-clock-parents = <&clk IMX93_CLK_VIDEO_PLL>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						ldb_from_lcdif: endpoint {
+							remote-endpoint = <&lcdif_to_ldb>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						ldb_lvds: endpoint {
+						};
+					};
+				};
+			};
+		};
+
+		lcdif: display-controller@4ae30000 {
+			compatible = "fsl,imx93-lcdif";
+			reg = <0x4ae30000 0x23c>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+				 <&clk IMX93_CLK_LCDIF_GATE>,
+				 <&clk IMX93_CLK_MEDIA_AXI>;
+			clock-names = "pix", "axi", "disp_axi";
+			assigned-clocks = <&clk IMX93_CLK_VIDEO_PLL>,
+					  <&clk IMX93_CLK_MEDIA_DISP_PIX>;
+			assigned-clock-parents = <&clk IMX93_CLK_24M>,
+						 <&clk IMX93_CLK_VIDEO_PLL>;
+			power-domains = <&media_blk_ctrl IMX93_MEDIABLK_PD_LCDIF>;
+			status = "disabled";
+
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				lcdif_to_dsi: endpoint@0 {
+					reg = <0>;
+				};
+
+				lcdif_to_ldb: endpoint@1 {
+					reg = <1>;
+					remote-endpoint = <&ldb_from_lcdif>;
+				};
+
+				lcdif_to_dpi: endpoint@2 {
+					reg = <2>;
+				};
+			};
 		};
 
 		usbotg1: usb@4c100000 {
-- 
2.43.0


