Return-Path: <linux-pm+bounces-14232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FFA978DE8
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B695B28D08A
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A26189539;
	Sat, 14 Sep 2024 05:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j97NTvXo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3F189508;
	Sat, 14 Sep 2024 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291589; cv=none; b=IsCT1wpAeYiuKe2TR/Yef1Cjis4afau5EwxYp9b1a1a5rTJY+z4XZjeIF0MvFYV3RBeu1fabIsn687V0l3bBfo3hkSem6nxmmKSHR2CItWZEGNrQZfc0dr5Jssoxp1wtYVv6mDhCPUjwqiAzWrrvfxhBRBKMm8Wk4Ss25XH3Qtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291589; c=relaxed/simple;
	bh=T5bc+2EEMpwWR9gMnt+KgpPAx4FmWo1Gg77h6CWR+yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOupCzYuNtBe8drhw5hXaO7sM4WazXutBe6HfLdmpJJyYHEyZ93BN2C2jJj4YOS3AIUelAcjLCWC2iXhKC99SUQNB2kbj0bTpHm7x+v7RLaXz5qwfWaimsvB9T4RQylZDMyxN7ZOTQHnGQMmJ0bJZS7nJ7UIj8qvXCbpx+XXqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j97NTvXo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71923d87be4so1243366b3a.0;
        Fri, 13 Sep 2024 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291586; x=1726896386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wlvrz0d4Sg9n0wIu368n1nhmE+F0zH2AADRG128tbs=;
        b=j97NTvXoa30G5EzoIRryfGSwQwH42i28P5MprZDDjbDu9h6zZdAnT4Urq7l99ds3xJ
         cszGSBdnJO+k4VVGTKayiark+XXpMs5BRDROT+unqf+z+UIeQ4eCSdSowja0zJ9POGFz
         WksdOfTL/hU8di/UxD1KkmpG3uGanpxQ0TtVwgj8+9jpV1y7p48+s25gE3yaG58ALIrC
         AgsmMI+eJmxNWK5tldxOgzZJDhIrYDBfXhQlIoe5OEwBwH/nmVMqfb80KLqrXE9AdWdo
         WoRsUQo/+XDTe1Akr1uH8V6XnMKEed5J1u5A1caowP0ObYlmMI9rQ+Hsi/rtfw4kZ4Ry
         itNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291586; x=1726896386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wlvrz0d4Sg9n0wIu368n1nhmE+F0zH2AADRG128tbs=;
        b=DIPVSCuri18XIwEXtZVOwS3z4lxE3rYfcvsahdPKgYyPc8OV+0sPJsb2M28yAYJmb6
         ZvPJ8hOvu7SeSM5HzCbkwo0qH/pk7j8032V+z9BSA2PcqPP+BMi43m3ghMNGROR35u2/
         ppqol0LEYdIL/UpEmpYQZE9ZPC2LtLuePPTTDK/ELgE3+Ct+r6Kmoac/dkzM3M/lAHLE
         78hXFJ1ENmggZG9qQ16cNf380libadFMyiPv76qNwNBXZ4X7oqTeS2U2mzks2+udzqZZ
         /xqnIf0DcKbXBfriwYAvWPYJ2RC+W/+tZuOEXIWLOkdUO17PDDgKDEf+lGrJhiOTN8yt
         NbGA==
X-Forwarded-Encrypted: i=1; AJvYcCUszFvb2IVWVJfkOsaIYBw/gxWEmg5Nd/KJhKlF0MGDJitjQIPT6APJ+jbPgp38sfHVdCXoFppEMcVLxnVU@vger.kernel.org, AJvYcCVjUyzeY1mAmUc6DbqKy2MrGhMUP1QnR7zgvaJK7Ezoi7pqzVrBm7F25oJu8SZh7JT6BYAT0kV8/Um8@vger.kernel.org, AJvYcCVuj8seFscXPN56HgvM8ibExkqa8llYxDivBbz3a92XcabGpms4yP4NEIHwvfyllEoV1maFhTP8IlBYwVT/b9Y=@vger.kernel.org, AJvYcCWO+41CQarJIjwHaKIw1mhVuJp9h7hIABfTlmhUVomhc7F3kIZb63cTWNI7gzCJlyi5sktrPMexez8IwQ==@vger.kernel.org, AJvYcCWl7MTm0Z2YiI0dHRxcOD3p26zfQ2roMND3XAc9Q8p0EZbY+LZWd713de40GTEgQ7U0OKh7LHcPcuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/quLfqowcXNqwQzQgJBzu+mkHXmfoEzJyxabIZcBiOtyO4ce
	+T7hGL0hSRQwpRSDbLYWBTF/5eaKAdDnzmzIZypUNUN9E+dBp7MN
X-Google-Smtp-Source: AGHT+IFc4fH2nFu3QAZU4F1o0SdC90vp2m1DHboqB5mKYnsNIFLa42id2xQG61BHJUBbQdTvtRNy/A==
X-Received: by 2002:aa7:88cd:0:b0:718:dd1e:de1a with SMTP id d2e1a72fcca58-71936b42d60mr7958431b3a.28.1726291586345;
        Fri, 13 Sep 2024 22:26:26 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:26:26 -0700 (PDT)
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
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 16/22] arm64: dts: apple: Add A9 devices
Date: Sat, 14 Sep 2024 13:17:25 +0800
Message-ID: <20240914052413.68177-20-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240914052413.68177-1-towinchenmi@gmail.com>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konradybcio@kernel.org>

Add DTS files for the A9 SoC and the following devices based on it:
- iPhone 6s
- iPhone 6s Plus
- iPhone SE (2016)
- iPad 5

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP, m1n1 and AOP pinctrl support]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile         |  10 ++
 arch/arm64/boot/dts/apple/s8000-j71s.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8000-j72s.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8000-n66.dts    |  15 ++
 arch/arm64/boot/dts/apple/s8000-n69u.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8000-n71.dts    |  15 ++
 arch/arm64/boot/dts/apple/s8000.dtsi       | 178 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/s8003-j71t.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003-j72t.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003-n66m.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003-n69.dts    |  15 ++
 arch/arm64/boot/dts/apple/s8003-n71m.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003.dtsi       |  19 +++
 arch/arm64/boot/dts/apple/s800x-6s.dtsi    |  52 ++++++
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi |  46 ++++++
 arch/arm64/boot/dts/apple/s800x-se.dtsi    |  52 ++++++
 16 files changed, 507 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j71s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j72s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n66.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n69u.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j71t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j72t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n66m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n69.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n71m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-6s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-se.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index adda522ea490..cbb7e409b7e3 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -18,6 +18,16 @@ dtb-$(CONFIG_ARCH_APPLE) += t7000-n56.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7000-n61.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7001-j81.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7001-j82.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-j71s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-j72s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-n66.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-n69u.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-n71.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-j71t.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-j72t.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-n66m.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-n69.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-n71m.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/s8000-j71s.dts b/arch/arm64/boot/dts/apple/s8000-j71s.dts
new file mode 100644
index 000000000000..b5a2dfa1121e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-j71s.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Wi-Fi) (Samsung), J71s, iPad6,11 (A1822)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j71s", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPad 5 (Wi-Fi) (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-j72s.dts b/arch/arm64/boot/dts/apple/s8000-j72s.dts
new file mode 100644
index 000000000000..8f3dea5adb09
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-j72s.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Cellular) (Samsung), J72s, iPad6,12 (A1823)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j72s", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPad 5 (Cellular) (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-n66.dts b/arch/arm64/boot/dts/apple/s8000-n66.dts
new file mode 100644
index 000000000000..30b4b6630b60
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-n66.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6s Plus (Samsung), N66, iPhone8,2 (A1634/A1687/A1690/A1699)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n66", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPhone 6s Plus (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-n69u.dts b/arch/arm64/boot/dts/apple/s8000-n69u.dts
new file mode 100644
index 000000000000..e63bc2e7f7c1
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-n69u.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone SE (Samsung), N69u, iPhone8,4 (A1662/A1723/A1724)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-se.dtsi"
+
+/ {
+	compatible = "apple,n69u", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPhone SE (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-n71.dts b/arch/arm64/boot/dts/apple/s8000-n71.dts
new file mode 100644
index 000000000000..f2964a1fc434
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-n71.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6s (Samsung), N71, iPhone8,1 (A1633/A1688/A1691/A1700)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n71", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPhone 6s (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000.dtsi b/arch/arm64/boot/dts/apple/s8000.dtsi
new file mode 100644
index 000000000000..18488f71a5c8
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000.dtsi
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple S8000 "A9 (Samsung)" SoC
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
+			compatible = "apple,twister";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "apple,twister";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
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
+			interrupts = <AIC_IRQ 192 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		aic: interrupt-controller@20e100000 {
+			compatible = "apple,s8000-aic", "apple,aic";
+			reg = <0x2 0x0e100000 0x0 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl_ap: pinctrl@20f100000 {
+			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x0f100000 0x0 0x100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 208>;
+			apple,npins = <208>;
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
+			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
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
+			interrupts = <AIC_IRQ 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 119 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wdt: watchdog@2102b0000 {
+			compatible = "apple,s8000-wdt", "apple,wdt";
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
+		/* Note that A9 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+/*
+ * The A9 was made by two separate fabs on two different process
+ * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
+ * the S8003 (APL1022) on 16nm. While they are seemingly the same,
+ * they do have distinct part numbers and devices using them have
+ * distinct model names. There are currently no known differences
+ * between these as far as Linux is concerned, but let's keep things
+ * structured properly to make it easier to alter the behaviour of
+ * one of the chips if need be.
+ */
diff --git a/arch/arm64/boot/dts/apple/s8003-j71t.dts b/arch/arm64/boot/dts/apple/s8003-j71t.dts
new file mode 100644
index 000000000000..0d906ae80b07
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-j71t.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Wi-Fi) (TSMC), J71t, iPad6,11 (A1822)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j71t", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPad 5 (Wi-Fi) (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-j72t.dts b/arch/arm64/boot/dts/apple/s8003-j72t.dts
new file mode 100644
index 000000000000..0cd7d88e9dfb
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-j72t.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Cellular) (TSMC), J72t, iPad6,12 (A1823)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j72t", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPad 5 (Cellular) (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-n66m.dts b/arch/arm64/boot/dts/apple/s8003-n66m.dts
new file mode 100644
index 000000000000..4146cd28160d
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-n66m.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6s Plus (TSMC), N66m, iPhone8,2 (A1634/A1687/A1690/A1699)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n66m", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPhone 6s Plus (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-n69.dts b/arch/arm64/boot/dts/apple/s8003-n69.dts
new file mode 100644
index 000000000000..8eed879b155e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-n69.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone SE (TSMC), N69, iPhone8,4 (A1662/A1723/A1724)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-se.dtsi"
+
+/ {
+	compatible = "apple,n69", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPhone SE (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-n71m.dts b/arch/arm64/boot/dts/apple/s8003-n71m.dts
new file mode 100644
index 000000000000..7ec6d2cda0bf
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-n71m.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6s (TSMC), N71m, iPhone8,1 (A1633/A1688/A1691/A1700)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n71m", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPhone 6s (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003.dtsi b/arch/arm64/boot/dts/apple/s8003.dtsi
new file mode 100644
index 000000000000..52094a634678
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple S8003 "A9 (TSMC)" SoC
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "s8000.dtsi"
+
+/*
+ * The A9 was made by two separate fabs on two different process
+ * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
+ * the S8003 (APL1022) on 16nm. While they are seemingly the same,
+ * they do have distinct part numbers and devices using them have
+ * distinct model names. There are currently no known differences
+ * between these as far as Linux is concerned, but let's keep things
+ * structured properly to make it easier to alter the behaviour of
+ * one of the chips if need be.
+ */
diff --git a/arch/arm64/boot/dts/apple/s800x-6s.dtsi b/arch/arm64/boot/dts/apple/s800x-6s.dtsi
new file mode 100644
index 000000000000..b5610258da25
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s800x-6s.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6s / 6S Plus common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	chassis-type = "handset";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 96 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 97 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 67 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 66 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl_ap 149 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi b/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
new file mode 100644
index 000000000000..a831131f16f3
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	chassis-type = "tablet";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 96 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 97 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 143 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 144 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/s800x-se.dtsi b/arch/arm64/boot/dts/apple/s800x-se.dtsi
new file mode 100644
index 000000000000..3699114188a8
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s800x-se.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone SE common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	chassis-type = "handset";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 96 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 97 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 67 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 66 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl_ap 149 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
-- 
2.46.0


