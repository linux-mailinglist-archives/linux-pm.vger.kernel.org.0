Return-Path: <linux-pm+bounces-30847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B0B04FFC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A464A748C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93062D8398;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="row2DinS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CE2D5C7A;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552232; cv=none; b=JkB6M4zl5uSYzzQwnmRSNRRLeLHP0sDol5CqnJxb5wKmgZXEZ1zGKH+WXMKvk8RQDe0CYyXeXza6gRMA55Tq15hq1P7JNv1ZsYq56nL+h/biueAv8FBh8n5rsUOqwOGylqQ3eNNHPA+7/GSR5TCCxVCMduIci3fM2f/RuansFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552232; c=relaxed/simple;
	bh=H/IT/1M/DiNxHWny8vVMHXjFpdjemZq+meeHnPHoPCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnVf7T8a5XnKPB8IK4Ouh9BD8bAoIvBIq/NC67xUZarS0F2UacbnJ5/4KEzixQ6bagMZSJZZo1bfw978z4Byw2Hs0rfdLh4POiBj2zSvXkvL36tnaWGdWRjgSCjY+nvaJQ9iBA9oMukG6vQey1VS7RmXxjYZPeoQhSxefXYGD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=row2DinS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6C9CC4CEE3;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=H/IT/1M/DiNxHWny8vVMHXjFpdjemZq+meeHnPHoPCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=row2DinS5tIgzMkxJTzm2ly3kUuFBUuhRFI+0pC7OFNHyG9xIbfzpXuPGl1a81QDe
	 2QKNwK3Qf/JO4dYSB6hh4BQqcZz/906+AM6eYXCmdsDcCw3mjc+gVambeDz5ZMuVfL
	 fBjoKfbIy2tewSLvMiuI092l7eYbuvtd1woOZw3zMSg/CWZwphB9CzM/eQ3/S9mWGI
	 1Zd3/lHdzFpy+e5EH7fAJq0crBfuBHMaPMH+K2rM/YBsVgF+OHGF/QWU9nxyMFUsXZ
	 LRq0PnZLUXbw18MLWveqN8g3ELQSjHLX/+TQFqBvDioOUkmDjZXsVYbGBXosoJy4S6
	 CKd+DFo9cLHrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9FEC83F2F;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:03:00 -0500
Subject: [PATCH 17/17] arm64: tegra: Add support for NVIDIA Shield TV Pro
 2019
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-17-e3f5f7de5dce@gmail.com>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
In-Reply-To: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=3522;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=EdWmD7c7kf19WARtvl7KhoiByIIwFTP6OAORo97ZbDc=;
 b=hU4JQpTVPlnql0F2O6v680Z46sPUs+HCYeJ0AlSADGcA2h4/FbpIN2ljlyhqzxraQ2zKbtjpd
 2MoYW37DS0gCrNbP4Nv+kn92hDb6nmaT85cEEWUPVxsKAyy/rkKMyEq
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add initial device-tree support for NVIDIA Shield TV Pro 2019 (a.k.a
MDarcy) based up the Tegra210B01 SoC with 3 GiB of LPDDR4 RAM.

This is very basic, intended for checking initial Tegra210B01 support.
More complete support for the device will be added later.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/Makefile                |  1 +
 .../boot/dts/nvidia/tegra210b01-p2894-0050-a08.dts | 10 ++++
 arch/arm64/boot/dts/nvidia/tegra210b01-p2894.dtsi  | 70 ++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
index 0fbb8a494dba5089d9b7243e766bd6028b7f3744..bc6f3e268020b6fdbc90b2fb2ec1daf30c80af0e 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p3450-0000.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2894-0050-a08.dtb
+dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210b01-p2894-0050-a08.dtb
 dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb
 dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p3509-0000+p3636-0001.dtb
 dtb-$(CONFIG_ARCH_TEGRA_194_SOC) += tegra194-p2972-0000.dtb
diff --git a/arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dts b/arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dts
new file mode 100644
index 0000000000000000000000000000000000000000..f18266b3d8ae341feaef5a1a911752f6a5ce2d0f
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra210b01-p2894-0050-a08.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra210b01-p2894.dtsi"
+
+/ {
+	model = "NVIDIA Shield TV Pro 2019";
+	compatible = "nvidia,p2894-0050-a08", "nvidia,darcy", "nvidia,tegra210b01",
+		"nvidia,tegra210";
+};
diff --git a/arch/arm64/boot/dts/nvidia/tegra210b01-p2894.dtsi b/arch/arm64/boot/dts/nvidia/tegra210b01-p2894.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..97c9bd8f293539e76d57b6cfee49c60fb482d6ab
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra210b01-p2894.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tegra210b01.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uarta;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0xc0000000>;
+	};
+
+	serial@70006000 {
+		/delete-property/ dmas;
+		/delete-property/ dma-names;
+		status = "okay";
+	};
+
+	pmc@7000e400 {
+		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <0>;
+		nvidia,cpu-pwr-good-time = <0>;
+		nvidia,cpu-pwr-off-time = <0>;
+		nvidia,core-pwr-good-time = <4587 3876>;
+		nvidia,core-pwr-off-time = <39065>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
+		status = "okay";
+	};
+
+	mmc@700b0600 {
+		bus-width = <8>;
+		non-removable;
+		status = "okay";
+	};
+
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
+	cpus {
+		cpu@0 {
+			enable-method = "psci";
+		};
+
+		cpu@1 {
+			enable-method = "psci";
+		};
+
+		cpu@2 {
+			enable-method = "psci";
+		};
+
+		cpu@3 {
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+};

-- 
2.50.0



