Return-Path: <linux-pm+bounces-14152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F497812A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B971C20F47
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6BB1DB959;
	Fri, 13 Sep 2024 13:30:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91711DB942;
	Fri, 13 Sep 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234216; cv=none; b=FQZJLpf1bEz2I6yh2PDWEkBqwvxHXid7hW2jcfC3bmSrdqjb5RkYawmF+Jbv+YeoKKBnLuGRuoy5o7Svps5+AQwUG7Ay6sZ89FTyrApWx476sfVdGQVc+a2qzM5YdC6ZCItei3r+QxJ431W95Vdp0fPkZ+WmelBJPLRkpF+/QEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234216; c=relaxed/simple;
	bh=+gsaSH3aysortKYUcNOJH/V2fmfVjq4GYeikFjibTf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLQ/moSKPYMDE4uj4Ozz8B42vof3jI2lpUdY+q676bnHRuWMQF2OIO+4T/p/HGvFQ2yUWwvl239QlBodXfjqQpP7kQs3Ji/nGrBjtZXst5z96qLeBpXf+XRyEYBZKkmXBs/AuJquZTxSywxoTAyIteNmOsGcHihrR/F0E5fCOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 868E815BF;
	Fri, 13 Sep 2024 06:30:43 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B4303F73B;
	Fri, 13 Sep 2024 06:30:12 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com,
	sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: [PATCH v7 2/4] arm64: amu: Delay allocating cpumask for AMU FIE support
Date: Fri, 13 Sep 2024 14:29:42 +0100
Message-Id: <20240913132944.1880703-3-beata.michalska@arm.com>
In-Reply-To: <20240913132944.1880703-1-beata.michalska@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the time being, the amu_fie_cpus cpumask is being exclusively used
by the AMU-related internals of FIE support and is guaranteed to be
valid on every access currently made. Still the mask is not being
invalidated on one of the error handling code paths, which leaves
a soft spot with theoretical risk of UAF for CPUMASK_OFFSTACK cases.
To make things sound, delay allocating said cpumask
(for CPUMASK_OFFSTACK) avoiding otherwise nasty sanitising case failing
to register the cpufreq policy notifications.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a2c72f3e7f8..cb180684d10d 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -194,12 +194,19 @@ static void amu_fie_setup(const struct cpumask *cpus)
 	int cpu;
 
 	/* We are already set since the last insmod of cpufreq driver */
-	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
+	if (cpumask_available(amu_fie_cpus) &&
+	    unlikely(cpumask_subset(cpus, amu_fie_cpus)))
 		return;
 
-	for_each_cpu(cpu, cpus) {
+	for_each_cpu(cpu, cpus)
 		if (!freq_counters_valid(cpu))
 			return;
+
+	if (!cpumask_available(amu_fie_cpus) &&
+	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
+		WARN_ONCE(1, "Failed to allocate FIE cpumask for CPUs[%*pbl]\n",
+			  cpumask_pr_args(cpus));
+		return;
 	}
 
 	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
@@ -237,17 +244,8 @@ static struct notifier_block init_amu_fie_notifier = {
 
 static int __init init_amu_fie(void)
 {
-	int ret;
-
-	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
-		return -ENOMEM;
-
-	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
+	return cpufreq_register_notifier(&init_amu_fie_notifier,
 					CPUFREQ_POLICY_NOTIFIER);
-	if (ret)
-		free_cpumask_var(amu_fie_cpus);
-
-	return ret;
 }
 core_initcall(init_amu_fie);
 
-- 
2.25.1


