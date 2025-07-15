Return-Path: <linux-pm+bounces-30842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62944B04FDA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF23BAE14
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC2A2D5C8A;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfjXeZo4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0982D3758;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=qbzl2ieGLKhmbh1nuFcbp7spndOXsJO84Z2ZruFNhbupW11deo1Q2KXR0P4wfE3V3YTt4hgXlfoRgOLQkwYhG3/7liVogcX3cenwE/ikAAd5ejXFE3zK2asHddHthOgYabHy097Jxw1saPgLl0hE6uXT00ZcBi5kIJ0TFEAc4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=O1H8aQyQkcYZnx7DwkuOzyQf08RWSL8y/htSjyjvz0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdSd7w6XJ8X6eD5FuZXttsHN6zKtPn+VPPFLY2zujSvxXudwp4F17G1nq7Fy79ig+bWveb/xPqo7Xk6CjzRqJqH9YazMbd8J3rWHnon84KXDxb7OGpsmPlklOmNgBvwnLqBBtrh9icDnwP5Ro957A18C4Vood5Cbvp0KyTsb1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfjXeZo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EA70C2BCAF;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=O1H8aQyQkcYZnx7DwkuOzyQf08RWSL8y/htSjyjvz0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tfjXeZo4Xmw89/4wLwJyqbZ+959BK8nUXefiXQ3aUGbpv2eDtkdHLnEM90GQ8HJQz
	 LIY/62K34j5h8GgMavZNg0qRrVFHSNjoCSRcrX7FRSYsJlNSqy/daL+ETuD5VmVi2P
	 kctc0JzLDX+qmzQyPcwR0pxIHmy29ctLQLxaWCZM0abiyO8UOcxsXSQsiaTShPh25T
	 Oxx6rohI7ucljCy58cr9Bj4YC2UvAS6nM/qqHGN2KgYOXuI5+AiKCt42/vNadtSj0z
	 H1fa25Uq3qT4IVciePX8BovD3brQE7Tb1dFnT8sW9jQV8Us3DN0we7wt5T3BQ0AqRa
	 nFGIUIAJiCqqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56333C83F2F;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:54 -0500
Subject: [PATCH 11/17] usb: xhci: tegra: Add Tegra210B01 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-11-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=1932;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=FYMpkpyzM578fnGIvudlc1If8b1f7SqQ00jSgTIDo10=;
 b=IZGaeuYCPAcdA7HqcAhnztHUBEbuakRfcaUkoGkPrr6y5zD9XB/sAdNRtnBLyEObkWOFTY8rJ
 HpGkX93861dAVCZYBhothATAUfHwdGyH+JllEFyOyHZAbASs9eIFtb5
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This uses a different firmware, but is otherwise compatible with
Tegra210.
---
 drivers/usb/host/xhci-tegra.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 0c7af44d4dae5066e66bd29c961510892b6e1301..aef100415f453fdd95c83cf511a914cf62e3e775 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -2547,6 +2547,30 @@ static const struct tegra_xusb_soc tegra210_soc = {
 };
 MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
 
+static const struct tegra_xusb_soc tegra210b01_soc = {
+	.firmware = "nvidia/tegra210b01/xusb.bin",
+	.supply_names = tegra210_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra210_supply_names),
+	.phy_types = tegra210_phy_types,
+	.num_types = ARRAY_SIZE(tegra210_phy_types),
+	.context = &tegra124_xusb_context,
+	.ports = {
+		.usb2 = { .offset = 4, .count = 4, },
+		.hsic = { .offset = 8, .count = 1, },
+		.usb3 = { .offset = 0, .count = 4, },
+	},
+	.scale_ss_clock = false,
+	.has_ipfs = true,
+	.otg_reset_sspi = true,
+	.mbox = {
+		.cmd = 0xe4,
+		.data_in = 0xe8,
+		.data_out = 0xec,
+		.owner = 0xf0,
+	},
+};
+MODULE_FIRMWARE("nvidia/tegra210b01/xusb.bin");
+
 static const char * const tegra186_supply_names[] = {
 };
 MODULE_FIRMWARE("nvidia/tegra186/xusb.bin");
@@ -2659,6 +2683,7 @@ static const struct tegra_xusb_soc tegra234_soc = {
 static const struct of_device_id tegra_xusb_of_match[] = {
 	{ .compatible = "nvidia,tegra124-xusb", .data = &tegra124_soc },
 	{ .compatible = "nvidia,tegra210-xusb", .data = &tegra210_soc },
+	{ .compatible = "nvidia,tegra210b01-xusb", .data = &tegra210b01_soc },
 	{ .compatible = "nvidia,tegra186-xusb", .data = &tegra186_soc },
 	{ .compatible = "nvidia,tegra194-xusb", .data = &tegra194_soc },
 	{ .compatible = "nvidia,tegra234-xusb", .data = &tegra234_soc },

-- 
2.50.0



