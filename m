Return-Path: <linux-pm+bounces-33514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6FB3D767
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0171885E42
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DC235BE2;
	Mon,  1 Sep 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8tqZHLt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5653223DCE;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697664; cv=none; b=vF5bV+YHvPUIAyFqymnkjzx5wDlc6ZAQfVlKG/Dpi1r+JigYRLsIVXSdHdSIbcAQtw+jAlA4fuqfx+Q45LSxeJqUaNJ7kznhCTuSUjvNgUqSQrRKeMi0VARmXf4XQo0CQaEwbaJLe1nVSycIUy0bgbPYxRZgowUZtv0TbIqGeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697664; c=relaxed/simple;
	bh=r3pUzrkcWVNCbofMp9WGG3qQXL4dcWz8Z9kujWaLZG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyMfb+nLFX6sGN2Vl1rTlvvA6/h3nXGilVvGImWm6WuNIjbrmaUzbWwTHmgJPWfgd+I0Rqacs5vZs8ZvgBpLitp9fXhgoEQ71+TKaNOA2oLMdWGuh5MsTR+/dOiiSuUuW043HTwq/ToEUno04bEIxSUGS9g3UugQ0N04wAs0prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8tqZHLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 625DAC113CF;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756697664;
	bh=r3pUzrkcWVNCbofMp9WGG3qQXL4dcWz8Z9kujWaLZG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O8tqZHLtz7at6qJhS9j4YrLQHNFw+3Yuj0+5iVkxGsD+B4Q6XthybflzuCWaIQhOp
	 273wgYHdHeBVghLPTq11XlZTV8INNULHWbvsvPlukjGoraCYILtIMXXD3HHEotG43v
	 txOO7UXVz5m2cR0KFja+5LIyoP+pOLH3JZ78G7YA/ChRoBkRDUQ9qZh/lof8eexSL0
	 p0lMsD9aUzchL/ThMXov2G0wdxdsF+2X1PD5tZ+tIKsV0yO6JwKUxPbbSkvuEXk0ds
	 4SgXr3N2dmAvOrkkxww3DOC1ddIHU08g6dh9fAS0BREn9joRUNrXDLgycsjju+tkkD
	 0W0/QihrctuHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A738CA1005;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 31 Aug 2025 22:33:53 -0500
Subject: [PATCH 5/8] memory: tegra186: Support icc scaling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-tegra186-icc-v1-5-607ddc53b507@gmail.com>
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
In-Reply-To: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756697663; l=2383;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=oxIJSUp3ozTyoLouc+lEW3YE1MQYQJbWMy5w5OZ/8c0=;
 b=6HE3/jakqKvQK0W06roOceFvPeItZFKCHApDFX9RQY94sI/gq8GlhcW0BqVLloyCF2g9NDBIK
 puTwzDavdgDA8WSjScPk/vExPYyuwRC9wL2Q2tPYVhWIcgpHfae/U4w
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
 drivers/memory/tegra/tegra186.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index aee11457bf8e032637d1772affb87da0cac68494..1384164f624af5d4aaccedc84443d203ba3db2c6 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -899,9 +899,56 @@ static const struct tegra_mc_client tegra186_mc_clients[] = {
 				.security = 0x51c,
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
 	},
 };
 
+static int tegra186_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	/* TODO: program PTSA */
+	return 0;
+}
+
+static int tegra186_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct icc_provider *p = node->provider;
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
+
+	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
+	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1) {
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
+static int tegra186_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static const struct tegra_mc_icc_ops tegra186_mc_icc_ops = {
+	.xlate = tegra_mc_icc_xlate,
+	.aggregate = tegra186_mc_icc_aggregate,
+	.get_bw = tegra186_mc_icc_get_init_bw,
+	.set = tegra186_mc_icc_set,
+};
+
 const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
@@ -912,6 +959,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
+	.icc_ops = &tegra186_mc_icc_ops,
 	.ch_intmask = 0x0000000f,
 	.global_intstatus_channel_shift = 0,
 };

-- 
2.50.1



