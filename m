Return-Path: <linux-pm+bounces-33316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1AB3A712
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C598562F96
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314132C30F;
	Thu, 28 Aug 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNouSF/U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678512F2908;
	Thu, 28 Aug 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400246; cv=none; b=nqWRTXYKTXbyVePw8WSAN84DBXAGf5ixKaYoqeCN/mT3pnB1ya3L8FtM57Oo7LEX6zRZNteF/9lbcF+kItSY/HVqnuqLP9RYjOnr8QLVU8oEodiwwezVpN7TfdSxMkEwb36I0LahkX7m2cgHxE6WS9T3/c8EpKLrAIlKrLTom7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400246; c=relaxed/simple;
	bh=qYSyZU0PA0XW8kSg/t1otLbzZhDMJW98vrjp/AywmYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6MwLkbOCJsTEVfzQtBOolAnxCzDBibxSFToj9GYEIYdZ81DCVHxNwoLpzkuoLiklaxB/h7VrgwePvDK9Z2eHEwfaRlu/P/fs8N/MsDQwudY7ZqnlLYeQvpMQxFIyD/LgCkmWjNHdKaIig5XNAOrnq3WiL2BvRySSmVhQLNgMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNouSF/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB9A1C4CEF5;
	Thu, 28 Aug 2025 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400245;
	bh=qYSyZU0PA0XW8kSg/t1otLbzZhDMJW98vrjp/AywmYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cNouSF/UMhBXna3ntSSdKPLw4W5PXSNUYdI8WHvzeKZfQxLmKZyluNJSCzoH9MHKy
	 68jAPAkdv4zLmGeRPDVEMW+RdnWZJoB+BpwNTEJpd3ziB3btj4EC1bI0pO4RpegkoJ
	 joPMmTEBIHSGKphiAhKlczQ/XBus0xKUpv0rwisQt11WFCuGFaoTdUtYgdLWFUyc5g
	 te9xi3RC6GYN7MRsDb4NOhYN9LV6J0Isuzfv2esHmZ7UYWmp4JLQ7VOIh4OH62N5/+
	 +60rx2BJPQlB97dbAaje9jc5/MMiejnraCvqc60F2MB7TV9RKmnxvXNYtPyzUmguFH
	 8Lyo9W3f9k0rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA718CA0EED;
	Thu, 28 Aug 2025 16:57:25 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 28 Aug 2025 11:57:20 -0500
Subject: [PATCH v2 1/2] cpufreq: tegra186: Set target frequency for all
 cpus in policy
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-tegra186-cpufreq-fixes-v2-1-fcffe4de1e15@gmail.com>
References: <20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com>
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>, 
 Sumit Gupta <sumitg@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756400245; l=1316;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=WE4FtNYlrqayHn8j1oFAZqsXZWGEdS20pQxJDsMXhig=;
 b=YyfT3NrbM2MhkdJH27FSwoRxJ9E03NvtZF1d+41tAofWnw75lpvLJkGUwXsyuj5UXtnP0vxW+
 Jtj/BIbg8kpCKyrA/AJVxPlvlqo9afivyUPh0qaJjuKHxZwDG7uLA5g
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The original commit set all cores in a cluster to a shared policy, but
did not update set_target to apply a frequency change to all cores for
the policy. This caused most cores to remain stuck at their boot
frequency.

Fixes: be4ae8c19492 ("cpufreq: tegra186: Share policy per cluster")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index cbabb726c6645d2e5f1857a47e5643c8552d1933..6c394b429b6182faffabf222e5af501393dbbba9 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -93,10 +93,14 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	struct cpufreq_frequency_table *tbl = policy->freq_table + index;
-	unsigned int edvd_offset = data->cpus[policy->cpu].edvd_offset;
+	unsigned int edvd_offset;
 	u32 edvd_val = tbl->driver_data;
+	u32 cpu;
 
-	writel(edvd_val, data->regs + edvd_offset);
+	for_each_cpu(cpu, policy->cpus) {
+		edvd_offset = data->cpus[cpu].edvd_offset;
+		writel(edvd_val, data->regs + edvd_offset);
+	}
 
 	return 0;
 }

-- 
2.50.1



