Return-Path: <linux-pm+bounces-16407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019709AED40
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E1928514C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BB41FC7FD;
	Thu, 24 Oct 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="TYpnzYM6"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A11FAF00;
	Thu, 24 Oct 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789792; cv=none; b=ACVh3S9bq/IexF61wbrFMXKSObQz8srKflyvmr1ntXtWhwrZ0Zj7kpqMz8dKMQIq8wet7yO+JCl/xd1aDc34vJcuKzZVu+lumr9rS5OyuI0Ri61paeA8W/LwedfjFuUhCORkj5+Y05I7Ljsxhc04WEJT5e9JLynkHjWVIcRlwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789792; c=relaxed/simple;
	bh=uyVlu0mrU5giK8mByMabW5323mqDUvUUrK92udeSLP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMftITYigKtNtORV4P7BUNzP0BOEV7vZc7fBlA6kCmP5vCJR8BDtw7YZwfSdOejuxntKmVeCodX+ZFkeyd5VGwS5DDyINaS7FJrs3jdpPWlHShUPf+MFUQOhnU4X7QxCCPXKR9efBYr0EdGo7Zaqz319TM/XYFyf1AjZSSaYdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=TYpnzYM6; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789786;
	bh=uyVlu0mrU5giK8mByMabW5323mqDUvUUrK92udeSLP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYpnzYM6Nsgb3H2I2pZjXhQGGCagJ5EygyfXnDxW07DZFpZ5LGeG1SnU5zczXZKYJ
	 cWcf6Y/gbU/AIxClBs3VbAgTFlSU4A1kgGqs5u+TYM6wys37/6jqlM3BN6J15h9And
	 gd4smAwOhFF/WOoRlE55n2N5+1ZxPdsT8aubCNWSCVhQVQ01Uc1L+PfJJKPNS33FYt
	 tUehpu6PhxJn+IvwNQ8lnJBxFPPmJ4VWQAQ4eepcX0InkXjQ/pjRttcHEoWVr5zrzQ
	 XjwalF8LXBeF9DFbVl2bX6hlItiZXqLGcN5rKYQIx8u1NNtcqaw/csNHplRheiBlpO
	 vtWpx5PYQmlSw==
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
Subject: [PATCH 08/13] arm64: allwinner: A100: enable EHCI, OHCI and USB PHY nodes in Perf1
Date: Thu, 24 Oct 2024 14:05:26 -0300
Message-ID: <20241024170540.2721307-9-masterr3c0rd@epochal.quest>
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

Add USB support on A100 perf1 board, which include two USB2.0 port.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../allwinner/sun50i-a100-allwinner-perf1.dts | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index f5c5c1464482..c6d8264b91b7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -7,6 +7,8 @@
 
 #include "sun50i-a100.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 /{
 	model = "Allwinner A100 Perf1";
 	compatible = "allwinner,a100-perf1", "allwinner,sun50i-a100";
@@ -18,6 +20,35 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
+		enable-active-high;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
 };
 
 &pio {
@@ -178,3 +209,10 @@ &uart0 {
 	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.47.0


