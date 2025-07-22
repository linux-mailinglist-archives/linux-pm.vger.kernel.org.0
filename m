Return-Path: <linux-pm+bounces-31294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76AB0E22F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 18:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C307A85DC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C327EFF7;
	Tue, 22 Jul 2025 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BscF1tWJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9527E1DC;
	Tue, 22 Jul 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203041; cv=none; b=hxCCcQ3CfsxT4I9bS7BwCX9m+iiiFwGTYf3bpLSIOjdrxH5VRganopb4XcOq8g8qKBpP1NkshTH0YQ88uLd9/6TKRy0/OsGEMKVXyCn/WoCU2QuZZP9mGv0lhcTiGTMt88TfV9QfuYe3VONy8j7l6S2e/L0769eBOb7ssNuFoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203041; c=relaxed/simple;
	bh=g/wu2ORIbmuERW3NX8g71IqwgPz9J0UD0VSGtZisKHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COxtUoIg/+Cd7iq/YbUAO7L+xiM4U5N3zsa7fr9TUxoub5zGAL19TEiKXme1PRzFKW9c9OyQvE5hu1VZluI1BcCI4MD47LBfynP09jfmVBazKwchEQBjXExiW079Pbyb/FPRKMAG/CYc/qILgannXysCHmCGY34gwyJjg2V2L9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BscF1tWJ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c14138668so2386489a34.2;
        Tue, 22 Jul 2025 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753203039; x=1753807839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T4j4YN6oDQNPwiIArxxsv6eScMKL6EZdlZnxxjmhd4=;
        b=BscF1tWJfWIzsBMzQzNISpt0iaj2PWiTgs9UAr1ZsUCZBTuHb+HzVhZyjDrQIQrpEP
         UJUtCPlWZLkSU4MQ6UiFn6bBAILLHvj1soXfwsS7OBW9K4ldQ6/XNblCgbLfMOT0eUUo
         +aK15jgLPfDpaPZeN/jDOeJYTIuhWv+WDUYZyhr66QavW9bZg5CIQjhOqaVGUjtOfKpQ
         sRo/P3cKR/lJ+fTSXhSniDZ5K1lUw1scdrIEn0KyA/frHcTYxizU4WYwWRZywSUafT2C
         hTg0aXD1UIknHT0wyuXSwF2t3L3HAGv6LIuaGRRABzqcbhuyzESyld39N9mOVx5sHl2d
         Dymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753203039; x=1753807839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T4j4YN6oDQNPwiIArxxsv6eScMKL6EZdlZnxxjmhd4=;
        b=Kxx0dKmrJDQSNbFpvMToykNWu5TMFXqULS2EiOOW3Eu0den237tR/A3p07dt6b0GqX
         z0v7FKnhHSI6z1tY1zEJhIIsPb1f73S4Vt07ITlsZbgapg6XlPbWxb5WOxI72MtjxTHw
         WrI1tfLqO1YtZVf8Br89v9moCNOGxjcpviZRdZplt1f5dXjY6t72ghghygYLgFNOqwwF
         VpqcwDuucUqWg44RFEE6MYIeKhSn+QYCJqvChz6m9DUUYg05W9DfcHEm/I39Es1nKq/N
         k3rJcdrfZNA9QW1Nlq4cx2Q/FKpUqJNJFwy2Yzz5THmq478Zdi/MjsehenNi39xyNR+/
         LQhw==
X-Forwarded-Encrypted: i=1; AJvYcCWTOtd0N+l/PxVZYFDCX/ldgJrw/JWHn5k+kf5XLQcG2e5OWfpgwQKmTDLn+Cx1YIi/nZQuL1tsiauH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1WiJ6S9Ia1uR2+9ZolQuqrHf/RE/kBO7mECKZ4udGMcy/qVa
	HCqI621SsZBKCSoeMa0Dudp1fY0EaLmshiX5ACA0ZMpc1JC71NRFXhn4tox7mg==
X-Gm-Gg: ASbGnctLUqLNIlH7oE3gu0Ta/lGp7hhceXDcbpFST4DHJAiG2EjbyZXSIL2TXbilI87
	ElsG2BJjskOSnvMARc7/sZTO1yDGG8Lj1VhIh0NHH5yqikh3JxBHM8uTrELiFuQFwpLiznjRyGV
	akkY6TjAPfmXvXtsZB82TvGdJbOCvpqOoh03E9fTRUYuN9bv0b8/QtYh02vcf9OKqfWYBNwznTv
	n/SPP9PYIdWO6SXy0LDi0uDWBz2A9zGN2vOLHGgufoaFJZAKdgHZKXmuF6SKxwdhL/2ztgwsH23
	XBx+nMLCjrqGzuxqo92Xb7gdO2stHDWlbIw+ik1lHprtwJUZG8pz0bni7mBeEF35OqltbPmGQoV
	U5jn/MBwC4gMFlxGZ0jHhLxyP7BrQI0ajFBUqaS8cOw==
X-Google-Smtp-Source: AGHT+IHeokX8OkKg9W5UgnjJNzRiPmYK0pExqvXzV2Dk0UVjxbyU6VknKu05HUKkhXdFOZFmldubDg==
X-Received: by 2002:a05:6808:219b:b0:41c:e915:2117 with SMTP id 5614622812f47-41f9945c148mr11726625b6e.34.1753203038871;
        Tue, 22 Jul 2025 09:50:38 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:a130:f3a0:d203:abc8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd59531d8sm2935217b6e.42.2025.07.22.09.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:50:38 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v5 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Tue, 22 Jul 2025 11:48:12 -0500
Message-ID: <20250722164813.2110874-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722164813.2110874-1-macroalpha82@gmail.com>
References: <20250722164813.2110874-1-macroalpha82@gmail.com>
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
index 873a2bd6a6de..e1ec1b3f4fc1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
@@ -575,6 +575,56 @@ &i2c6 {
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
@@ -603,8 +653,34 @@ battery@62 {
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
@@ -807,6 +883,12 @@ usbc0_int: usbc0-int {
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
@@ -1239,3 +1321,43 @@ bluetooth {
 		shutdown-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
 	};
 };
+
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
-- 
2.43.0


