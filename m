Return-Path: <linux-pm+bounces-31152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30654B0BA50
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9522E188BC4F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2157223DFF;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2KQxA5d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225AE1F5834;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=C4b7gBnzOkN30YWTA2saRt5NUeub09o7KTT13uTg2zR2jeOaAUnN6FoCkgxH+D11bvE0SHFvWdqxUt9osatOQcOA04UJ5u5wP+75tT2n2nUMktJht1a59LMxeVjL/vC6TR6x1b/nSXLjlH/eJP1ga+rGqsXTyGGB1seM0eVnhOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=sA5jK2V5skay2wNZXk62Cnr/WW7u/wNzJuiuJRLLdvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7UM7YX1NbQpJarV1xH4x8MnGVfXMMm8SGbJ2H2XcC6+XdSpamEXYIq71fMbT2gGZX8at88wO6g+3nPszdT7UsLeKMjsJBOTu759eJ4kXkOVyZbzgFNtVxpgVfbSg6t2oJAD70RDfE+26I+Ml5fnDACTLguggype5wSL1lV7wYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2KQxA5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F334CC4CEFC;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064241;
	bh=sA5jK2V5skay2wNZXk62Cnr/WW7u/wNzJuiuJRLLdvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r2KQxA5dXmLXDwvI1+pikYMX4+MGn6TRE7GyyZdPY5R9v6gRYoVtRZcUc4I6Cg/UA
	 ilh2fXPD5JNlSj90nC9aSCASBD/mitoM4oP5a1KyWX7kue4jkKxmOS0hezD6bXGhas
	 9HG16/V1ow0tixKb9rAJBbUXFCIT5hdjwyWRfJEGPbrQManeyuvq1155EYzKSfzrLe
	 UMHmy/Dnxjb/XpfRPInVrqrv2EIvifJYC4mCHkF8u3n82KPtJtl+CJfQ8ywLYc9CfZ
	 RemoXk4d/3Rj/ZYlJi3m/IDMNT/N0ayoVymITT9ti9BFpOiWew31EDJzejKwzIy3Tq
	 +FneX5u52Aj9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2EDC87FC5;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:15:05 -0500
Subject: [PATCH v2 11/17] usb: xhci: tegra: Add Tegra210B01 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-11-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1932;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=u4MyJKHAAFOoAMSOmgjeS/X4Ejtyfwszu/1wKGnsxoU=;
 b=tA5ONdEvrWoKhcaOrjdxpAymCR/aSkTi7yRM2gWunDmn7Rfg89bxZ6y9P9BZUVGXYItGvdMIK
 THthuPCQNTZDg9m/LCrcMj5i8gKD9gNXwhqI4lIdLRhxYhZM+8sjUYJ
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
2.50.1



