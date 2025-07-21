Return-Path: <linux-pm+bounces-31148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E7B0BA2B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C266189942C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C494D2222A0;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMgDu/p/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390001FBC92;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=KHPkO+hrLc3g6vePGzOkmJuR2L9lCRUE0QQJRkWs6lFsYn+f0DRocb5SBiRhJH0GdicJ6MbkmQhLcZdmPW7nrQPSBpS9Jsonl9uIcXNdaoYXWplIrSGzM+IKZJzFH5iOlEt8s0xaTyQeRYnPrYWqBk7p/eHsjvZxsFUL+XIl/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=qp9tUPFQuumYksisjGHPVxkd5k0ASmphuZsAeWWISew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P89Mtxr4XXkwYGbNk/4ztUK9E+P/eejE4jS4uv/ckjclDVzzdlIMZWnYmaiwfIcHfcXHREkyBtQAjxl3mJ7Mvtt7wFfskOd/NqSuv/0tKgTX1lL29k9BPtsEyiefHGVsR7hr3xpoRuBXhPkSUu22xLFhPVeVPI7IjdfXJwmFG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMgDu/p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11D3DC4CEFB;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064241;
	bh=qp9tUPFQuumYksisjGHPVxkd5k0ASmphuZsAeWWISew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tMgDu/p/Klfmd52jEZH9nxTP+aC83HmY+nR6oQeGSVg5uBa3kCxAoZaEVIUnw+jYb
	 SZsBa++RzKfCwaNZ+j3WcBs+6UP+yHXz1gypztaN4yBgMC/A2xhh+NDB2K9myD41xQ
	 ATjxvH+Zx73gKiHfp0Tlw/OdJxnLzFWX0zggRHVhMk7c5lntS3WGR+Gcobvf4ie68a
	 isNlSXODLgJuON6zBA16+vvN5MOHjnnwIXr3zrVP/HRUqKUkuPez7vybLRyGSmxXNT
	 NZfA+tO4a7xqDdtIuR7KLWrqkvsbLdJk5ynaMH7Q0BvZ9SvPErjAChgRcFafxMJGVm
	 rHdv3j5BFVD3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF1C87FC6;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:15:06 -0500
Subject: [PATCH v2 12/17] usb: gadget: tegra-xudc: Add Tegra210B01 Support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-12-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1624;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=If0Hje67iTpggX4b+9TtDr2gpSLnQeDIgSv7GE82lsA=;
 b=+NLKfcfz9GwPFjmm4POLuf7fNqzdg2v20Awvp09SyxlKT8iidTCJEY6/kbi1s15fho1B7xgFC
 79xu7pkkJNkA9jyXejvfcidxdaNTNNDuZ7gpJFFUGc8Xq4NrtgP5Gr9
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

It doesn't need some of the workarounds that the original Tegra210 does.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 2957316fd3d003e8444a825a72d228b7db06febe..1d2fb9bd51c7369dc5d056e49ae184659a40406c 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3652,6 +3652,22 @@ static struct tegra_xudc_soc tegra210_xudc_soc_data = {
 	.has_ipfs = true,
 };
 
+static struct tegra_xudc_soc tegra210b01_xudc_soc_data = {
+	.supply_names = tegra210_xudc_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra210_xudc_supply_names),
+	.clock_names = tegra210_xudc_clock_names,
+	.num_clks = ARRAY_SIZE(tegra210_xudc_clock_names),
+	.num_phys = 4,
+	.u1_enable = false,
+	.u2_enable = true,
+	.lpm_enable = false,
+	.invalid_seq_num = false,
+	.pls_quirk = false,
+	.port_reset_quirk = true,
+	.port_speed_quirk = false,
+	.has_ipfs = true,
+};
+
 static struct tegra_xudc_soc tegra186_xudc_soc_data = {
 	.clock_names = tegra186_xudc_clock_names,
 	.num_clks = ARRAY_SIZE(tegra186_xudc_clock_names),
@@ -3698,6 +3714,10 @@ static const struct of_device_id tegra_xudc_of_match[] = {
 		.compatible = "nvidia,tegra210-xudc",
 		.data = &tegra210_xudc_soc_data
 	},
+	{
+		.compatible = "nvidia,tegra210b01-xudc",
+		.data = &tegra210b01_xudc_soc_data
+	},
 	{
 		.compatible = "nvidia,tegra186-xudc",
 		.data = &tegra186_xudc_soc_data

-- 
2.50.1



