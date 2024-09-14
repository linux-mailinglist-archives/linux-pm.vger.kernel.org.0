Return-Path: <linux-pm+bounces-14230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19AC978DDF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5DE28D0A6
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377D187348;
	Sat, 14 Sep 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zndb6ndS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8E186E47;
	Sat, 14 Sep 2024 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291579; cv=none; b=ggzpSwbcPva+FzfeP40S0YLVOvlJ3KUqpfy4emPinz+Wq0faZ8D0i+HVZC2b2q0fum+NletUgofmnxem+Bg3f7U5CVHVv+WxE4uCQfmF4qquY47NhJkiMmmRZEjt0hILn1LSPjIL8u0Wem9XXINem6yDw6gu5yjxEqOyZqOrEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291579; c=relaxed/simple;
	bh=/UwfqXhivwWOFPln36L2jqERm8pwkyaUlda7cHIUrTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGsAg9auH8vbmZY1xoJGTnLurktkXQuEgznqErDMTbuLK8/Kqn/LXMazTbR0jbZYY1uotnssmUvAiCkEBa8vXgCIDpBQMlhXBWa17+7M909ISV/CKJfi/r6c8ef5Zi/j0tTcotaSDE4wTzjEoPoy76edodjTJnGveJMdI3ZFCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zndb6ndS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71923d87be4so1243346b3a.0;
        Fri, 13 Sep 2024 22:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291577; x=1726896377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/3KV47ziEBBZC/y1RFBXW9LjMIFFLMDCfq/UMfNL3E=;
        b=Zndb6ndSOh1Ve2T9IWi0FaJhDXiYMrztzun7h3c2pYVFJesuy/9zVO36nx4nBe+gSe
         DTgF6xb7eCGkClYfMc2Up9zs1aK9OJeqX1NxIqye4AIdzXOs1BNN0KutvAwHii3pnFtV
         VbOoEAXsIFxgJMmPSSGDmR8PymlNx2NLu5QfNslSWe5ligtm8ei/EZ/Z68yisOkZc9e9
         HXArLmzNH1B7NB/7sN9X7Cva/QD23gJaI79LFLtRiBQ32n2cQzMCHqgCZFzc4A9MLmx1
         Y4oNADFUhrqnWXeMdWGkMh3gH/Nn83Q6qSV+DR4OnPZPkeddHEI3aaDvtHusSPffemBH
         DdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291577; x=1726896377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/3KV47ziEBBZC/y1RFBXW9LjMIFFLMDCfq/UMfNL3E=;
        b=p26W0lrwmI1Em3QfzbS5XJ/Wt4DefCTV696Sag27SscYCryFk8Y22w8t5BatKlxlVd
         8tOD2kIRmPKJ+0fAQfjNzvBfLIy1pp1GNLucCezCOOlf5E1kS9Gglldr3psd65MeKPEg
         AG/9sP5s8Yy+Pr/xrEYnFDcnhTEtTRG1wKuU8zLf/JgdgqXXWGon3K7IRK29gPe8ffnZ
         x1HKX0kaMC1HvAZeabBLYDfQMipsouZ6hwYxN2xgfNMV2nsTtzF2RchAQdepahfOaNwh
         35MPcmvsGbxW+bl7frwLBZhbvyRTQvRENCK+n3WIYn9UzDm0X6v0WQy4BL12RL+BRhLS
         LXdg==
X-Forwarded-Encrypted: i=1; AJvYcCV0nV1HfJfF3vZyWtwRZZiBBxZG2JlWO/XBLoEWpOaf6KX8JBd7R8jI+nDJWWaEG1DBgBPmWrWz2Hs=@vger.kernel.org, AJvYcCVTg9gryhbPo7YXwoI/tULRi5/DljE86/PXLow/13TgBiZRv0vn/pmpfGh8MfPid6IaIr8xTxyPdvEJx4i2@vger.kernel.org, AJvYcCVheIqZuRHNdcRhaJrt0RzYxAgfmb3/LJyFOLp0MC0qZvC8GDQ7Kjnc6yN1vg1h59S//XYwtFaP0/Xe@vger.kernel.org, AJvYcCVmaEbmpkYJa7Pin9yuuF31J0mTE6R5iu7oKF4xyFHdaw4wXrA5zyuxCf3XTxHR05wigZChq8I1IBbWoQ==@vger.kernel.org, AJvYcCXseJzZwkxPe5aU1YMLsD/ic5jRCBueBFvDUpQpfeM991Y9bZbxKNamF2YrQ8u6avEJsCh7qXffHDMdabr5COE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t0VLz43wYZgrT8HPfKDn3eGTflcStTpbNK89ISB+NG9aeWp7
	XqcdysQFm6/iI5OSUXWbeVZigoSu5HmW73kVjtvQIAFUw+2ihlSX
X-Google-Smtp-Source: AGHT+IG5vyukhGc7WBUcD3BWY4QdsTNMAHJqa2srziEcmw3fyk1vrhztKuwjSX3cMCFbXdVjHkxXzg==
X-Received: by 2002:a05:6a20:c90e:b0:1cf:4197:6697 with SMTP id adf61e73a8af0-1d112db3766mr7578092637.23.1726291577288;
        Fri, 13 Sep 2024 22:26:17 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:26:16 -0700 (PDT)
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
Subject: [PATCH v2 14/22] arm64: dts: apple: Add A8 devices
Date: Sat, 14 Sep 2024 13:17:23 +0800
Message-ID: <20240914052413.68177-18-towinchenmi@gmail.com>
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

Add DTS files for the A8 SoC and the following devices based on it:

 - iPhone 6
 - iPhone 6 Plus
 - iPad mini 4
 - iPod touch 6
 - Apple TV HD

The remaining HomePod is not supported as part of this patch.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP and m1n1 support, gpio-keys additions]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile         |   6 +
 arch/arm64/boot/dts/apple/t7000-6.dtsi     |  52 ++++++++
 arch/arm64/boot/dts/apple/t7000-j42d.dts   |  19 +++
 arch/arm64/boot/dts/apple/t7000-j96.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000-j97.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi |  53 ++++++++
 arch/arm64/boot/dts/apple/t7000-n102.dts   |  50 +++++++
 arch/arm64/boot/dts/apple/t7000-n56.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000-n61.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000.dtsi       | 146 +++++++++++++++++++++
 10 files changed, 382 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t7000-6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j42d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j96.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j97.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-mini4.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n102.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n56.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n61.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index e1ee803f72a7..d5dd1e2e4f4c 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -10,6 +10,12 @@ dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j85.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j86.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j87.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-n51.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-j42d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-j96.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-j97.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-n102.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-n56.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-n61.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/t7000-6.dtsi b/arch/arm64/boot/dts/apple/t7000-6.dtsi
new file mode 100644
index 000000000000..3802e853af42
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-6.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6 / 6 Plus common device tree
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+#include "t7000.dtsi"
+
+/ {
+	chassis-type = "handset";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl 32 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl 33 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl 45 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl 46 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl 131 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-j42d.dts b/arch/arm64/boot/dts/apple/t7000-j42d.dts
new file mode 100644
index 000000000000..88bc6ff68f25
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-j42d.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple TV HD, J42d, AppleTV5,3 (A1625)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000.dtsi"
+
+/ {
+	compatible = "apple,j42d", "apple,t7000", "apple,arm-platform";
+	model = "Apple TV HD";
+	chassis-type = "television";
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-j96.dts b/arch/arm64/boot/dts/apple/t7000-j96.dts
new file mode 100644
index 000000000000..8a32a50cc2df
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-j96.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad mini 4 (Wi-Fi), J96, iPad5,1 (A1538)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-mini4.dtsi"
+
+/ {
+	compatible = "apple,j96", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPad mini 4 (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-j97.dts b/arch/arm64/boot/dts/apple/t7000-j97.dts
new file mode 100644
index 000000000000..ac7d501f88d2
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-j97.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad mini 4 (Cellular), J97, iPad5,2 (A1550)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-mini4.dtsi"
+
+/ {
+	compatible = "apple,j97", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPad mini 4 (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-mini4.dtsi b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
new file mode 100644
index 000000000000..c0fcdc900d01
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad mini 4 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t7000.dtsi"
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
+			gpios = <&pinctrl 32 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl 33 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl 45 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl 46 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl 36 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-n102.dts b/arch/arm64/boot/dts/apple/t7000-n102.dts
new file mode 100644
index 000000000000..81fb62dce5bc
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-n102.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod touch 6, N102, iPod7,1 (A1574)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "t7000.dtsi"
+
+/ {
+	compatible = "apple,n102", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPod touch 6";
+	chassis-type = "handset";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl 32 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl 33 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl 46 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl 45 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-n56.dts b/arch/arm64/boot/dts/apple/t7000-n56.dts
new file mode 100644
index 000000000000..2c358df14458
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-n56.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6 Plus, N56, iPhone7,2 (A1549/A1586/A1589)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-6.dtsi"
+
+/ {
+	compatible = "apple,n56", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPhone 6 Plus";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-n61.dts b/arch/arm64/boot/dts/apple/t7000-n61.dts
new file mode 100644
index 000000000000..10b4ca8babf7
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-n61.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6, N61, iPhone7,2 (A1549/A1586/A1589)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-6.dtsi"
+
+/ {
+	compatible = "apple,n61", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPhone 6";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
new file mode 100644
index 000000000000..b766129ad472
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T7000 "A8" SoC
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
+			gpio-ranges = <&pinctrl 0 0 208>;
+			apple,npins = <208>;
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
+		/* Note that A8 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


