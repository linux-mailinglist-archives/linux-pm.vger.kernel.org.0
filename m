Return-Path: <linux-pm+bounces-28812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644EFADACD8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 12:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C2172FE7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D027FB0C;
	Mon, 16 Jun 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="AYtavwrT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A5277C81;
	Mon, 16 Jun 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067942; cv=none; b=iagUVOUbaV/nM3fHmL6HrmQJmGoy8naAo7HDB2WJLlM0ajYlN91TUIqS+WF2GrpW6rRwST/0WxN50UkLlBhHGYx3pII5Q4t+Qgh5I7myBalneHzeskMoszxoywPP9tgA9pZTOQxYpkfjigu4VtGft7SJnREnsTKfavyN+HDPEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067942; c=relaxed/simple;
	bh=CXJdMVM7yfnfOWdD19oSNPqLnLxqQfuOKdmhOWln+X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKgc8KlRT7BasuyJPIWYO/lYkGjm+18hjbLq6C/OiuYWwGkSQsIr/B8G8LziTsWmF7s8iICA/JL5D9PVYLl9nTV3wTyJSbC1BvGyHXXxxetmWXGrQHGWoGuyct7/kcavIz27HlZ8gH9Vu1wAAQzzoDMhBBHg5wF3pW/ARKfwhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=AYtavwrT; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id D8DC810093E;
	Mon, 16 Jun 2025 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750067922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHQ5vPeo13GqSQMpnsgrtHpzp9AC7Cqs5ZLxrZU37Ag=;
	b=AYtavwrTzhH3Jgi9vODa7fCqs16ThzVMTPwbbnrPN8Dd9WVq12XvC3ilaxkbU4xddMnFhP
	xUlfN52Zoq5LjggC6OPkNJgR0b3ehD5IDyaV5k5jjoBMxdW3AKlyiZwJllfOUANq0h4yDQ
	pnI4gMorcrun6dOSQFFdv7WIlpII1T8=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 7AAB7122704;
	Mon, 16 Jun 2025 09:58:41 +0000 (UTC)
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
Subject: [PATCH v4 05/13] arm64: dts: mediatek: mt7988: add cci node
Date: Mon, 16 Jun 2025 11:58:15 +0200
Message-ID: <20250616095828.160900-6-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616095828.160900-1-linux@fw-web.de>
References: <20250616095828.160900-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add cci devicetree node for cpu frequency scaling.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v3:
- add mt7988-cci compatible as suggested by angelo
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index c46b31f8d653..560ec86dbec0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -12,6 +12,35 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	cci: cci {
+		compatible = "mediatek,mt7988-cci", "mediatek,mt8183-cci";
+		clocks = <&mcusys CLK_MCU_BUS_DIV_SEL>,
+			 <&topckgen CLK_TOP_XTAL>;
+		clock-names = "cci", "intermediate";
+		operating-points-v2 = <&cci_opp>;
+	};
+
+	cci_opp: opp-table-cci {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-660000000 {
+			opp-hz = /bits/ 64 <660000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-1080000000 {
+			opp-hz = /bits/ 64 <1080000000>;
+			opp-microvolt = <900000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -25,6 +54,7 @@ cpu0: cpu@0 {
 				 <&topckgen CLK_TOP_XTAL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu1: cpu@1 {
@@ -36,6 +66,7 @@ cpu1: cpu@1 {
 				 <&topckgen CLK_TOP_XTAL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu2: cpu@2 {
@@ -47,6 +78,7 @@ cpu2: cpu@2 {
 				 <&topckgen CLK_TOP_XTAL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu3: cpu@3 {
@@ -58,6 +90,7 @@ cpu3: cpu@3 {
 				 <&topckgen CLK_TOP_XTAL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
+			mediatek,cci = <&cci>;
 		};
 
 		cluster0_opp: opp-table-0 {
-- 
2.43.0


