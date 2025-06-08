Return-Path: <linux-pm+bounces-28270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73221AD148E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720A43A8BE4
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584BD2561CC;
	Sun,  8 Jun 2025 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="SV8MICNG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495918CBE1;
	Sun,  8 Jun 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417737; cv=none; b=IXmIixfxTGP6I+2ihipDMvNda6FW+vY6Syc+p/zoQB++g4KvlfzI55MhQ/1/bF3KZnQOBrjYh1E3Q0r0S4iDGNGtKHAOTwPfeErIZeVW5MxrHKlGxAl/Q5bRZ6QIcLzidrSyoMPmGolxj+aD3cmvAat3NmYcQmMkC7mrSruDpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417737; c=relaxed/simple;
	bh=YgR2lE90UIU0P3ZSP894Ns873m5uky+bEMrwkq/n4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEvXWeNPo6Y8NBiGjqDXkDkUcj4NZWc1BhcYicqCgEDwCHEfNBm6z1oVZZC+n4cSSnXj/rghHcgZqlRZHJDUw37qL1yHH6SZ6kgyVhCaGvgwbWJsYXi6/3xlWwwbEKoJ6w00XpFtD0ZHxfyH4zB92E9LjgvQf5cjh/sF8Z3t/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=SV8MICNG; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 4871C3FE8B;
	Sun,  8 Jun 2025 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749417304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDifwxY7gQOfgk+tbRvfbMg2JVV/EadqzCD4+/695V0=;
	b=SV8MICNG8wUHu62OpXIGmq4wfS9Jt4huC9Fk77hLCeJ52SIK35Z2So274RLS//UsWTeTLh
	osYkKhaQZXdcj0ixy9lUe/G8AaE5F2joGJU6PJeRMWCoiDUo5PDHTcr3TticQn/Wlx1Htu
	a/9xieXRv5R2iRv/AVKkTKWAEiOMbSQ=
Received: from frank-u24.. (fttx-pool-80.245.77.166.bambit.de [80.245.77.166])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E14CF1226F5;
	Sun,  8 Jun 2025 21:15:03 +0000 (UTC)
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
Subject: [PATCH v3 13/13] arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
Date: Sun,  8 Jun 2025 23:14:46 +0200
Message-ID: <20250608211452.72920-14-linux@fw-web.de>
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

Assign pinctrl to switch phys and leds.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- add labels and led-function and include after dropping from soc dtsi
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index d8b9cd794ee3..f10d3617dcac 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+#include <dt-bindings/leds/common.h>
 
 #include "mt7988a.dtsi"
 
@@ -151,6 +152,66 @@ &gmac2 {
 	phy-mode = "usxgmii";
 };
 
+&gsw_phy0 {
+	pinctrl-names = "gbe-led";
+	pinctrl-0 = <&gbe0_led0_pins>;
+};
+
+&gsw_phy0_led0 {
+	status = "okay";
+	function = LED_FUNCTION_WAN;
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port0 {
+	label = "wan";
+};
+
+&gsw_phy1 {
+	pinctrl-names = "gbe-led";
+	pinctrl-0 = <&gbe1_led0_pins>;
+};
+
+&gsw_phy1_led0 {
+	status = "okay";
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port1 {
+	label = "lan1";
+};
+
+&gsw_phy2 {
+	pinctrl-names = "gbe-led";
+	pinctrl-0 = <&gbe2_led0_pins>;
+};
+
+&gsw_phy2_led0 {
+	status = "okay";
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port2 {
+	label = "lan2";
+};
+
+&gsw_phy3 {
+	pinctrl-names = "gbe-led";
+	function = LED_FUNCTION_LAN;
+	pinctrl-0 = <&gbe3_led0_pins>;
+};
+
+&gsw_phy3_led0 {
+	status = "okay";
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port3 {
+	label = "lan3";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
2.43.0


