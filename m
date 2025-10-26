Return-Path: <linux-pm+bounces-36846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB70C0AB9F
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 15:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEBE189AA33
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B62EA170;
	Sun, 26 Oct 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdfKS5E9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFA21255B;
	Sun, 26 Oct 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490290; cv=none; b=Hd2lVBOJjqnI3w5bueF7hD2EIb+ZRmANr0wwlPSJVKnbXWTZobPj8+HcX3ocyEaleDfDLsDrrFvx0tae5eGFzSuyWX3rsXCkzFgRMMkXWyK8d7ldTbXHGKUJ4igwbTfFtBMcFjbzyZ/49i1EK4vWxOxcyJXuRQQrDtFeWRXbXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490290; c=relaxed/simple;
	bh=4vTT0FyKPNjsqEerarHmYTUfCGgYxM2Ua+H89VPNHns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpuG/Oy7sJ5Cg4oW6iHtu49h0VyloNtQSL8etdz1cgZz4V2n8yholrnTgn+tETvf4cM6lKI0iceIZGh6f938eu1DV5Uu8sAcsCghmKJblho9fKT6mAkbxvYsHG6fkvyYXIrLPOT+cEk+EK/IXTTdKv/vtblGVxGK6CnmJZU89ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdfKS5E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD95C116B1;
	Sun, 26 Oct 2025 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761490290;
	bh=4vTT0FyKPNjsqEerarHmYTUfCGgYxM2Ua+H89VPNHns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdfKS5E9PXjN6nnjBxfmHtAy/tzt60/Ds1aiwHVyI6Zgofqy/iRpFzycEshW3DEDM
	 jA5YUwo9IpOeX/JfnP/EOploPLAA7f1nOP51Feshiqq1HH/odTqbNKAIxdrJajljXK
	 M9H+nJshBrrJfffCjuUUSphJobBEYbvudre4du63NDPOlSN8XRCTLtdJA1ZPwL2z3P
	 YhcSzFNXnSx7p34EvHCT0fnAPfJsOKmm472p6rw8hKT1hZyJT4FvBCPiarATLCn2gx
	 BehaOw8JqbbGMHycaMaYeDzp1Lz4GvbvuR0WbQPntD4Zc/Lhzunr9NnJkbyVAArMYl
	 3Q+nT0PvI6zzw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Aaron Kling <webgeek1234@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.15] cpufreq: tegra186: Initialize all cores to max frequencies
Date: Sun, 26 Oct 2025 10:49:20 -0400
Message-ID: <20251026144958.26750-42-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026144958.26750-1-sashal@kernel.org>
References: <20251026144958.26750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aaron Kling <webgeek1234@gmail.com>

[ Upstream commit ba6018929165fc914c665f071f8e8cdbac844a49 ]

During initialization, the EDVD_COREx_VOLT_FREQ registers for some cores
are still at reset values and not reflecting the actual frequency. This
causes get calls to fail. Set all cores to their respective max
frequency during probe to initialize the registers to working values.

Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `tegra186_cpufreq_get()` reads the EDVD register for a policy’s lead
  CPU and returns 0 when the register is still at its reset value
  (`drivers/cpufreq/tegra186-cpufreq.c:120-126`); the cpufreq core
  treats a zero return as fatal and tears down the policy
  (`drivers/cpufreq/cpufreq.c:1486-1492`), so the driver currently fails
  to probe on systems where some cores never had their EDVD register
  programmed by firmware.
- The patch teaches `init_vhint_table()` to hand the caller the number
  of valid operating points and asserts that at least one exists
  (`drivers/cpufreq/tegra186-cpufreq.c:178-193` together with the new
  check at `259-266`), so we know which table entry corresponds to the
  highest valid frequency.
- During probe the driver now programs every CPU in each cluster with
  the highest frequency/voltage tuple from the freshly built table
  (`drivers/cpufreq/tegra186-cpufreq.c:268-273`). This guarantees those
  EDVD registers hold a non-zero, valid state before cpufreq asks for
  the current rate, unblocking registration while staying in-spec
  because the value comes directly from the board’s own V/F table.
- The change is tightly scoped to the Tegra186 cpufreq driver, relies
  only on data already returned by BPMP, and doesn’t alter core
  interfaces; once cpufreq is up, the existing `set_target` path
  continues to broadcast every new selection to all CPUs in the policy
  (`drivers/cpufreq/tegra186-cpufreq.c:100-103`), so there’s no new
  long-term behaviour difference beyond the one-time initialization
  write.
- Risk is low: the only observable effect is a brief switch to a table-
  defined maximum frequency during probe, which is within the validated
  OPP set and quickly superseded by the governor, whereas the unfixed
  bug leaves the entire cpufreq subsystem unusable on affected Tegra186
  systems.

 drivers/cpufreq/tegra186-cpufreq.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 6c394b429b618..bd94beebc4cc2 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -138,13 +138,14 @@ static struct cpufreq_driver tegra186_cpufreq_driver = {
 
 static struct cpufreq_frequency_table *init_vhint_table(
 	struct platform_device *pdev, struct tegra_bpmp *bpmp,
-	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id)
+	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id,
+	int *num_rates)
 {
 	struct cpufreq_frequency_table *table;
 	struct mrq_cpu_vhint_request req;
 	struct tegra_bpmp_message msg;
 	struct cpu_vhint_data *data;
-	int err, i, j, num_rates = 0;
+	int err, i, j;
 	dma_addr_t phys;
 	void *virt;
 
@@ -174,6 +175,7 @@ static struct cpufreq_frequency_table *init_vhint_table(
 		goto free;
 	}
 
+	*num_rates = 0;
 	for (i = data->vfloor; i <= data->vceil; i++) {
 		u16 ndiv = data->ndiv[i];
 
@@ -184,10 +186,10 @@ static struct cpufreq_frequency_table *init_vhint_table(
 		if (i > 0 && ndiv == data->ndiv[i - 1])
 			continue;
 
-		num_rates++;
+		(*num_rates)++;
 	}
 
-	table = devm_kcalloc(&pdev->dev, num_rates + 1, sizeof(*table),
+	table = devm_kcalloc(&pdev->dev, *num_rates + 1, sizeof(*table),
 			     GFP_KERNEL);
 	if (!table) {
 		table = ERR_PTR(-ENOMEM);
@@ -229,7 +231,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra186_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
-	unsigned int i = 0, err;
+	unsigned int i = 0, err, edvd_offset;
+	int num_rates = 0;
+	u32 edvd_val, cpu;
 
 	data = devm_kzalloc(&pdev->dev,
 			    struct_size(data, clusters, TEGRA186_NUM_CLUSTERS),
@@ -252,10 +256,21 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 	for (i = 0; i < TEGRA186_NUM_CLUSTERS; i++) {
 		struct tegra186_cpufreq_cluster *cluster = &data->clusters[i];
 
-		cluster->table = init_vhint_table(pdev, bpmp, cluster, i);
+		cluster->table = init_vhint_table(pdev, bpmp, cluster, i, &num_rates);
 		if (IS_ERR(cluster->table)) {
 			err = PTR_ERR(cluster->table);
 			goto put_bpmp;
+		} else if (!num_rates) {
+			err = -EINVAL;
+			goto put_bpmp;
+		}
+
+		for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
+			if (data->cpus[cpu].bpmp_cluster_id == i) {
+				edvd_val = cluster->table[num_rates - 1].driver_data;
+				edvd_offset = data->cpus[cpu].edvd_offset;
+				writel(edvd_val, data->regs + edvd_offset);
+			}
 		}
 	}
 
-- 
2.51.0


