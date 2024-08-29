Return-Path: <linux-pm+bounces-13195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7838F96520B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 23:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30406285056
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F41BA891;
	Thu, 29 Aug 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORtjQwxC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B014A614;
	Thu, 29 Aug 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967211; cv=none; b=CZhF8n/xCL2vZr/eR3p8aBbvWQaKumfHDYMNCLsQPmOcXZPcR2uws7XWWTPAJxl8Petwp2uW74iJJNRiB3A9qnSSmLGL9opFUigh5huZyGR4lwhRBOZiJxxAR3T8JE/UmyRidgvRJZTLHgGdYBZqp61KfHA8uJ4TDKT1WxrMyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967211; c=relaxed/simple;
	bh=pPQC5JrFu+LScQA+/CHCdDhmrQHf9GsGbq2cJ5Rwkec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbU5DCLgVXajyxyobzYReQRUZAVpOEzth+KI8gYG7Ccg1TudotkCzAnTxE3Hz8O1ZX83mRuhmIWLFwNFe9esmtC8x1Jb9A1IwKYA6BH9RldTKR+CZ7zv/pmmbqAIK8j48RI7MtdDchDlLonNKFmzK/6wpwmsmJyT8dghy7IYRqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORtjQwxC; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3df03d1f1ddso745083b6e.0;
        Thu, 29 Aug 2024 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724967208; x=1725572008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj3QlBwnF+GIPuRokIl1Fw2RmZHFpFFEAW8mKs0kajo=;
        b=ORtjQwxCBK6RNYKY5gGWgP323wFQ07yXkdYZnhZgofUs2xkjWd7A7g5ZtDJ6prZwUb
         A3QpphU8lo/N0zp5v+xOrUFq7mjBRjF/kyd2B13AkLyrpKFlA3BKXOedFnPGnydKuRBt
         uIV2K0qL8ND/EmM5q5Yo3lc/NQXxiYe3yGyG8T+TP6yETgrl6NNCW+wF5svM/dPj3PSN
         895Jjj9mToZWJeHL6nB5pYtmKtxecGup7qWCk93TvUCXzm2TfyhqaAKXEPyWNIcQQUpY
         LBFvcHGK1MFZb2eOGosQVa7fHk+rCA9rbvY3pVNd5iXpquR/B3Tc8RzIeaxMPD3uPsYE
         ziWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967208; x=1725572008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj3QlBwnF+GIPuRokIl1Fw2RmZHFpFFEAW8mKs0kajo=;
        b=j4BU/1lEd+drYArXF8psd9p4nF5kZ/p9BQb8yENySbx2xYee+9+nIAo5CyVUZObFNr
         X7nF9SwFWYoqWRYxU6vy8Ng5185MI6ouMzgC9cVMPFse4ZaqFUSFsJ7v799N+f/y+VR+
         Kt7CIy8Wd/MR11dFgD5n/Xq7lRjKBelyvQNXPnpoqD1X1Pz5IgDTWme2bl2KE30AhTYF
         An4rxv6luqu1E+FeK9yRsUC+iBcIZFhuM1UU+Js+MBkNf6qDOnx1/14xv7GjWxLBBKDp
         0tQMbOwov3kZ8p2ABMfhqIO0pIr+vb5S17xLmdnoxCxCHIsxBKSl0tO4lvS/4Qf6rU+m
         NZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXAzNgt7ua19DTfAPO2eLKsuF6K8FJ43A6FyaRi0eJu40wI85nYafRre77Y9vlofzBAQX9QMqfmtZ3W@vger.kernel.org
X-Gm-Message-State: AOJu0Ywomab3NluU44cB3yepMxwvRnX96HxgJ9EowmQIcrMDkSsiqbUb
	JNZ7Cw3waqaqwZux8bTmue1aCEAb33gtcFiwY5OqZKuXv/Dm24rxoms1OA==
X-Google-Smtp-Source: AGHT+IHD3omSACS8v9kmJln/gr4mXhsj7YW6sSe0USTvs8AX4oeJCHN3HaxoTc2C6WmotHPMrB7cdA==
X-Received: by 2002:a05:6808:e8b:b0:3da:e02f:eb8e with SMTP id 5614622812f47-3df05e6322bmr4412211b6e.43.1724967208404;
        Thu, 29 Aug 2024 14:33:28 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11865de3sm93097b6e.42.2024.08.29.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:33:28 -0700 (PDT)
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
Subject: [RFC 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Thu, 29 Aug 2024 16:31:02 -0500
Message-Id: <20240829213102.448047-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829213102.448047-1-macroalpha82@gmail.com>
References: <20240829213102.448047-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the BQ25703 charger manager and boost regulator to
the Gameforce Ace. This also allows us to add the USB Type-C port
manager which has a dependency on the boost regulator.

This specific patch has a dependency on the following series:
https://lore.kernel.org/linux-rockchip/20240829204517.398669-1-macroalpha82@gmail.com/

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
index 91efb9dafc89..371f84d5ba6b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
@@ -575,6 +575,56 @@ &i2c6 {
 	pinctrl-0 = <&i2c6m3_xfer>;
 	status = "okay";
 
+	fusb302: typec-portc@22 {
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
@@ -603,8 +653,40 @@ cw2015@62 {
 			 0x2F 0x00 0x64 0xA5 0xB5 0x1C 0xF0 0x49>;
 		cellwise,monitor-interval-ms = <5000>;
 		monitored-battery = <&battery>;
+		power-supplies = <&bq25703>;
 		status = "okay";
 	};
+
+	bq25703: bq25703@6b {
+		compatible = "ti,bq25703a";
+		reg = <0x6b>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&charger_int_h>;
+		pinctrl-names = "default";
+		power-supplies = <&fusb302>;
+		ti,charge-current = <2500000>;
+		ti,current-limit = <5000000>;
+		ti,max-charge-voltage = <8750000>;
+		ti,minimum-sys-voltage = <7400000>;
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
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
 };
 
 &i2c7 {
@@ -1235,3 +1317,41 @@ bluetooth {
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
2.34.1


