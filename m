Return-Path: <linux-pm+bounces-446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A77FD4F9
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAC2283472
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DAC1BDF4;
	Wed, 29 Nov 2023 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 093E61FC3;
	Wed, 29 Nov 2023 03:08:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF2262F4;
	Wed, 29 Nov 2023 03:09:07 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 506623F5A1;
	Wed, 29 Nov 2023 03:08:18 -0800 (PST)
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
Subject: [PATCH v5 07/23] PM: EM: Refactor how the EM table is allocated and populated
Date: Wed, 29 Nov 2023 11:08:37 +0000
Message-Id: <20231129110853.94344-8-lukasz.luba@arm.com>
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

Split the process of allocation and data initialization for the EM table.
The upcoming changes for modifiable EM will use it.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 52 ++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3c8542443dd4..99426b5eedb6 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -142,18 +142,25 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	return 0;
 }
 
+static int em_allocate_perf_table(struct em_perf_domain *pd,
+				  int nr_states)
+{
+	pd->table = kcalloc(nr_states, sizeof(struct em_perf_state),
+			    GFP_KERNEL);
+	if (!pd->table)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
+				struct em_perf_state *table,
 				int nr_states, struct em_data_callback *cb,
 				unsigned long flags)
 {
 	unsigned long power, freq, prev_freq = 0;
-	struct em_perf_state *table;
 	int i, ret;
 
-	table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
-	if (!table)
-		return -ENOMEM;
-
 	/* Build the list of performance states for this performance domain */
 	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
 		/*
@@ -165,7 +172,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		if (ret) {
 			dev_err(dev, "EM: invalid perf. state: %d\n",
 				ret);
-			goto free_ps_table;
+			return -EINVAL;
 		}
 
 		/*
@@ -175,7 +182,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		if (freq <= prev_freq) {
 			dev_err(dev, "EM: non-increasing freq: %lu\n",
 				freq);
-			goto free_ps_table;
+			return -EINVAL;
 		}
 
 		/*
@@ -185,7 +192,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		if (!power || power > EM_MAX_POWER) {
 			dev_err(dev, "EM: invalid power: %lu\n",
 				power);
-			goto free_ps_table;
+			return -EINVAL;
 		}
 
 		table[i].power = power;
@@ -194,16 +201,9 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 	ret = em_compute_costs(dev, table, cb, nr_states, flags);
 	if (ret)
-		goto free_ps_table;
-
-	pd->table = table;
-	pd->nr_perf_states = nr_states;
+		return -EINVAL;
 
 	return 0;
-
-free_ps_table:
-	kfree(table);
-	return -EINVAL;
 }
 
 static int em_create_pd(struct device *dev, int nr_states,
@@ -234,11 +234,15 @@ static int em_create_pd(struct device *dev, int nr_states,
 			return -ENOMEM;
 	}
 
-	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
-	if (ret) {
-		kfree(pd);
-		return ret;
-	}
+	pd->nr_perf_states = nr_states;
+
+	ret = em_allocate_perf_table(pd, nr_states);
+	if (ret)
+		goto free_pd;
+
+	ret = em_create_perf_table(dev, pd, pd->table, nr_states, cb, flags);
+	if (ret)
+		goto free_pd_table;
 
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
@@ -249,6 +253,12 @@ static int em_create_pd(struct device *dev, int nr_states,
 	dev->em_pd = pd;
 
 	return 0;
+
+free_pd_table:
+	kfree(pd->table);
+free_pd:
+	kfree(pd);
+	return -EINVAL;
 }
 
 static void
-- 
2.25.1


