Return-Path: <linux-pm+bounces-30839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E83B04FEC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789FA188FF23
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F92D4B47;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/l2XBgv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A22D3A7D;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=LpFODl5VF2UwD39KQJJ3a+EqJd8AZ3RpazIJk5gzqAJxIttTIfDuQWHTG3QFD3jNy8u4kuv7Fxxzj7qj4zTFM4jlUpjvztjCsecXTSoIgoAKqd+lTz95eOQYqr3lXILruAQEq/vcTolNiuZm+MGaGTNvPPEm/o8qOwj+v6BOHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=8XHtSfC2ebH34+htWvEVWam88ECVhbOPEjKTBosP36M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XM83EE50gSdZjuA56OQglmkWYD/pcuzOzcypNF+8ESBBD78etZq7fJpyuY/19W4JhWQ1Qq3vmw5jGjseVtvp1ymGwNkx7RXPdB5+U2u4Zk1pW+HIgt15EDu0TkWLcA55tQ6m741YWbsFfo5xDSeTnSYlO7nKN5nms9h8g3biY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/l2XBgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EC91C4CEF1;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=8XHtSfC2ebH34+htWvEVWam88ECVhbOPEjKTBosP36M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g/l2XBgvd8t+W6vEh/KOnsx4FBK4zAHQi5sEFcvjPZ4vc9KMsd/uJUUBWkg07WDnb
	 Kkmf2IUfqfJo0As0P4IgRq+GwXK7YphNXQLzSNHF1KKBfOMZf7XwSAiMOHrJ25uOs5
	 fzuSqgM9Ly3nQe+37FcBFmHzLAaLPeCBtdWuCkjRVPtaV7+SMRQ2wVgZLHWlkXNelb
	 RdM84H4cYS/S/J4L2EaQ5sAqNWRe4OQg/RMmjcnwnDcbxiEaZW/kT87Ff10Z+iXKXt
	 ZkzdZuQ3xqcrJHJfYFGVFPi6sPte4GiAgDHya8qDYUAruuh3O4VHc/B0FYHaacl/eD
	 FfyYlP74vLY3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D7C83F2E;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:56 -0500
Subject: [PATCH 13/17] thermal: tegra: Add Tegra210B01 Support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-13-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=4724;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ZTHZksfHlIxysbAaJHHhbZR9I6Z/OnRkEYYXQcE8KVM=;
 b=8bwnEv+juqDwOC653qmsqpRvdzpkcOy+aV1SQ5AXOhYjO+I7luZqUcUhrFn/V12PUyySpevTJ
 rschJRrtETMCPrFH4PwCgkuKQ4zsJb+1XHs5LFtfJ2zabx2dj9ychbW
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add Tegra210B01 SOC_THERM configuration

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/thermal/tegra/soctherm.c          |  4 ++
 drivers/thermal/tegra/soctherm.h          |  1 +
 drivers/thermal/tegra/tegra210-soctherm.c | 78 +++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 926f1052e6de04fc4d5ff78334b52ffe98cdf4ca..e07ae0e5553f38b78f30bb88a0e02aca995d7b5a 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2065,6 +2065,10 @@ static const struct of_device_id tegra_soctherm_of_match[] = {
 		.compatible = "nvidia,tegra210-soctherm",
 		.data = &tegra210_soctherm,
 	},
+	{
+		.compatible = "nvidia,tegra210b01-soctherm",
+		.data = &tegra210b01_soctherm,
+	},
 #endif
 	{ },
 };
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 70501e73d586230d3caca8dea0966afd7f23142a..0d80e739b67da23571137db0cc3140c8967fa071 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -147,6 +147,7 @@ extern const struct tegra_soctherm_soc tegra132_soctherm;
 
 #ifdef CONFIG_ARCH_TEGRA_210_SOC
 extern const struct tegra_soctherm_soc tegra210_soctherm;
+extern const struct tegra_soctherm_soc tegra210b01_soctherm;
 #endif
 
 #endif
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index d0ff793f18c561230497b57b325ae87f12a7b83a..80f67c1fd496d613147ecc6618c4934d03b1e67e 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -44,6 +44,14 @@ static const struct tegra_tsensor_configuration tegra210_tsensor_config = {
 	.tsample_ate = 480,
 };
 
+static const struct tegra_tsensor_configuration tegra210b01_tsensor_config = {
+	.tall = 16300,
+	.tiddq_en = 1,
+	.ten_count = 1,
+	.tsample = 240,
+	.tsample_ate = 480,
+};
+
 static const struct tegra_tsensor_group tegra210_tsensor_group_cpu = {
 	.id = TEGRA124_SOCTHERM_SENSOR_CPU,
 	.name = "cpu",
@@ -125,6 +133,12 @@ static const struct tegra_tsensor_group *tegra210_tsensor_groups[] = {
 	&tegra210_tsensor_group_mem,
 };
 
+static const struct tegra_tsensor_group *tegra210b01_tsensor_groups[] = {
+	&tegra210_tsensor_group_cpu,
+	&tegra210_tsensor_group_gpu,
+	&tegra210_tsensor_group_pll,
+};
+
 static const struct tegra_tsensor tegra210_tsensors[] = {
 	{
 		.name = "cpu0",
@@ -193,6 +207,58 @@ static const struct tegra_tsensor tegra210_tsensors[] = {
 	},
 };
 
+static const struct tegra_tsensor tegra210b01_tsensors[] = {
+	{
+		.name = "cpu0",
+		.base = 0xc0,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x098,
+		.fuse_corr_alpha = 1085000,
+		.fuse_corr_beta = 3244200,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "cpu1",
+		.base = 0xe0,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x084,
+		.fuse_corr_alpha = 1126200,
+		.fuse_corr_beta = -67500,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "cpu2",
+		.base = 0x100,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x088,
+		.fuse_corr_alpha = 1098400,
+		.fuse_corr_beta = 2251100,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "cpu3",
+		.base = 0x120,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x12c,
+		.fuse_corr_alpha = 1108000,
+		.fuse_corr_beta = 602700,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "gpu",
+		.base = 0x180,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x154,
+		.fuse_corr_alpha = 1074300,
+		.fuse_corr_beta = 2734900,
+		.group = &tegra210_tsensor_group_gpu,
+	}, {
+		.name = "pllx",
+		.base = 0x1a0,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x160,
+		.fuse_corr_alpha = 1039700,
+		.fuse_corr_beta = 6829100,
+		.group = &tegra210_tsensor_group_pll,
+	},
+};
+
 /*
  * Mask/shift bits in FUSE_TSENSOR_COMMON and
  * FUSE_TSENSOR_COMMON, which are described in
@@ -226,3 +292,15 @@ const struct tegra_soctherm_soc tegra210_soctherm = {
 	.use_ccroc = false,
 	.thermtrips = tegra210_tsensor_thermtrips,
 };
+
+const struct tegra_soctherm_soc tegra210b01_soctherm = {
+	.tsensors = tegra210b01_tsensors,
+	.num_tsensors = ARRAY_SIZE(tegra210b01_tsensors),
+	.ttgs = tegra210b01_tsensor_groups,
+	.num_ttgs = ARRAY_SIZE(tegra210b01_tsensor_groups),
+	.tfuse = &tegra210_soctherm_fuse,
+	.thresh_grain = TEGRA210_THRESH_GRAIN,
+	.bptt = TEGRA210_BPTT,
+	.use_ccroc = false,
+	.thermtrips = tegra210_tsensor_thermtrips,
+};

-- 
2.50.0



