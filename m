Return-Path: <linux-pm+bounces-33131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6522CB373B2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 22:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D93167DA7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 20:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD9272E63;
	Tue, 26 Aug 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbUu3WDv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646C1A2541;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239383; cv=none; b=bF+Nt/GI6sk5Spxn/lVmQM1KrOGHFKq3qZAXzEAikB8yIprt6IxtWY+SEDQZZaTACxgr172vcuGbTi+AdFfFjlR8xxAW7H0istsr1JozHC3sH3OPrfEYeqkIYPwC3wYYl5rSTW4iC77165x9S4lGanB1SfegKOLrQG0VFzrVJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239383; c=relaxed/simple;
	bh=qYSyZU0PA0XW8kSg/t1otLbzZhDMJW98vrjp/AywmYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pO6+l8wKC6geWzFqyGN+0JjEnbx07qBPBz0IwzpC16y9Wb2f2HtqLE/4syTCZG1SBnZzml6qGHLka/Gc5QuSSwgYCOxC9F68l6wLjesNhKhIXgzo5hkpuJml8O2VV/PpOlwTjdU76qgrB+Mb63u5gTA076cvnzSnhuQWdsNdM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbUu3WDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3186C116B1;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756239382;
	bh=qYSyZU0PA0XW8kSg/t1otLbzZhDMJW98vrjp/AywmYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mbUu3WDvS5ofZaeqLyNY8C1x1RhwS53o/tpZ0YbiMI7GA3eMFaMOGDMrcjVqB3I/E
	 9azNh0xsbkRyjdStrWIPGiRXVLpBebLNlf9ClW0/2/qwvH2LKWuWhmOm2VP0tp+Mzt
	 +RAITjOoyl84ac32QO52AUfYuLJ/XU3B29DrxQdl7aZbb/eYjRRX7EwV6G9SeebZ51
	 H3UTwLy6FsIXAsBlJAGSG5VdItdYqkpn7XbSXPMJc2Bt++CoEsN5m+0JF494tqXd5K
	 6TMaymOgnzH5omlx9TPnrhJBtp9xhkFpl9Yzv3bCrewYFAVSuccZUGlMDSS6TfsJDi
	 f+w3Prywm3N4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1005CA0FED;
	Tue, 26 Aug 2025 20:16:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 26 Aug 2025 15:15:59 -0500
Subject: [PATCH 1/2] cpufreq: tegra186: Set target frequency for all cpus
 in policy
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-tegra186-cpufreq-fixes-v1-1-97f98d3e0adb@gmail.com>
References: <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
In-Reply-To: <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>, 
 Sumit Gupta <sumitg@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756239382; l=1316;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=WE4FtNYlrqayHn8j1oFAZqsXZWGEdS20pQxJDsMXhig=;
 b=smWWYy/Dw/cQATAk4Z2y1dcYGsWu36PsKoRmK9tyjhXEskFAgD6sXXMNfYn9K9FzflP/aqSj9
 3DihDaoNiFABrTnV76BoTO4+WgS5u7RvZzPAdYn4JKMTrVNJbQxivd3
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



