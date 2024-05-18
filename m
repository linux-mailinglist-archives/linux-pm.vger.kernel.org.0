Return-Path: <linux-pm+bounces-7964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF58C90C4
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED8E1F21B32
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA1E3D3BC;
	Sat, 18 May 2024 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKAN9kP5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B238F86;
	Sat, 18 May 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716034374; cv=none; b=UvFqvANDpyo/NCZLqdb1gkG9XQdA9Zrio/lGG9aaxLz82AWspBnX0pVBCDdHdgBke64hIQwZTOrm92OCKBgVijq3OpDXdUJd6BFalaQCyOJXB5Zp8mOF/MIu2bHw/Dc3JwjSAMmWZ76b7ee3Rb5lNBwgnXwzBQZYO3LXjSVHKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716034374; c=relaxed/simple;
	bh=puCzSyBrPHewwjdEAZq1RTx7Q2v3HQBbD2CoRPBEE3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnJS+a/mfYLpwwPcGve/bAJcwf8VsBC3ivyWH9cISH7aOgCLZWGupJEkBTRVWRO/eyH6r5K5gHECmHXeEPs3PoBERVlk2FYYRNJT0BTD2F8PJqlTVJ+PYZVpDQU0jSxx6XL69yMz9ovkk904WklfdtEbBP4MNPDYbW5zgBbHQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKAN9kP5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f72a29f13so1859475e87.3;
        Sat, 18 May 2024 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716034371; x=1716639171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+CcrlNbsHEM5IbBF+aEvbweCw5RwAqEr0nCDuf0P80=;
        b=JKAN9kP5ZusZhA12zRuB65WHsNocMAl3YIwgRzAUB0k37H0uD+NVmFMz+zs3Af4J0r
         d3rW7jt0DaKYolfpiyWk26OVsot/KlJksYWhXbqhlO+1MrsDkcVn+LkrrivQrNKGdYpb
         pvq9eOVEVe6BjC/UJynMs0lx+172yDJhpaVLjkFYxhuA0P6NWVhSalHroyLdBORaVe1r
         qdiJpipD17F/6pMPx2EkWkKLLOrPmh2H0UrBzIUfGo0s0hR7WyyWyn+6PfklbNUpIdDY
         PPDUhCizGYTeDrcCJyS5ifosGJySgJQVp7aBNTb6yvZUARbpmBFc/abTEwhGiKgueIx7
         TPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716034371; x=1716639171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+CcrlNbsHEM5IbBF+aEvbweCw5RwAqEr0nCDuf0P80=;
        b=YxHuP7KUwcveu7MpB9b3AaS41ije01KhON9wKvf+5E/VseO8fmjVk9mplSqx/OIX0F
         gkT4/maQOdxINL6DIlscwKh/PKgNpIChkZH1a9wd1NM+KbeC+RGZ0RV8U09PXeRIllHs
         4QJ8xVWzNaUiVZ7ssxLRdT/Q9IcYMbkPETOQXCmMj/l1WbAF/mawflV6cP3gL4Lco9vD
         5nE9Rxy2IJMMoelBEPlwvxKnzbcxCdc0fmhCeiHvOpXga+GXdJo+QXgEgsMU3BbfbgXO
         1Bn5TeY4FibyBDybdYfqvFqVjCUlhHQDA2EtLuzamcPG8vXMOvncD4SP//qfSK5TwIiz
         P3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXyvKAZvINSHESjRl3nm2UfQ222MW8oL5LabBwSONBN4Gr68Pjm49ry4tns4xuDCQgIREEatBLya8bsht9jB2lrOsbV7KF9KGtQJEUQyuc6N3DCvNSF3NZ+Z2XeNhRL8gaIWwifEqYxxw==
X-Gm-Message-State: AOJu0Yw9gHEd5octGSqVvBJLUcFAQq2NwtmP9TkD5+m46+fNqq6E5TJC
	WGiaJD1e/fw5F9E6qLY65Fbp36MVm8TTBgd/FX3ImCbXw140Tv+o
X-Google-Smtp-Source: AGHT+IGCqom0f/JiQFDnaCldSas0fyciwxHluc+scNBqYPHfPb0Rl7baW0X6/IEtd7zm1t+AwIBO0A==
X-Received: by 2002:a05:6512:1304:b0:51c:5171:bbed with SMTP id 2adb3069b0e04-5221006e625mr19978831e87.15.1716034371324;
        Sat, 18 May 2024 05:12:51 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8688sm3543568e87.213.2024.05.18.05.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 05:12:51 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sat, 18 May 2024 14:12:06 +0200
Subject: [PATCH 3/3] ARM: dts: sti: add thermal-zones support on stih418
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-thermal-v1-3-7dfca3ed454b@gmail.com>
References: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
In-Reply-To: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
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
X-Mailer: b4 0.13.0

Add a 'thermal-zones' node for stih418.

A thermal-zone needs three components:
  - thermal sensors, described in an earlier commit[1]
  - cooling devices, specified for each CPU
  - a thermal zone, describing the overall behavior.

The thermal zone needs references to both CPUs and thermal sensors,
which phandle are also added. The thermal management will then be
achieved on CPUs using the cpufreq framework.

[1] https://lore.kernel.org/lkml/20240320-thermal-v3-2-700296694c4a@gmail.com/

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
2.45.1


