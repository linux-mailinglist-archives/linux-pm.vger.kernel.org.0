Return-Path: <linux-pm+bounces-32820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A972B30028
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A581C22A56
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12DE2DECD8;
	Thu, 21 Aug 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndDyP9mR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756A2DE1FE;
	Thu, 21 Aug 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793636; cv=none; b=WIzsbTRDXXvmNZ8sB0U9McSYrwseLtIimofen2ibOPvezRnIVa2TlzylNV0FT0f5g1ZPt4fdlUdEmc5SNpv7e/hqyO0zyL+rVUvUy+eP6Jy9iP+g6cVGFGwnlJL1iF7uXr1efrgI82M+e3boPnY4SDfZ5LSYrjpOA8uVQkthB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793636; c=relaxed/simple;
	bh=a2VaGbnudM1PA9g6aSsfgVl1WnSIPcWzvBS/7G/JRIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adbGaNhGBGA/slkV2pC73Vt4VakTr2kODy7IzjTBNUIKsQbkJPVOv00vXHiqYw8q2mZGVbdnzK4epuMXwUAgBTwb7cHkR+II+A3QWLD4+CMRScoPIXSV9FB4RGutR31ODRiiq3K0n3UJP8kDfIMt4netY+AoS05LRYZG95lXXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndDyP9mR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-435de838484so823372b6e.3;
        Thu, 21 Aug 2025 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793634; x=1756398434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbxwAPRbZLLGWs9r1VP1FnvbCoc9pGEKPj76nnKqTXY=;
        b=ndDyP9mRJAww0uS8g/LpqD5OGWmWjBndqkXTWodwEcmxdNeM7aMQaKgA9NRT4cvYWr
         rhNY6tRMM6RfmbhwBhVwhy9GoFKZIt4bCGuPTK6HkgGZY8YFd3I2Yroz4WQqG2RDEjNY
         tRJiVGaCNnjKsYJI7/GNOqc80r4Y1AnhGuV6uaBFljZTj4R+t2mbFn5Hd1ksq+Z5CMOr
         VNdimD9hw4R+wJTRI4HJqcuH0OfK+q5KNyNM41Y8j9nnRBn+a84GZVhjrWKTkAVgLlo9
         FubIU9nbiGs8EzaWtrhE7Q52wJyR7IptmijDsTMDS9kWiUmGSKYEYujL/I3Uc2lQQppI
         V/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793634; x=1756398434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbxwAPRbZLLGWs9r1VP1FnvbCoc9pGEKPj76nnKqTXY=;
        b=dBKGs5vdcAKqOlH+9cXGkjdMt7NcixST7fjCrFG8e6Ku7x+q4ZKtFE6GBoZTMHCRvk
         ztYxvUyS0vLwbj5r3rM97uyGa317vKuinmir9DxK/hT2WaLSxvQX+cQ28s0Ioi9BVs5n
         TvQPyn3aofUBfPY7K0syTAg0rWGQCLAcvIoPjBcG4Z54niPbW0B9tkiIzKmqpb0OSdcn
         eNe+cj3xBrSpYufTLuKSKo4t7IryJehq08PEHubQ0H7bd3niDAi2nv3RZol9iBOSWChb
         te9vAYy2DpDreBlzKjRGupX9yd16JHcLgm2eaRqJ6I9l6ggb1Vqrhynem6GVBUYXkbOc
         PMzg==
X-Forwarded-Encrypted: i=1; AJvYcCVtMb8iOzCaTgaIjoDQEnQXYf33qPMVvzPaBsSKVAPQeeeEx6OZF0+IGBrkQzv3keCMiVoZaq6MHkKX@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXRyqNzzMmTV2ospBy6c/+o3W9xbNbqvcqZ+7pyLGiIUlk/GV
	uO9dZ/rvo6MV+GjgBiKrrycn3vl0Ul2rDLF32DWiFHgLgwpmvnRjWduz
X-Gm-Gg: ASbGncsCRJ0yw9lPc6Ozl1EMWTHVOBEIHw3xx/IuKUfUPPcluTEJA0Wym01wsEoNwbu
	l0OO8NzCi/xiZe6mYoPJmJ6spMbs81kEBHso+ervA7W7Bv0cDrZcPLCHbrOD4Hz8yiBey/kDqFT
	G6/5ws0xBXSF+Xw2E/yyWkmfnJw7mcs0lymzHIypklYQmJ5H1Gds/xg9lvA2MpvVdkc56p5L6VF
	W8FgWsngaxr47lVdLt/9993WWdWyC1ROhFu9KHOenHup9mQHfUw7p04fEhUtRa9Yrq55svElJQz
	dYlZ6BddEKz0ZuJ5lxjGcofr3Er/Yg8pvtNfe1eRg8XeYoR5H0UzBPyZcoC6ioTRtrHO3VgnREk
	wr0pdkP8xbcdmlC770U6DiGf2GYQ+yzR+dKADMMlmpA==
X-Google-Smtp-Source: AGHT+IG7yXhlPQPLqBgyGC5iSVZkwtCYQoExiYrE4Ik476mrwWOIwzGKx0YYZ7rN+LaJYEGjIes+Cw==
X-Received: by 2002:a05:6808:1301:b0:3f9:36ec:dab3 with SMTP id 5614622812f47-437851b75d4mr80511b6e.14.1755793633915;
        Thu, 21 Aug 2025 09:27:13 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b19a:18c8:26b9:21c7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bec14b3cesm1674706eaf.27.2025.08.21.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:27:13 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V7 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Thu, 21 Aug 2025 11:24:48 -0500
Message-ID: <20250821162448.117621-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821162448.117621-1-macroalpha82@gmail.com>
References: <20250821162448.117621-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the BQ25703A charger manager and boost regulator to
the Gameforce Ace. Add the USB-C port and PHY as well as they all
depend on each other for operation.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
index 55fc7cbef58d..f5894672fcbd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
@@ -612,6 +612,56 @@ &i2c6 {
 	pinctrl-0 = <&i2c6m3_xfer>;
 	status = "okay";
 
+	fusb302: typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PC7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&usbc0_int>;
+		pinctrl-names = "default";
+		vbus-supply = <&usb_otg_vbus>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <1000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_FIXED(9000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_FIXED(12000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usbc0_orien_sw: endpoint {
+						remote-endpoint = <&usbdp_phy0_orientation_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					usbc0_role_sw: endpoint {
+						remote-endpoint = <&dwc3_0_role_switch>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					dp_altmode_mux: endpoint {
+						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
+					};
+				};
+			};
+		};
+	};
+
 	rtc_hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
@@ -640,8 +690,34 @@ battery@62 {
 			 0x2F 0x00 0x64 0xA5 0xB5 0x1C 0xF0 0x49>;
 		cellwise,monitor-interval-ms = <5000>;
 		monitored-battery = <&battery>;
+		power-supplies = <&bq25703>;
 		status = "okay";
 	};
+
+	bq25703: charger@6b {
+		compatible = "ti,bq25703a";
+		reg = <0x6b>;
+		input-current-limit-microamp = <5000000>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
+		monitored-battery = <&battery>;
+		pinctrl-0 = <&charger_int_h>;
+		pinctrl-names = "default";
+		power-supplies = <&fusb302>;
+
+		regulators {
+			usb_otg_vbus: vbus {
+				enable-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
+				pinctrl-0 = <&boost_enable_h>;
+				pinctrl-names = "default";
+				regulator-max-microamp = <960000>;
+				regulator-max-microvolt = <5088000>;
+				regulator-min-microamp = <512000>;
+				regulator-min-microvolt = <4992000>;
+				regulator-name = "usb_otg_vbus";
+			};
+		};
+	};
 };
 
 &i2c7 {
@@ -853,6 +929,12 @@ usbc0_int: usbc0-int {
 			rockchip,pins =
 				<0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
+
+		usbc_sbu_dc: usbc-sbu-dc {
+			rockchip,pins =
+				<4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>,
+				<4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	vcc3v3-lcd {
@@ -1286,6 +1368,46 @@ bluetooth {
 	};
 };
 
+&usb_host0_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dwc3_0_role_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
+};
+
+&usbdp_phy0 {
+	mode-switch;
+	orientation-switch;
+	pinctrl-0 = <&usbc_sbu_dc>;
+	pinctrl-names = "default";
+	sbu1-dc-gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_HIGH>;
+	rockchip,dp-lane-mux = <2 3>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_orientation_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_orien_sw>;
+		};
+
+		usbdp_phy0_dp_altmode_mux: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&dp_altmode_mux>;
+		};
+	};
+};
+
 &vop {
 	status = "okay";
 };
-- 
2.43.0


