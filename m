Return-Path: <linux-pm+bounces-13999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CACC974D52
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D5288AD8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10D18FDB7;
	Wed, 11 Sep 2024 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQTQZg5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB318FDD5;
	Wed, 11 Sep 2024 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044486; cv=none; b=fecNtohbhrqE/hyRBDdEq7fRMfFQ9XpIIgjV4M2uFHXNSVSvyor5+QVgFGWLebIafoe3R+DOFL3TTWxS2ZNMLEXb2ZH5PULP/XkldSzDIUliv3Yf9cGedtZBN2P9h3GdyewCsCBUhImWPvqmV4+KGU+Bdiz4vRxhJj1ha6JVN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044486; c=relaxed/simple;
	bh=p5B0nMUiXk2Nf+hW1bJbdvVrjX73VjTxc8JQ2izCgko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYw0c35YKI76SEv3L6f7xs5XPSj5h/X7BQeidxLPmxjM/jVhrr2ALrdTmfr+8suVlHfeHgMzx+0J9aN4d0ZlnnSZTYftECDIw+oyvZZ6XyqjtDfcEvZQTVal6EtH+wwFQCFu+t7f+AT74ayfTGCvc/Q++Na2TF/XwiH7fLR8vBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQTQZg5G; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7191df6b5f5so200452b3a.0;
        Wed, 11 Sep 2024 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044483; x=1726649283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMPbclYCNFGi9JPTCNBzyfzCwz/gwpnCEGb6ZlMwvTo=;
        b=eQTQZg5GSFo2CkiwIPTloH7ulDgUGdrg6cGHn5uQOQgG/kylckB3LhTZ/+FxOp1JAt
         H4S/yK0GkpZu/u1mHVDYdoKMKdRvddxxqN+yo1fxuO0LlvItWfYbuPXFGn8GQZWkcDwf
         +qLMdaZWSfURCO+qcXpr+2keLdLJZXDcB1HN9zKmTO00wQHYovSkQY7vnYHO1wokk/Ya
         YDqikenHQo4QTQZwmOnkBxSgT5Mk2T5Y6c6xQiH8+Curul39dKCpeEX9XfOhps3NZS1O
         d9H+vvvA+V2J9XI4wIU+d0f/2eQOeAXV/6qT9YHtbaxEpRgLqjbGeHQg9d9Nxg72rX9i
         psNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044483; x=1726649283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMPbclYCNFGi9JPTCNBzyfzCwz/gwpnCEGb6ZlMwvTo=;
        b=creSyfiHZihoUzPPr0C+POoMNHRP8jXEj+Ni+HPTa7rLhCK+ktFT+qMqA7RVRX7aNP
         ZWgPQXvDNQTORLLYzLBLW8vWQgf/9qctMGKQ2cNF7z1HGJrQx6ViIRp/of2Ra2+zCAJ+
         n4qrjXx1/GKlvTmZHw0irGz2IDIPwNJ7uprHtz92Sjjz9q0VCwsPlAh0ms3KNuu8ov3f
         OEaRse09cOOgCkaPvT7/8aWK5ngk+U7ui7YxzWeogDfIxB9+Si+Ge0CsMUD+3fnuCVde
         iqqkWHlvzsHA2ZYJ/wjkwcEhfBxdhIEGyGp3j3Dq6HUR0VTBAW/gYFchwdIAk784ThUz
         t4zw==
X-Forwarded-Encrypted: i=1; AJvYcCV0FvN5wtpB+QRHBYS+9JjqU0x6lFWXhsmx4wWpHb8A7lh7zdgR3N30YkGWf+3WUlluRrypQbhrM6a36Q==@vger.kernel.org, AJvYcCVKFktveLt6vQFyD2+3MIOcTRVx2ZZaca5iEr3k6MCUwcHMjJpYo6VakzQNqpQirP8xpWd/S/qD2xFPCfL081E=@vger.kernel.org, AJvYcCVxplQbOmeiS9DvssDKlVDS8NhX9KVdTghHVWTFDcgZgFGTD8kF8PcuK0ASb1ko2mngu9/cMjBz+cQDJjM0@vger.kernel.org, AJvYcCWsCKOQOnHw/lx0+2vmrH85t+A0DCMJOALp6lome0poM+pl4VmUa1MjoiIW3m90/cywY8O7MYgKHew=@vger.kernel.org, AJvYcCXvjepsIj3rsTohnRwo4OtJICNueNkGEzK5xAbk3gcrhjRsMQx2klMFCe+0K95BQ7nI5nGg1ApvISJK@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgkLrJUVRBNgtOnj51vitbIvNkKhIHDNH/U0DZm/Oke5Bob4b
	vcyRydyoH5QDa6zmoDRIHWg/tVfJkEs9TNUeoiflM8ElF02Rc/jg
X-Google-Smtp-Source: AGHT+IE7AZsL3FZQaBv1lAqTrdgFMdmNnJVT3hulpenmeXW2swQpgA3XrR6DOc91ih2n0zjawEEIKw==
X-Received: by 2002:a05:6a00:1993:b0:70e:a42e:3417 with SMTP id d2e1a72fcca58-718d5e189bbmr25371924b3a.10.1726044483465;
        Wed, 11 Sep 2024 01:48:03 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:02 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 15/22] arm64: dts: apple: Add A8X devices
Date: Wed, 11 Sep 2024 16:41:05 +0800
Message-ID: <20240911084353.28888-17-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konradybcio@kernel.org>

Add DTS files for the A8X SoC and the only device based on it, the iPad
Air 2.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Ivalyo: system memory bits]
Co-developed-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
[Nick: SMP, m1n1 and gpio-keys support, pinctrl fixes]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile        |   2 +
 arch/arm64/boot/dts/apple/t7001-air2.dtsi |  44 +++++++
 arch/arm64/boot/dts/apple/t7001-j81.dts   |  14 ++
 arch/arm64/boot/dts/apple/t7001-j82.dts   |  14 ++
 arch/arm64/boot/dts/apple/t7001.dtsi      | 154 ++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j81.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j82.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index d5dd1e2e4f4c..adda522ea490 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -16,6 +16,8 @@ dtb-$(CONFIG_ARCH_APPLE) += t7000-j97.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7000-n102.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7000-n56.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7000-n61.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7001-j81.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7001-j82.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/t7001-air2.dtsi b/arch/arm64/boot/dts/apple/t7001-air2.dtsi
new file mode 100644
index 000000000000..2c84de4c418a
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7001-air2.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Air 2 common device tree
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t7001.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl 92 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl 93 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7001-j81.dts b/arch/arm64/boot/dts/apple/t7001-j81.dts
new file mode 100644
index 000000000000..ca90dc0c872c
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7001-j81.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Air 2 (Wi-Fi), J81, iPad5,3 (A1566)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7001-air2.dtsi"
+
+/ {
+	compatible = "apple,j81", "apple,t7001", "apple,arm-platform";
+	model = "Apple iPad Air 2 (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/t7001-j82.dts b/arch/arm64/boot/dts/apple/t7001-j82.dts
new file mode 100644
index 000000000000..d9fd16f48db7
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7001-j82.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Air 2 (Cellular), J82, iPad5,4 (A1567)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7001-air2.dtsi"
+
+/ {
+	compatible = "apple,j82", "apple,t7001", "apple,arm-platform";
+	model = "Apple iPad Air 2 (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/t7001.dtsi b/arch/arm64/boot/dts/apple/t7001.dtsi
new file mode 100644
index 000000000000..9a5f0a4bde52
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7001.dtsi
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T7001 "A8X" SoC
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ * Based on Asahi Linux's M1 (t8103.dtsi) and Corellium's A10 efforts.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+/ {
+	interrupt-parent = <&aic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+		};
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "apple,typhoon";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "apple,typhoon";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu2: cpu@2 {
+			compatible = "apple,typhoon";
+			reg = <0x0 0x2>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0 0>; /* To be filled in by loader */
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * The bootloader reserves a region for the (varying-address, depending
+		 * on what FW your device runs AND model) framebuffer under this node.
+		 */
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		nonposted-mmio;
+		ranges;
+
+		serial0: serial@20a0c0000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x0a0c0000 0x0 0x4000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 158 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		wdt: watchdog@20e027000 {
+			compatible = "apple,t7000-wdt", "apple,wdt";
+			reg = <0x2 0x0e027000 0x0 0x1000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		aic: interrupt-controller@20e100000 {
+			compatible = "apple,t7000-aic", "apple,aic";
+			reg = <0x2 0x0e100000 0x0 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl: pinctrl@20e300000 {
+			compatible = "apple,t7000-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x0e300000 0x0 0x100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 184>;
+			apple,npins = <184>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 68 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt";
+		/* Note that A8X doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


