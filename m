Return-Path: <linux-pm+bounces-28267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABCAD1478
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3510188AD50
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD332561B9;
	Sun,  8 Jun 2025 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="KAXnG/rC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C513635C;
	Sun,  8 Jun 2025 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417313; cv=none; b=eASeFqXVqh3g3YlrRs1h7aOz9pBYPXBGgHjpTHs30IPvksL+C4YxvLbbCNwSsyak0lRKWSXdFyKtySjtyc4o7MQg8TVZAjwZ+jErM9+l24kpmu822pI7DhWy2wnGMzsjLt8Ghu+70kJ8fx/vSXwtaljOQvmloptHCv+4nMd4OtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417313; c=relaxed/simple;
	bh=8nYAHc4W1H8AXtWO3AyimTIeoWo9EVs3rj/0J1sXtjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4f6fB+m612wmkc/k3p/l0y4Tl+VTw2xDfo54otkMnORMnB0v3umwwhsbIJiYyaJgtcBwXDK+Kwqm752euLrv8ThGiWPAIH4B8bcr9o7Bg6A+1l4TObkvSA6z8UYKN+8f9jGxqBwN5D/aM+/IGsJgbHa3f9QYr9/kPVxb/DzcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=KAXnG/rC; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 6DC4160144;
	Sun,  8 Jun 2025 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749417301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqy5KMEDiWU7YgTuGCWxILiLLKLE1lv6K48VTywDIN8=;
	b=KAXnG/rCAffFgKtE8Wn3wkzrxLNYdaqEoZKXZMoR0QGo3TXjrJDZ2zCvEiqN8zMxI5PbF5
	xhItsAQ8LQXDgBSdAf9KA8PiY4lSHpAlvdUjfWR5an7/3XhPrrVMfWVEwwfBGM5boLBPlU
	qnpjGEVE+1op+QGyOwfFpjcMz+JGqUU=
Received: from frank-u24.. (fttx-pool-80.245.77.166.bambit.de [80.245.77.166])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 121531226D6;
	Sun,  8 Jun 2025 21:15:01 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic ethernet-nodes
Date: Sun,  8 Jun 2025 23:14:39 +0200
Message-ID: <20250608211452.72920-7-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250608211452.72920-1-linux@fw-web.de>
References: <20250608211452.72920-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add basic ethernet related nodes.

Mac1+2 needs pcs (sgmii+usxgmii) to work correctly which will be linked
later when driver is merged.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 124 +++++++++++++++++++++-
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 560ec86dbec0..ee1e01d720fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -680,7 +680,28 @@ xphyu3port0: usb-phy@11e13000 {
 			};
 		};
 
-		clock-controller@11f40000 {
+		xfi_tphy0: phy@11f20000 {
+			compatible = "mediatek,mt7988-xfi-tphy";
+			reg = <0 0x11f20000 0 0x10000>;
+			resets = <&watchdog 14>;
+			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
+				 <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
+			clock-names = "xfipll", "topxtal";
+			mediatek,usxgmii-performance-errata;
+			#phy-cells = <0>;
+		};
+
+		xfi_tphy1: phy@11f30000 {
+			compatible = "mediatek,mt7988-xfi-tphy";
+			reg = <0 0x11f30000 0 0x10000>;
+			resets = <&watchdog 15>;
+			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
+				 <&topckgen CLK_TOP_XFI_PHY_1_XTAL_SEL>;
+			clock-names = "xfipll", "topxtal";
+			#phy-cells = <0>;
+		};
+
+		xfi_pll: clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
 			resets = <&watchdog 16>;
@@ -714,19 +735,116 @@ phy_calibration_p3: calib@97c {
 			};
 		};
 
-		clock-controller@15000000 {
+		ethsys: clock-controller@15000000 {
 			compatible = "mediatek,mt7988-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
-		clock-controller@15031000 {
+		ethwarp: clock-controller@15031000 {
 			compatible = "mediatek,mt7988-ethwarp";
 			reg = <0 0x15031000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		eth: ethernet@15100000 {
+			compatible = "mediatek,mt7988-eth";
+			reg = <0 0x15100000 0 0x80000>,
+			      <0 0x15400000 0 0x200000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ethsys CLK_ETHDMA_CRYPT0_EN>,
+				 <&ethsys CLK_ETHDMA_FE_EN>,
+				 <&ethsys CLK_ETHDMA_GP2_EN>,
+				 <&ethsys CLK_ETHDMA_GP1_EN>,
+				 <&ethsys CLK_ETHDMA_GP3_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU2_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU1_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU0_EN>,
+				 <&ethsys CLK_ETHDMA_ESW_EN>,
+				 <&topckgen CLK_TOP_ETH_GMII_SEL>,
+				 <&topckgen CLK_TOP_ETH_REFCK_50M_SEL>,
+				 <&topckgen CLK_TOP_ETH_SYS_200M_SEL>,
+				 <&topckgen CLK_TOP_ETH_SYS_SEL>,
+				 <&topckgen CLK_TOP_ETH_XGMII_SEL>,
+				 <&topckgen CLK_TOP_ETH_MII_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_500M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_PAO_2X_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_SYNC_250M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_PPEFB_250M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_WARP_SEL>,
+				 <&ethsys CLK_ETHDMA_XGP1_EN>,
+				 <&ethsys CLK_ETHDMA_XGP2_EN>,
+				 <&ethsys CLK_ETHDMA_XGP3_EN>;
+			clock-names = "crypto", "fe", "gp2", "gp1",
+				      "gp3",
+				      "ethwarp_wocpu2", "ethwarp_wocpu1",
+				      "ethwarp_wocpu0", "esw", "top_eth_gmii_sel",
+				      "top_eth_refck_50m_sel", "top_eth_sys_200m_sel",
+				      "top_eth_sys_sel", "top_eth_xgmii_sel",
+				      "top_eth_mii_sel", "top_netsys_sel",
+				      "top_netsys_500m_sel", "top_netsys_pao_2x_sel",
+				      "top_netsys_sync_250m_sel",
+				      "top_netsys_ppefb_250m_sel",
+				      "top_netsys_warp_sel","xgp1", "xgp2", "xgp3";
+			assigned-clocks = <&topckgen CLK_TOP_NETSYS_2X_SEL>,
+					  <&topckgen CLK_TOP_NETSYS_GSW_SEL>,
+					  <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>,
+					  <&topckgen CLK_TOP_USXGMII_SBUS_1_SEL>,
+					  <&topckgen CLK_TOP_SGM_0_SEL>,
+					  <&topckgen CLK_TOP_SGM_1_SEL>;
+			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>,
+						 <&topckgen CLK_TOP_NET1PLL_D4>,
+						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+						 <&apmixedsys CLK_APMIXED_SGMPLL>,
+						 <&apmixedsys CLK_APMIXED_SGMPLL>;
+			mediatek,ethsys = <&ethsys>;
+			mediatek,infracfg = <&topmisc>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gmac0: mac@0 {
+				compatible = "mediatek,eth-mac";
+				reg = <0>;
+				phy-mode = "internal";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gmac1: mac@1 {
+				compatible = "mediatek,eth-mac";
+				reg = <1>;
+				status = "disabled";
+			};
+
+			gmac2: mac@2 {
+				compatible = "mediatek,eth-mac";
+				reg = <2>;
+				status = "disabled";
+			};
+
+			mdio_bus: mdio-bus {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* internal 2.5G PHY */
+				int_2p5g_phy: ethernet-phy@f {
+					reg = <15>;
+					compatible = "ethernet-phy-ieee802.3-c45";
+					phy-mode = "internal";
+				};
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.43.0


