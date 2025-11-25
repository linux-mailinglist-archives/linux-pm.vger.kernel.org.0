Return-Path: <linux-pm+bounces-38521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA25C83390
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 04:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8E1D4E1344
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DC7220F2D;
	Tue, 25 Nov 2025 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T96zC1PK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0733EC
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041223; cv=none; b=h1X5wdtpP10rLdiivIzn2z1i485Fr7tAUQvZ1/Hi7oSs1hQKTq8/N4cbqw9duifRAZztSWS2iktEur0H5QTUjsYvSsQKFoVsWo/nte3/i2fSQBsnvvxuGoUzyI7g+HsLpnhzpARUFjvOl+1oDtfipREzVSiGwuu3wv0Xv2TVzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041223; c=relaxed/simple;
	bh=BSOxbYIoF1VYWCnlt4snHcA2NZLCvAaMwrOPbYOV2Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X9IyZQ+HEQsafaM4CIHYSD8W8+fW+RjvyQPi/H5VaANNk9q1yqT3dAq8Lbr4bRFB6S2i6TkUJL7VLUqXC29pGMxrNLgOIN8yNW7ydav0okn2xR24K5JdEskz/SPUQj84mfkuwK0P5dw5uKFQKCRdcndiLVbChprCH0THYENpc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T96zC1PK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764041222; x=1795577222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BSOxbYIoF1VYWCnlt4snHcA2NZLCvAaMwrOPbYOV2Dc=;
  b=T96zC1PK6iQYTmTwodCw22cCeFLIhjLC3BcDx6Ojq0i/O2jriwcijmKh
   HRMYey0mtmInwk7x+oQpJpOLNbFO6TYw62fZkoAyZdL4wmkgGqxawmvJU
   zKHJZqIS6VrkwRCq+uZUzEye4Uz31agP/aLnLyt/bkUuBlO7rZYY+jJZ5
   rXkrL4XpJubTmDVg7QN7J/M1C+DiESQ0PqN6dTiXyl/4bKESNeMtZlAVi
   RD+h19PZ6FnwaVvBMgDXDb1zEqLPKoipSdFxVztKwwHschwkDCOq0xc4V
   /a7MPnpeR4HxeQQC1rLek42uz2sJmCnXzLZ20ba+sGykB8RhHHtkh/gjJ
   A==;
X-CSE-ConnectionGUID: 6lm9c1qmQFO0f+AzhyuyHw==
X-CSE-MsgGUID: XmvxxZl3RuajWCUJkeCUog==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="83666558"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="83666558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 19:27:00 -0800
X-CSE-ConnectionGUID: d/OGklylR2OOQJaqovRIvA==
X-CSE-MsgGUID: l6IZ6SolRzy0oqexK49o8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="192965080"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 24 Nov 2025 19:26:57 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
Date: Tue, 25 Nov 2025 08:54:37 +0530
Message-Id: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sugov_next_freq_shared(), the CPU capacity is retrieved only
for the CPU that triggered the update (sg_cpu->cpu) and then
incorrectly applied to all CPUs in the shared frequency domain
during the loop.On heterogeneous systems with CPUs of different
capacities sharing a frequency domain, this causes incorrect
frequency selection.

Calculate per-CPU capacity in the loop and track maximum across
all CPUs for proper frequency calculation.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/sched/cpufreq_schedutil.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 0ab5f9d4bc59..9fdbc7a6063d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -492,15 +492,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned long util = 0, max_cap;
+	unsigned long util = 0, max_cap = 0;
 	unsigned int j;
 
-	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
-
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
-		unsigned long boost;
+		unsigned long boost, j_max_cap;
 
+		j_max_cap = arch_scale_cpu_capacity(j);
+		max_cap = max(max_cap, j_max_cap);
 		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
 		sugov_get_util(j_sg_cpu, boost);
 
-- 
2.34.1


