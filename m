Return-Path: <linux-pm+bounces-26696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F2AAB0BE
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960DA3B24E5
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 03:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3D31DA54;
	Tue,  6 May 2025 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StHdUEwI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995629C336;
	Mon,  5 May 2025 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485112; cv=none; b=ERKv0rjQn26zwFWuX5iBAAzpmaU7u+ouZvc1DjY+tmc/UlFoDjyXyE7BZeZwD2ouNGk0CB/TaDApko9XaVTH03VrKH0Vk71w8RSi2I2zHZwFwJ/kLUB1GdK4fHgw6yszIZJhhIUncztTxLpASwV/xUYcz4L6Hj7DTglxi+1/NPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485112; c=relaxed/simple;
	bh=hJchu9HNBiomGtHufvvQooMabHDIoweG+MLUMc5liNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KysrOg2AGWLPShA/3eiazsdsoAyXkicE4OLV9eHJiKn0qdKLRYezUvl5SVz4rlXcHROz1HlkbQy7V3U3QtNVz9BSshi5D0D8uL1U5L9D+W4f10viAEsI99ISbW1w36+sUY4lo3rxNsUyFt32WtxcZuM0uh6aM1FaUWls58048iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StHdUEwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BEDC4CEEF;
	Mon,  5 May 2025 22:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485110;
	bh=hJchu9HNBiomGtHufvvQooMabHDIoweG+MLUMc5liNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StHdUEwIK/CkVZCuL7Xt2P940WQ02jeJGOom6uhIMA2iOXMgYrQSu7zVD8v1gJYOQ
	 clpm100/krafqsSv78qbBteIIPpKqDmgNL6PLBMm3PE323fevoCGIWe/ArIP1+pOQG
	 kfLORU+9vGTdrCb5jVPR+sPBP5HLYgZNJghPSPZ11kauDIf83t1UbJK8bhARzTxn8Z
	 90VhyDL15QQF/S/Ubz1qCBDcN+X7pactoIu+kC2RiatST4lATYw1DIbtNYKpZymxVh
	 UgCAl+KLi8BljNKr1fXBwlBspLXVBqXnrfT9Cqw8DxoS1djrJKus1bKtyYhVgQ7l9G
	 D3Ab93ZNQsU9Q==
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
Subject: [PATCH AUTOSEL 6.12 167/486] cpufreq: tegra186: Share policy per cluster
Date: Mon,  5 May 2025 18:34:03 -0400
Message-Id: <20250505223922.2682012-167-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 7b8fcfa55038b..4e5b6f9a56d1b 100644
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


