Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B217F45
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEHRne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 13:43:34 -0400
Received: from foss.arm.com ([217.140.101.70]:41816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfEHRnP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 13:43:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 528C780D;
        Wed,  8 May 2019 10:43:15 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCBAF3F575;
        Wed,  8 May 2019 10:43:13 -0700 (PDT)
From:   douglas.raillard@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        quentin.perret@arm.com, douglas.raillard@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com
Subject: [RFC PATCH 4/7] sched/cpufreq: Move up sugov_cpu_is_busy()
Date:   Wed,  8 May 2019 18:42:58 +0100
Message-Id: <20190508174301.4828-5-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

Move sugov_cpu_is_busy() static function of cpufreq_schedutil.c higher
in the file so it can be used by other functions.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f4173a7c0f01..a52c66559321 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -173,6 +173,19 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
 	}
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
+{
+	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
+	bool ret = idle_calls == sg_cpu->saved_idle_calls;
+
+	sg_cpu->saved_idle_calls = idle_calls;
+	return ret;
+}
+#else
+static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
+#endif /* CONFIG_NO_HZ_COMMON */
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -462,19 +475,6 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 	return max(boost, util);
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
-static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
-{
-	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
-	bool ret = idle_calls == sg_cpu->saved_idle_calls;
-
-	sg_cpu->saved_idle_calls = idle_calls;
-	return ret;
-}
-#else
-static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
-#endif /* CONFIG_NO_HZ_COMMON */
-
 /*
  * Make sugov_should_update_freq() ignore the rate limit when DL
  * has increased the utilization.
-- 
2.21.0

