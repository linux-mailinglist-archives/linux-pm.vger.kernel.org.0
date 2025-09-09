Return-Path: <linux-pm+bounces-34202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752B1B4A20B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2080C1739AE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 06:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA923043CE;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5wFqBb7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF5303A0C;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398895; cv=none; b=HhduKCl/4Ao2cIFED1bfIW95dMLyVE7vlyOJat/pYDgeUQNFPCBMOMPgPwm2LviXpek1LhD4aMFPZh9Xo41URyZYRYAjD3c4moD9VPsFQs5EVlwdWy1Wq1hNhk+w99VRBbextTPNX6OYlvuIhz/Tddp80I+Ai/SqwQmhgNj4Oo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398895; c=relaxed/simple;
	bh=A3ft+SxI4NFHmoZ4Cc4iWC22ct2WO9bN7Z4S5URvJxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVI5sw5oFnv83LVlthpAiBYn/lq7fqQ16lIeGObXom2dT90US9AA6Lf9dxyGM4Xn0awNLT0N3wvyPUR2BFpFXSRPkVdFJX4FXDA1OZMWxlts4zML60YLwKCT8JP1gBu39xTMCdjViRHhdIDo6RXmfe7oz1C6+Z5FTntL2soo54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5wFqBb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A552FC116D0;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757398894;
	bh=A3ft+SxI4NFHmoZ4Cc4iWC22ct2WO9bN7Z4S5URvJxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y5wFqBb7SCsSmsUWBCd4WAvRctBZpqiueNH4A7OVSzKyjN5hMAVci60SyOng2Vpmd
	 NgDXbZhKZBRapY80Qxzzot4MJhVAqjY9iuMEHl0+ED/qBx90sTNRaFiUi6IaRG7xq9
	 WPYduNswY3Csq6eZ2XGiIxbwrx1oColONzJgnL9KDIvxP+rHDvMGabCJir3wkLO7qS
	 SL1vrAsuzCzU5VAt0+22Th6NXoQNDbfaSucpJfPMxRv3BibHUSmQc013TfV9z4m2je
	 PQvmjHdwq0dBeYLhVe3c9D1nWRjh8G5fWbA4MzNUQPKQB7XY+BgKJenYSsc7rvIAz6
	 NDmVcZgulFsSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D331CA0FED;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 09 Sep 2025 01:21:34 -0500
Subject: [PATCH v2 6/8] memory: tegra194: Support icc scaling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-tegra186-icc-v2-6-09413724e781@gmail.com>
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
In-Reply-To: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757398893; l=2712;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=3MNvz35Who37oCQFtQGQqKBjr1XzOGhEfbsNxRdRmLQ=;
 b=9TUPlrXy5MPMzLxaXGR6HI6g2rU8jq8oKe9JYY1cIBcxVHQ7yQRRaNk6U8TEAYstVhrFftoVN
 57mbONCg6c6CJw5BWE1SXweNkq93EGbdUE/io+qeNOudktpXot+mIVp
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add Interconnect framework support to dynamically set the DRAM
bandwidth from different clients. The MC driver is added as an ICC
provider and the EMC driver is already a provider.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/memory/tegra/tegra194.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index 26035ac3a1eb51a3d8ce3830427b4412b48baf3c..e478587586e7f01afd41ff74d26a9a3f1d881347 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1340,9 +1340,66 @@ static const struct tegra_mc_client tegra194_mc_clients[] = {
 				.security = 0x7fc,
 			},
 		},
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER0,
+		.name = "sw_cluster0",
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER1,
+		.name = "sw_cluster1",
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER2,
+		.name = "sw_cluster2",
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA_ICC_MC_CPU_CLUSTER3,
+		.name = "sw_cluster3",
+		.type = TEGRA_ICC_NISO,
 	},
 };
 
+static int tegra194_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	/* TODO: program PTSA */
+	return 0;
+}
+
+static int tegra194_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct icc_provider *p = node->provider;
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
+
+	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER2 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER3) {
+		if (mc)
+			peak_bw = peak_bw * mc->num_channels;
+	}
+
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static int tegra194_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static const struct tegra_mc_icc_ops tegra194_mc_icc_ops = {
+	.xlate = tegra_mc_icc_xlate,
+	.aggregate = tegra194_mc_icc_aggregate,
+	.get_bw = tegra194_mc_icc_get_init_bw,
+	.set = tegra194_mc_icc_set,
+};
+
 const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
 	.clients = tegra194_mc_clients,
@@ -1355,7 +1412,7 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
-	.icc_ops = &tegra_mc_icc_ops,
+	.icc_ops = &tegra194_mc_icc_ops,
 	.ch_intmask = 0x00000f00,
 	.global_intstatus_channel_shift = 8,
 };

-- 
2.50.1



