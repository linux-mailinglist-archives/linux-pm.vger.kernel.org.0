Return-Path: <linux-pm+bounces-26672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C6AAA2E8
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 01:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EEB1884A25
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 23:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C9288C0F;
	Mon,  5 May 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+AcWVM5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B56288C06;
	Mon,  5 May 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483771; cv=none; b=C5FwjIibPBmsRUpMrNqrfGb6ia+51CzWZd4NlzVXN1hRT+UIkbpLEGP1tsbMkuJrh6ERwDXOCy06wLIZvYv7884sKMLGKiTuJWEmU6SndUAzPxtZlXu2xcdgQozc8++MFgGJyRQpEHac8S+t0HMKY3E484b+2dFi3n3Xh6F0+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483771; c=relaxed/simple;
	bh=8WjTKjGU3V9xksAdI3/caOLKWUX5IZYzx5E2zBSlnAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnNLoH6mNcI81k2HLyyd3s+byEr65f/vOy29E8GocmBCvX9xEfSTWouDAxK82hZJsHixJ85/jgbcw095njq6zZbiJTCsQcqt4GYacFue5DySCRpzvmbb9FJO72hxmW77lYoQxxFPL0q9y6q3uRVH77E4FBPEi/ue5nuvqfFg0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+AcWVM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97373C4CEED;
	Mon,  5 May 2025 22:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483771;
	bh=8WjTKjGU3V9xksAdI3/caOLKWUX5IZYzx5E2zBSlnAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+AcWVM5JnZwF7lvb9FWjBfgA7GQkRNs5CuDtU3YdwCOjcq4GCK/zlvuuT24Oqim6
	 IBTIau0+wAOdl0F+wMfjfJ4AmwJztZTxg92HcQ9smqOA2GRrkm+djyZK9ynQKoW5HF
	 b1aPrvNmuARefWhi5nCgQA7Hf+yACiSjZt3ciYHKMF+JmTEE/inhhXCpS4xwO2nma1
	 OXOqXlnYbtemRxJt1ZYWBUwpQLf/Zxns3v9xrbIHZzYOLcoxiTa7GCdyRug8mgklRg
	 5sOn7K7zbFm2QuINuR2raTQLE9C4GrF9rL8yQuc7wa0gRvK5JH7r41tWthWYmsmXX4
	 t2c4yvx9UWEbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 210/642] cpufreq: tegra186: Share policy per cluster
Date: Mon,  5 May 2025 18:07:06 -0400
Message-Id: <20250505221419.2672473-210-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Aaron Kling <luceoscutum@gmail.com>

[ Upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8 ]

This functionally brings tegra186 in line with tegra210 and tegra194,
sharing a cpufreq policy between all cores in a cluster.

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index c7761eb99f3cc..92aa50f016660 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
+	u32 cpu;
 
 	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
+	/* set same policy for all cpus in a cluster */
+	for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
+		if (data->cpus[cpu].bpmp_cluster_id == cluster)
+			cpumask_set_cpu(cpu, policy->cpus);
+	}
+
 	return 0;
 }
 
-- 
2.39.5


