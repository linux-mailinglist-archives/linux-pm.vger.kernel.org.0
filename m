Return-Path: <linux-pm+bounces-443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3A7FD4F3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E8328342C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186AF1BDEA;
	Wed, 29 Nov 2023 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D708310FC;
	Wed, 29 Nov 2023 03:08:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B712F4;
	Wed, 29 Nov 2023 03:08:59 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 343DB3F5A1;
	Wed, 29 Nov 2023 03:08:10 -0800 (PST)
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
Subject: [PATCH v5 04/23] PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
Date: Wed, 29 Nov 2023 11:08:34 +0000
Message-Id: <20231129110853.94344-5-lukasz.luba@arm.com>
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

The Energy Model (EM) is going to support runtime modification. There
are going to be 2 EM tables which store information. This patch aims
to prepare the code to be generic and use one of the tables. The function
will no longer get a pointer to 'struct em_perf_domain' (the EM) but
instead a pointer to 'struct em_perf_state' (which is one of the EM's
tables).

Prepare em_pd_get_efficient_state() for the upcoming changes and
make it possible to re-use. Return an index for the best performance
state for a given EM table. The function arguments that are introduced
should allow to work on different performance state arrays. The caller of
em_pd_get_efficient_state() should be able to use the index either
on the default or the modifiable EM table.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/energy_model.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01dfac4..8069f526c9d8 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
- * @pd   : Performance domain for which we want an efficient frequency
- * @freq : Frequency to map with the EM
+ * @state:		List of performance states, in ascending order
+ * @nr_perf_states:	Number of performance states
+ * @freq:		Frequency to map with the EM
+ * @pd_flags:		Performance Domain flags
  *
  * It is called from the scheduler code quite frequently and as a consequence
  * doesn't implement any check.
  *
- * Return: An efficient performance state, high enough to meet @freq
+ * Return: An efficient performance state id, high enough to meet @freq
  * requirement.
  */
-static inline
-struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
-						unsigned long freq)
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
+			  unsigned long freq, unsigned long pd_flags)
 {
 	struct em_perf_state *ps;
 	int i;
 
-	for (i = 0; i < pd->nr_perf_states; i++) {
-		ps = &pd->table[i];
+	for (i = 0; i < nr_perf_states; i++) {
+		ps = &table[i];
 		if (ps->frequency >= freq) {
-			if (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
 			    ps->flags & EM_PERF_STATE_INEFFICIENT)
 				continue;
-			break;
+			return i;
 		}
 	}
 
-	return ps;
+	return nr_perf_states - 1;
 }
 
 /**
@@ -226,7 +228,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
-	int cpu;
+	int cpu, i;
 
 	if (!sum_util)
 		return 0;
@@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	ps = em_pd_get_efficient_state(pd, freq);
+	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
+				      pd->flags);
+	ps = &pd->table[i];
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
-- 
2.25.1


