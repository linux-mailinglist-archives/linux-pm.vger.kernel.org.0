Return-Path: <linux-pm+bounces-461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395227FD50F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD3B1C20917
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717E1C293;
	Wed, 29 Nov 2023 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5031E1FE1;
	Wed, 29 Nov 2023 03:09:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F6E2F4;
	Wed, 29 Nov 2023 03:09:48 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E0913F5A1;
	Wed, 29 Nov 2023 03:08:58 -0800 (PST)
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
Subject: [PATCH v5 22/23] PM: EM: Add em_dev_compute_costs() as API for device drivers
Date: Wed, 29 Nov 2023 11:08:52 +0000
Message-Id: <20231129110853.94344-23-lukasz.luba@arm.com>
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

The device drivers can modify EM at runtime by providing a new EM table.
The EM is used by the EAS and the em_perf_state::cost stores
pre-calculated value to avoid overhead. This patch provides the API for
device drivers to calculate the cost values properly (and not duplicate
the same code).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 ++++++++
 kernel/power/energy_model.c  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 9c47388482a0..836622b1a0a1 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -170,6 +170,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
 void em_free_table(struct em_perf_table __rcu *table);
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -355,6 +357,12 @@ static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
 	return NULL;
 }
 static inline void em_put_table(void) {}
+static inline
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 234823c0e59d..fadfdefbe5f0 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -286,6 +286,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	return 0;
 }
 
+/**
+ * em_dev_compute_costs() - Calculate cost values for new runtime EM table
+ * @dev		: Device for which the EM table is to be updated
+ * @table	: The new EM table that is going to get the costs calculated
+ *
+ * Calculate the em_perf_state::cost values for new runtime EM table. The
+ * values are used for EAS during task placement. It also calculates and sets
+ * the efficiency flag for each performance state. When the function finish
+ * successfully the EM table is ready to be updated and used by EAS.
+ *
+ * Return 0 on success or a proper error in case of failure.
+ */
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states)
+{
+	return em_compute_costs(dev, table, NULL, nr_states, 0);
+}
+
 /**
  * em_dev_update_perf_domain() - Update runtime EM table for a device
  * @dev		: Device for which the EM is to be updated
-- 
2.25.1


