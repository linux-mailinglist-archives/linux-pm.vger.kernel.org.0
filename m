Return-Path: <linux-pm+bounces-29618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356DBAEA785
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 21:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F87F3A4467
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504032F0E3B;
	Thu, 26 Jun 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I09if8Nv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE142F0E29;
	Thu, 26 Jun 2025 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967772; cv=none; b=dOqCKwaEt5LeDyeptwqIjJVvR8TC9z+l1Z2OOKJ3l3guS0b5njxLGYv4fP2E9a4JJMRRXBUN2l6BLrgvZ+xhwAIIXULdT8uZy59W5VLF/wjzKRQ/EdscB/BExGhZ712HSKBTiqgAha18tSJQ08uzrArWp/NX1Ebf4T+Gou+jtAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967772; c=relaxed/simple;
	bh=g/wu2ORIbmuERW3NX8g71IqwgPz9J0UD0VSGtZisKHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaW2JwrW15XHYNkzMIiDhu3SJxH0AXm5sCoPVJD0VjVwaXc2OIM/8nQaAEhVoz7hdDQ/IFji1zEXQCFCB5FuqEMnoMa0Yhg1KuHrcmvscMbwHGnUKqXOJIPtuO1hHFcdwA5dTiQBAfkAwraApTLa6JCkt4PL6k+pLpdLYwclsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I09if8Nv; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60d5c665fceso698455eaf.1;
        Thu, 26 Jun 2025 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750967769; x=1751572569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T4j4YN6oDQNPwiIArxxsv6eScMKL6EZdlZnxxjmhd4=;
        b=I09if8Nv3SKjK/9TxEIhOXsNN4XxKY+AS3JM94+H1Enkenib+DRZQVD5Z8HCHXC32H
         j8MjArtEH16bag6Xy/8F9Zow5frUdOviv1jbPoyICOrHLjJvY6uuA5qK+Jp1KJfy7LCT
         IaDYPT5VZPSp0f/eeAoJbYbyRkt783l8WQdaLfFBCeo/jT5srnpwHXtO3rthL027OFdr
         ITA2iHGaPi2o/ONC6Oq66QO+Seprlh43qWu8G2LOXdX+/FJB0jRB+jMqvGBrHQ/+jLM3
         zw/rVO6wVpAKAP1+395F5zXuIvlJfdMf4rncspZgw858e0dL5NE7flzejPJ9efz9nht/
         /sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967769; x=1751572569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T4j4YN6oDQNPwiIArxxsv6eScMKL6EZdlZnxxjmhd4=;
        b=DA5hnIN3zuD1jb4Jw5T/TDS5tfIYZDMxOzBOhH0GFvhdfy1zOgckkRv6VeaMtqwb3t
         P9ne2RbJ0n3i/DkIudrgd0g4YZUui6UwGSJKJVNbI25GkPcC5oZw6EIOUMW+FdnNrIX2
         j4WogzLIHe0KfE6btnYXPgtof5xUa6sEAEe7+MwWaagHOpbcTL1jMOwyc4ydR8dAkdWC
         RfR7PJqj8ktrtJrVr6JNwrh6W8rVm1pEyc+Fy3KwcnWI1XSJRG8Jj3vDjhcoH2z7IZ81
         HwRe9Ou2yNx0XDdJ8hwIebUM7gGHnPjVbPU4Xl+DchgbkOVANnUrqvdu2KfLoiDYTeST
         vygg==
X-Forwarded-Encrypted: i=1; AJvYcCWDBx/2NVCbGy6UpDUkkeWoBowuTY+391H+tJgQNZZkLuvJgyXfCAJGeebPs2Hq38DypWB4zHs/L7ta@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5sTP1eSKoI+buTljIaHKxpNt09KSG4EY+DqQsGreo4xxVS9O
	u6X5H0dX9wpEJ0oVHAwsLW8FVxVcHODKswvWslVDq6iaCxfDs+u0t21MxZYajg==
X-Gm-Gg: ASbGncvXDLMc2O/HL8e+x6Gt1+fexEr8cT5ryvhtkg7SO8rCUCgZIxDBXYjksxyK3yr
	C8Hp6VO6TOVwd4Gyd3Pey4W7c9IqJGzJDNoIP7YlV0nThymugWSZSK0pCeXJtquTD+76BSHzONc
	0I6Kxwszvlhei0Os4PODyB/XHl/tu9mfdanC4TT10c6OQXj+e1LO1xOEVGaGcFpkUsuUC1FF6H5
	/wYNOv//87/mcByl5vkzm6QFhj9mjRiMPPaTJhpHAX0rG7DNo+z6ril/TM2xKzq9eeDlmsivJ8s
	zGlFFtRLbSTfGdU5MZS6PUQN7D+yp0HePtGTKm4ypw8ZOXz30MOe+hn0Kjr1cCTItrmihxbExna
	kq19WbA==
X-Google-Smtp-Source: AGHT+IEo8AITbnaEu3zuHVHElFTHaq9bdkk99cfQ72utFV9ddz60HWLZ7uz6nCioz//mtEgXYVlYng==
X-Received: by 2002:a05:6820:1b09:b0:611:a78b:57ce with SMTP id 006d021491bc7-611b90153d0mr364796eaf.2.1750967769472;
        Thu, 26 Jun 2025 12:56:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:f978:7e9c:c207:c035])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8582352sm66915eaf.22.2025.06.26.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:56:09 -0700 (PDT)
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
Subject: [PATCH V4 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Thu, 26 Jun 2025 14:53:43 -0500
Message-ID: <20250626195343.54653-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626195343.54653-1-macroalpha82@gmail.com>
References: <20250626195343.54653-1-macroalpha82@gmail.com>
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


