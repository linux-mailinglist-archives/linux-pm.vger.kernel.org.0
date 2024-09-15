Return-Path: <linux-pm+bounces-14310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5D9795A6
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2828A28833A
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883F153808;
	Sun, 15 Sep 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYkfdLQM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBA1509A5;
	Sun, 15 Sep 2024 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387779; cv=none; b=FwLm5A/f0F3E6/6CI9c7ISSVCV+sXAy5CtfHhNjRWwtJ1NQE8DgWPKbtiPsV6Qj4j1XLiVJ0/s6HL3Rsiv2XvGPqaNs4wfnOlqTTw9/qbqhF7qaYwziazZDZK1TvmvKSeRhwMGXqhndzRVDo6dARpGMfwyfUacyiYfXbKnofjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387779; c=relaxed/simple;
	bh=HHvgVvFPWRjidvUMCkK1Nupat0J09Z8Qrv63xgKUIDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL8l2uVvU64ZD50OXqzzbcMFgpUVZCU17oclVE3mVYX+DsQ9zbGllVWa7KHSRj86N4975Bl/4OJFQHJLQBS0BcLY9S2m7xoTdwQHEturySPiZqMmOJRVfNyRSUVfCTMF2BlDd1Lo/Yll+IsnS5tS7jbrGGrJcqVN5O1au4AaVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYkfdLQM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc47abc040so28093595ad.0;
        Sun, 15 Sep 2024 01:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387776; x=1726992576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ8eeyP2xvo9Prgib1JUIv8xlFgy/EeVZhebgg6pBd8=;
        b=bYkfdLQMb+W+7KWcyCssT1WKDIVFk1a5SzPMYBK2Fvgqo8NEs46jl1eec/9jiBklUL
         +RUUHFaR0VHgc8I34sp1t6o6Enxo8IkNNVUqNPA78SoRiakF+i9vvTpr3NLeu4PwYN19
         YWY6Duxr8InZK6Ga1xmjWkUaBFlykSl4NcFEPs2iNaImgD+qBdqv/9E79AVPnNotQcgV
         QJvX7MktpPGZjEe7D8xyZRIk+yY8Kd8vCuYfCwCNXx8vw+XCOWY4Ab/IVpegdaoiReDG
         qlk9U62nv9l/zfOyyRobWSYE2qZcppS5j2+jfdZfge2w7IN8g5+TlDzn97d1PTCW3wFl
         IQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387776; x=1726992576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ8eeyP2xvo9Prgib1JUIv8xlFgy/EeVZhebgg6pBd8=;
        b=wuc6vhUuysJohOXDvku+KCdQX64UbvN65XOHrD5IL4/60rb2vnsKVPFPOs6fy9TJ6a
         hPejux42pq+Fn2NXodUkxFxsXpZRrBOBjDAWwSS3P936uoGmyduDpAFdr8pS8rMq11WI
         QaTQH20wFA5WwzoJbFdxYd6kFN2H+0Ebwlo/07b8E1d/2qdyu+fmX46asz8xp0o9gr7v
         UbHGYOw+oP86s7iewWzhsWOxv6net2EtPVuJ6kGhTFys9CoF1T7ptmPaJxT8SA7hO7cT
         cppgbAB1QewE8w/HXWIpntyIvUzktcECkqMthxgJvjdj5NIeWcWGlM5oEQxuBIPPT1qo
         Y80Q==
X-Forwarded-Encrypted: i=1; AJvYcCUchLgbEb5fUSFfXhyiTSO5G/MuNNWTn8OQGSvfEtKNRZxTbxDqE7Nhs/xB2SKk/dZQH+4+D5YeOlLrbGri@vger.kernel.org, AJvYcCUrvf433CHTVdQW9O+lN58r2tBYhXvqUowFk245cIvCRCL+eNhVAOu3L6u4bLHcNJvzoAOzXblTunI=@vger.kernel.org, AJvYcCUuWz8njmR5QEBlNqtH1KZN68SBPvvpzzm8Jvb7BOl5df/ti0mXagM6N8/Lx2mZJs61L07ILkwmIZXte9Voy3c=@vger.kernel.org, AJvYcCWrOE20VOFrtWkFQe/ZxN01vVsr6NVNxvjYYSfKGPEKWprDR/p4rluajsPAfahtdVsvJFN7LVVSftkb@vger.kernel.org, AJvYcCXw0H64/h6SgG70mCkWi1sAKrI08aCwNMP8Mp74OsBqwSMgzQnD9dYIl9isKZ/Zg7O9FouRIN5rcsgj2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKr+h4a/sJGF+AHpaTMA/MR0JNLb+1isHdshy5DTAOghcaIrkS
	2+7kihCjMWSqq3LL2GM9sjyP++CXQi3upLVjTPdPem57+9gU12E4
X-Google-Smtp-Source: AGHT+IGOQTZPe5BCJEbxvvQq8f2wItHxNU+92r7VY6nWGFIvf+cjeMkJJSRz44gFxatuhWHrSAgoiA==
X-Received: by 2002:a17:902:ea0b:b0:206:ae0b:bfb6 with SMTP id d9443c01a7336-2076e412914mr154026745ad.40.1726387776385;
        Sun, 15 Sep 2024 01:09:36 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:09:36 -0700 (PDT)
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
Subject: [PATCH v3 18/20] arm64: dts: apple: Add A10X devices
Date: Sun, 15 Sep 2024 15:59:03 +0800
Message-ID: <20240915080733.3565-19-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915080733.3565-1-towinchenmi@gmail.com>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
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
 .../devicetree/bindings/arm/apple.yaml        |   8 +-
 arch/arm64/boot/dts/apple/Makefile            |   5 +
 arch/arm64/boot/dts/apple/t8011-j105a.dts     |  15 ++
 arch/arm64/boot/dts/apple/t8011-j120.dts      |  14 ++
 arch/arm64/boot/dts/apple/t8011-j121.dts      |  14 ++
 arch/arm64/boot/dts/apple/t8011-j207.dts      |  14 ++
 arch/arm64/boot/dts/apple/t8011-j208.dts      |  14 ++
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |  47 +++++
 arch/arm64/boot/dts/apple/t8011.dtsi          | 175 ++++++++++++++++++
 9 files changed, 302 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j105a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j120.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j121.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j207.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j208.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pro2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011.dtsi

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index db32bda29336..dc9aab19ff11 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -204,10 +204,10 @@ properties:
         items:
           - enum:
               - apple,j105a # Apple TV 4K (1st Generation)
-              - apple,j120  # Apple iPad Pro 2 (12.9-inch) (Wi-Fi)
-              - apple,j121  # Apple iPad Pro 2 (12.9-inch) (Cellular)
-              - apple,j207  # Apple iPad Pro 2 (10.5-inch) (Wi-Fi)
-              - apple,j208  # Apple iPad Pro 2 (10.5-inch) (Cellular)
+              - apple,j120  # iPad Pro 2 (12.9-inch) (Wi-Fi)
+              - apple,j121  # iPad Pro 2 (12.9-inch) (Cellular)
+              - apple,j207  # iPad Pro 2 (10.5-inch) (Wi-Fi)
+              - apple,j208  # iPad Pro 2 (10.5-inch) (Cellular)
           - const: apple,t8011
           - const: apple,arm-platform
 
diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 4a7002e289a0..a44c14fae7bc 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -41,6 +41,11 @@ dtb-$(CONFIG_ARCH_APPLE) += t8010-j172.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8010-j71b.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8010-j72b.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8010-n112.dtb
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
index 000000000000..4efd02725963
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-j105a.dts
@@ -0,0 +1,15 @@
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
+	chassis-type = "television";
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
index 000000000000..9f681dd9d463
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8011-pro2.dtsi
@@ -0,0 +1,47 @@
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
+	chassis-type = "tablet";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 139 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
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


