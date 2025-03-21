Return-Path: <linux-pm+bounces-24370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CCDA6B839
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949B77AB36D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672F215078;
	Fri, 21 Mar 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1s/t4jh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE01F4616;
	Fri, 21 Mar 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550983; cv=none; b=SBqwK1XTS9+BTl2iMo9Tv6kYAhfuPm55seFav7zAD5EfRIUVpVpVUnCM8dxLriP/E0A9pmtc9RKW6RHgOQ4RVI3/UGYbb1kxGdEUQMuN9xrHo2IQisTIUSVUhZwuPhp9dLaj3AN+zp4CQom0D4chGHnlvwdVaLaWJCQmXlOFoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550983; c=relaxed/simple;
	bh=yenB81RFTTQVZzOuKrtKURDLchhy5hYMxQgAe625KOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWhuHD2DZfr0pmx+8Zl1/o1Ds4+OabkgmRmnj2+3Hbm2l8R5bouX15TRJFNnWdsEUf4ARwRyUVWfhKQB4qW/zF6Fo2JA38ovqlOLdzZshapUn6eYCR21tcYzicRFOsy1QiBqvN3cqtdtzAWyh1Et5zCASAGRQmwYsDdpXhwYT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1s/t4jh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso366954966b.1;
        Fri, 21 Mar 2025 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742550980; x=1743155780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ROs3p4d9jnnyN4eUO0PMHx9QqYizb1PZN92H3mvS00=;
        b=Z1s/t4jh3D4TzG0ZK1hbdmsEIJjEYLqllUmuY9h/lBiIMkU20/3VlEwJ6aJJQLKEak
         13ZSygN3649jPYPr1PYI94jfIGPF8UAo6tmUhWbYjccBv3HT+BRDwE/00P8n6wvACBR0
         BCi6oZ6TBSZNXuyMzCUhkOtClNRKFvGxhDFUYCh+j9Lg0ogQ3GA9go7oWHsYRuJoFqDo
         7OoIObByk2q09zInhaH3KNfPpDe6zOXrU0p+tmzGPzbs5Dwku7aCY013NSsTFFQdX+0C
         XD5GRmNFneGZuKvAqa9gJzIJMI8LcxjAWdbFzSE7hKp3bql0kVO/UtwfgaaTipa9JTno
         6PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550980; x=1743155780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ROs3p4d9jnnyN4eUO0PMHx9QqYizb1PZN92H3mvS00=;
        b=GPHtHsK9tpVTQ6TyTELSqvQMHr6L+cJLHi4xxGo5DUwwiYrVPkBvY9sNrQ1nf/0fnV
         3aghTUV3rb/Iuu+UpM1l3UI/2t6Aka8FoKnjrbswm3/0YPIUCvDnU1RdrBkhC0RrZeAZ
         VAMBE/AHRd6KErbQFKrLzY4K05zmZiLPMnLMvZ28EgiTMDrrXfKoeT2RjMCv0zhiHktJ
         ss6nNMztSBfZnN6dyB+2f1MrzaRWvMEIUE8FFKrohXUqP1zAoK7dGEL0fxLfocwxZcCD
         Pc+pjQzfVt/831uvuwa87PuQWP05OdXwVE7BO1PURQr2lc88q/wzjVLj7PXVr0nK1O4/
         YvYg==
X-Forwarded-Encrypted: i=1; AJvYcCVNmq3q5PaP02YjT5TQGFm7sqBoOj2ZPUbqVXR99Kl3zTGAs9H2AStMkV+quQlYK6E+zWwxKxlZ0FY=@vger.kernel.org, AJvYcCWfWOl/7cTM7NWNQaQRFVoxh2xxUC1QrgKC4XHzcxRrSbWfVEark99TUmPncLHFu59hE+Eo6xQUY/k=@vger.kernel.org, AJvYcCXwgy518s+wsbp7BcozE2L0IKvMUcTlsOfoIAMZywOtPNwGf365x9tkxr+2Oyj+FxLlBJ9x1GwQ1Rgsyhbi@vger.kernel.org
X-Gm-Message-State: AOJu0YxTypfrg9T1i57XJ2u2xCa5EZEy3rfMRng//LOru/5jD2AJYiU7
	5Iwx3zp6QtPMLSwmZSCWaUjKHLCwKFRV1vPtuZDEkd5f7Q+ijR5m
X-Gm-Gg: ASbGncubmUoaq97wFv2qCU2aCV7js5v+bClNtaVa15+7P1ztB6EdLnCDk5TwuP69sUI
	FKdPz+XcBTYfCYfHWIGfkxA/X+HFAGYmk6P9sMs9gMc1C+vEASG6hAQzLyw1egQCaTWq9qC68IA
	yrr/tWrMhfMGJuxcE8eJTwv6mGc3R3ephHFfv3h2ggyVQvAGOWiEdOnqidfei6OXo9AnJInu+pt
	Ty9D/5/ab6Yn5mj10u4/PvjyiKQduJfMVEK3s8LTcnpvb00oXArMNyWgEcBtpIrX1QvNWoOB4s4
	7vnaxY4QCSAwmWHcnn7mgvysYWvsIzFYIADd
X-Google-Smtp-Source: AGHT+IH+4wAaY50C8bL7aK9Ptp4xkCMlAxpcm/+zXUd2CW2A4362UChdfR33GSZUd9xYi+PVzxtxOg==
X-Received: by 2002:a17:907:6ea2:b0:ac2:7a3b:31e2 with SMTP id a640c23a62f3a-ac3f251f286mr226334166b.45.1742550979800;
        Fri, 21 Mar 2025 02:56:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef869f19sm122300866b.33.2025.03.21.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:56:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: tegra: Add DFLL clock support on Tegra 4
Date: Fri, 21 Mar 2025 11:55:56 +0200
Message-ID: <20250321095556.91425-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321095556.91425-1-clamor95@gmail.com>
References: <20250321095556.91425-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DFLL clock node to common Tegra114 device tree along with clocks
property to cpu node.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 341ec0962460..25d063a47ca5 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/memory/tegra114-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/tegra114-car.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
 #include "tegra114-peripherals-opp.dtsi"
@@ -710,6 +711,30 @@ mipi: mipi@700e3000 {
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
+	dfll: clock@70110000 {
+		compatible = "nvidia,tegra114-dfll";
+		reg = <0x70110000 0x100>, /* DFLL control */
+		      <0x70110000 0x100>, /* I2C output control */
+		      <0x70110100 0x100>, /* Integrated I2C controller */
+		      <0x70110200 0x100>; /* Look-up table RAM */
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA114_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA114_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA114_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		resets = <&tegra_car TEGRA114_RST_DFLL_DVCO>;
+		reset-names = "dvco";
+		#clock-cells = <0>;
+		clock-output-names = "dfllCPU_out";
+		nvidia,sample-rate = <11500>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <10>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		status = "disabled";
+	};
+
 	mmc@78000000 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000000 0x200>;
@@ -841,6 +866,15 @@ cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			clocks = <&tegra_car TEGRA114_CLK_CCLK_G>,
+				 <&tegra_car TEGRA114_CLK_CCLK_LP>,
+				 <&tegra_car TEGRA114_CLK_PLL_X>,
+				 <&tegra_car TEGRA114_CLK_PLL_P>,
+				 <&dfll>;
+			clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
+			/* FIXME: what's the actual transition time? */
+			clock-latency = <300000>;
 		};
 
 		cpu@1 {
-- 
2.43.0


