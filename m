Return-Path: <linux-pm+bounces-1844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B6824724
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F05288449
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B852C84B;
	Thu,  4 Jan 2024 17:15:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FE2CCC4;
	Thu,  4 Jan 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C414E1570;
	Thu,  4 Jan 2024 09:16:00 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BF843F64C;
	Thu,  4 Jan 2024 09:15:12 -0800 (PST)
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
Subject: [PATCH v6 09/23] PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
Date: Thu,  4 Jan 2024 17:15:39 +0000
Message-Id: <20240104171553.2080674-10-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104171553.2080674-1-lukasz.luba@arm.com>
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new Energy Model (EM) supports runtime modification of the performance
state table to better model the power used by the SoC. Use this new
feature to improve energy estimation and therefore task placement in
Energy Aware Scheduler (EAS).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8ddf1d8a9581..5f842da3bb0c 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -239,9 +239,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long allowed_cpu_cap)
 {
 	unsigned long freq, ref_freq, scale_cpu;
+	struct em_perf_table *em_table;
 	struct em_perf_state *ps;
 	int cpu, i;
 
+#ifdef CONFIG_SCHED_DEBUG
+	WARN_ONCE(!rcu_read_lock_held(), "EM: rcu read lock needed\n");
+#endif
+
 	if (!sum_util)
 		return 0;
 
@@ -264,9 +269,10 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
-				      pd->flags);
-	ps = &pd->table[i];
+	em_table = rcu_dereference(pd->em_table);
+	i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
+				      freq, pd->flags);
+	ps = &em_table->state[i];
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
-- 
2.25.1


