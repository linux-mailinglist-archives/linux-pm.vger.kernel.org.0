Return-Path: <linux-pm+bounces-34632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE73B5724D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211493B06B2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980522EC08E;
	Mon, 15 Sep 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DosSW2gp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7B2EB874
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923351; cv=none; b=bB3czN5rKMX/wXzcdoQzC+CMD2qWOEwuturQnMUK+p2QeBv5kQnhjaqj8JqbuTqf9UBn0LSlHKSte6XHgYI/mwJpsJVka/bIbo2u3M9T0ekICTxOSMOd4z0LK4wYJRNyISPqPDJBvpCVvdv5Ovd/5ll2InkEcDpiNYPGubyk0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923351; c=relaxed/simple;
	bh=ye9UTh3DGTIR2GXSy9SPAJZIcahY1wHdNVmZ/3VEzHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1jNlbAahAxFOE8nDcmYvbKWmjTg8b+49CnOfL3zyNPFY+aMEW9WnzNai6a2a2dqyTy8oDdeTF6IYVnuZCdWlzCIVWa8Mwo+PDW221Lze8JVOLbwbHXQv5MGW+GmuwRhrrE0N7RjJt12FLhKDwD7AwpvYWMm/qw16g5hukwHGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DosSW2gp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso3684931e87.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923347; x=1758528147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATEPApqyTT3jVHOmbw/KgRu7Cv8Hn9TFPWpJMkbUBLE=;
        b=DosSW2gp9e50j/9LysjVps0WKRPolXJ1QIj7yRTQfaDqRCkXij3sqbMspnyvTPB+U1
         aYqEwHIk8eV4He35auNMcDyzw7DnQpPdZ5jq71zcN4H2kR3b0QFQW8JZyhUBuSMd+y94
         p6znGuYIp/Hairdx34BfzZJdIMQzhSYEsZeddpyulQwvC9xo0pZVTKkDXjTFM77mP5ml
         ZJqLRAjUHMeBEBSM8OhrKfd6lbIpI1zleyErl3qC54IB9NaYAPG2xQozeUodIwAFKU/C
         GM7sHQLKStkLS0CZWq87tjBEvmuaht7kR6zqzCJm3AOZaE5+rgdhIWURngWN0jj+93w5
         67jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923347; x=1758528147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATEPApqyTT3jVHOmbw/KgRu7Cv8Hn9TFPWpJMkbUBLE=;
        b=j8Lf5ozUj4+WQL+9gp/4JoL3D49EZ3Ytun2TPSimw2l8Is4r4A3Z2fKxeaYGOOxzgD
         nGVZbKvZecLbuJl90+i+WvhQY0PJLlmvCycS5hd1/9TqELWDS3eHkj/EfTMhnlOu18Qz
         TrgKwqU0uBUvCMoZAFKU2t63VE8sW4jP4Ot9PNna3WHdOavhhPzbvLQNo7hTX5m9Kx+t
         Ajkm7UPSq5lcNok3GF31jV3A5BO8fL8QQdJo8Eb8uVy3GSn82XlKM5bKiW3WGynKL30u
         s3z07xWWK6BcQKrgH4Pc5pLESdIUVRyDJGYwX+GEEwfh4wwFoKcaw2AAYPtLVQCJhnpd
         3vog==
X-Forwarded-Encrypted: i=1; AJvYcCWR3ALOkGGbv5SgJyC35A71GiEmxtFRvCy+hWCHMkqdD98jIlVxeT7Zm2MURGGH5WO1ScBuCqPVnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAe+OjE+rB227W1Kn+EoVfss9yhy9fPPF6APsMBbLNx91rpJ5D
	5MPylSwDuPEDXqeegf1tbzwTUjtEVZsQIYwMstntJ1xHZtZM9C3CCUSa
X-Gm-Gg: ASbGncvkLdo26AMnN7gghCDHJeFJd4WFxYucZD5YLT8nJ28T4yXd9yXa+05w2Zjw6kz
	mZnNB1R3t834CO4Ngpy7lm218lo0V0+Ebm69SUpvcGnj/qOl32FHWykZ348ep9nBOGs0BefGX81
	4/5dZYXcMI0n8Gn8Evp9BsmXs2GfJeJ2t7YCMmTwrFcR0wPY+4Rxlmk2XBUuB0AJwBCytfx5jYF
	Ll3+3919RDR64CS0S+5UZst/euWks2S+LDCUltZ1QAnhDaPz/jV9lFTcKgnNORSv8raE2Sbf1SA
	u8zthHlUBZRRRY+lZ6oqVpnioo/Q/6GAZAHeOFl8QEWZACUnRcjAqT3Ue8A89XRsjlDuwfIvXvu
	Ys/xtebVFhN7sPJvZp/2V7ZEo
X-Google-Smtp-Source: AGHT+IFE2b9fNGrtXtktFaLnqY0Wj56OIzV2rKxcVX1YbWplFFMNHaFswaLdAdbTgGawmGgAW0AddQ==
X-Received: by 2002:a05:6512:2585:b0:55f:43ba:9410 with SMTP id 2adb3069b0e04-5704b52f23emr3336414e87.15.1757923346893;
        Mon, 15 Sep 2025 01:02:26 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:26 -0700 (PDT)
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
Subject: [PATCH v3 04/11] memory: tegra: implement EMEM regs and ICC ops for Tegra114
Date: Mon, 15 Sep 2025 11:01:50 +0300
Message-ID: <20250915080157.28195-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
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
2.48.1


