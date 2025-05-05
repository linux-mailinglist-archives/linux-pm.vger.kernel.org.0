Return-Path: <linux-pm+bounces-26689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8921EAAABC4
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 04:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA887A03E2
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23537EA7B;
	Mon,  5 May 2025 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keAJmZkZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3B381E93;
	Mon,  5 May 2025 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486534; cv=none; b=ZHUVA1zfV/w1uOaBLHP+ePzl93cGLZjNGN/VkHytoMcmekSl3tZ57chxGjJFaFMEg++IG9+hahp8A+LGAcNLxxe820B8sqxo2pVp+P9+VbGoblplQ1qHbtzxbkJ+OM8y7psZgTaPVkTQJjygvdMbsaqiIZachjFrsR8lntnmxeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486534; c=relaxed/simple;
	bh=lknYkve/ssLDCR4ZLt5Gu05goNj+CeRKYYC396pQaIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bW7J4/b8u5BA8vpY9qPyFPHtc6EoJ8bNwfAccCH3Rq07WBN4XFAACd5aIwsap0uP89/FnN3P6Uf/SkNeQOF3su2mLbmQnCmKuB20Rfg5NR7pHTHDTIl/7J//KUQowniGI+LhKjG9q7eLMnnFunjSIFVPPo4e35IO4eSewcecXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keAJmZkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B021C4CEED;
	Mon,  5 May 2025 23:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486532;
	bh=lknYkve/ssLDCR4ZLt5Gu05goNj+CeRKYYC396pQaIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=keAJmZkZoBM0XSJmpjS12qRZ70BPooL7t7MMYoohVM6eYfRF7+390sxV7yXy+NHV/
	 SVwgPTnVtYSLWqBOvAH3mrZBCLt+2YMaiezHlGHOLlx6CF9IS4Mgl/1zzbMjKeIW4L
	 A/YlbKn7s2a1EVWj2Yi5fAKLMT2zoySBXlRfidGhKqihYIX6F/JX+lB6NLKMTvU3fh
	 LmbpXfopRR4TsNTM/YX3u0654RlUOLIQbrD1/0m40h0PJmpJ3g1f7kvPSLZWhgWGdO
	 BfW9uCy3EXxCg9pu0B3UsDAXvIbC8H8CSmS6zutDLJAVnspqboEocCRdcfM+5t7W3T
	 7uDxRdraVNWHA==
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
Subject: [PATCH AUTOSEL 6.1 078/212] cpufreq: tegra186: Share policy per cluster
Date: Mon,  5 May 2025 19:04:10 -0400
Message-Id: <20250505230624.2692522-78-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 6c88827f4e625..1d6b543037237 100644
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


