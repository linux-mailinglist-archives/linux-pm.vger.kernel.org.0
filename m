Return-Path: <linux-pm+bounces-18700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220C9E6FBA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F206E16E0C5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD2D20B213;
	Fri,  6 Dec 2024 13:57:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8CB20ADED;
	Fri,  6 Dec 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493423; cv=none; b=UAIjHtcHmSard25H81mnmxxX1mymW3KbRmixYl/a4KCq0wKjy/4CIINYsVIEU6aRZr5fsJU1v0ITSqtAaZ5eUQ+1fIH5MxhoNAkG98mwOj80LzEL2G8PdhbMS16EHO74XaabxS0zBCM86ZfXMFCYaKqhDL002RTUJY2haNbWtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493423; c=relaxed/simple;
	bh=V7kbG2we2G9VPn+kmJJl0fOGU9tS1a4sR7kecVizBi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKcGLZx/9p/2truKhz94zAj3uRZcCVJqD8YzzN9MdNf9JWyZ8B2YSdTlGvpU0+0VriMS3YF9g75fj0vg7o7xgcYBqkdZHfvhp3zrXVL5IO+XvAU31QExSIQZdmek2QeZF9wqT2C63ls7+PEkkpQi2R7XwozkDHcxOLMI8hxs90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7D971474;
	Fri,  6 Dec 2024 05:57:28 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E38753F71E;
	Fri,  6 Dec 2024 05:56:58 -0800 (PST)
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
Subject: [PATCH v8 4/4] arm64: Update AMU-based freq scale factor on entering idle
Date: Fri,  6 Dec 2024 13:56:00 +0000
Message-Id: <20241206135600.4083965-5-beata.michalska@arm.com>
In-Reply-To: <20241206135600.4083965-1-beata.michalska@arm.com>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
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
---
 arch/arm64/kernel/topology.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5f5738b174c7..6c43aafac77c 100644
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


