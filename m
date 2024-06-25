Return-Path: <linux-pm+bounces-9978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9661991738E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 23:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC31284215
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DCB17E905;
	Tue, 25 Jun 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLdl6CAH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC217DE31;
	Tue, 25 Jun 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351199; cv=none; b=mIdiKOQYJl9Cc3ShBp1v4QIrsbBuYSqvX5wn84QWROXosS3MY9f3Y1E1qrzlTjASulj1HlQXdKNIQJEK3qqMDfGaLuniaiCO1aE9ALAaA7znl9mvqCSZl+V3fSTWghxeV/hwIFLpjOBDmSZ383M3ozeF3thwiDRsUotfUacSwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351199; c=relaxed/simple;
	bh=4vCRzl6qgQmsj5uuos6q/9cqMkVQ+6J87WAp5hpMHN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCwIUGgTD1pZG1Kr/GuqDAQsjCgPMMBxL2ZRw3KIQhmi5b1pWz20pI7HnD5i3lLHZkXMwtXeI/wCVcUnMEN2zRS3Ac9uiyJYVQ+DJQkbZzLqXbfj94+f0ckX6plmURNS1zPYXl5R3Mw2PN2XpuAGeShQIsyPM3x5BukUP8550nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLdl6CAH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so3737900f8f.3;
        Tue, 25 Jun 2024 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719351196; x=1719955996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUkVIkbscryFzLdHAGkO+1ya2/2312ktRzQgqWxaXtI=;
        b=NLdl6CAHGoUHHhsip89UccBLy01Z8TozcgTSr2Ok6pE0jxhKgL/ofogaJ+yVZpnKq/
         Y1JP8YAIBFfB7xm0bq6OCxcfJl1TKfO9R/xCQ05W2pBKms5xIreDktnaHozxQN7HH326
         mAGVJpmH9ViZu8j/hi8N6CehsFoU/IF0guiZWnFFHI2svre+6Cegob+Dhq2DfP9D4Tmu
         CwvDNhBh9j+RkbRHQ4PczzY8b6NRxhgY7Qx1XuqjC/+qA+0A4BztPk76JtqfpRGKV1Ld
         p0wCM5d1ccjTMpCXf8It1cpHqkZ0drQ35QBTOiXEsajzHBjho0+LJE+ltFgXguMK9koi
         3Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351196; x=1719955996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUkVIkbscryFzLdHAGkO+1ya2/2312ktRzQgqWxaXtI=;
        b=Xra7KUylEiOpfl5HbLCDFwT1Y8KHzoTtkNIo6H1vuYjLO45vSXkb+vyLrvdcG3U5yG
         mk1e+Iy+zdjrd/BRXqdlW4sNhPKerCIdoXcfYRTBdHb2FZRfUpEAbCQJhsoGZOdLEMO/
         Hb0z/7sQLvSt79u/Kg20NkMlMgCqSF6lxwVAUvsuHld1DHv7J0KEsvDqUlWy1rTtqVOk
         EXs40p2XUaKPB30Kv5C6kj4Wj8uxBbyPoJbKQCuA/WCd8gr+CEwI8FNf9X1T+s0xWKyW
         wRJ9uD4UIdJyjkF/NAt4DbBOUljJdt06O3+nQMn+76HgOaXKjqPbQAH3kMIxJzyzBpMJ
         nhdw==
X-Forwarded-Encrypted: i=1; AJvYcCXeg/D4+CiLs3n1N4RRvdpmX9xZjzv7Vs/TQlq39Ol2AtNMM9ORSbQwJ7BT4yPwVJB3vyrxWwYK9htvEgjr2Vq8Fspudsdghl1+25WQGfad5a8jqZZuKwktaGUsujx8y880ldSq//QbWw==
X-Gm-Message-State: AOJu0Yys9r05gaC/u7yyeocN6wRWMoEhoguWC5wTZUI4oeI4pBUn4P78
	00JpTmvKYijaJ7KaJkHyvkIuA27VjKVkVVAgI0mEIYNoWtaaU7/o
X-Google-Smtp-Source: AGHT+IF1vNOVtlSl9cFErkZZ3gZeIrjKfVDkNDpF40NXHmyTCzK4OuWl8NqNcyOSM/LpMW3SCCIssA==
X-Received: by 2002:adf:fa4c:0:b0:35d:c106:2db8 with SMTP id ffacd0b85a97d-366e7a63802mr7040004f8f.57.1719351195202;
        Tue, 25 Jun 2024 14:33:15 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36647e7eb4fsm13959262f8f.18.2024.06.25.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:33:15 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Tue, 25 Jun 2024 23:32:42 +0200
Subject: [PATCH v2 3/3] ARM: dts: sti: add thermal-zones support on stih418
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-thermal-v2-3-bf8354ed51ee@gmail.com>
References: <20240625-thermal-v2-0-bf8354ed51ee@gmail.com>
In-Reply-To: <20240625-thermal-v2-0-bf8354ed51ee@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Add a 'thermal-zones' node for stih418.

A thermal-zone needs three components:
  - thermal sensors, described in an earlier commit[1]
  - cooling devices, specified for each CPU
  - a thermal zone, describing the overall behavior.

The thermal zone needs references to both CPUs and thermal sensors,
which phandle are also added. The thermal management will then be
achieved on CPUs using the cpufreq framework.

[1] https://lore.kernel.org/lkml/20240320-thermal-v3-2-700296694c4a@gmail.com/

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/st/stih407-family.dtsi |  6 +++--
 arch/arm/boot/dts/st/stih418.dtsi        | 41 +++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
index 29302e74aa1d..35a55aef7f4b 100644
--- a/arch/arm/boot/dts/st/stih407-family.dtsi
+++ b/arch/arm/boot/dts/st/stih407-family.dtsi
@@ -33,7 +33,7 @@ delta_reserved: rproc@44000000 {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
@@ -52,8 +52,9 @@ cpu@0 {
 			clock-latency = <100000>;
 			cpu0-supply = <&pwm_regulator>;
 			st,syscfg = <&syscfg_core 0x8e0>;
+			#cooling-cells = <2>;
 		};
-		cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
@@ -66,6 +67,7 @@ cpu@1 {
 					    1200000 0
 					    800000  0
 					    500000  0>;
+			#cooling-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
index b35b9b7a7ccc..6622ffa8ecfa 100644
--- a/arch/arm/boot/dts/st/stih418.dtsi
+++ b/arch/arm/boot/dts/st/stih418.dtsi
@@ -6,23 +6,26 @@
 #include "stih418-clock.dtsi"
 #include "stih407-family.dtsi"
 #include "stih410-pinctrl.dtsi"
+#include <dt-bindings/thermal/thermal.h>
 / {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
 			cpu-release-addr = <0x94100A4>;
+			#cooling-cells = <2>;
 		};
-		cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
 			cpu-release-addr = <0x94100A4>;
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -44,6 +47,38 @@ usb2_picophy2: phy3 {
 		reset-names = "global", "port";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <250>;  /* 250ms */
+			polling-delay = <1000>;         /* 1000ms */
+
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu_crit: cpu-crit {
+					temperature = <95000>;  /* 95C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu-alert {
+					temperature = <85000>;  /* 85C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	soc {
 		rng11: rng@8a8a000 {
 			status = "disabled";
@@ -107,7 +142,7 @@ mmc0: sdhci@9060000 {
 			assigned-clock-rates = <200000000>;
 		};
 
-		thermal@91a0000 {
+		thermal: thermal@91a0000 {
 			compatible = "st,stih407-thermal";
 			reg = <0x91a0000 0x28>;
 			clock-names = "thermal";

-- 
2.45.2


