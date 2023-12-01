Return-Path: <linux-pm+bounces-613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6EE800AEB
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 13:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B712812DB
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5821345;
	Fri,  1 Dec 2023 12:31:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 713991717;
	Fri,  1 Dec 2023 04:31:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CCEC1007;
	Fri,  1 Dec 2023 04:32:12 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AED743F5A1;
	Fri,  1 Dec 2023 04:31:24 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rafael@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
Date: Fri,  1 Dec 2023 12:32:05 +0000
Message-Id: <20231201123205.1996790-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The policy returned by cpufreq_cpu_get() has to be released with
the help of cpufreq_cpu_put() to balance its kobject reference counter
properly.

Add the missing calls to cpufreq_cpu_put() in the code.

Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the release function")
Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_cpu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 45bb7e2849d7..aac278e162d9 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -152,6 +152,8 @@ static void pd_release(struct dtpm *dtpm)
 	if (policy) {
 		for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
 			per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) = NULL;
+
+		cpufreq_cpu_put(policy);
 	}
 	
 	kfree(dtpm_cpu);
@@ -204,12 +206,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd || em_is_artificial(pd))
-		return -EINVAL;
+	if (!pd || em_is_artificial(pd)) {
+		ret = -EINVAL;
+		goto release_policy;
+	}
 
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
-	if (!dtpm_cpu)
-		return -ENOMEM;
+	if (!dtpm_cpu) {
+		ret = -ENOMEM;
+		goto release_policy;
+	}
 
 	dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
 	dtpm_cpu->cpu = cpu;
@@ -231,6 +237,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	if (ret)
 		goto out_dtpm_unregister;
 
+	cpufreq_cpu_put(policy);
 	return 0;
 
 out_dtpm_unregister:
@@ -242,6 +249,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 		per_cpu(dtpm_per_cpu, cpu) = NULL;
 	kfree(dtpm_cpu);
 
+release_policy:
+	cpufreq_cpu_put(policy);
 	return ret;
 }
 
-- 
2.25.1


