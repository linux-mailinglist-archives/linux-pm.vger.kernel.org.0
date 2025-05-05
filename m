Return-Path: <linux-pm+bounces-26686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B764AAAEBD
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351041BA3436
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA42EC033;
	Mon,  5 May 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL2Hl65h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE633768AF;
	Mon,  5 May 2025 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485992; cv=none; b=Ff6hiWi8PtbHuUSc8qlbAmkjxcDylD4Ka/v+SgVmmshS1w6hoEe+SHASaObXChTplnaRhoPO1HTFN+HBhIy3TCp1Fk6a4qWBcM8TTF1biDQ65QcRz1mjHUhQYYiN10bGeSpckhwWiJJEJJkWsMz5en2Rih07z4uRuA0zyCsmW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485992; c=relaxed/simple;
	bh=hJchu9HNBiomGtHufvvQooMabHDIoweG+MLUMc5liNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJLrwA9xXPamh3ph148bAgh2EsLe+NwGga3ur6GOqbO6bzb2xyjrKXwy2TbKqBo95729hkeqEr6o/0RltWK/O7Be5T6BGFrWHp6Lu/h6GsN5/LYkVhjuPXLLO6ONH4am4s8swiM4IPD+QWezQWg83YfBHd8Ih4Kd32uHTjtxJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL2Hl65h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DE7C4CEF2;
	Mon,  5 May 2025 22:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485990;
	bh=hJchu9HNBiomGtHufvvQooMabHDIoweG+MLUMc5liNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JL2Hl65h97lf3A79jTq2yh2VRKp/wLwoRHEdcrZivP3bH/Gl7nRTuY9egPdPE2ppg
	 sX19v6+fjSAbe3VSTXM/6Ij2kfP6agTbc5j2te1nyhmJwxKvwl4e1ideno2j76/SWJ
	 9oxqJrb4eo/6matWwm8iKxQZIzksnRyU+kuzi4BoFb0o8Yj9oAjU1Stqpc1dhI+RX6
	 KAnDnJONiEgG2wIdMNB9x8uPoykYoWzqo+rQ4eH8XC5i7OVApaKDmAiWM9ZDb8kLVJ
	 Yh3QblaHthdZUjiyBKnZpCYJFNqbAq/VD5zDZOh7yUhJFDaMS+VIvF/ySfuzIBMrnI
	 /E+4DDHUhJ+sg==
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
Subject: [PATCH AUTOSEL 6.6 100/294] cpufreq: tegra186: Share policy per cluster
Date: Mon,  5 May 2025 18:53:20 -0400
Message-Id: <20250505225634.2688578-100-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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


