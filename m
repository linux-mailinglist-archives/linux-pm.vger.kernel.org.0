Return-Path: <linux-pm+bounces-21400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E7A28AEE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80501188343C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E515CD4A;
	Wed,  5 Feb 2025 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFMEUXjP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73858155CB3;
	Wed,  5 Feb 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759975; cv=none; b=hYg9y8c1pCUqF+VrW7TQEBrgbVoM4iEJHaSZwdT0KHrbG8WWTrOTJECDcDfzpz/0EmF5+nsicJxMuG4nugRR9eLCp8EZ8apxlduqpxSojq1fGWPt/fMHaaWMGYGQJ//5cviXROqiE9hiZhKks16ZwCUpJjTzAWnjRBvigxHCihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759975; c=relaxed/simple;
	bh=xp/XAYCJ0gW1/42TPE8bMe25omHNEVQkGeqAyKFjknE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMVlzopumCUNBTchhJ4xOT/YLFvZV2cpf2hrlM5pQ9KnvfcJrgKBform97958CFlvC4Ud3SFK7joueW4TRJN9M7ifzwwL8R/znJtJ2hgJmaYEI5dAPwE9qEanc8mQgcFO3j/NvLBjNL8hQ4UvwohJZi1fp2HMmDrm9KhX6Bw1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFMEUXjP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc82e38c10so10605615a12.3;
        Wed, 05 Feb 2025 04:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759968; x=1739364768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyEbgL/DE3XaQNmV45jqJ+6PRNx/4WLm+5/Q7HMMYbM=;
        b=YFMEUXjP6oAp9ViG6Ee/Xlu02HBxAqagfQurU4njnVxmZdcUledbbYBLF5oanBnK71
         6LKZfrZm9IFBhFis1IVJFhPpWhuV7v6nhbtD1y6RwvNj4wEcashHXONWownMcx65AbmG
         LNspU4RFvLIFX4x7Pkpk5V6etyTv05nYl5B5RFii66KxpuVXOj558CZtagEK0RzRfCP6
         kUyPq40zwaIJqCAaib81L/lpDkhe5vZmrBq9axnQwEh9orqYkf0iSVVu1Vs/hKxvHgQk
         W7C7AwQPmwj428/dXgC6LRGbHe6bZ39aoIldp8lU4+5NMPDq04MedS+oPkxoKeoQ6LDL
         8Ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759968; x=1739364768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyEbgL/DE3XaQNmV45jqJ+6PRNx/4WLm+5/Q7HMMYbM=;
        b=FW95vXHl9dBPkq+Rkp+iQMRemWpzah4ngU+Vl5JIvw3zJHP05TjLl8UkuR927hbVVM
         l6zcjua420tuF5lSzSTqgwMk9cX08Gk75ImleLwECBysHyWr84op0UjZ2zNfJpNRXy99
         udPkqwyOoVJdsOij9IN+V2Bxlp7FGLLbu3yPqmgxuaZc5VGXCivnnt0m5NqN+jXB/Za6
         zfNKAD7FD0Ke4gpaLMPvu75x3OPlQ38tkfTOpM9vCmCbBNsboVEso5i5yPsbILh8xaIo
         eLS7fjI+wvpp/ZbhUQ+HDhFCCn2m7Mt6AbxFBPn7jeYw8lmjy7j92068BE+aOabudha5
         Fh0g==
X-Forwarded-Encrypted: i=1; AJvYcCVVgQAzAM9Pu35xvz4sU0ZhQa9ghZXfSNf7DcXIaHS5HPPLOW7MREQK9kLQ6s4fVG+FEsgapgPBQVIaug==@vger.kernel.org, AJvYcCW6yXcmy3snm8oUX/HdSOkProevTA08ncPWF/MMUZyEN8SU0wiur/xaqgyBVDSnAUxffvVJjj2GP1I=@vger.kernel.org, AJvYcCWtdwGhlS5nT6ObXfdGGdky4UyceP3as6+l3LroU4I9KJCtpSOLZaqhUkysn2AzHh3JKngs7GuITgGT@vger.kernel.org, AJvYcCXMwAF9OcfTw9CXJe0ImRn6aW1hxQeMdhdBU+pQIFBftqhJ+ivgTXCkI32XIitjiaquxTa/Mx8D4mws@vger.kernel.org, AJvYcCXv2U6UD2MeEQopsYZrbjRuBUUJw29Svkw85jIdtupcCI2auwfEm03Ih0e3SntUVaXVMMFG/5w2ZqPKh73u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QUp9NFsOUTpBQkJ04IFSKI+ukcTv4KFzEnU1dDy0pRTWJNgr
	F7tRUDqqhZz3g3BsFZ3nO6o4tYcy9VrnJkRFbLnmKehhv0WV+4xp
X-Gm-Gg: ASbGncufqel68JkmTGZisGtp2bkefI+A5u/nGwuUWSPRc5jQD/TxO4GMeEKwGMpjwWD
	y2sYk0WOg0MdrN0Jexur+6ggbflGo3xlHjBPiCg39vdesJ5+7Y2ttAlGSF3Y6KHFNGNKHcuscWZ
	SLQfWSAIimCkbzyXDTujuDvpptq8h3XLkcU4oJqT4B8083MhAASzj9NzdXiGOLe5sID5u7JV/VJ
	oQmbBmqxVrf/kn2TtHRI2m8IsxKtRSwl1vmvfIS51KtrI0d8dXpu2vhPOqRWKzmVzAYKTUuVbYN
	Wt5cftzmYe+9JMetkyKZB3qKc/ejqL0bUGUzQMKSbS3zHw==
X-Google-Smtp-Source: AGHT+IETUIvDkqTKdY7k2714QPYM3xUPceBcb2unO/nI5NYhZ4IV4FRiMa6FjOclLKPwMVNHsxzJ0A==
X-Received: by 2002:a05:6402:358d:b0:5d0:cfad:f6c with SMTP id 4fb4d7f45d1cf-5dcdb764604mr2738652a12.21.1738759967460;
        Wed, 05 Feb 2025 04:52:47 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:46 -0800 (PST)
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
Subject: [PATCH v2 10/10] ARM: dts: sun8i: add DTS file for yuzuki-lizard V851s
Date: Wed,  5 Feb 2025 13:52:25 +0100
Message-Id: <20250205125225.1152849-11-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205125225.1152849-1-szemzo.andras@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yuzuki-lizard is an Open Hardware board based on Allwinner V851s SoC. Add a basic dts for it.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 arch/arm/boot/dts/allwinner/Makefile          |   1 +
 .../boot/dts/allwinner/sun8i-v851s-lizard.dts | 196 ++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v851s-lizard.dts

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index 48666f73e638..af84073f6a51 100644
--- a/arch/arm/boot/dts/allwinner/Makefile
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -260,6 +260,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-v3-sl631-imx179.dtb \
 	sun8i-v3s-anbernic-rg-nano.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
+	sun8i-v851s-lizard.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb \
 	sun8i-v40-bananapi-m2-berry.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
diff --git a/arch/arm/boot/dts/allwinner/sun8i-v851s-lizard.dts b/arch/arm/boot/dts/allwinner/sun8i-v851s-lizard.dts
new file mode 100644
index 000000000000..180d10b1a06a
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-v851s-lizard.dts
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+// Copyright (C) 2024 Andras Szemzo.andras@gmail.com>
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "sun8i-v853.dtsi"
+
+/ {
+	model = "Yuzuki-lizard";
+	compatible = "yuzukihd,lizard", "allwinner,sun8i-v853", "allwinner,sun8i";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+	    reg = <0x40000000 0x4000000>;
+	};
+
+	reg_vcc: vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_vcc_1v8: vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_usbvbus: usbvbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbvbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	reg_vcc_3v3: vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	reg_vdd_cpu: vdd-cpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		status_led {
+			linux,default-trigger = "heartbeat";
+			label = "led:red";
+			gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 4 6 GPIO_ACTIVE_LOW>; /* PE6 */
+	};
+};
+
+&dcxo {
+	clock-frequency = <24000000>;
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu>;
+};
+
+&pio {
+	vcc-pa-supply = <&reg_vcc_3v3>;
+	vcc-pc-supply = <&reg_vcc_3v3>;
+	vcc-pd-supply = <&reg_vcc_3v3>;
+	vcc-pe-supply = <&reg_vcc_3v3>;
+	vcc-pf-supply = <&reg_vcc_3v3>;
+	vcc-ph-supply = <&reg_vcc_3v3>;
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_ph9_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "spi-nand";
+		spi-max-frequency = <75000000>;
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "awboot";
+				reg = <0x00000000 0x00020000>;	/* 128K */
+			};
+
+			partition@20000 {
+				label = "dtb";
+				reg = <0x00020000 0x00020000>;  /* 128k */
+			};
+
+			partition@40000 {
+				label = "kernel";
+				reg = <0x00040000 0x00800000>;  /* 8MB */
+			};
+
+			partition@840000 {
+				label = "rootfs";
+				reg = <0x00840000 0x077c0000>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_ph11_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	broken-cd;
+	disable-wp;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	xr829: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <4 7 IRQ_TYPE_LEVEL_HIGH>; /* PE7 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus-supply = <&reg_usbvbus>;
+	usb0_id_det-gpio = <&pio 4 9 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
-- 
2.39.5


