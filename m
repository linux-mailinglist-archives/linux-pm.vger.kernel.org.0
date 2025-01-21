Return-Path: <linux-pm+bounces-20750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B09A1796D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A877B3AABE8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05E1BD519;
	Tue, 21 Jan 2025 08:45:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF61B87DA;
	Tue, 21 Jan 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449119; cv=none; b=S+SLkp2D8ayBMevBkAch01yUfN/ebBytF6inLb3may1cAgFYa9q7JGgB0mAdRgOc2oUvprq9IH8jYKji2cs0nFSS+3qaEQi8xRLR1tzzSJ1OKxoDmtMsxZQFqZAmGsjTSrPAnrMzpZfxuMgRGkhJMKTnVb7jVMtoOhSFst5yXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449119; c=relaxed/simple;
	bh=+gsaSH3aysortKYUcNOJH/V2fmfVjq4GYeikFjibTf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rw01nHyHqYq4mQ2Ybdn4vi+kxDJZbkr45RHCg2AAi0ZkmzSnrjPptqaqFioLEbHdMhAff0xLw1wW/Uo5Jy1+paFU/7jStY70yftwVligWGGoO23U2tnom2goXLj5AQrtWGodCrK0uaBmmV1YT03XyHO+wPCv25Y120ZE/+dMJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A38CA1516;
	Tue, 21 Jan 2025 00:45:45 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7A333F66E;
	Tue, 21 Jan 2025 00:45:14 -0800 (PST)
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
Subject: [PATCH v9 3/5] arm64: amu: Delay allocating cpumask for AMU FIE support
Date: Tue, 21 Jan 2025 08:44:33 +0000
Message-Id: <20250121084435.2839280-4-beata.michalska@arm.com>
In-Reply-To: <20250121084435.2839280-1-beata.michalska@arm.com>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
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


