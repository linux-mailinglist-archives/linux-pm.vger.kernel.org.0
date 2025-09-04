Return-Path: <linux-pm+bounces-33812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B11BB4355B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10271773A8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928C92BDC13;
	Thu,  4 Sep 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wz2BLhUI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD028934F
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973855; cv=none; b=PCwECA+XSn04KXof8Nya4hYvEBW5WDs4zHNvrMc1TIzxpnR8bYcPBQJuNU+kA6BkCgZ7k2EdVu0/qnmW+A/H4qQoK0BZJcDEyjah0wR2TUAMs1mzsN30s4+HJnRdXh9exV94I9MinUlE9S5z+vIgFTVrAEhxq8bTsKBa+EoUlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973855; c=relaxed/simple;
	bh=zWt2mCW6m0/ZqG/NuHpwedi6EWHPLxwbzCT/6aoTX/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkhg2aoN55sML1L5DNNTZxcqzT042PDnJIKVGiuAidEVoIRL+mwhP2LNxzZeiuW/kWAfCazyHVKmZgyc460OXppVCy7j8/hdYy7UGauP0d8TgP9GE6f7dmZSQakFGxsDDxvIcP7F2g5gnoK8wbH5yyM5MlKNptJuO6dzOjLJ7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wz2BLhUI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756973854; x=1788509854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zWt2mCW6m0/ZqG/NuHpwedi6EWHPLxwbzCT/6aoTX/M=;
  b=Wz2BLhUIbKpGADIcM9PhyIUKPfNafZwUcY6ZhFCwrbTCeJiLiqHUfco5
   +HEtB9beoCDFE3dHuFy67KwcNRw8/toSYKi+gXgtDcB5W6EBVG9atGeG6
   uDIfdQf4YoGMvEXrr+YFI8MWt3ecuuf1Rn33S28WzFPHEQGhOXgIOZsaa
   izVjKqagwz6LQIAv32tpstcJKx0cl/JoB80LMUkor2HIrc7h/PToqHMRq
   bZmzJcQs8WqHCZROhfx2HuPraTWit+M3a2CgKdR+wuU/QW42arvxWD4rI
   CVGvpf6N/J8BjQyVvGBWPz0lyFSUNIZ5h1xQqI4yYQnRgwW6yJ83gt7C0
   w==;
X-CSE-ConnectionGUID: XjyvHW/JRwO34MQHnkGuAQ==
X-CSE-MsgGUID: nJCP9ZagTEKW9dixWhhWWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70400652"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="70400652"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 01:17:34 -0700
X-CSE-ConnectionGUID: umYDvqqXQTC2duhn5F/98g==
X-CSE-MsgGUID: 7oFNmmJEQzSrnPdAUNFWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="172655343"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa010.fm.intel.com with ESMTP; 04 Sep 2025 01:17:31 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpufreq: acpi-cpufreq: Optimize SMP calls in drv_write() function
Date: Thu,  4 Sep 2025 13:46:00 +0530
Message-Id: <20250904081600.2706572-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current drv_write() implementation performs redundant work by calling
do_drv_write() on the current CPU and then issuing smp_call_function_many()
to all CPUs in the mask, including the current CPU again. This results in
duplicate MSR writes on the current CPU and unnecessary IPI overhead.

Optimize the function by:
- Executing do_drv_write() locally when current CPU is
  in the target mask
- Use a temporary mask to exclude the current CPU from
  smp_call_function_many.
- Falling back to smp_call_function_many() for the target
  CPUs when current CPU is not in the target mask

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 4f7f9201598d..081d2d8a13da 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -330,6 +330,7 @@ static void drv_write(struct acpi_cpufreq_data *data,
 		      const struct cpumask *mask, u32 val)
 {
 	struct acpi_processor_performance *perf = to_perf_data(data);
+	struct cpumask tmp_mask;
 	struct drv_cmd cmd = {
 		.reg = &perf->control_register,
 		.val = val,
@@ -338,10 +339,14 @@ static void drv_write(struct acpi_cpufreq_data *data,
 	int this_cpu;
 
 	this_cpu = get_cpu();
-	if (cpumask_test_cpu(this_cpu, mask))
+	if (cpumask_test_cpu(this_cpu, mask)) {
 		do_drv_write(&cmd);
+		cpumask_andnot(&tmp_mask, mask, cpumask_of(this_cpu));
+		smp_call_function_many(&tmp_mask, do_drv_write, &cmd, 1);
+	} else {
+		smp_call_function_many(mask, do_drv_write, &cmd, 1);
+	}
 
-	smp_call_function_many(mask, do_drv_write, &cmd, 1);
 	put_cpu();
 }
 
-- 
2.34.1


