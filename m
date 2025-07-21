Return-Path: <linux-pm+bounces-31155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018F7B0BA40
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214CA7AB943
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5BF22D9E7;
	Mon, 21 Jul 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnixVS72"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D821A435;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=aYJupbztAnoas3PPkdR1bKS3kOgdlnhYvI2xARZporKGkYJbPvZbsFbeHkNRRUa+J0m0drFargp+QzDp6AujdjX+ovIzkCG7ABRmpjUUganRj7DA40OTvMvZhEgCmwJ4WwLYUsv7stKfqfd9v1b32EKoT0zWgWdA4V238IfNcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=3ydShq20mxxCIN54bhrZPW1GL4izZ/sL45OAM2AudYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWMzN/Ut0W++TvtJeRAzcPh/JL2bKi5ZVSoc2X20haxG9WO5aSCeXusvZUJf/kMA4FKp8oahrV4AjWa2B0rmM75XLa5HWbtknIYqqclwlRnkW3ddHv6yDTFJsqaqQJewUgt9f3MeOcsRjsWKm0zq7kx0TzJ3g8WvNDqCEVlF4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnixVS72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D3B2C4CEF9;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064241;
	bh=3ydShq20mxxCIN54bhrZPW1GL4izZ/sL45OAM2AudYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nnixVS72iOnqo/kicb14gXMzfO77Y4HUYG2mx1Yq0bIfXfW35S8rFiANdqqYv7sCW
	 OwQ+O3f7t/l4n22qVpG3ict2MjiwrgWee1OEJHcUAL1RxdzipkpZWRyg7zNHjAt/fs
	 0W0cH/tzyaaTz3ojPe1dywjg9QSE/3K0zzCp9QFD1BwxZGeGRTuNZwAb/pMn3twdyJ
	 nJn3Tmq8M86VXFQB7Xff5dHOd4CguB455bgfi+crQzZrm97qX+3b38Ls+y9XB00Dz6
	 +VgvJrYBUwx1/dWXlBO0n3rco89bc7YWPdVJ7/Z+2H82MzyQEDFTm8ari+XRi9YVy0
	 trGh470NFgDJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5419EC83F1A;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:15:10 -0500
Subject: [PATCH v2 16/17] arm64: tegra: Add Tegra210B01 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-16-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1982;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=49OX805LYoy4B3LF8skuT6ywroy9Cv9R181cjDO5IEQ=;
 b=oMVw8JtuhnOyL5sYPqAD8v+W7FmFHchQmwUYJ7IgbcGTDm7t/8Wop5PETkYVy1RjMNHclfNxh
 u0XFXiUhd/2CUs0Ipn+o0vaXkzLHwjiABqWIKxODj92Ph3IVLOzfPl/
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Also known as Tegra X1+, the Tegra210B01 has higher CPU and GPU clocks
than the original Tegra210.

Add a SoC-level device tree file that describes most of the hardware
available on the SoC. This is derived from the Tegra210 dtsi, as they
share a lot.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210b01.dtsi | 64 +++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210b01.dtsi b/arch/arm64/boot/dts/nvidia/tegra210b01.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..87e55af3ed2466c5d353dbd8706230aef97b90f7
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra210b01.dtsi
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tegra210.dtsi"
+
+/ {
+	compatible = "nvidia,tegra210b01", "nvidia,tegra210";
+
+	host1x@50000000 {
+		/delete-node/ sor@54540000;
+		/delete-node/ dpaux@545c0000;
+
+		dc@54200000 {
+			nvidia,outputs = <&dsia &dsib &sor1>;
+		};
+
+		dc@54240000 {
+			nvidia,outputs = <&dsia &dsib &sor1>;
+		};
+	};
+
+	clock@60006000 {
+		compatible = "nvidia,tegra210b01-car";
+	};
+
+	i2c@7000d100 {
+		/delete-property/ pinctrl-0;
+		/delete-property/ pinctrl-1;
+		/delete-property/ pinctrl-names;
+	};
+
+	pmc@7000e400 {
+		compatible = "nvidia,tegra210b01-pmc";
+	};
+
+	bpmp@70016000 {
+		status = "okay";
+	};
+
+	usb@70090000 {
+		compatible = "nvidia,tegra210b01-xusb";
+	};
+
+	padctl@7009f000 {
+		compatible = "nvidia,tegra210b01-xusb-padctl";
+	};
+
+	usb@700d0000 {
+		compatible = "nvidia,tegra210b01-xudc";
+	};
+
+	thermal-sensor@700e2000 {
+		compatible = "nvidia,tegra210b01-soctherm";
+
+		throttle-cfgs {
+			heavy {
+				nvidia,cpu-throt-percent = <0>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_NONE>;
+			};
+		};
+	};
+
+	clock@70110000 {
+		compatible = "nvidia,tegra210b01-dfll";
+	};
+};

-- 
2.50.1



