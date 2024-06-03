Return-Path: <linux-pm+bounces-8514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2108D7D16
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 10:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB291F215E2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB66A032;
	Mon,  3 Jun 2024 08:13:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8D59B4A;
	Mon,  3 Jun 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402436; cv=none; b=td64iQUSC3WsLSyD1+I0+qw8TIzOXpre68BEnsGvDXc7vGFTzym4EavgTi6mivsHDs6QSCuizdY7AfJQ+Dw2Mkh1Bnt4Gl6/+9oWkx0N3HQN7JSBEDRfLbQ4EjfoZ/ILjwh2nVsa1pCftiD1308APHmmw+62RR7Z4hBEdxZZ2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402436; c=relaxed/simple;
	bh=yhcFTKDrrJswRkQGSVNrK7EEevy1VSzs20U97xZ+xfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/XsAiyBiLS7QwBNM8f7Hkapk9wkHk7tpnfqKWEb1jxO3+m/PXEfbUkKUA4A0lrqLiPX72zbwpb2PdxGV8ABD2V+PFevAdYuYbBqv5axLYO9gj2ssTDVCtItgrNqgacI5ztmTvDGpx0Bpx3FZ8DhglwO2IYKRoKdJbsioMfbMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EE381063;
	Mon,  3 Jun 2024 01:14:17 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 150D33F792;
	Mon,  3 Jun 2024 01:13:51 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com
Cc: ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com
Subject: [PATCH 1/1] cpufreq: Rewire arch specific feedback for cpuinfo/scaling_cur_freq
Date: Mon,  3 Jun 2024 09:13:31 +0100
Message-Id: <20240603081331.3829278-2-beata.michalska@arm.com>
In-Reply-To: <20240603081331.3829278-1-beata.michalska@arm.com>
References: <20240603081331.3829278-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures provide a way to determine an average frequency over
a certain period of time, based on available performance monitors (AMU on
ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on_cpu
into cpuinfo_cur_freq policy sysfs attribute handler, which is expected to
represent the current frequency of a given CPU,as obtained by the hardware.
This is the type of feedback that counters do provide.
At the same time, keep the scaling_cur_freq attribute align with the docs
and make it provide most recently requested frequency, still allowing to
fallback to using arch_freq_get_on_cpu for cases when cpuinfo_cur_freq is
not available.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/cpufreq/cpufreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..3b0eabe4a983 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -758,7 +758,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 	ssize_t ret;
 	unsigned int freq;
 
-	freq = arch_freq_get_on_cpu(policy->cpu);
+	freq = !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->cpu)
+				    : 0;
 	if (freq)
 		ret = sprintf(buf, "%u\n", freq);
 	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
@@ -795,7 +796,10 @@ store_one(scaling_max_freq, max);
 static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	unsigned int cur_freq = __cpufreq_get(policy);
+	unsigned int cur_freq = arch_freq_get_on_cpu(policy->cpu);
+
+	if (!cur_freq)
+		cur_freq = __cpufreq_get(policy);
 
 	if (cur_freq)
 		return sprintf(buf, "%u\n", cur_freq);
-- 
2.25.1


