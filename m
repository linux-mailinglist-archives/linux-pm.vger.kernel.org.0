Return-Path: <linux-pm+bounces-31154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA91B0BA3F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086877ABB26
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EBE22B585;
	Mon, 21 Jul 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEBvMVGd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFA21CA07;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=tNdMlOwgDk0NIor7FKJy1VNdFPF80yOrJ54HUZ+fgOV8E3foxUIxY8YSDLYcHph1fQmbmoBSDtQyNrL72x+wAgJ0JGYfn4CyOBl9TyYT1lEvHxKSiQYJI+tG9/4JM/reWYo0kesakb8qhQTN/p10mJEFMFxyS7/FbqHxf4rDdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=0Sl9ne1fNA79gjabf0syuWDSWv557+WLdkh+UrDoEwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPgibWhm149JN//NVJgCs9ahKfzCQx4FqlCQNV5Q95CvF3RWy+iaurUp+srWoKWu/wZwGfNLBoyY4u5RhAFdGAPwOpa96+e2FWlG7/pHafCsRkDlgD84uQoPFQjA+tXDw4h1dMhh5EW27V/NX1Jngjwu8BsATTtXYL64jos+/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEBvMVGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C964C4CEFC;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064241;
	bh=0Sl9ne1fNA79gjabf0syuWDSWv557+WLdkh+UrDoEwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iEBvMVGdnmrpx3Gorr8MU9SBlunmSv+vZj9fsDtcAeC0Bw8XXdxqiWxZi08LSbRGY
	 az9vNgK8NarxoRl4Y3E5RC2OVQLMk+EW+/r6rt0V+THT1g6wBilMDqsW8d4TmDutnN
	 TO93MYMT+HfrgiWF7uRpa63xTFr8tuLi8NMxk83lulxzatf0uDssNsTuCDZ18J+d4G
	 5PX6VEKR3jvkVXYmB5j+7Ur/QjxyQgVxVwEWlC9O3gfSc+ohJDGJEhCoMmKG7S3gjG
	 p16IamcvwtNCoTrauC6wtIDbN0J/2TP5KHwZNZ9ntpeDNQhjL5AMXTYMoaZ1VPKUN8
	 SpafUfr2VGuQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63029C87FC6;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:15:11 -0500
Subject: [PATCH v2 17/17] arm64: tegra: Add support for NVIDIA Shield TV
 Pro 2019
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-17-9cb209f1edfc@gmail.com>
References: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
In-Reply-To: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=3522;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=lBbPA4YnfIve2RzYnMMZrMuioshaXo0K/YzU1CSGgG0=;
 b=uZ18x9hPOETwB5r3x1VYui41gkdHxgunkMehPDkapwffmjyk9Z9GL845wi0QzejmISzNQ7Qte
 Wh8pVLrwHUIC3gw1diFucLnJPehp2XDs65AuWnzCj/LV+jaGFCmrF1V
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
2.50.1



