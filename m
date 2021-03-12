Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D417C3391C6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhCLPoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhCLPoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BDC061574;
        Fri, 12 Mar 2021 07:44:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 610AB1F46E6B
Received: by jupiter.universe (Postfix, from userid 1000)
        id 298764800C7; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 01/38] ARM: dts: motorola-cpcap-mapphone: Prepare for dtbs_check parsing
Date:   Fri, 12 Mar 2021 16:43:20 +0100
Message-Id: <20210312154357.1561730-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'<&gpio1 parameters &gpio2 parameters>' and '<&gpio1 parameters>,
<&gpio2 parameters>' result in the same DTB, but second format has
better source code readability. Also 'dtbs_check' currently uses
this format to determine the amount of items specified, so using
this syntax is needed to successfully verify the devicetree source
against a DT schema format.

Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../arm/boot/dts/motorola-cpcap-mapphone.dtsi | 59 +++++++++----------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index 08a7d3ce383f..ea02fd403a9b 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -27,16 +27,14 @@ cpcap_adc: adc {
 
 		cpcap_battery: battery {
 			compatible = "motorola,cpcap-battery";
-			interrupts-extended = <
-				&cpcap 6 0 &cpcap 5 0 &cpcap 3 0
-				&cpcap 20 0 &cpcap 54 0 &cpcap 57 0
-			>;
+			interrupts-extended =
+				<&cpcap 6 0>, <&cpcap 5 0>, <&cpcap 3 0>,
+				<&cpcap 20 0>, <&cpcap 54 0>, <&cpcap 57 0>;
 			interrupt-names =
 				"eol", "lowbph", "lowbpl",
-				"chrgcurr1", "battdetb",
-				"cccal";
-			io-channels = <&cpcap_adc 0 &cpcap_adc 1
-				       &cpcap_adc 5 &cpcap_adc 6>;
+				"chrgcurr1", "battdetb", "cccal";
+			io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+				      <&cpcap_adc 5>, <&cpcap_adc 6>;
 			io-channel-names = "battdetb", "battp",
 					   "chg_isense", "batti";
 			power-supplies = <&cpcap_charger>;
@@ -44,20 +42,19 @@ &cpcap 20 0 &cpcap 54 0 &cpcap 57 0
 
 		cpcap_charger: charger {
 			compatible = "motorola,mapphone-cpcap-charger";
-			interrupts-extended = <
-				&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
-				&cpcap 22 0 &cpcap 21 0 &cpcap 20 0 &cpcap 19 0
-				&cpcap 54 0
-			>;
+			interrupts-extended =
+				<&cpcap 13 0>, <&cpcap 12 0>, <&cpcap 29 0>,
+				<&cpcap 28 0>, <&cpcap 22 0>, <&cpcap 21 0>,
+				<&cpcap 20 0>, <&cpcap 19 0>, <&cpcap 54 0>;
 			interrupt-names =
-				"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
-				"rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
-				"battdetb";
-			mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW
-				      &gpio3 23 GPIO_ACTIVE_LOW>;
-			io-channels = <&cpcap_adc 0 &cpcap_adc 1
-				       &cpcap_adc 2 &cpcap_adc 5
-				       &cpcap_adc 6>;
+				"chrg_det", "rvrs_chrg", "chrg_se1b",
+				"se0conn", "rvrs_mode", "chrgcurr2",
+				"chrgcurr1", "vbusvld", "battdetb";
+			mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>,
+				     <&gpio3 23 GPIO_ACTIVE_LOW>;
+			io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+				      <&cpcap_adc 2>, <&cpcap_adc 5>,
+				      <&cpcap_adc 6>;
 			io-channel-names = "battdetb", "battp",
 					   "vbus", "chg_isense",
 					   "batti";
@@ -98,22 +95,22 @@ power_button: button {
 
 		cpcap_usb2_phy: phy {
 			compatible = "motorola,mapphone-cpcap-usb-phy";
-			pinctrl-0 = <&usb_gpio_mux_sel1 &usb_gpio_mux_sel2>;
+			pinctrl-0 = <&usb_gpio_mux_sel1>, <&usb_gpio_mux_sel2>;
 			pinctrl-1 = <&usb_ulpi_pins>;
 			pinctrl-2 = <&usb_utmi_pins>;
 			pinctrl-3 = <&uart3_pins>;
 			pinctrl-names = "default", "ulpi", "utmi", "uart";
 			#phy-cells = <0>;
-			interrupts-extended = <
-				&cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
-				&cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
-				&cpcap 48 0
-			>;
+			interrupts-extended =
+				<&cpcap 15 0>, <&cpcap 14 0>, <&cpcap 28 0>,
+				<&cpcap 19 0>, <&cpcap 18 0>, <&cpcap 17 0>,
+				<&cpcap 16 0>, <&cpcap 49 0>, <&cpcap 48 0>;
 			interrupt-names =
-				"id_ground", "id_float", "se0conn", "vbusvld",
-				"sessvld", "sessend", "se1", "dm", "dp";
-			mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH
-				      &gpio1 0 GPIO_ACTIVE_HIGH>;
+				"id_ground", "id_float", "se0conn",
+				"vbusvld", "sessvld", "sessend",
+				"se1", "dm", "dp";
+			mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,
+				     <&gpio1 0 GPIO_ACTIVE_HIGH>;
 			io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
 			io-channel-names = "vbus", "id";
 			vusb-supply = <&vusb>;
-- 
2.30.1

