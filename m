Return-Path: <linux-pm+bounces-33860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FFAB44246
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A54A46E8D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617A52F28FF;
	Thu,  4 Sep 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5Kv8QxH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DDB2F616F;
	Thu,  4 Sep 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002096; cv=none; b=tRtLv1cDYOGc9Xa0clfMmwyPiaf+1Xm77xVYgxShsgZA02Zzz1ukbNRzKbMdVZIAfBCjSpn+9zacTJ6H2e68u2UzU1nsT/JGKqERG5RINkSFjZl/okJNHxRQK8HdE48IVM8KESjDtIX2fobIpLmIRL9szOk3+p25XK+a2VBldeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002096; c=relaxed/simple;
	bh=a2VaGbnudM1PA9g6aSsfgVl1WnSIPcWzvBS/7G/JRIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L06X2B901/BDZynr3gfyR3Ee54id8vA3lt1P8kaoKhTOX0dbV1lkEwntQW/kfu6faYoxqpXhohHV+WGE4QwMlRF7LCnhWEQTyoFPCFx6v9fLse2C2PQ4d+iE5JA6P8nr4a6PsF9uoLa5HwxmT9t3BCwH9lW8R6uso67fFkC6ynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5Kv8QxH; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30cce892b7dso515566fac.1;
        Thu, 04 Sep 2025 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757002093; x=1757606893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbxwAPRbZLLGWs9r1VP1FnvbCoc9pGEKPj76nnKqTXY=;
        b=b5Kv8QxHHDAos5XoTu4bO404EVcgLO57Pa8EYF+JizuIYsegCFsstQnu5zcNVJZTQX
         cTPoK841LozEWPiLrHWpCfZCFyQypi1AqiIt+tDfKIjFKoRe79aaKDi+7aia+lDgFA+o
         CYY6EFUJuJj4RPoQ08d6BxnM+9UZnO5UNon9HfF4bQG2bWU7Leb8gflmMhoxtmbLl/vR
         nPBtbYReUVRIzOUAQmpUcS0sQJwO+RYDoZrsiONLNg6dEGsMZOJ1biQpqW9jAJQJEp4T
         kYLWU2sFZpChYjCcE0JTcr6XF+qtQcnM0yKZCA1EPOypislecWpqbKJPzrJEdPDbE59+
         9BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002093; x=1757606893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbxwAPRbZLLGWs9r1VP1FnvbCoc9pGEKPj76nnKqTXY=;
        b=XLzK/SaDiJkbVtfUbPKd7Fkcoi1Jz8jHh9mRavp3uYhFpl5qaLRzx0Wjxs/fCrS0ED
         g0x5h5pBkvApk3ldt0cH2mUaG+O63/lF/XwGkAgaU6NiCHESzwPC/nLSu/5gJtOP4q+M
         +yf3OIYVFjkiNWYhm1o5ro47W/KgnPhQwbc8kzSQCvo+3WAIVeNMsQLhNSsKHo0ZUpTV
         c4bNKvXc4R5/lVzfRC5xvrnMAL7FZeL+p4bXamoRL5JaszTN1JHOysw8+zR/BeiZNoFe
         Z76STbNuZhFipXgubSgCAsW2wKsyKiOVmgpC+mtyhaefdzR4G6fafF9dEFiLpMo+GERn
         KcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvktY6UQHC25JtQkycPnG3VyhqLTGEKToAexgFdsTnamrFh3GwnKna4FQcWdsCFBb6QKpFrgGqlV9v@vger.kernel.org
X-Gm-Message-State: AOJu0YyEevHs0bOtvTyk2p/AowRDpssr7twQGmrfKG30iTX5LkatuUYc
	kvNIRFHSVJI55wLCviF8zUAJ/YekWjQgQIjJnVJlr22iKLEyNfCTJuij
X-Gm-Gg: ASbGnctFzo2/1H0zr4gtWoZ0ERzKmqIYayz5zs8PayIbyBQdgpJ68BA6/jFEw1qlJS/
	et2dnOpgZeU/BiTBrzWIHpvG1rAegxIBWTodLzEXGQjh0xhEnLhnRIionaJLhKx2RlK67FGuNV9
	zXqRlD1+neqJxrorQIdY70PosyV/CvJmbBrGIcz03M8XpT6w7Bz4ux15I7aNAccjdFI89KZWUBN
	DyMkdNsOqsE82zxm0KLY+YiAmrxjyYUeMZszpXLf99Cq/pgxplcbprjgkd6wfIpxQw+2XYJLge8
	myAmyIC0XzC4bpYB48VPhl+AQ7ScwuWD/oRvkvrVPySmZNHpM/959sDuYwfEHzGJNeRCtGBR/Ml
	qzelSSrYZ/xrtNvVZFdOZCnXpue9TiRPjLwaK0fnLgxl2IPa+cwhe
X-Google-Smtp-Source: AGHT+IHjB2+IkhRCLJgIXDZnkVz9/1NAMGeK1BR80GdOB6f5va7pWqIXQ3joMoysK4vHfou5xDfW9w==
X-Received: by 2002:a05:6871:eb03:b0:30b:de9b:705c with SMTP id 586e51a60fabf-3196307f013mr10559358fac.5.1757002092703;
        Thu, 04 Sep 2025 09:08:12 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:c51e:64e3:dc5d:9652])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5fcbf6asm2437593fac.20.2025.09.04.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:08:12 -0700 (PDT)
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
Subject: [PATCH v8 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Thu,  4 Sep 2025 11:05:30 -0500
Message-ID: <20250904160530.66178-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904160530.66178-1-macroalpha82@gmail.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
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


