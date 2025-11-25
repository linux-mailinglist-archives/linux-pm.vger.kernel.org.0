Return-Path: <linux-pm+bounces-38576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79521C84E23
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6FC24E87E5
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BFA3195E0;
	Tue, 25 Nov 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQmtfZga"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5F31A815
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072387; cv=none; b=ToQyObIR3O1v30AlCGBq/kbu/SveCx55R6IytS/rJTVgFea/ZENneRAVGALYcENsVffrICuGmzw6g7uAmdnP23slQsOp0vwLpojFWeHmi2YDtAf7VGKbDMPhEMDLTPNt4lqL+dTWvDK2c4FQWAzYPkKegdJiyvuxTiHMHa24/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072387; c=relaxed/simple;
	bh=vCLI0D38I7UFcPwZZbFQiumGdDRiJ+S0BamD2HUcfBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtjdJgcHUXsLTzhwSQn5CQgo2Hum/hO+xVsalOr/PMMiIXTiVGPRZpcaIokkPif6zNEG0A+fs+qVz58KnKj99C/byOyFGoEoPbW4HkmQlucNVMAwQsnwdv1r4v6/625GCK/Jbl3MCtxYuOEhlJV7DAciT2vuQPEWB3imaW8rioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQmtfZga; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59583505988so7320479e87.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072383; x=1764677183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBPLwWIdtjG1mcTPYivwQD9uLIkx3G/GI8kSilZAKuE=;
        b=iQmtfZgaI5L1eVlazBvuLdLMzsCsiHVHKRaDMAzkW56hPbJDqFqCe2+dwvAgpXnlf+
         KdKGiY7gV0Vr8x3LOWSGXy+jgNnoBayVbfEp1PutTtDOuVCDfR7b4e2D8j1Jpb1kEHC7
         cCgMmM0Ty5+EN8/iHFEkDQXOJ9tu+u0ydcCJ2k1+xftVPamywvGKLOoqeFqAct25e0YW
         LLYbge8hTkivgVHzkVYwHvqZcj9MuA4sqIIZeS97eCVaj0FLprwTE1ftO492r2cIHK85
         aPsmppV7BTEsHfTNHXlDNpky0HX29f/KFKZMzwnekJSby7+M7gseBtBzsxcChGog4qC2
         jBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072383; x=1764677183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBPLwWIdtjG1mcTPYivwQD9uLIkx3G/GI8kSilZAKuE=;
        b=AGCt6Yn5c/gvVLa7vtgWv6M5pu3fF/fRlp3DTQy4wC1WOIuM30NGtbo8o7vbevzbTV
         aksHSr54V+o5YmBAYtkINCteGq6pCfgGIjiXDPVwpIVtSN4ycA5BEtMGkV8o2W2Smw8w
         ub1njFPO9OeQLR8Y3r+T7XcV/ETC+muAhAlRNHoL5PkUgf2hligDjrO9eGvOeE8CerIp
         4jYR8NYZiuoU6o+7eRNJ0Na1FRDbHc06PsIy4SZVzTqRu/4e9Mo7PdbdT/fHuwjuXRps
         PgUhMrWWr1B6/zQEek818sRo4LXaMp+DSXuXDcH09jBDMmJS4+eIpynozmX24R/yLrGP
         cKZw==
X-Forwarded-Encrypted: i=1; AJvYcCUW2Tm8XZaCo+DJD4t+BGWLbgJUHhocZeRyBXQBE/+Brx4xzJxiUrGyYhJsmNE9k/dCd9XwGTuXlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeC/vpKazqEQOJlCNzXsc6rKQy3SwBJROIitJiyIGymYcMWAT
	wHDvP+5ROKNF4ddofCHxILBRpP7LF3AZ5XBHMDKenPsWCqtWZ0H0bW1d
X-Gm-Gg: ASbGncs4NDouB3eXEYKWech6RJjmNOAyvjDQreInvXvMmq2qO2ULRaUyI3dGTeUvtk1
	7ywiycdJbH41WI2HSS1hdUredIAGyoTAODWTLYjxYj7nC+o4OM+NRcBkFDH8uYM74t3q5tMY7ic
	nSQ9BjlyzHlALxabKOztg6pQWZ6MSjDMRiSta29jDOI4ELnSejElobQ5oDiH1AMObtz6qvOLYJC
	F0k152JU9ZQ2OaJedyNRRbfYdYnx4YX7VlMi0Uo/TPnntF5RBfrQ6rcR0S0PBlTNLC0+TFYK5ND
	mrD9zdNjCt90tetn3gkTEWmSgZj6K7FvVVFoMSwnyg5VdyCYtObCwyUX0Kr3vHQSE2GgfTSnTtM
	aUS5NGKZIP0cdG1ASOrfVYOf7SqBh6edGbXarRn3t+kFKF3N3t0Y2Q636/YeaK4npZ+Hg3r+5On
	I=
X-Google-Smtp-Source: AGHT+IGykcBRsPUsz7Ak6ifQ8PwSl1/S9aiCfj6adli2FqPi9i4Uh9NGgAAcUrxrwauN/J/3yHIxIQ==
X-Received: by 2002:a05:6512:12cd:b0:595:7b24:d352 with SMTP id 2adb3069b0e04-596a37b55damr4631276e87.24.1764072382925;
        Tue, 25 Nov 2025 04:06:22 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 04/12] memory: tegra: implement EMEM regs and ICC ops for Tegra114
Date: Tue, 25 Nov 2025 14:05:51 +0200
Message-ID: <20251125120559.158860-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125120559.158860-1-clamor95@gmail.com>
References: <20251125120559.158860-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare Internal Memory Controller for introduction of External Memory
Controller.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/memory/tegra/tegra114.c | 193 ++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index d03a5d162dbd..c615857f7fad 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/mm.h>
 
@@ -1165,6 +1166,195 @@ static const struct tegra_mc_reset tegra114_mc_resets[] = {
 	TEGRA114_MC_RESET(VI,       0x200, 0x204, 17),
 };
 
+static void tegra114_mc_tune_client_latency(struct tegra_mc *mc,
+					    const struct tegra_mc_client *client,
+					    unsigned int bandwidth_mbytes_sec)
+{
+	u32 arb_tolerance_compensation_nsec, arb_tolerance_compensation_div;
+	unsigned int fifo_size = client->fifo_size;
+	u32 arb_nsec, la_ticks, value;
+
+	/* see 20.3.1.1 Client Configuration in Tegra4 TRM v01p */
+	if (bandwidth_mbytes_sec)
+		arb_nsec = fifo_size * NSEC_PER_USEC / bandwidth_mbytes_sec;
+	else
+		arb_nsec = U32_MAX;
+
+	/*
+	 * Latency allowness should be set with consideration for the module's
+	 * latency tolerance and internal buffering capabilities.
+	 *
+	 * Display memory clients use isochronous transfers and have very low
+	 * tolerance to a belated transfers. Hence we need to compensate the
+	 * memory arbitration imperfection for them in order to prevent FIFO
+	 * underflow condition when memory bus is busy.
+	 *
+	 * VI clients also need a stronger compensation.
+	 */
+	switch (client->swgroup) {
+	case TEGRA_SWGROUP_MPCORE:
+	case TEGRA_SWGROUP_PTC:
+		/*
+		 * We always want lower latency for these clients, hence
+		 * don't touch them.
+		 */
+		return;
+
+	case TEGRA_SWGROUP_DC:
+	case TEGRA_SWGROUP_DCB:
+		arb_tolerance_compensation_nsec = 1050;
+		arb_tolerance_compensation_div = 2;
+		break;
+
+	case TEGRA_SWGROUP_VI:
+		arb_tolerance_compensation_nsec = 1050;
+		arb_tolerance_compensation_div = 1;
+		break;
+
+	default:
+		arb_tolerance_compensation_nsec = 150;
+		arb_tolerance_compensation_div = 1;
+		break;
+	}
+
+	if (arb_nsec > arb_tolerance_compensation_nsec)
+		arb_nsec -= arb_tolerance_compensation_nsec;
+	else
+		arb_nsec = 0;
+
+	arb_nsec /= arb_tolerance_compensation_div;
+
+	/*
+	 * Latency allowance is a number of ticks a request from a particular
+	 * client may wait in the EMEM arbiter before it becomes a high-priority
+	 * request.
+	 */
+	la_ticks = arb_nsec / mc->tick;
+	la_ticks = min(la_ticks, client->regs.la.mask);
+
+	value = mc_readl(mc, client->regs.la.reg);
+	value &= ~(client->regs.la.mask << client->regs.la.shift);
+	value |= la_ticks << client->regs.la.shift;
+	mc_writel(mc, value, client->regs.la.reg);
+}
+
+static int tegra114_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(src->provider);
+	const struct tegra_mc_client *client = &mc->soc->clients[src->id];
+	u64 peak_bandwidth = icc_units_to_bps(src->peak_bw);
+
+	/*
+	 * Skip pre-initialization that is done by icc_node_add(), which sets
+	 * bandwidth to maximum for all clients before drivers are loaded.
+	 *
+	 * This doesn't make sense for us because we don't have drivers for all
+	 * clients and it's okay to keep configuration left from bootloader
+	 * during boot, at least for today.
+	 */
+	if (src == dst)
+		return 0;
+
+	/* convert bytes/sec to megabytes/sec */
+	do_div(peak_bandwidth, 1000000);
+
+	tegra114_mc_tune_client_latency(mc, client, peak_bandwidth);
+
+	return 0;
+}
+
+static int tegra114_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
+				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	/*
+	 * ISO clients need to reserve extra bandwidth up-front because
+	 * there could be high bandwidth pressure during initial filling
+	 * of the client's FIFO buffers.  Secondly, we need to take into
+	 * account impurities of the memory subsystem.
+	 */
+	if (tag & TEGRA_MC_ICC_TAG_ISO)
+		peak_bw = tegra_mc_scale_percents(peak_bw, 400);
+
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static struct icc_node_data *
+tegra114_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
+	const struct tegra_mc_client *client;
+	unsigned int i, idx = spec->args[0];
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	list_for_each_entry(node, &mc->provider.nodes, node_list) {
+		if (node->id != idx)
+			continue;
+
+		ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+		if (!ndata)
+			return ERR_PTR(-ENOMEM);
+
+		client = &mc->soc->clients[idx];
+		ndata->node = node;
+
+		switch (client->swgroup) {
+		case TEGRA_SWGROUP_DC:
+		case TEGRA_SWGROUP_DCB:
+		case TEGRA_SWGROUP_PTC:
+		case TEGRA_SWGROUP_VI:
+			/* these clients are isochronous by default */
+			ndata->tag = TEGRA_MC_ICC_TAG_ISO;
+			break;
+
+		default:
+			ndata->tag = TEGRA_MC_ICC_TAG_DEFAULT;
+			break;
+		}
+
+		return ndata;
+	}
+
+	for (i = 0; i < mc->soc->num_clients; i++) {
+		if (mc->soc->clients[i].id == idx)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	dev_err(mc->dev, "invalid ICC client ID %u\n", idx);
+
+	return ERR_PTR(-EINVAL);
+}
+
+static const struct tegra_mc_icc_ops tegra114_mc_icc_ops = {
+	.xlate_extended = tegra114_mc_of_icc_xlate_extended,
+	.aggregate = tegra114_mc_icc_aggreate,
+	.set = tegra114_mc_icc_set,
+};
+
+static const unsigned long tegra114_mc_emem_regs[] = {
+	MC_EMEM_ARB_CFG,
+	MC_EMEM_ARB_OUTSTANDING_REQ,
+	MC_EMEM_ARB_TIMING_RCD,
+	MC_EMEM_ARB_TIMING_RP,
+	MC_EMEM_ARB_TIMING_RC,
+	MC_EMEM_ARB_TIMING_RAS,
+	MC_EMEM_ARB_TIMING_FAW,
+	MC_EMEM_ARB_TIMING_RRD,
+	MC_EMEM_ARB_TIMING_RAP2PRE,
+	MC_EMEM_ARB_TIMING_WAP2PRE,
+	MC_EMEM_ARB_TIMING_R2R,
+	MC_EMEM_ARB_TIMING_W2W,
+	MC_EMEM_ARB_TIMING_R2W,
+	MC_EMEM_ARB_TIMING_W2R,
+	MC_EMEM_ARB_DA_TURNS,
+	MC_EMEM_ARB_DA_COVERS,
+	MC_EMEM_ARB_MISC0,
+	MC_EMEM_ARB_RING1_THROTTLE,
+};
+
 const struct tegra_mc_soc tegra114_mc_soc = {
 	.clients = tegra114_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra114_mc_clients),
@@ -1172,10 +1362,13 @@ const struct tegra_mc_soc tegra114_mc_soc = {
 	.atom_size = 32,
 	.client_id_mask = 0x7f,
 	.smmu = &tegra114_smmu_soc,
+	.emem_regs = tegra114_mc_emem_regs,
+	.num_emem_regs = ARRAY_SIZE(tegra114_mc_emem_regs),
 	.intmask = MC_INT_INVALID_SMMU_PAGE | MC_INT_SECURITY_VIOLATION |
 		   MC_INT_DECERR_EMEM,
 	.reset_ops = &tegra_mc_reset_ops_common,
 	.resets = tegra114_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra114_mc_resets),
+	.icc_ops = &tegra114_mc_icc_ops,
 	.ops = &tegra30_mc_ops,
 };
-- 
2.51.0


