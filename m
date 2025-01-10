Return-Path: <linux-pm+bounces-20216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B60DA0910B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA303A5A41
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC4213245;
	Fri, 10 Jan 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRBwrv/3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE97212FB7;
	Fri, 10 Jan 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512801; cv=none; b=B7iSalYdTW+OsUzEWZARr7BiibVn/O+j2HJ5dhSQOQELH9XEay2icycGlY01Pc2cli+gRYfvsZ70rAMbc326uENkXcjrWYIhbuTvyKvWAa/VlKKKsN9ipsroWfMrFUvg2jkiOS/wu/+DmdQO79IxmnEVdRig3Rfn9xkPrRDQ+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512801; c=relaxed/simple;
	bh=ZrTjoZTAaLe91YzVSUup4kjuEP2bWhsdZw6HS/hxEcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0MwVmqxTjzpYu6QRL7NLxA9pzMdhGK88Hb5eJmiewkqMNpIxMPEsKI5mkvKEtceZ6j3Sht4Pf1zHHIa2sx3kQvkSEvpw0vZX3xlF9tMuEakUEFxDjQxBRi7tPKF+K4RQYN5y6ZPcQ5oG7eZdD2K70ooyhtW920OphTPJzRBY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRBwrv/3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385eed29d17so1082895f8f.0;
        Fri, 10 Jan 2025 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512797; x=1737117597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nozmpJQsg22jiSs48IB4iJIoZo0lhuoH2dL8CNclHCE=;
        b=NRBwrv/3TThIsW0eqmjtnfJe8W/vOk8HI8JIJNMn6dwxe/wvd1XG+t4a7mbAtuDryM
         p6wteF5Z7PFeRex2u+FbSgRUwRtWxTEMgV35DV/5RGBCeBJdv18OJBxNh2Onipz/5P6p
         nOV2xvnL//H3/GW2bcX75wB6C3DFCXh+jy5qi/nWaT5e19py719ifdQcUICar9AVbWNj
         LZuOwm98sFyU+N7s7iVNPXS1f+WLk9+/WeWhfqmC2UJ/o8s4gQvJ/f5yUzRSOKQTAZpd
         K6+FLOuFMmsxJHrlrP/bb3cjbxng3xo+Vdlk4qLWTIxIz4edlsEYtUDLEe5pbMfo25Sc
         FeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512797; x=1737117597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nozmpJQsg22jiSs48IB4iJIoZo0lhuoH2dL8CNclHCE=;
        b=ip1Ln13Sa5l7I0b1KrphLmDhP5mMO4NNfz/yt6MkVe6LakknrJdeYTlNOB4rBGSqiu
         NR8DRp9jqfoq97mAjKmmL9UL/W5agThgXxJc6uHiGbZYj1Dw/4hAhbaVSdwMxN6T2fbS
         E1QhhLpba/varynGC8GfSNVP70GJQhT+n1d3C9aq/F1hF91V8wSuDfwOk0AUMHp/8e1l
         F5rXkdel5nkZFH3awBiVs17YZ3qFgodZuOiRyrPqCLllOppaZIpOjBkIzkuiADCE40Nw
         TVoXrgasoX95xv/HncWienM4Do2ah+BgTeKqxtY8cWBNKPRww3ZRh+rcWxoBOOVw8ZT1
         9+8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgHvqiE34dhgfsPz3IvsQwWzkrl4D4NMrKMWgyZsRnqq+ksvRGOq1G4Jrz2QA2QKh7l8XM0fUlvqO2@vger.kernel.org, AJvYcCWm+OaYJVVZh93s3rxSDXlzPuX9rGXGVWHg2jFRiZjlq/b2iOPRSOMqShYxzp10RY6et/IkRaWXfeI0@vger.kernel.org, AJvYcCWylpStzzuLjHGoTCKIpOCYcnr4/uBiE6fOxBf3OR+8UDswNHRahR3kO/59+LOHxHB7FXv3NtGugnV8FA==@vger.kernel.org, AJvYcCX6aZrEDqjn8Yu7E2xNJmwYl9urrZhznoaBYTaJUEkaSGQTdDTzdFyRf/79WZYfqoZl0KhjSHHdTNfHdDlT@vger.kernel.org, AJvYcCXJOoiNuVDOs40NzNpDGQhYY3ulbyuLX8kl0H8SYHgi5SF1lnao6YCEUBqJ6G3KWX5RHexTuky8zpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XnUotWHumGs09fbYNyJUKwXxH/Nl0P/ScK5KgpKPVMN7giDs
	qmydiaNy+8ZHyBwxOf3KU8a4SfKN4Pgn3Wm2jozbUI2mnE1U/GIn
X-Gm-Gg: ASbGncs7dGoCjc1Xmi+kvOzNequ3pMyDe1RMgpi62yqUoOpG8PBLc5SQ/q896/YmziA
	iNywMXexvYcu1Yhqm5Gihsy5HpdqRjCgjbTWmlkftt1vc8Xr47KS4sisBaT8kcMiQNx4I/FvdxI
	SbnzYA3cs7HUHkDMbWMo0iJTxjExgilpjMuloPr1vcVUrlRv/CXknQIuxos0RqyKCpHB6HiUx8w
	e+qk0IYSEbo4QG3gsQcreXIIe1NZfJELZFokj5/hJyliNZTlkpDUHvFVUCLLv4DzdsFCTUXeiif
	gruPZo9Psv0=
X-Google-Smtp-Source: AGHT+IFOe7KOjKzbNd2JWzyj9jIFOIXUdiW7gt9PgQGUkaWczrjN4bnRuGXCkrxgt5ONRvjc0O3CMg==
X-Received: by 2002:a05:6000:4615:b0:385:e013:39ef with SMTP id ffacd0b85a97d-38a872f6993mr8687437f8f.6.1736512797163;
        Fri, 10 Jan 2025 04:39:57 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:56 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 12/12] ARM: dts: sun8i: add DTSI file for V853
Date: Fri, 10 Jan 2025 13:39:23 +0100
Message-Id: <20250110123923.270626-13-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110123923.270626-1-szemzo.andras@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V853/V851 is a new SoC by Allwinner. Add a basic dtsi file for it.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi | 673 ++++++++++++++++++++
 1 file changed, 673 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi

diff --git a/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi b/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
new file mode 100644
index 000000000000..4ecc97c7e7c0
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com>
+
+#include <dt-bindings/clock/sun6i-rtc.h>
+#include <dt-bindings/clock/sun8i-v853-r-ccu.h>
+#include <dt-bindings/reset/sun8i-v853-r-ccu.h>
+#include <dt-bindings/clock/sun8i-v853-ccu.h>
+#include <dt-bindings/reset/sun8i-v853-ccu.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/allwinner,sun8i-v853-ppu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	osc24M: osc24M-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24M";
+		#clock-cells = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7","arm,armv7";
+			reg = <0>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			clock-frequency = <912000000>;
+			clock-latency = <2000000>;
+			cooling-min-level = <5>;
+			cooling-max-level = <0>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <142>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,	/* Secure Phys IRQ */
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,	/* Non-secure Phys IRQ */
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,	/* Virt IRQ */
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;	/* Hyp IRQ */
+		clock-frequency = <24000000>;
+		interrupt-parent = <&gic>;
+		arm,cpu-registers-not-fw-configured;
+		arm,no-tick-in-suspend;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		interrupt-parent = <&gic>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		dma-noncoherent;
+
+		pio: pinctrl@2000000 {
+			compatible = "allwinner,sun8i-v853-pinctrl";
+			reg = <0x2000000 0x800>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB0>, <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			interrupt-controller;
+			#gpio-cells = <3>;
+			#interrupt-cells = <3>;
+
+			/omit-if-no-ref/
+			uart0_ph9_pins: uart0-ph9-pins {
+				pins = "PH9", "PH10";
+				function = "uart0";
+			};
+
+			/omit-if-no-ref/
+			uart2_pe12_pins: uart2-pe12-pins {
+				pins = "PE12", "PE13";
+				function = "uart2";
+			};
+
+			/omit-if-no-ref/
+			dsi_2lane_pins: dsi-2lane-pins {
+				pins = "PD1", "PD2", "PD3", "PD4", "PD5", "PD6";
+				drive-strength = <30>;
+				function = "dsi";
+			};
+
+			/omit-if-no-ref/
+			spi0_pins: spi0-pins {
+				pins = "PC0", "PC1", "PC2", "PC3", "PC4", "PC5";
+				function = "spi0";
+			};
+
+			/omit-if-no-ref/
+			spi3_pins: spi3-pins {
+				pins = "PH11", "PH12", "PH13", "PH14";
+				function = "spi3";
+			};
+
+			/omit-if-no-ref/
+			i2c2_ph11_pins: i2c2-ph11-pins {
+				pins = "PH11", "PH12";
+				function = "i2c2";
+			};
+
+			/omit-if-no-ref/
+			i2c3_ph13_pins: i2c3-ph13-pins {
+				pins = "PH13", "PH14";
+				function = "i2c3";
+			};
+
+			/omit-if-no-ref/
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
+				function = "sdc0";
+			};
+
+			/omit-if-no-ref/
+			mmc1_pins: mmc1-pins {
+				pins = "PE0", "PE1", "PE2", "PE3", "PE4", "PE5";
+				function = "sdc1";
+			};
+
+			/omit-if-no-ref/
+			rmii_pe_pins: rmii-pe-pins {
+				pins = "PE0", "PE1", "PE2", "PE3", "PE4",
+				       "PE5", "PE6", "PE7", "PE8", "PE9";
+				function = "emac";
+			};
+
+			/omit-if-no-ref/
+			rmii_pd_pins: rmii-pd-pins {
+				pins = "PD1", "PD2", "PD3", "PD4", "PD5",
+				       "PD6", "PD7", "PD8", "PD20", "PD21";
+				function = "emac";
+			};
+
+			/omit-if-no-ref/
+			dmic_ph9_pins: dmic-ph9-pins {
+				pins = "PH9", "PH10";
+				function = "dmic";
+			};
+		};
+
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&osc24M>,
+				 <&ccu CLK_BUS_PWM>,
+				 <&ccu CLK_APB0>;
+			clock-names = "hosc", "bus", "apb";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			allwinner,pwm-channels = <12>;
+			#pwm-cells = <0x3>;
+		};
+
+		ccu: clock-controller@2001000 {
+			compatible = "allwinner,sun8i-v853-ccu";
+			reg = <0x2001000 0x1000>;
+			clocks = <&osc24M>,
+				 <&rtc CLK_IOSC>,
+				 <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "iosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun20i-d1-gpadc";
+			reg = <0x2009000 0x0400>;
+			clocks = <&ccu CLK_BUS_GPADC>;
+			resets = <&ccu RST_BUS_GPADC>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <1>;
+		};
+
+		i2s0: i2s@2032000 {
+			compatible = "allwinner,sun50i-r329-i2s";
+			reg = <0x2032000 0x1000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S0>,
+				 <&ccu CLK_I2S0>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S0>;
+			dmas = <&dma 3>, <&dma 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		i2s1: i2s@2033000 {
+			compatible = "allwinner,sun50i-r329-i2s";
+			reg = <0x2033000 0x1000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>,
+				 <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S1>;
+			dmas = <&dma 4>, <&dma 4>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		timer: timer@2050000 {
+			compatible = "allwinner,sun20i-d1-timer",
+				     "allwinner,sun8i-a23-timer";
+			reg = <0x2050000 0xa0>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
+		wdt: watchdog@20500a0 {
+			compatible = "allwinner,sun20i-d1-wdt-reset",
+				     "allwinner,sun20i-d1-wdt";
+			reg = <0x20500a0 0x20>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+			status = "reserved";
+		};
+
+		uart0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500000 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			dmas = <&dma 14>, <&dma 14>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart1: serial@2500400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500400 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart2: serial@2500800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500800 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			dmas = <&dma 16>, <&dma 16>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart3: serial@2500c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500c00 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			dmas = <&dma 17>, <&dma 17>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c0: i2c@2502000 {
+			compatible = "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502000 0x400>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			dmas = <&dma 43>, <&dma 43>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c@2502400 {
+			compatible = "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502400 0x400>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			dmas = <&dma 44>, <&dma 44>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@2502800 {
+			compatible = "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502800 0x400>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			dmas = <&dma 45>, <&dma 45>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3: i2c@2502c00 {
+			compatible = "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502c00 0x400>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C3>;
+			resets = <&ccu RST_BUS_I2C3>;
+			dmas = <&dma 46>, <&dma 46>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4: i2c@2503000 {
+			compatible = "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2503000 0x400>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C4>;
+			resets = <&ccu RST_BUS_I2C4>;
+			dmas = <&dma 47>, <&dma 47>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		syscon: syscon@3000000 {
+			compatible = "allwinner,sun8i-h3-system-control";
+			reg = <0x3000000 0x1000>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			sram_c: sram@20000 {
+				compatible = "mmio-sram";
+				reg = <0x00020000 0x21000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00020000 0x21000>;
+
+				ve_sram: sram-section@0 {
+				    compatible = "allwinner,sun8i-v3s-sram-c", "allwinner,sun4i-a10-sram-c1";
+				    reg = <0x000000 0xa000>;
+				};
+			};
+		};
+
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun20i-d1-dma";
+			reg = <0x3002000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			resets = <&ccu RST_BUS_DMA>;
+			dma-channels = <16>;
+			dma-requests = <48>;
+			#dma-cells = <1>;
+		};
+
+		hwspinlock: hwlock@3005000 {
+		    compatible = "allwinner,sun6i-a31-hwspinlock";
+			reg = <0x3005000 0x1000>;
+			clocks = <&ccu CLK_BUS_SPINLOCK>;
+			clock-names = "ahb";
+			resets = <&ccu RST_BUS_SPINLOCK>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		sid: efuse@3006000 {
+			compatible = "allwinner,sun20i-d1-sid";
+			reg = <0x3006000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calib: ths-calib@14 {
+				reg = <0x14 0x8>;
+			};
+		};
+
+		hstimer@3008000 {
+			compatible = "allwinner,sun7i-a20-hstimer";
+			reg = <0x03008000 0x1000>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_HSTIMER>;
+		};
+
+		gic: interrupt-controller@3021000 {
+			compatible = "arm,gic-400";
+			reg = <0x03021000 0x1000>,	/* GIC Dist */
+			      <0x03022000 0x2000>,	/* GIC CPU */
+			      <0x03024000 0x2000>,	/* GIC VCPU Control */
+			      <0x03026000 0x2000>;	/* GIC VCPU */
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>; /* GIC Maintenence IRQ */
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		npu: npu@3050000 {
+			compatible = "vivante,gc";
+			reg = <0x03050000 0x1000>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "npu";
+			clocks = <&ccu CLK_BUS_NPU>, <&ccu CLK_NPU>;
+			clock-names = "bus", "core";
+			assigned-clocks = <&ccu CLK_PLL_NPU_4X>, <&ccu CLK_NPU>;
+			assigned-clock-parents = <&osc24M>, <&ccu CLK_PLL_NPU_4X>;
+			assigned-clock-rates = <1392000000>, <348000000>;
+			resets = <&ccu RST_BUS_NPU>;
+			power-domains = <&ppu PD_NPU>;
+		};
+
+		mbus: dram-controller@3102000 {
+			compatible = "allwinner,sun20i-d1-mbus";
+			reg = <0x3102000 0x1000>,
+			      <0x3103000 0x1000>;
+			reg-names = "mbus", "dram";
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_MBUS>,
+				 <&ccu CLK_DRAM>,
+				 <&ccu CLK_BUS_DRAM>;
+			clock-names = "mbus", "dram", "bus";
+			dma-ranges = <0 0x40000000 0x80000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun20i-d1-mmc";
+			reg = <0x4020000 0x1000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			no-sdio;
+			no-mmc;
+			cap-sd-highspeed;
+			max-frequency = <150000000>;
+			mmc-ddr-1_8v;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun20i-d1-mmc";
+			reg = <0x4021000 0x1000>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <150000000>;
+			mmc-ddr-1_8v;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@4022000 {
+			compatible = "allwinner,sun20i-d1-mmc";
+			reg = <0x4022000 0x1000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			no-sdio;
+			no-sd;
+			cap-mmc-highspeed;
+			max-frequency = <150000000>;
+			mmc-ddr-1_8v;
+			mmc-ddr-3_3v;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi0: spi@4025000 {
+			compatible = "allwinner,sun50i-r329-spi";
+			reg = <0x4025000 0x1000>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI0>;
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
+			num-cs = <1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@4026000 {
+			compatible = "allwinner,sun50i-r329-spi-dbi",
+				     "allwinner,sun50i-r329-spi";
+			reg = <0x4026000 0x1000>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI1>;
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			num-cs = <1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi2: spi@4027000 {
+			compatible = "allwinner,sun50i-r329-spi";
+			reg = <0x4027000 0x1000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI2>;
+			dmas = <&dma 24>, <&dma 24>;
+			dma-names = "rx", "tx";
+			num-cs = <1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi3: spi@4028000 {
+			compatible = "allwinner,sun50i-r329-spi";
+			reg = <0x4028000 0x1000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI3>;
+			dmas = <&dma 25>, <&dma 25>;
+			dma-names = "rx", "tx";
+			num-cs = <1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		usb_otg: usb@4100000 {
+			compatible = "allwinner,sun8i-a33-musb";
+			reg = <0x4100000 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			extcon = <&usbphy 0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usbphy: phy@4100400 {
+			compatible = "allwinner,sun8i-v853-usb-phy";
+			reg = <0x4100400 0x100>,
+			      <0x4101800 0x100>;
+			reg-names = "phy_ctrl",
+				    "pmu0";
+			clocks = <&ccu CLK_USB_OHCI>;
+			clock-names = "usb0_phy";
+			resets = <&ccu RST_USB_PHY>;
+			reset-names = "usb0_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb@4101000 {
+			compatible = "generic-ehci";
+			reg = <0x4101000 0x100>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI>,
+				 <&ccu CLK_BUS_EHCI>,
+				 <&ccu CLK_USB_OHCI>;
+			resets = <&ccu RST_BUS_OHCI>,
+				 <&ccu RST_BUS_EHCI>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb@4101400 {
+			compatible = "generic-ohci";
+			reg = <0x4101400 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI>,
+				 <&ccu CLK_USB_OHCI>;
+			resets = <&ccu RST_BUS_OHCI>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ppu: power-controller@7001000 {
+			compatible = "allwinner,sun8i-v853-ppu";
+			reg = <0x7001000 0x400>;
+			clocks = <&r_ccu CLK_R_PPU>;
+			resets = <&r_ccu RST_BUS_R_PPU>;
+			#power-domain-cells = <1>;
+		};
+
+		r_ccu: clock-controller@7010000 {
+			compatible = "allwinner,sun8i-v853-r-ccu";
+			reg = <0x7010000 0x230>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		nmi_intc: intc-nmi@7010320 {
+			compatible = "allwinner,sun9i-a80-nmi";
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x07010320 0xc>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		rtc: rtc@7090000 {
+			compatible = "allwinner,sun50i-r329-rtc";
+			reg = <0x7090000 0x400>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_RTC>;
+			clock-names = "bus";
+			resets = <&r_ccu RST_BUS_R_RTC>;
+			wakeup-source;
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
2.39.5


