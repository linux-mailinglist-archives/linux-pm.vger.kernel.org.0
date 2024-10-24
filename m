Return-Path: <linux-pm+bounces-16408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B99AED41
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5151A1F22A1C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAFD1FC7F8;
	Thu, 24 Oct 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="SA0QNzYQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3581FAEF6;
	Thu, 24 Oct 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789793; cv=none; b=kClCNcSgddifGkOq2C/Dc7hCgWoF6dXbu8Y+HU0KGOUSsEUWv6T1rNI1Nci4065fq3hwQkoODtJh24e9x1G7Dvpctj7jGcIFzQJKrDCDNg3TTbb/THjKq7JcpqS/F47Q/jrx2HPUEJocHsAfpqv1UqOaYyNcln8awMvuwwoqvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789793; c=relaxed/simple;
	bh=SXlv9B8AoJX1K/LjIPZJ5S+TFLEbtezksBkekZtH358=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRS8GIPEjhTHYD4FYZFs4ModAOXOhUaufR5OMM+sJLC69+YcYlsnNrtoM7EChoDR7aHAQvS0s4KTHI7CGFK/2AVK1uUC0zSGLTf4mQZ/d6mrHJSzeKksw2BFq8K0bWPCKyZDK4PGCK685LZopUkoK78DxE8bJC+cKb45sY3PWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=SA0QNzYQ; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789786;
	bh=SXlv9B8AoJX1K/LjIPZJ5S+TFLEbtezksBkekZtH358=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA0QNzYQV4gTjTYnKFIEcdb3jDoLhhKKll25bO7rw3IkEcEfI+DB+wxCqvdgtSNOY
	 GW/fOm7PZ8gaLs5uJIYAlXz+efQuBajSudGYQ/xI6ga6lnjRA2sAllK1wVLpuUE80g
	 I3QwHnZhd+PzrNXdDzxQ7dzwF6aWFsfsfUsxQA4Yk/PTFKBaCXsdM8AAw7cNdnbw9J
	 xPmhAGUB5wjMxtwNnhi82GjOKdjs+/cP1q09n1ZlCpvyKTIngTA5JfHr/4V+wrt7d6
	 QClQQ1sYyz9l0rNrw8YuirKraWliqG7YWtWiSzqKP9rUnUUiaKExexvIJHOdn/t43q
	 rlSeOKqnCX4cA==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Parthiban <parthiban@linumiz.com>,
	Yangtao Li <frank@allwinnertech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 07/13] arm64: dts: allwinner: a100: add usb related nodes
Date: Thu, 24 Oct 2024 14:05:25 -0300
Message-ID: <20241024170540.2721307-8-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank@allwinnertech.com>

Allwinner A64 have two HCI USB controllers, a OTG controller and a USB
PHY device, let's add nodes on dts.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
[masterr3c0rd@epochal.quest: fallback to a33-musb instead of h3-musb]
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index adb11b26045f..0aee1b578661 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -302,6 +302,97 @@ ths: thermal-sensor@5070400 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		usbphy: phy@5100400 {
+			#phy-cells = <1>;
+			compatible = "allwinner,sun50i-a100-usb-phy";
+			reg = <0x05100400 0x14>,
+			      <0x05101800 0x4>,
+			      <0x05200800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu0",
+				    "pmu1";
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>;
+			clock-names = "usb0_phy",
+				      "usb1_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
+			reset-names = "usb0_reset",
+				      "usb1_reset";
+			status = "disabled";
+		};
+
+		ehci0: usb@5101000 {
+			compatible = "allwinner,sun50i-a100-ehci",
+				     "generic-ehci";
+			reg = <0x05101000 0x100>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb@5101400 {
+			compatible = "allwinner,sun50i-a100-ohci",
+				     "generic-ohci";
+			reg = <0x05101400 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usb_otg: usb@5100000 {
+			compatible = "allwinner,sun50i-a100-musb",
+				     "allwinner,sun8i-a33-musb";
+			reg = <0x05100000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			dr_mode = "otg";
+			status = "disabled";
+		};
+
+		ehci1: usb@5200000 {
+			compatible = "allwinner,sun50i-a100-ehci",
+				     "generic-ehci";
+			reg = <0x05200000 0x100>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_BUS_EHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>,
+				 <&ccu RST_BUS_EHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb@5200400 {
+			compatible = "allwinner,sun50i-a100-ohci",
+				     "generic-ohci";
+			reg = <0x05200400 0x100>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		r_ccu: clock@7010000 {
 			compatible = "allwinner,sun50i-a100-r-ccu";
 			reg = <0x07010000 0x300>;
-- 
2.47.0


