Return-Path: <linux-pm+bounces-32233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682EEB23AE2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 23:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787F51AA5C4A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8E2D73B5;
	Tue, 12 Aug 2025 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXZidM4l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A572D7394;
	Tue, 12 Aug 2025 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035132; cv=none; b=nUksnFSAvyQko0Zh+L6c0vfXa4z4+RZ3hGZFJKWBdUWYrE5W/t5RVLP95VFnH5ZKMeY2EqolnZTOolzskmxy/94i099Ydga5fN2m4nzsdwfyBrglwpFSz7iou/a8WD4ONXffWOodCxboiFxezFNEgx/VuzQNQQVJkeR5ne3wkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035132; c=relaxed/simple;
	bh=a2VaGbnudM1PA9g6aSsfgVl1WnSIPcWzvBS/7G/JRIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlCnyUc0oPE6tdLkUUvo4lfDtK0xf4olJkv4XnjIpqXI+0H37VOHuzemJhNv8/Mt0Ldv+i+qTxXlFZbDKdFLXaXrTgcaNtCRqetg8GGI0ypZf89H19GoXHSvjhexFzDa5hujWCft08xOqM3QfhXjebx5b4TfPIYpWMlXGdpMcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXZidM4l; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-302effd5978so3002493fac.2;
        Tue, 12 Aug 2025 14:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035130; x=1755639930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbxwAPRbZLLGWs9r1VP1FnvbCoc9pGEKPj76nnKqTXY=;
        b=RXZidM4l1rdVVwjJKNLW5VePVqs3gjpZI2Ne8w4mmkQTd55YOp6YgDFLGpoNNX8Tbp
         2e8lH3E5zwnb73nHy3YkbLr12kJ/OdBc9bkilFMPzCgig8nQBesYT03rpAhlGN02bQfb
         0MB5rxhhH34CJ4SVkT40n20RR3BOYl1q1ORC9C44AgYukkz08Y0oy4BBuQV3/8lLO5l5
         EchFvpQWMeE/VqpteEJt/dPCgdjd5BkmK0/Y2VCs290ridf3v1U650Bftj9NpYnaznCo
         sjiuFBaGlzFHFzDGSlWst9gJykZcwM/NFHN88pJmW5TSb2Tms4z7QBsQc9CCtWBTh/mv
         sQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035130; x=1755639930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbxwAPRbZLLGWs9r1VP1FnvbCoc9pGEKPj76nnKqTXY=;
        b=m/eqHZTQC7D8xgoLNpUB0XGdENTahwMytoU6DJDBfGFUQ7zDuzP0372ucawERWcZDd
         Jd4Mi+kpiVCWDh6+yLGG76bqR6ppijKQywfi4d1KTzToZqFekQ2vwqG/Qf3kVGmdoj+i
         WkOzDL6cEaPikbmPuiIwjRo2WtqEuiBmhh0VTKUUDyLcLW86vn7EdJ4NLO9cJ1joj7p+
         RmsH4Z9m5n1xbYLyAEzMNVhj7IP+NT+QM4B2oqJwNoUvXRLL4JI7XKiYgOXI5Za9IK//
         kQxVl75Rv/1ywBg1HRPb2FfnIz5Gon/PoPf0bqsnvFIsOU8QIbzP10itjuJw21nzmGZh
         jzMA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQ2cB6p98bqwSZKhY7irrOjbYkXJfbuGiBWPSl1MmJ14NrCcDSZD24tEE5Izk0f4Bjc9VEIKQaF7j@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQFLZsx3RQG2t00BYAjpOKNgtb1YyBmIjMq2iZQNDb5KTF0xR
	l1ogSr6FJa38VM33DVsjFOCa0GJHJrWrWgbiHhBPGszcd/axWo/jqIrNadde/w==
X-Gm-Gg: ASbGncttPqbkkOO7VJbrNb6/F+oF6lBMKJPVqrCHQ6h7OYT38N2RRB4CNjxn+hJK3Ix
	CvT6l4ujXJblgOZzVa63sZqnkKcPkrXuA10aPBmv/pFtYc+PlBE+ensOzymxTfxu4hls3dZTrkP
	5ddIHWTVhMxb/A9fs6wWGtJiMrfGsaGxmKzl62908ONRvxSTY/9QFr4nIzrTanWaElsiNkb0oSv
	jOy+YVpvReZrEaFKt5QYAvxmBcKgzSfjWa8qakBjhHXkT6d6DIY0h6IyT+F9dRcETUvjIxl8yV5
	45TsrarUEsIGnGTSD6GJm2cHjiJedIwIjKpuGNakuo/wGSfNXQPfaislQbH2ElWNUJSlZBgmFll
	T8NWNVL5j+jdMqNgjbpdLTF/fmHpqP/sVORUbtKd3vQ==
X-Google-Smtp-Source: AGHT+IFMDIBEwkoAFWfmFPeE4jkHvh48lkAdk+3gMISL3QZlC5MqVz0RueEmO5dX/CZAEbTgNvD+eA==
X-Received: by 2002:a05:6871:5312:b0:30b:aa71:3ea9 with SMTP id 586e51a60fabf-30cb5a0f92cmr496984fac.8.1755035130298;
        Tue, 12 Aug 2025 14:45:30 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:d904:cea9:a76b:d0a3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30c10c7a694sm4092741fac.9.2025.08.12.14.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:45:30 -0700 (PDT)
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
Subject: [PATCH V6 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Tue, 12 Aug 2025 16:43:00 -0500
Message-ID: <20250812214300.123129-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812214300.123129-1-macroalpha82@gmail.com>
References: <20250812214300.123129-1-macroalpha82@gmail.com>
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


