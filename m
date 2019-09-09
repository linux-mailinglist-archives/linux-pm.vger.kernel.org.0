Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE57AD1FE
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 04:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfIIChc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Sep 2019 22:37:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731928AbfIIChc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Sep 2019 22:37:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B818AF25;
        Mon,  9 Sep 2019 02:37:30 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Conditional frequency invariant accounting
Date:   Mon,  9 Sep 2019 04:42:16 +0200
Message-Id: <20190909024216.5942-3-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190909024216.5942-1-ggherdovich@suse.cz>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

intel_pstate has two operating modes: active and passive. In "active"
mode, the in-built scaling governor is used and in "passive" mode,
the driver can be used with any governor like "schedutil". In "active"
mode the utilization values from schedutil is not used and there is
a requirement from high performance computing use cases, not to read
any APERF/MPERF MSRs. In this case no need to use CPU cycles for
frequency invariant accounting by reading APERF/MPERF MSRs.
With this change frequency invariant account is only enabled in
"passive" mode.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cc27d4c59dca..d55da8604d50 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2381,6 +2381,8 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
 	int ret;
 
+	x86_arch_scale_freq_tick_disable();
+
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
 
@@ -2393,6 +2395,9 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	global.min_perf_pct = min_perf_pct_min();
 
+	if (driver == &intel_cpufreq)
+		x86_arch_scale_freq_tick_enable();
+
 	return 0;
 }
 
-- 
2.16.4

