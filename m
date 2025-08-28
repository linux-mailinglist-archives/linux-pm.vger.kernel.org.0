Return-Path: <linux-pm+bounces-33318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F8B3A715
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C365631C9
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4B32C33A;
	Thu, 28 Aug 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM+XGxY/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1932A3E0;
	Thu, 28 Aug 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400246; cv=none; b=nTVjcfz/Rhbw/X9mnsbeZ6wSB4OkKoTCRcaQ7dMdA8JPVnAG8CDP8hlV5W7Rz4I/RoWg3jsu4+qpDv6gN8Tl7CBD8DtklByJVcP5YeKhBj4CBLky9S/kezGp+o2VsMBHs7e9aCoSiPl+C6Br/O6h3amvEqzK0p+8Mant9TRg1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400246; c=relaxed/simple;
	bh=7Bo46Qm6sbQrAz42iMDQTa+uTCurRIDADfSAfnNE0z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4dnUUVX6MN64DYjBYFSKiEZM72THjcZro0m3hBDvxAHo0GP6cAo1MT7TVhslvXY3Objh0FtgHPNMTvQLsF3E75XGgd4dQOE5Vi1IpkAA8UG/eCzgPovo/1Kw+L4L/bvjukb0LrnWZMkfgLZLcqtEbKzTF0MjpKXAQBuEAdOOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM+XGxY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5FA6C4CEF6;
	Thu, 28 Aug 2025 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400246;
	bh=7Bo46Qm6sbQrAz42iMDQTa+uTCurRIDADfSAfnNE0z8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BM+XGxY/JUExkVDKbOPNKYrLVcEwUI6JG/RXd4ZAgkqQKywCdbUSnH6S78CKxRuW0
	 1sXOoAFeXpGrzAZVkvJmb/fFRPWj5HtkEA1mh3MKH6S23Cfx5RsqmSN0KOzci0KjE3
	 94CLwmb7AhM3XOCiMR4R/8pYyKVw+uxrBYEOiIQvmJIzS7wyzHwbzez+dz/qn2VlFG
	 tX5WHj4FRxKZkTXniP31H7odnFlexSwS6aGdvuJQ+ArZhGkiw0ZTV8V9Tutd4ytwue
	 4PsU/XoeVSXQKh+Ek169ZQnr+9AECUC/sJdrTG7i0iMYbGaj1UvZ9fkZ7uMyH0V5If
	 l0zflSBMddRKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FDBC8303F;
	Thu, 28 Aug 2025 16:57:25 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 28 Aug 2025 11:57:21 -0500
Subject: [PATCH v2 2/2] cpufreq: tegra186: Initialize all cores to max
 frequencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-tegra186-cpufreq-fixes-v2-2-fcffe4de1e15@gmail.com>
References: <20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com>
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756400245; l=2602;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=6Wg/olsymhL3iTHVB65L4Tbz1bDTYeRv7QGuafdu3Ts=;
 b=cq59RVWvKCRsrVWPAoipifGivNEQpYMiPpNPJwrGMvU6ees48p4XzTffroZGdxWFZ0wcMrpcf
 K44ysojMCmuDXNrptjVXxKpI1NnZs9dtspMu+0VxTAAHVwdAmETTsay
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
 drivers/cpufreq/tegra186-cpufreq.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 6c394b429b6182faffabf222e5af501393dbbba9..3cd42db955c1c705f9774879e34b71ae124e86d2 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -138,7 +138,8 @@ static struct cpufreq_driver tegra186_cpufreq_driver = {
 
 static struct cpufreq_frequency_table *init_vhint_table(
 	struct platform_device *pdev, struct tegra_bpmp *bpmp,
-	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id)
+	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id,
+	int *max_rate)
 {
 	struct cpufreq_frequency_table *table;
 	struct mrq_cpu_vhint_request req;
@@ -218,6 +219,7 @@ static struct cpufreq_frequency_table *init_vhint_table(
 	}
 
 	table[j].frequency = CPUFREQ_TABLE_END;
+	*max_rate = num_rates - 1;
 
 free:
 	dma_free_coherent(bpmp->dev, sizeof(*data), virt, phys);
@@ -229,7 +231,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra186_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
-	unsigned int i = 0, err;
+	unsigned int i = 0, err, edvd_offset;
+	int max_rate = 0;
+	u32 edvd_val, cpu;
 
 	data = devm_kzalloc(&pdev->dev,
 			    struct_size(data, clusters, TEGRA186_NUM_CLUSTERS),
@@ -252,11 +256,19 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 	for (i = 0; i < TEGRA186_NUM_CLUSTERS; i++) {
 		struct tegra186_cpufreq_cluster *cluster = &data->clusters[i];
 
-		cluster->table = init_vhint_table(pdev, bpmp, cluster, i);
+		cluster->table = init_vhint_table(pdev, bpmp, cluster, i, &max_rate);
 		if (IS_ERR(cluster->table)) {
 			err = PTR_ERR(cluster->table);
 			goto put_bpmp;
 		}
+
+		for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
+			if (data->cpus[cpu].bpmp_cluster_id == i) {
+				edvd_val = cluster->table[max_rate].driver_data;
+				edvd_offset = data->cpus[cpu].edvd_offset;
+				writel(edvd_val, data->regs + edvd_offset);
+			}
+		}
 	}
 
 	tegra186_cpufreq_driver.driver_data = data;

-- 
2.50.1



