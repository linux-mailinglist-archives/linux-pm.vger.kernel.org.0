Return-Path: <linux-pm+bounces-30841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01784B04FF2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51191171629
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A832D5C6E;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKDMQS/x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F82D3A88;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=m4FyuX9J1EDNIkNLD3+OVdbloLqFNn7hzXGF72ufH3qWbcuTWVniWkr3pKufb0gGbfDOjI1AiaXyVUhFNvikqGQaEVc2c/ktqCebFDchPRGOvwyy5DO/0lcDsOAOsedT+nrv/JmBzCDwgZLqXi8huqZkVYyqOU/YTtMtZmuP10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=u7olUKfS03c9Mbr4nQGTSTHx3nl6QJuN1w4bvpppFPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZ/mHT5GI7bJef7jU588klWkEYamaimqPX7iYmLmX8m0l/G+O9jQi3YgfD1ggEyMT0z83LGvO2DbjMbHGoDjpFbW9OWVbC3DZREqekA+vnmWcKU9o3zrf2cy3t/4WxlZoqIwDSg0N1/0CwB9tbz0tmcjIrplkwgvjopmpC2hn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKDMQS/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B942C4CEF7;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=u7olUKfS03c9Mbr4nQGTSTHx3nl6QJuN1w4bvpppFPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MKDMQS/xbsGvDn6qIllD0JAJlqSPjefAqNiJ+rY6r98mq0e/KpOKPGkKTCAmxpCzw
	 C0zOnjfUsDa7MvrFhDw3QdYHEqw+pVRyDilw/+sVlXqWFxUkd0dz9u0eeCxC5ZDjv2
	 1AXbcgTdrRafUmdGS2buu7lYadsPNUFpPsY4hWaLNbChmjcDspfF4kHBZFiHsPAtOh
	 fKFCXPo4d9bzhhttloiW5oFD2K9OUevwUMPqwUwPeNJgXjc+Xu1IAIznAy74zowhZL
	 V2sJXsVyuj/EuYSviDtda5gCQLvGzylFMhWqIx8O+QMqHewbJ77cPOwfcusl/qi6Lw
	 MxdUN61v4D8+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F02C83F1D;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:55 -0500
Subject: [PATCH 12/17] usb: gadget: tegra-xudc: Add Tegra210B01 Support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-12-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=1624;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=hwelDVF01l5ZRuL1g/lhcmuuedoseJ2J1ZVrnMI3gXs=;
 b=baFB1DdUEiia6vOQK8oaNGYQd3FsJhUrLGKbcFZMIszCMnODWRn0Ug45lihanr925q/MIEhwc
 MiBWkJ36UueBY0taC3Y8kgN3WP59wXKyUpgQRjaLt6QHrUdgjgRhxJ5
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
2.50.0



