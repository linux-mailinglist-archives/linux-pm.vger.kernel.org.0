Return-Path: <linux-pm+bounces-26690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1BAAAC91
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D755A1BA5ED8
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 02:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC639CC49;
	Mon,  5 May 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAKJyv68"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4FF2F4161;
	Mon,  5 May 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486908; cv=none; b=ix1xEibHbs6GBuxvYJckDASwLVormESdDvZGhqqaSx39ZA16RrRBP1n0g7MtY/ei5m/zPQTYXfMLj66+4D2w6XGDAKL3vPL2f328hxu6pLzpaxt7DFZKd0gbpkKgAuTDsu9PrmBOYN6IJD7VzXeTs/bPcBkihQQVPzX29hXtFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486908; c=relaxed/simple;
	bh=V/+TK0izZzZS0EJ0WMtAlltjs7JTuVPirujUWhnm3Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sm3b02KLRVvUo3e+qdGdjSpt3ZSAJSVG6hFbLM26kkt31fVSKQyf/ozws9sU9XQpQKmqIpjOMRZfcuVF06cEy4De+UgzFpyBY31F8eiDpfGkwqDaoH+OyFVUuEj+GouZDKWLbpIpHuDWbU0MNP2wMWYghgYyE2LdFi6X4tKWXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAKJyv68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6320FC4CEF1;
	Mon,  5 May 2025 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486907;
	bh=V/+TK0izZzZS0EJ0WMtAlltjs7JTuVPirujUWhnm3Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAKJyv68Imw1iqO4F764/sk9oVu6piGdM1pJUQ3ApAnGp13qm6AeNR5uB5ctkJZjz
	 B61kTSZ3SpSwbiXBoA3BtMjFAmVNV28mC+aDQefKp2+CkuliP7YvSS0LRzlZzhqXxZ
	 Eo4bMDG+IqhPp1jjAxvPRKr7jUJj95RWSbbBLolj2AeEiuTW1Plunykwg6pqDqbnsa
	 S7lmGxOHMdcaa3CFNDI5MX8giFeMP2RRq9MWHBoDsxM9tioD4W31gRF2dALdRbMDJ1
	 9V+orQnCdzGivGmMRIQcDec0P6e6rV3A3ha2xL6VDlZPBXrahDK9aqtjLWrp8MBLq7
	 1LYq+aOJ4B3UQ==
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
Subject: [PATCH AUTOSEL 5.15 054/153] cpufreq: tegra186: Share policy per cluster
Date: Mon,  5 May 2025 19:11:41 -0400
Message-Id: <20250505231320.2695319-54-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 5d1943e787b0c..19597246f9ccb 100644
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


