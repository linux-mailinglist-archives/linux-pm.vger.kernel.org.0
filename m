Return-Path: <linux-pm+bounces-28806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E2EADACBF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BCD172638
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE5277814;
	Mon, 16 Jun 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="eGf3s0Dn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948A2750E5;
	Mon, 16 Jun 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067929; cv=none; b=UXrUGx0Vzhjpyn8/pH7dSnQKL4Ylic84JOPZDD6FWqzbhLz7fVyUnMHBHHQ+WHkZvgrZT+S4tXj1Ni7PgXFXnP1ZNR1ACNk2Iau7KZrxnCYLo7AH3gYzG5PFJg4+k6rHuoHyQBg02tzpfcD2ycSHcEM3gvXfgfjZjAYgc1PDIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067929; c=relaxed/simple;
	bh=owery2Y9xho1bAvAYoxF0F6uDfB7KsKdTzyV/Nr07xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tB5W14J7Qf9aoOjhLZ9Cqw4v3yORDf4VWwOKm3yoWnXYb5kuaXHE1bweaHo5/7BL9Ral4HMRvp5vKmd8ZGRmDok4dErmNewzNn4zISLEOpFJ5iMxlOs3ds0MJznrwaoeNFt9ml/GyOHFVZpjbM8oACXlqLwXIq6Zpk9Chdvz9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=eGf3s0Dn; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 0FF9A41AAA;
	Mon, 16 Jun 2025 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750067925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw75z6h4HeFha6AF7YI1R1VXg23z1dS7Y1C1o8vw7rQ=;
	b=eGf3s0DnOxdkyJ/bqKhPYLUNNu8lm1EH/gFkuSpNKsWX+3qZuQNyRwASfKEMGEm2fQoDTf
	O69zsIH/WgY96o7CRTYc7NKZH53QlTbgh+Pp3GprVlMs6sxL/68rBMojwDKx2iY0f4yRFQ
	HmWWR8lAQTkKU8pFEi1ptWI5CmAJiQ4=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id A7FE4122704;
	Mon, 16 Jun 2025 09:58:44 +0000 (UTC)
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
Subject: [PATCH v4 13/13] arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
Date: Mon, 16 Jun 2025 11:58:23 +0200
Message-ID: <20250616095828.160900-14-linux@fw-web.de>
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

Assign pinctrl to switch phys and leds.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v4:
- reorder switch phy(-led) properties
v2:
- add labels and led-function and include after dropping from soc dtsi
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 4d709ee527df..7c9df606f60d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+#include <dt-bindings/leds/common.h>
 
 #include "mt7988a.dtsi"
 
@@ -152,6 +153,66 @@ &gmac2 {
 	sfp = <&sfp1>;
 };
 
+&gsw_phy0 {
+	pinctrl-0 = <&gbe0_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy0_led0 {
+	function = LED_FUNCTION_WAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
+};
+
+&gsw_port0 {
+	label = "wan";
+};
+
+&gsw_phy1 {
+	pinctrl-0 = <&gbe1_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy1_led0 {
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
+};
+
+&gsw_port1 {
+	label = "lan1";
+};
+
+&gsw_phy2 {
+	pinctrl-0 = <&gbe2_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy2_led0 {
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
+};
+
+&gsw_port2 {
+	label = "lan2";
+};
+
+&gsw_phy3 {
+	pinctrl-0 = <&gbe3_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy3_led0 {
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
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


