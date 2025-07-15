Return-Path: <linux-pm+bounces-30837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0599B04FEA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53226188F9A5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBD2D46CD;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKb7aXUd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703E2D322C;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=U1cpFbqHipsCAKQKidGRLQ33JoNdJfEPgPH2TGfkyR53h74Gs57AlchIZSfVQOwJjarkj1LGWAIoMSTt290YNGgtnr7DzWQXTcW7ag5nQoAw1rc/AYGL2ivZ4OK8Hx1Fj7yxzR7t/T9j9gbLQW0oR5+vMabefdm8EkEaTawsc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=eYz4Uz7qvxPXvaD5+scVscI+Mnw/orHA8ggA3QXS2uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L6dMLfT/eiVcsGZWkC+HJhyV9shSzfufQV7fqlm9Bq0pbIeJ8+C2u1FrnvA5AjKv45K6G3CaQSHTP+X8K7VOgWiMMEjqZBe5z/N14R2Q8X/hucVSfxoSxhRzMXwl4Gx7JL2dCk1/rlFWE8+wctd8BvD5dVVcmdBafpuj/X0ioLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKb7aXUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51BB8C116D0;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=eYz4Uz7qvxPXvaD5+scVscI+Mnw/orHA8ggA3QXS2uQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oKb7aXUdpvWmbeIMOMnPdzEQQ0JDJuSXoxIFqu59czvTTfNRBexW0dqGBzP5tx6+H
	 rdnR5/FnJwP7WOB0lHiAg2Dl4D5NxlsRPrXVXa1YJ6lAG2hFE2LujBqaz1582HFLPU
	 jWJX8ovg0bfSl0yLjAPIEOYlFxb6mkbB53GPa60umeqglfM0WHpn0o+WioqqTt7pd7
	 4oIrJL9K0IxItzA5F4BdaQB95OEc9HBgPVF0HPeydra7wulO8dumYJSMzQalRsv73j
	 61FQ7LKBezXFU84FYuKArg9204hPFIM7IMYPB/UZZKbH7tp7DnuKRQzyH1CHBrfY7E
	 WCdxbrZVYEH/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BCC83F22;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:53 -0500
Subject: [PATCH 10/17] phy: tegra: xusb: Add Tegra201B01 Support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-10-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=4435;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=TSuQQI+G6ILFcFZHB2dMmAYCp0s3pQX0JPK9qVVVEqg=;
 b=aRbDQDeDAgDBuaO6BSCQXo+tsZtTbtOCuQw0YShxKtJvYDjZtpUGKEnf4KuwnX1bqv766iqcu
 ZRVeTH/QJlRBD2uReHxAsHfiSDtd2/H8JFsAvYfRabzHBWKS3/7yL4S
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

It has slightly different lanes compared to the original Tegra210.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.c          |  4 ++++
 drivers/phy/tegra/xusb.h          |  1 +
 3 files changed, 46 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index ebc8a7e21a318160b162113eea8a6c97b7ed7966..06b587f84270cdea2ea397e55e1e326e270d4caa 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -2559,6 +2559,15 @@ static const struct tegra_xusb_lane_soc tegra210_pcie_lanes[] = {
 	TEGRA210_UPHY_LANE("pcie-6", 0x028, 24, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(6)),
 };
 
+static const struct tegra_xusb_lane_soc tegra210b01_pcie_lanes[] = {
+	TEGRA210_UPHY_LANE("pcie-0", 0x028, 12, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(0)),
+	TEGRA210_UPHY_LANE("pcie-1", 0x028, 14, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(1)),
+	TEGRA210_UPHY_LANE("pcie-2", 0x028, 16, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(2)),
+	TEGRA210_UPHY_LANE("pcie-3", 0x028, 18, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(3)),
+	TEGRA210_UPHY_LANE("pcie-4", 0x028, 20, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(4)),
+	TEGRA210_UPHY_LANE("pcie-5", 0x028, 22, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(5)),
+};
+
 static struct tegra_xusb_usb3_port *
 tegra210_lane_to_usb3_port(struct tegra_xusb_lane *lane)
 {
@@ -2847,6 +2856,13 @@ static const struct tegra_xusb_pad_soc tegra210_pcie_pad = {
 	.ops = &tegra210_pcie_ops,
 };
 
+static const struct tegra_xusb_pad_soc tegra210b01_pcie_pad = {
+	.name = "pcie",
+	.num_lanes = ARRAY_SIZE(tegra210b01_pcie_lanes),
+	.lanes = tegra210b01_pcie_lanes,
+	.ops = &tegra210_pcie_ops,
+};
+
 static const struct tegra_xusb_lane_soc tegra210_sata_lanes[] = {
 	TEGRA210_UPHY_LANE("sata-0", 0x028, 30, 0x3, pcie, XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2),
 };
@@ -3016,6 +3032,11 @@ static const struct tegra_xusb_pad_soc * const tegra210_pads[] = {
 	&tegra210_sata_pad,
 };
 
+static const struct tegra_xusb_pad_soc * const tegra210b01_pads[] = {
+	&tegra210_usb2_pad,
+	&tegra210b01_pcie_pad,
+};
+
 static int tegra210_usb2_port_enable(struct tegra_xusb_port *port)
 {
 	return 0;
@@ -3290,6 +3311,26 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 };
 EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
 
+const struct tegra_xusb_padctl_soc tegra210b01_xusb_padctl_soc = {
+	.num_pads = ARRAY_SIZE(tegra210b01_pads),
+	.pads = tegra210b01_pads,
+	.ports = {
+		.usb2 = {
+			.ops = &tegra210_usb2_port_ops,
+			.count = 4,
+		},
+		.usb3 = {
+			.ops = &tegra210_usb3_port_ops,
+			.count = 4,
+		},
+	},
+	.ops = &tegra210_xusb_padctl_ops,
+	.supply_names = tegra210_xusb_padctl_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
+	.need_fake_usb3_port = true,
+};
+EXPORT_SYMBOL_GPL(tegra210b01_xusb_padctl_soc);
+
 MODULE_AUTHOR("Andrew Bresticker <abrestic@chromium.org>");
 MODULE_DESCRIPTION("NVIDIA Tegra 210 XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index c89df95aa6ca988ea02df6220061be5c7f2c9a46..4a55f1dde660a502d3ff1ab4a275a3f97f19632d 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -59,6 +59,10 @@ static const struct of_device_id tegra_xusb_padctl_of_match[] = {
 		.compatible = "nvidia,tegra210-xusb-padctl",
 		.data = &tegra210_xusb_padctl_soc,
 	},
+	{
+		.compatible = "nvidia,tegra210b01-xusb-padctl",
+		.data = &tegra210b01_xusb_padctl_soc,
+	},
 #endif
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
 	{
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 6e45d194c68947618778dc132720ae757f5fd656..a2074dd3770449c64157e60ef230cefc27238ceb 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -503,6 +503,7 @@ extern const struct tegra_xusb_padctl_soc tegra124_xusb_padctl_soc;
 #endif
 #if defined(CONFIG_ARCH_TEGRA_210_SOC)
 extern const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc;
+extern const struct tegra_xusb_padctl_soc tegra210b01_xusb_padctl_soc;
 #endif
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
 extern const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc;

-- 
2.50.0



