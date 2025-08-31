Return-Path: <linux-pm+bounces-33492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D07B3D565
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 23:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748AD175CC8
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 21:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7FD23C8A1;
	Sun, 31 Aug 2025 21:44:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BF800;
	Sun, 31 Aug 2025 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756676645; cv=none; b=oiGdljkk6N/ZdXFE8wG4B5cM15wIzzijy4nb0oqLNbqcpt4e0u3astynwPqS5HOlACnltJITW/jdgWLpPQG4ScGvgTLE0vUGMayjLskPfK9dDJ9WRCDbgWH1QFMC/2megiqQkTPSaq2uZTnbX/uWRWXHmDCCguU8N45h3w7U4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756676645; c=relaxed/simple;
	bh=XhLWBhTPHbzSraYjiFNcsGlZcv2V8Lnl9xjhUeu1L1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Td2T8rmFipcHD2LFOPqdqsXHAEOkJjJvTxopIxAAzwrvRJYdzG6rHCGidFiyobCRD+yT+mpQmw8X7OPvqWhgjH1tWNx0HWF+V8VzKgjbI2k3+TNH1Te7IgvtpmtBzHk1xcXMOHfCJIWGidv3h4CQ+V/pEVUMcaeVa49qaDUlvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7841D13;
	Sun, 31 Aug 2025 14:43:54 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.78.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA9153F694;
	Sun, 31 Aug 2025 14:44:01 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dietmar.eggemann@arm.com,
	kenneth.crudup@gmail.com,
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] PM: EM: Fix late boot with holes in CPU topology
Date: Sun, 31 Aug 2025 22:43:57 +0100
Message-Id: <20250831214357.2020076-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
adjustment") added a mechanism to handle CPUs that come up late by
retrying when any of the `cpufreq_cpu_get()` call fails.

However, if there are holes in the CPU topology (offline CPUs, e.g.
nosmt), the first missing CPU causes the loop to break, preventing
subsequent online CPUs from being updated.
Instead of aborting on the first missing CPU policy, loop through all
and retry if any were missing.

Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity adjustment")
Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
Closes: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b8144d@panix.com/
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/power/energy_model.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index ea7995a25780..b63c2afc1379 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -778,7 +778,7 @@ void em_adjust_cpu_capacity(unsigned int cpu)
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;
-	int cpu;
+	int cpu, failed_cpus = 0;
 
 	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
 		pr_warn("no free memory\n");
@@ -796,10 +796,8 @@ static void em_check_capacity_update(void)
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy) {
-			pr_debug("Accessing cpu%d policy failed\n", cpu);
-			schedule_delayed_work(&em_update_work,
-					      msecs_to_jiffies(1000));
-			break;
+			failed_cpus++;
+			continue;
 		}
 		cpufreq_cpu_put(policy);
 
@@ -814,6 +812,11 @@ static void em_check_capacity_update(void)
 		em_adjust_new_capacity(cpu, dev, pd);
 	}
 
+	if (failed_cpus) {
+		pr_debug("Accessing %d policies failed, retrying\n", failed_cpus);
+		schedule_delayed_work(&em_update_work, msecs_to_jiffies(1000));
+	}
+
 	free_cpumask_var(cpu_done_mask);
 }
 
-- 
2.34.1


