Return-Path: <linux-pm+bounces-21182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389CDA24053
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 17:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C9A164D70
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746E1EC01E;
	Fri, 31 Jan 2025 16:25:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CECB1F0E2C;
	Fri, 31 Jan 2025 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340712; cv=none; b=cvG8LKhBNRgtBgDpL9uaGbNMu2KOgCG+1n8d8EQWIRLLPYfYxsZ/FaOand78nbeCrUWt+gtNNp52fen3UgYoDNDJNIqKNbDKOjDUcBfz8s8YNQ5DagxPSMok+Dlf2GZmaE08NpxSR6YmBNSooEjitbe6+3/2GVLhBwb715Z9vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340712; c=relaxed/simple;
	bh=UrPeDcBjCasShll16HrywUAszFC33HX30upT7GhLdsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HiLx76q4VFpaOh6XOwtsDRyRxfej3tOQ+bADNd194ShdN8krdwA8G3xsgSsH2OdCfF7zmPSac+xBJzpEYTPZyA63BljFF7J3C4E4m1CdAG0RsHOubifmNjYBrFHSKCBCxiG4lMqf+7ubF1iOC3G/p3HOopW8t87y+XysI5y1B7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C221DFEC;
	Fri, 31 Jan 2025 08:25:34 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4656F3F694;
	Fri, 31 Jan 2025 08:25:07 -0800 (PST)
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
	zhanjie9@hisilicon.com,
	ptsm@linux.microsoft.com
Subject: [PATCH v10 4/4] arm64: Update AMU-based freq scale factor on entering idle
Date: Fri, 31 Jan 2025 16:24:39 +0000
Message-Id: <20250131162439.3843071-5-beata.michalska@arm.com>
In-Reply-To: <20250131162439.3843071-1-beata.michalska@arm.com>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the frequency scale factor has been activated for retrieving
current frequency on a given CPU, trigger its update upon entering
idle. This will, to an extent, allow querying last known frequency
in a non-invasive way. It will also improve the frequency scale factor
accuracy when a CPU entering idle did not receive a tick for a while.
As a consequence, for idle cores, the reported frequency will be the
last one observed before entering the idle state.

Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/kernel/topology.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index bd238e5c2133..6f0cab8e746b 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -213,6 +213,19 @@ static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
 		cpumask_test_cpu(cpu, amu_fie_cpus);
 }
 
+void arch_cpu_idle_enter(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!amu_fie_cpu_supported(cpu))
+		return;
+
+	/* Kick in AMU update but only if one has not happened already */
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
+	    time_is_before_jiffies(per_cpu(cpu_amu_samples.last_scale_update, cpu)))
+		amu_scale_freq_tick();
+}
+
 #define AMU_SAMPLE_EXP_MS	20
 
 int arch_freq_get_on_cpu(int cpu)
-- 
2.25.1


