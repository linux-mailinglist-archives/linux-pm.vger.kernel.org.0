Return-Path: <linux-pm+bounces-33355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB8B3B126
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 04:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA81583015
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858621FF3B;
	Fri, 29 Aug 2025 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7TeKyS1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BE212B0A;
	Fri, 29 Aug 2025 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435696; cv=none; b=A5uBwgmtAaq8Hcg/ONds4Z1Y8HAIs1h8Ndk2kHuyi2vWSze3/gsT4F7O5w+w6oSul+sEjwcS4yTZnm72jEubbi7GK+kWdRKS4jHSWBFNiTCLwydcsIbnH6Zo2dH/1xAL3VwU8kFwSJ52nBq80V4HQTtTgXrAOl8bdXRtR2bRMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435696; c=relaxed/simple;
	bh=GnJwClUxMWgMLpJm4CE+0XiogVWIkUx6AZPEqH60IBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QMclrAGZ165XnC6AKRdNd3lAGbk9IsdQTVZcLL6dCVRM4LW3lr3BGYzbH5bfIgYNHiN8GX8+9tsa8vpNH0RqD8f/9RATa/xjgrJ7gEFGj/bNQBsJGVlX9tJ0imjO4Km1U3zW3kB+gPXb6c3COm9fTpGwczG08Lg24EdKdCxbkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7TeKyS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0732C4CEED;
	Fri, 29 Aug 2025 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756435694;
	bh=GnJwClUxMWgMLpJm4CE+0XiogVWIkUx6AZPEqH60IBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m7TeKyS1pbTDlTAQzi986/MgfPdzbtmHcInF6csSJFt71BTr7ArILTWlgEDAUhvNq
	 E+sCYCyEfMwczhwBGVvJZK9SEbIgsdKhZywNEt34eVre4UrJSAmhNiPW7DZsVTQXF6
	 q0VdJWevJoVkTKs3tqe5gasTRvxfuwzhaMopwnd2tP0g5yDkGyjhocPgwm/yxXQKsv
	 3K5lBffO9Vlt5Utz/FRYN7L4GM2CC/J6clW/tv0dgbzGkJJ9QrLmSCromOQc6RkQEI
	 Hgo+Wyt3s4XnfvoN4g8xfuF21PcRzZGDRckzqy1Y2xY9EcC2SacN9Z01nP+G03D3eW
	 NSfrW743NlQEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2FCA0FF6;
	Fri, 29 Aug 2025 02:48:14 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 28 Aug 2025 21:48:13 -0500
Subject: [PATCH v3 2/2] cpufreq: tegra186: Initialize all cores to max
 frequencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-tegra186-cpufreq-fixes-v3-2-23a7341db254@gmail.com>
References: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>, 
 Sumit Gupta <sumitg@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756435694; l=3164;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Cee7AliwERvbB7wKaI7YwL2ggH/0vhQ+XE9hO86NkEY=;
 b=HeiRL5v18eMEMdGOnHaqyKruV+NWZaMq9DEOZL+rad/fbdGREpgpd56SZYuM31CexSZoLwlAb
 64G6dPnq1uzDAMXzNyNyD8K5JXE46E3JMQvSLBUolq1UMEmuURTmdOE
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

During initialization, the EDVD_COREx_VOLT_FREQ registers for some cores
are still at reset values and not reflecting the actual frequency. This
causes get calls to fail. Set all cores to their respective max
frequency during probe to initialize the registers to working values.

Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 6c394b429b6182faffabf222e5af501393dbbba9..bd94beebc4cc2fe6870e13ca55343cedb9729e99 100644
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
2.50.1



