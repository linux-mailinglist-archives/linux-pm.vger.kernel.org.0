Return-Path: <linux-pm+bounces-29394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCBAE4AF3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3351C3B501D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585642BE7BB;
	Mon, 23 Jun 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK2XNVP7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638726E175;
	Mon, 23 Jun 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695901; cv=none; b=R0HuOUDe//hEoAPbOQ2xa9ineSF0gF5PlOP8Vm+yLFmHJoUFtlXvsm0lh4X8Rv/X+IRSIaHh03CXfqOZSIEhuG1ybr8sahYNttOG7jsZguoOuAqb0LsRBk1E1iZw9mUFWeXcMQJvONy09IF79eD9L2ixeI6Vc4Y1Thkfc15Et1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695901; c=relaxed/simple;
	bh=RkkZ1rVcIjjaIuIUTMKQMdxZMeQhhhILKOa4cee/qmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCbEOX80lc/S2xo5l+B/2Ybe6wvN1PQBomiQLitOWMpMJ48pDg+DluAXo/hv7fLyL2gFqimRR4NP326gcincUVg7YpcP8YDpTZ0HvFGyoTJbHQMCq9u340U/tjjxXwMwmHPlBM2a0ZXJn9EsX3R6ilsxPasno83v7KMgsyepnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK2XNVP7; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40aa971550aso2877163b6e.3;
        Mon, 23 Jun 2025 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750695897; x=1751300697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VWQ/3f6uGRHlfE4j0BNsaq/8Sj/J2vStE5CIqW2jYY=;
        b=ZK2XNVP7i7ziywdF0Ls+yPLQa4xYpHCo/WL62bz8h+VgndchPyXD8KLWpOATCFFSeB
         PyFQX0wMqxMylOqFEbx1t4LZ4vlFVikVufxdPubpUaNKGPD0cVyz+5vPDTBMXOB9Mycu
         k7UjgZdgUW2RZOoYlgXfFKsT3xwbBEQqzQ6WKVTS6KL0kem3xcjWr09omSwKntw4Jcfo
         ecltfCcK00ByMs0pZWj190b37qvuOaLwJXrTncz9ClYNe0mbp8v5l4r9C7Td+BhWQCv9
         FhMVZB1YEFFYarjnAFvf19EofuiwdtUNV8fUKXdpgTHA0G4KYcs2i77f1dlauQQDIG/A
         JTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695897; x=1751300697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VWQ/3f6uGRHlfE4j0BNsaq/8Sj/J2vStE5CIqW2jYY=;
        b=IMn/PwuA4RKkpNS7j1OuJAtD94R7cPE7T7LarGR9XSVNCaOudXTP+wPhuYmdAOfcbS
         Z7NhONBALHxyMVL+TUkHHoMOIdRtMYoL1BA6/BSCf5RW/NQpZKo85WW0x3D/j0e/ZU7w
         ZHiOdRkkDblT0XeUbLm8tYriHQRDmOQasJT1AZjGR0oUHB9cxhUOiSQIPSbJBTyn47qb
         RthfstIo1+knCqqv5ehMv3qWo2XTnXw2pTZ3cTXzFHzNsPnilkQ98mskCvKmnAbA8qrV
         2/gar+nbwIRTCd0UNTfpB6VpMas+bv/o+RcUrA4X0oKZ1l09Y2RDK9tFeOf56MgJ6j5q
         uCmg==
X-Forwarded-Encrypted: i=1; AJvYcCUFzTsfWk82QtQySrOm6u/q775LeZCWv/nrB8bWbPgPz/TmlOTmWnMuFaS682bHu0jvSOdUMvHoWdVE@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoemS+DUMjc1/zR509CSwum+89fNzZfr968eCWFOBVBroctW+
	l55T6DBEAGJujmt7mRxwMiHLt9Mnn1+DMnyjGhCiljrX+brngjH18jkBvBY9RA==
X-Gm-Gg: ASbGncsznsTeAeN+HBuzUhvxWc/0rh2egdO392WuqX2wV9PwEuQt4dSvp0Eb+l7Ylz4
	/id8qCK+JtH4bhW+rVQ00LcP7JpufPdqv3zVT8U9nAcO45+62byZHur0NdLjSZs5T0WsYtnvlA9
	ZFRprvTFLtPjqbiaaBZ4VdwGo3EKTslJW8PyEuHG7kVEbpsLeH6mqYJy6kpM53Lwy5ibSENTGar
	X19E/82ythKUJSCdRd2o/deKBxlfqOTDqx1UByQxxH+IcrE6ZC2zWZ+lhokcpuChwHlXTOKJ7UC
	hX9KgN3SaPj1nu/OB1ZsRsKvXwuGUHKGqRVJhj8Vpva3VIOnNByV3cTc5bl1GJiJgC+PMY/S4Qz
	XILNH1w==
X-Google-Smtp-Source: AGHT+IEG6Bs+8/vgnN6uLWTEKDv4PXruPRD0LnhaF/zwmLkI61Lhi04Ucp0qj7I+ePqCr/pYfrtLEw==
X-Received: by 2002:a05:6808:1383:b0:406:67b7:8b62 with SMTP id 5614622812f47-40ac6fe65f9mr8820873b6e.38.1750695897359;
        Mon, 23 Jun 2025 09:24:57 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:61a2:e42d:d809:3616])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6ced44esm1427308b6e.24.2025.06.23.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:24:57 -0700 (PDT)
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
Subject: [PATCH V3 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Mon, 23 Jun 2025 11:22:23 -0500
Message-ID: <20250623162223.184304-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623162223.184304-1-macroalpha82@gmail.com>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
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
index 873a2bd6a6de..c74a4e0fa238 100644
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
+			usb_otg_vbus: usb-otg-vbus {
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


