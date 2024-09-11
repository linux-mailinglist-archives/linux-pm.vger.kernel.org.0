Return-Path: <linux-pm+bounces-14003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8F974D68
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB07A1C2206B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CC19C57A;
	Wed, 11 Sep 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ2qknB/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70518192D74;
	Wed, 11 Sep 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044505; cv=none; b=uMVEM+DEBAjfqFzA1NDDSRvmcGhOdBCziff+UFxSUjpbrHHzNPTcG461sCLPOGtXRDYLsqiruxdedhiL838Z6rJzX/uDGmCU5I/0dJenVo6SBOdY35jLY5nIT6P3EdgQCYFrBJj7C2EdIknqFsljvc1LknVzp253k9b1u4x1StA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044505; c=relaxed/simple;
	bh=kKnGjGer0GpkYv971Vx+n2KUjPkmTn3uhC9c1BtrCuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmSjFbcnz+l1tBjBqNm9oyOdvJu0mtIXXop1Y3Gy5ONihL3swGRWq/adqzos9kqEVPXToqltbGFJ4wraW3hONHZ/Zhoeejrr5JoPOkRfwEywRqiiAHaZ4MbOP+uh487ODoZ1Z43Coivaq1ieesQqNqOiLXjyBnEimVUnr1v0SEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ2qknB/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718f28f77f4so1569743b3a.1;
        Wed, 11 Sep 2024 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044503; x=1726649303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOWT9ZMaU2LCiTv/nxWqViXuhbjjJ1vEYbojvBCVwlQ=;
        b=dZ2qknB/9Y62WKpC3GAnlsKOrzwP0/mdFyuFnLms96GMU5X8Tt1eYMCrodN74tF8ZY
         +qM9jQ4ppZs8Xf5wKBJsnKgZvfG4ASemhAFMqkUJvQhWCiH95HDXYqFN2LzXZpH4biJt
         Xil2bLCF8maIy2rU8taSDjMTnPO8aSVDFLXinGvbxGUU6oGB+Az5ghNYtdBBNHVEfs0p
         nlmch0U2OL8c1U9t/CZ2eUwuyT/EjjzfRUyXZ1jeD34+spBGvMQOFVO5nnXv+xANXlD+
         x/ksyVV6MwuUIdEJfH0DoOUGZQUV6aAW8oo0AC6ISRy1RVbBa/KB1J3EfiR3thM+x1W5
         1aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044503; x=1726649303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOWT9ZMaU2LCiTv/nxWqViXuhbjjJ1vEYbojvBCVwlQ=;
        b=soot+h/8E5N3L3lcPIAPTF5fq+dbMHvlE+qHSuOIKmpJZqKe2gAjdCt6qFmhJBDTxf
         /LJQqVIwhk84HW2Dh+Q23VS4dR39p+9k+978Prixf6A6EOfqYNhN1xPa/jb90FQ0TG04
         m4sP0nNKdWO/InAj/qOOWX9K3NfPi4Ib53ja1GjoY0KCqqYY7DKmMuFLfpSp6LXX89jm
         ZsgGPBnGg9ow8rGDSdluGE9Oe8docSoqPdhNwKucPkw5ENrksVMH3+1OuPCZIbeVsJCR
         IBts5vX0wP2IFyz9iVeaJ971QDv9iStKMVZMQ3zfgfkk4i2KCMCoqvoTzcS1EoJc8yGs
         6guA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5lxJlNi0xBM93aiH7tMdRnEDTsDor+xEcGm3XH0rqGjb9HX33ztbTgB0qSKZLOXYQBfRwXEbfWzrZZOaP/U=@vger.kernel.org, AJvYcCVLLgzeHN2/H9jPLdCWOM0HW8j+hWLugUoeaqA2u9rO6DipsFmugbntvQYDfZliv2fnxlFwOZ7mEHc=@vger.kernel.org, AJvYcCVZ9mj4/KDnCTmuqqg91SGeSihwAGFI308V71wL3/mzNNLGL3O8Y1o4bJJSvIBweFDkgAydus1n1S2I@vger.kernel.org, AJvYcCWFaArasVZ6Ure3n1RdTo6/RhOTlx8vcWysYMK44M9yIdA97PH9nr7vYKxuC/RbHZS0DPDQjXjay/lqfQ==@vger.kernel.org, AJvYcCWk4QQ51CnGSRulnl66P/blg3vpGnohqtaLZxnJBwEz5dtQUL3ZF4nG9S50UAdgGczqlxzTH0vy6PRM5Zfv@vger.kernel.org
X-Gm-Message-State: AOJu0YwChDJh1izrjmkFUr0Zsz0kKQODepOAFM83hQaKKl3kuL4/YgDM
	qlnYZHBv0ad4AOTteCS3hqQ5/LVPS3S9Kew5CMS73pXgnOsOt4Qk
X-Google-Smtp-Source: AGHT+IHcumzjB2M1Vnz7MRqEeXGs/uqxxwldp20jnsS+ipeHk9CpmUyDzM/MM+S4nNgh1nkaOgciyw==
X-Received: by 2002:a05:6a20:d80c:b0:1cf:3084:feef with SMTP id adf61e73a8af0-1cf62cc24c9mr3610290637.17.1726044502589;
        Wed, 11 Sep 2024 01:48:22 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:21 -0700 (PDT)
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
Subject: [PATCH 19/22] arm64: dts: apple: Add A10X devices
Date: Wed, 11 Sep 2024 16:41:09 +0800
Message-ID: <20240911084353.28888-21-towinchenmi@gmail.com>
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

Add DTS files for the A10X SoC and the following devices based on it:

- Apple TV 4K
- iPad Pro (2nd Generation) (10.5 Inch)
- iPad Pro (2nd Generation) (12.9 Inch)

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP, m1n1 and Apple TV 4K support, uart interrupt and pinctrl fixes]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile        |   6 +-
 arch/arm64/boot/dts/apple/t8011-j105a.dts |  14 ++
 arch/arm64/boot/dts/apple/t8011-j120.dts  |  14 ++
 arch/arm64/boot/dts/apple/t8011-j121.dts  |  14 ++
 arch/arm64/boot/dts/apple/t8011-j207.dts  |  14 ++
 arch/arm64/boot/dts/apple/t8011-j208.dts  |  14 ++
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi |  45 ++++++
 arch/arm64/boot/dts/apple/t8011.dtsi      | 175 ++++++++++++++++++++++
 8 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j105a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j120.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j121.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j207.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j208.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pro2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 4a7002e289a0..be66624aa6e0 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -40,7 +40,11 @@ dtb-$(CONFIG_ARCH_APPLE) += t8010-j171.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8010-j172.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8010-j71b.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8010-j72b.dtb
-dtb-$(CONFIG_ARCH_APPLE) += t8010-n112.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8011-j105a.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8011-j120.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8011-j121.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8011-j207.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8011-j208.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/t8011-j105a.dts b/arch/arm64/boot/dts/apple/t8011-j105a.dts
new file mode 100644
index 000000000000..c12879b4612f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-j105a.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple TV 4K (1st Generation), J105a, AppleTV6,2 (A1482)
+ * Copyright (c) 2024, Nick Chan <towinchenmi@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "t8011.dtsi"
+
+/ {
+	compatible = "apple,j105a", "apple,t8011", "apple,arm-platform";
+	model = "Apple TV 4K (1st Generation)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8011-j120.dts b/arch/arm64/boot/dts/apple/t8011-j120.dts
new file mode 100644
index 000000000000..a620d8aaf468
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-j120.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro 2 (12.9-inch) (Wi-Fi), J120, iPad7,1 (A1670)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8011-pro2.dtsi"
+
+/ {
+	compatible = "apple,j120", "apple,t8011", "apple,arm-platform";
+	model = "Apple iPad Pro 2 (12.9-inch) (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8011-j121.dts b/arch/arm64/boot/dts/apple/t8011-j121.dts
new file mode 100644
index 000000000000..dfec25f7d54a
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-j121.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro 2 (12.9-inch) (Cellular), J121, iPad7,2 (A1671)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8011-pro2.dtsi"
+
+/ {
+	compatible = "apple,j121", "apple,t8011", "apple,arm-platform";
+	model = "Apple iPad Pro 2 (12.9-inch) (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8011-j207.dts b/arch/arm64/boot/dts/apple/t8011-j207.dts
new file mode 100644
index 000000000000..12582bfe7532
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-j207.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro 2 (10.5-inch) (Wi-Fi), J207, iPad7,3 (A1701)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8011-pro2.dtsi"
+
+/ {
+	compatible = "apple,j207", "apple,t8011", "apple,arm-platform";
+	model = "Apple iPad Pro 2 (10.5-inch) (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8011-j208.dts b/arch/arm64/boot/dts/apple/t8011-j208.dts
new file mode 100644
index 000000000000..c0cd18e0ab18
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-j208.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro 2 (10.5-inch) (Cellular), J208, iPad7,4 (A1709)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8011-pro2.dtsi"
+
+/ {
+	compatible = "apple,j208", "apple,t8011", "apple,arm-platform";
+	model = "Apple iPad Pro 2 (10.5-inch) (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8011-pro2.dtsi b/arch/arm64/boot/dts/apple/t8011-pro2.dtsi
new file mode 100644
index 000000000000..3aac97327dfb
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-pro2.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro 2 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8011.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 139 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 138 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 43 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 40 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
new file mode 100644
index 000000000000..e9f7d54893fe
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8011 "A10X" SoC
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
+			compatible = "apple,hurricane-zephyr";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "apple,hurricane-zephyr";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu2: cpu@2 {
+			compatible = "apple,hurricane-zephyr";
+			reg = <0x0 0x2>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0 0>; /* To be filled by loader */
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
+			interrupts = <AIC_IRQ 216 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		aic: interrupt-controller@20e100000 {
+			compatible = "apple,t8010-aic", "apple,aic";
+			reg = <0x2 0x0e100000 0x0 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl_ap: pinctrl@20f100000 {
+			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x0f100000 0x0 0x100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 219>;
+			apple,npins = <219>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 48 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@2100f0000 {
+			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x100f0000 0x0 0x100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 42>;
+			apple,npins = <42>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 130 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 131 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wdt: watchdog@2102b0000 {
+			compatible = "apple,t8010-wdt", "apple,wdt";
+			reg = <0x2 0x102b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt";
+		/* Note that A10X doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


