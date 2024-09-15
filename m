Return-Path: <linux-pm+bounces-14311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0E9795AB
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1541C2178D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03DE1547E6;
	Sun, 15 Sep 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/z8Yxgy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BE152517;
	Sun, 15 Sep 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387783; cv=none; b=tXVlTnq5Z+k1RZL/mnL6oI/KVbJWryjkqEAqYlXjvHZPQjhdFQaNbj2kJOjLYD2R0TtPGkMXM/AgQxgeCIuOGxFWTaG+J3Db5qLkIlfu8oVBAT0x6IPzKpC857f6vAzjKr6Uo/wXj8wTBT3023PiLcjesgEHXmoXiCzsSdvxBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387783; c=relaxed/simple;
	bh=kr1vrgurxiDgbelJLrol7r0IUT65cJqbxjgAKobi8Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGX1d6yvKZH7vFzMSjrF+qH7DesdlfALEyhxbsVe5jDJsWunnFDqO83rlLLcb+Nn7ckR3f0CXuT4lIUEX9NeafpHcn/OeblijLOB4hgOa1crNewihslUfb97DXy0d8qBhSOpcTwY4i//MA9SvVlXM3MPJ5KflxMbGxNbp7pKdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/z8Yxgy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206b9455460so26577055ad.0;
        Sun, 15 Sep 2024 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387781; x=1726992581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4Z1lxT6+fynpf/jmdAXu96saf2Sig4EHn+8sb3FUTw=;
        b=J/z8YxgyIBFpbY6/LaIj6ra95xUBe1hT0Uv14ZbCpR/2GA5v73+ALw9TPMMOhwVURP
         EnP8eNM5KZdR8LkCay+p2poF4ELikGabKmuQn5vrm1ebw8563haEW907T39gdNnCKzRL
         9p7MIbap1NsJBVYA2+sVEpZ9KFS2WIYOavJNh4h5DQoOA/pkVbNqh58DYRL/vEsG4Jz7
         hmRmhemvaaT6NwQ6kbjWdRzN+Cj197zx0G/j+/juiGghUYj1e4v/YRzm+2PPM7uJATP3
         ebBR4aAH2o82qlC8n0G5XdEy77OqpevnOL9yJprgxeViHl1KhRYyDTi/43oWcnsyX1CI
         iFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387781; x=1726992581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4Z1lxT6+fynpf/jmdAXu96saf2Sig4EHn+8sb3FUTw=;
        b=QUnsQUM4t9uhhpwQsHx424OgdqkKebisELhnlA9vJDyRIkTGCD9YOclxJCtGSfwFxi
         76sGAICIipX/57KR7mJyd5WUYW/50hqIgAXNnHACRPfibObKf2/dbjdUY54IQnVAYzkD
         G7OrA2Gf5yA0xYE5FcqHDp57rXPvBxkbZm8AxwG1/nGCrZk2/2dOl0pf/GwaYnQ9W6uS
         7O/6Idf6/b/xxfnONEDSQ1MGp3tMuW1QkecvBcajJnd7PT4JaiMmL8oyueruEZoGnQzm
         azw5eF2SZoIMHedtjlNY1e/O51b5X2ceTlRuyKsKUMHFykzdMyZ19Tc3RgAsyu7WD/hq
         KDow==
X-Forwarded-Encrypted: i=1; AJvYcCUX23AD+K/J18hwXHR5ieLIUF/PomqPUurpsLtLFNIZwKb/iCbGzDa2uiejvGeciszBHAF6l5KGwrscyMRTLTM=@vger.kernel.org, AJvYcCUnYyn4YJIEW4rwonu+Oab+ZUtcPQkiPdSZaGYG//izWEmuK5jVM/dbhnk7/z5Ne6ev4qpgi8aGhAcMVaFW@vger.kernel.org, AJvYcCUos1UkzK3WYEECW0iX2RoBAN8vzhcu543UN1t9CJys+62syMohhQPzOLV3zcIlm2n79WN7Sqs8NRY=@vger.kernel.org, AJvYcCW/tNHAn0YdfO1SBYbf2fAGAHUcPWJSVkJcMbJVRkoe28qHEjcjXMt4jzbzt2v5zfkZzCrz9X50z+MFcg==@vger.kernel.org, AJvYcCW33mAjqXJVpHsdZnqvQV4dO1bJGvv92vCfvQNaaN9+5B6m7AYbvkU5/fQIFL4vO+L/AMXHBIBubZhI@vger.kernel.org
X-Gm-Message-State: AOJu0YyZisNIynzt32dEoqGd4LYzIdUPD9GQFMfM5PIj4ZvdhoTSXGHY
	LZaGNTT0lNH0kls06dFdjaZTqE/sqKuqO+spXGb0WH9e1Cj5Jvel
X-Google-Smtp-Source: AGHT+IFn0RO+vNIB4QIOY05N4wOqGRxLJnHsKspX+bbF0ZWtdbp38gBEivnTo3W11ifl7iJQZ9ZxVw==
X-Received: by 2002:a17:902:e88b:b0:205:8763:6c2d with SMTP id d9443c01a7336-2076e56e3c5mr164445625ad.9.1726387780885;
        Sun, 15 Sep 2024 01:09:40 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:09:40 -0700 (PDT)
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
Subject: [PATCH v3 19/20] arm64: dts: apple: Add A11 devices
Date: Sun, 15 Sep 2024 15:59:04 +0800
Message-ID: <20240915080733.3565-20-towinchenmi@gmail.com>
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

Add DTS files for the A11 SoC and the following devices based on it:

- iPhone 8
- iPhone 8 Plus
- iPhone X

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP and m1n1 support, disabled SMC pinctrl]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile         |   6 +
 arch/arm64/boot/dts/apple/t8015-8.dtsi     |  16 ++
 arch/arm64/boot/dts/apple/t8015-8plus.dtsi |   9 +
 arch/arm64/boot/dts/apple/t8015-d20.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8015-d201.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8015-d21.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8015-d211.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8015-d22.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8015-d221.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8015-x.dtsi     |  16 ++
 arch/arm64/boot/dts/apple/t8015.dtsi       | 268 +++++++++++++++++++++
 11 files changed, 399 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8plus.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d20.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d201.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d21.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d211.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d22.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d221.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index a44c14fae7bc..ab6ebb53218a 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -46,6 +46,12 @@ dtb-$(CONFIG_ARCH_APPLE) += t8011-j120.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8011-j121.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8011-j207.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8011-j208.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d201.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d20.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d211.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d21.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d221.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d22.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/t8015-8.dtsi b/arch/arm64/boot/dts/apple/t8015-8.dtsi
new file mode 100644
index 000000000000..cac1d47285a1
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-8.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8015.dtsi"
+
+/ {
+	chassis-type = "handset";
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-8plus.dtsi b/arch/arm64/boot/dts/apple/t8015-8plus.dtsi
new file mode 100644
index 000000000000..ea291a95f028
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-8plus.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 Plus common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/* The 8 Plus has minor differences like 1 more camera, 1 GiB of RAM more and a bigger display. */
+#include "t8015-8.dtsi"
diff --git a/arch/arm64/boot/dts/apple/t8015-d20.dts b/arch/arm64/boot/dts/apple/t8015-d20.dts
new file mode 100644
index 000000000000..35d79e2ceebc
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d20.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 (Global), D20 iPhone10,1 (A1863/A1906/A1907)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8.dtsi"
+
+/ {
+	compatible = "apple,d20", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 (Global)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d201.dts b/arch/arm64/boot/dts/apple/t8015-d201.dts
new file mode 100644
index 000000000000..31e0947fee70
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d201.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 (GSM), D20 iPhone10,4 (A1905)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8.dtsi"
+
+/ {
+	compatible = "apple,d201", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 (GSM)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d21.dts b/arch/arm64/boot/dts/apple/t8015-d21.dts
new file mode 100644
index 000000000000..a902ba7f1133
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d21.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 Plus (Global), D21 iPhone10,2 (A1864/A1897/A1898)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8plus.dtsi"
+
+/ {
+	compatible = "apple,d21", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 Plus (Global)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d211.dts b/arch/arm64/boot/dts/apple/t8015-d211.dts
new file mode 100644
index 000000000000..3b3f886c0c09
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d211.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 Plus (GSM), D211 iPhone10,5 (A1899)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8plus.dtsi"
+
+/ {
+	compatible = "apple,d211", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 Plus (GSM)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d22.dts b/arch/arm64/boot/dts/apple/t8015-d22.dts
new file mode 100644
index 000000000000..5a7a6092c2d0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d22.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone X (Global), D22, iPhone10,3 (A1865)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-x.dtsi"
+
+/ {
+	compatible = "apple,d22", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone X (Global)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d221.dts b/arch/arm64/boot/dts/apple/t8015-d221.dts
new file mode 100644
index 000000000000..dd920c945bd6
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d221.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone X (GSM), D221, iPhone10,6 (A1901)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-x.dtsi"
+
+/ {
+	compatible = "apple,d221", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone X (GSM)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-x.dtsi b/arch/arm64/boot/dts/apple/t8015-x.dtsi
new file mode 100644
index 000000000000..afba4944656b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-x.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone X common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8015.dtsi"
+
+/ {
+	chassis-type = "handset";
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
new file mode 100644
index 000000000000..746acb86fff0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8015 "A11" SoC
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
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_e1: cpu@1 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_e2: cpu@2 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x2>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_e3: cpu@3 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x3>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_p0: cpu@10004 {
+			compatible = "apple,monsoon";
+			reg = <0x0 0x10004>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_p1: cpu@10005 {
+			compatible = "apple,monsoon";
+			reg = <0x0 0x10005>;
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
+		serial0: serial@22e600000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x2e600000 0x0 0x4000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 282 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		aic: interrupt-controller@232100000 {
+			compatible = "apple,t8015-aic", "apple,aic";
+			reg = <0x2 0x32100000 0x0 0x8000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl_ap: pinctrl@233100000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x33100000 0x0 0x1000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 223>;
+			apple,npins = <223>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 56 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@2340f0000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x340f0000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 49>;
+			apple,npins = <49>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 138 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 139 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 141 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_nub: pinctrl@2351f0000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x351f0000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_nub 0 0 8>;
+			apple,npins = <8>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 170 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wdt: watchdog@2352b0000 {
+			compatible = "apple,t8015-wdt", "apple,wdt";
+			reg = <0x2 0x352b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 172 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_smc: pinctrl@236024000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x36024000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_smc 0 0 6>;
+			apple,npins = <6>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 205 IRQ_TYPE_LEVEL_HIGH>;
+			/*
+			 * SMC is not yet supported and accessing this pinctrl while SMC is
+			 * suspeneded results in a hang.
+			 */
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt";
+		/* Note that A11 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


