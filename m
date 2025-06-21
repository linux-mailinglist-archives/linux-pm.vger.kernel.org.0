Return-Path: <linux-pm+bounces-29197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD9AE2AFA
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 20:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E623A6C54
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270BC26F476;
	Sat, 21 Jun 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdf6Hobk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C0254AE1;
	Sat, 21 Jun 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529034; cv=none; b=nASAkAfW45bFohLL4HKUzQzRjXNQA189otlsEEmq4SFySuEZjeCZUAXU0YKOPDjRrwGn+HS3jVGtreG1NPDoeskK1cH/6c4v5HJvBgEGWDu2Bd/eZRlH5F1cYNR/Kpu5dwP/DRPGAvbS/5BHwxrMwzD4vI4iuhOIYTmYwzcDiJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529034; c=relaxed/simple;
	bh=RkkZ1rVcIjjaIuIUTMKQMdxZMeQhhhILKOa4cee/qmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEt56Goxj5BYtkJvc4Jcbwx3eU4nqD333KeKLw7xgw63UXFed+9mdbYqPUgGo5cYfG4rPvuF7MgcKv0Fm2rdCxq9VBbXL1J6q3g+teMpNjWDkSawmo30ROMZ5w4YRUPbTjIRpc6s7KKb5XErBBVE4/ExQD7Hz3w/biSu+ONdcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdf6Hobk; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7382a999970so1944406a34.3;
        Sat, 21 Jun 2025 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750529031; x=1751133831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VWQ/3f6uGRHlfE4j0BNsaq/8Sj/J2vStE5CIqW2jYY=;
        b=jdf6HobkJ9BvUdLetkH2PFAmBDPI6b2UphCDRyhyMC7EFxXwRZpY9Jopv9yIlabZLX
         HLmXLimxdBkFN27utH+6F/taeb1nfsnjYUHoZNuoU1Hjpjh5/9X2VIdvOvHbXnTyXoHK
         XjTGwwcLOsmAbTvuNgvHhGhsMI2D/IndC/ZZ9JfviJJWkve3VyKOyk7ykf8GKY2EVgIC
         fDKtYomI0XMUTt+zQGsipUdw4Bcl1U7D8/3+z7UFQo5cAOvHeiAp05B0fft1d7nDmp0s
         KrgcvPs2h/ftKe7mKbq5nNi+NaHO/7+lN2DH2uw0/QxRO6fNX3ma2W6jEse80ar9P227
         yglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750529031; x=1751133831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VWQ/3f6uGRHlfE4j0BNsaq/8Sj/J2vStE5CIqW2jYY=;
        b=utN+SodT0iAMZDVMSn1GLj3oz2JDov6pQymXhih7tPP8V0pri0d1CzJlyeby5MS/Zi
         37huzOvPNbP0bK6dNQuU5+vC7VS81IYEsWgWMX6hre2CkG6Z5lVW4sUOD6eov0FuuL/l
         tFY5uE7WRpBedn1aUaYVtFiV2JHEmInA43d/9SEvqekecynrYk0D65tyYO0opp9sN0oZ
         VE3LVGcn6jYlQTeZcDcFe/2uIj/HSPX0fG4SjXPoqjVwHYUydou9HyXgjvl6Cgtvmwnc
         fzUHvoQ6y3agkgHYMnm0Hj7eH1aWRny+OUPBzn5SBEjAZaXK9mGoFAPxx1FO1gF7g9af
         632w==
X-Forwarded-Encrypted: i=1; AJvYcCVbGDn2es9Yyx667wvmIJRe749lO4KbrOodTsXflhYzxTqNyfoDDqI7nsI+0MmSISXYMLQdy2mz1kxf@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKyfIe5tbtlgpFYhRexOZFgk9zy3tOxly/HkbssjjkrXnz6er
	TVvinPcvVj7VBMoNr7XGJW+39kBzqnw4LB2XFPRVGaOPF0DsyvCm8S7k9xlYUA==
X-Gm-Gg: ASbGnctnPW5whbivTSZDN6vSl6dejbJ4NFlCEVLvTECAAenkAp+JHX114her1PSUzUi
	N5AOXSAjqgl6R8pQ7SYQjtXYNs5nV0I5LpETBtBeFCb6vARtZaj5k+DOPtKCwSgjaOz9mEXrDmN
	vnU0JVXmd4UKiM7Pc6w2ANA2zSNjXuT4mSkfsk7xYkyKSOPnO5J4Fe2LkWAQYy7eAPVCXN4u3FL
	ko+dU0Zenu2XVtT3ZVeiPC+PUqsh4DoHiDFmF9x1GP9doYaf2TUtXvVFDXUUQImqiXIn/y75dla
	np71YL2sIsr+6YshOM8C4oog1/hAmtw1ZAh6dHWd0UQGWgqfPWxdzLLkh8fk
X-Google-Smtp-Source: AGHT+IFiLXYIned3w/8jpGd43WO8zO95ib2QVaU/sdAM/cAhlQwDADtJv0SrvwE6/jrq4UNJ8sGUxw==
X-Received: by 2002:a05:6830:6607:b0:72b:93c9:41a6 with SMTP id 46e09a7af769-73a91fbf66amr5329313a34.20.1750529031452;
        Sat, 21 Jun 2025 11:03:51 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90ca8707sm782895a34.46.2025.06.21.11.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 11:03:51 -0700 (PDT)
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
Subject: [PATCH V2 5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
Date: Sat, 21 Jun 2025 13:01:19 -0500
Message-ID: <20250621180119.163423-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621180119.163423-1-macroalpha82@gmail.com>
References: <20250621180119.163423-1-macroalpha82@gmail.com>
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


