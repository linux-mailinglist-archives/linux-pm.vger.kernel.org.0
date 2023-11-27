Return-Path: <linux-pm+bounces-296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBD7FA5BB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 17:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58402818A9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5987D358A8;
	Mon, 27 Nov 2023 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 630F0EA;
	Mon, 27 Nov 2023 08:09:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36971688;
	Mon, 27 Nov 2023 08:09:58 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 947263F6C4;
	Mon, 27 Nov 2023 08:09:09 -0800 (PST)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	sumitg@nvidia.com
Cc: sudeep.holla@arm.covm,
	will@kernel.org,
	catalin.marinas@arm.com,
	viresh.kumar@linaro.org,
	rafael@kernel.org,
	ionela.voinescu@arm.com,
	yang@os.amperecomputing.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into cpufreq_verify_current_freq
Date: Mon, 27 Nov 2023 16:08:38 +0000
Message-Id: <20231127160838.1403404-3-beata.michalska@arm.com>
In-Reply-To: <20231127160838.1403404-1-beata.michalska@arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumit Gupta <sumitg@nvidia.com>

When available, use arch_freq_get_on_cpu to obtain current frequency
(usually an average reported over given period of time)
to better align the cpufreq's view on the current state of affairs.
This also automatically pulls in the update for cpuinfo_cur_freq sysfs
attribute, aligning it with the scaling_cur_freq one, and thus providing
consistent view on relevant platforms.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
[BM: Subject & commit msg]
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8c4f9c2f9c44..109559438f45 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 {
 	unsigned int new_freq;
 
-	new_freq = cpufreq_driver->get(policy->cpu);
+	new_freq = arch_freq_get_on_cpu(policy->cpu);
+	new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
 	if (!new_freq)
 		return 0;
 
-- 
2.25.1


