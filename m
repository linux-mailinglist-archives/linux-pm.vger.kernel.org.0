Return-Path: <linux-pm+bounces-442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814E7FD4F5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75905B20F71
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3A1BDEC;
	Wed, 29 Nov 2023 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 240BA1998;
	Wed, 29 Nov 2023 03:08:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BADA1424;
	Wed, 29 Nov 2023 03:08:57 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EEDF3F5A1;
	Wed, 29 Nov 2023 03:08:07 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com
Subject: [PATCH v5 03/23] PM: EM: Find first CPU active while updating OPP efficiency
Date: Wed, 29 Nov 2023 11:08:33 +0000
Message-Id: <20231129110853.94344-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Energy Model might be updated at runtime and the energy efficiency
for each OPP may change. Thus, there is a need to update also the
cpufreq framework and make it aligned to the new values. In order to
do that, use a first active CPU from the Performance Domain. This is
needed since the first CPU in the cpumask might be offline when we
run this code path.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 42486674b834..aa7c89f9e115 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 	struct em_perf_domain *pd = dev->em_pd;
 	struct cpufreq_policy *policy;
 	int found = 0;
-	int i;
+	int i, cpu;
 
 	if (!_is_cpu_device(dev) || !pd)
 		return;
 
-	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
+	/* Try to get a CPU which is active and in this PD */
+	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
+	if (cpu >= nr_cpu_ids) {
+		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
+		return;
+	}
+
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy) {
 		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
 		return;
-- 
2.25.1


