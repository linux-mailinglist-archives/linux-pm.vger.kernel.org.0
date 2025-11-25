Return-Path: <linux-pm+bounces-38552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E47C6C849B4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9631634F040
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3130FF13;
	Tue, 25 Nov 2025 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ss1qZQ2i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F530F81C
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068239; cv=none; b=acnkK9ZpNxjK8r0YC/TIyxnLG/5DcUZLehQ1KwTdYSX+UkMhJFZT5VOwJaDEclnPH4FUNGBLPwMfnfkREOkrRh8jPo+Tfk8IA45J2GmSHHFPwHY+AVQ4QwfNfAenr2T4fyUKa9X1tcJp+TbvgJtgqOZL7sFIXq1pLrV/AdsWdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068239; c=relaxed/simple;
	bh=yc0hIpOJu+V5RbwYUwDCHm+DvpZeSkUMYousGsylyLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVVkSSN5D03ucTbQNj455dh/h4RMTZoMf0K5gr7t/BADzNE7ClVMT2595qdxoJ9igwUFSm1QcrleH3ONtY8WmSkEotAaQacBZtqUwbIdwuzIWdqv2Y3rU20OqYP6vQyMG8CTMvXcCVD25rafnBkvd61dt4tPnqgj/IyhSBsW6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ss1qZQ2i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764068238; x=1795604238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yc0hIpOJu+V5RbwYUwDCHm+DvpZeSkUMYousGsylyLM=;
  b=Ss1qZQ2iH1cfIuYNVwXagyki4wNvZJUX+aekGrWh9SYPqxckpXmOrhCY
   uAUVzdwBfsyQghtG0YoPzuZAnjZGyrvH/Xg4wmvfnsAwiqlaBLdAIa+nz
   LGyzP/O93RAcy2SSanjR/ewf2TiTKE0CzyTM5UPWSB/meTO0AbOQ7/DBs
   ctYcROYQVG2cWTUgwsntKkuK0KH85L46mKdpFUEMCfMwuqnQPgwZMtp8x
   gKhxAf1DRhb0gwQ67E7INuuFZndroZBqsx/eNu9xnxYBjLPdQJvnVL70A
   pr1Hn++anNHVFItdvRSGPaSXOuS9k4hzBR7D4+r6jxNaiKCDrCWWwG7rT
   g==;
X-CSE-ConnectionGUID: AzZsY4qqQ1GvnQnIkLDrGg==
X-CSE-MsgGUID: DKWzQiNHRlSGeKU6x/1ZRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="53649415"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="53649415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 02:57:17 -0800
X-CSE-ConnectionGUID: yU2m0c92TJmSfU6Dr9Ghpg==
X-CSE-MsgGUID: 9uvG7PSZQRyVum5DMJaPjQ==
X-ExtLoop1: 1
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa003.fm.intel.com with ESMTP; 25 Nov 2025 02:57:13 -0800
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
Subject: [PATCH] cpufreq: schedutil: Fix tunables_hook cleanup on init failure
Date: Tue, 25 Nov 2025 16:24:53 +0530
Message-Id: <20251125105453.471445-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If sugov_init() fails after registering the tunables_hook to the
global list, the hook is not removed before freeing the tunables
structure via kobject_put(). This leaves a dangling list entry
pointing to freed memory.

Remove the hook from the list in the error path to prevent this.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9fdbc7a6063d..165c58a51a83 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -800,6 +800,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	return 0;
 
 fail:
+	list_del(&sg_policy->tunables_hook);
 	kobject_put(&tunables->attr_set.kobj);
 	policy->governor_data = NULL;
 	sugov_clear_global_tunables();
-- 
2.34.1


