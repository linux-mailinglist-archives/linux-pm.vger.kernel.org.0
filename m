Return-Path: <linux-pm+bounces-456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E7D7FD508
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCEA28344A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010A51C295;
	Wed, 29 Nov 2023 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C52AA1BF9;
	Wed, 29 Nov 2023 03:08:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B982F4;
	Wed, 29 Nov 2023 03:09:34 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14FD73F5A1;
	Wed, 29 Nov 2023 03:08:44 -0800 (PST)
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
Subject: [PATCH v5 17/23] powercap/dtpm_devfreq: Use new Energy Model interface to get table
Date: Wed, 29 Nov 2023 11:08:47 +0000
Message-Id: <20231129110853.94344-18-lukasz.luba@arm.com>
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

Energy Model framework support modifications at runtime of the power
values. Use the new EM table API which is protected with RCU. Align the
code so that this RCU read section is short.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm_devfreq.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index 612c3b59dd5b..514aa0d9d9c2 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -37,11 +37,15 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct devfreq *devfreq = dtpm_devfreq->devfreq;
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
+	struct em_perf_state *table;
 
-	dtpm->power_min = pd->table[0].power;
+	table = em_get_table(pd);
 
-	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
+	dtpm->power_min = table[0].power;
 
+	dtpm->power_max = table[pd->nr_perf_states - 1].power;
+
+	em_put_table();
 	return 0;
 }
 
@@ -51,20 +55,22 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	struct devfreq *devfreq = dtpm_devfreq->devfreq;
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
+	struct em_perf_state *table;
 	unsigned long freq;
 	int i;
 
+	table = em_get_table(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
-		if (pd->table[i].power > power_limit)
+		if (table[i].power > power_limit)
 			break;
 	}
 
-	freq = pd->table[i - 1].frequency;
+	freq = table[i - 1].frequency;
+	power_limit = table[i - 1].power;
+	em_put_table();
 
 	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power;
-
 	return power_limit;
 }
 
@@ -89,8 +95,9 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
 	struct devfreq_dev_status status;
+	struct em_perf_state *table;
 	unsigned long freq;
-	u64 power;
+	u64 power = 0;
 	int i;
 
 	mutex_lock(&devfreq->lock);
@@ -100,19 +107,21 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	freq = DIV_ROUND_UP(status.current_frequency, HZ_PER_KHZ);
 	_normalize_load(&status);
 
+	table = em_get_table(pd);
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		if (pd->table[i].frequency < freq)
+		if (table[i].frequency < freq)
 			continue;
 
-		power = pd->table[i].power;
+		power = table[i].power;
 		power *= status.busy_time;
 		power >>= 10;
 
-		return power;
+		break;
 	}
+	em_put_table();
 
-	return 0;
+	return power;
 }
 
 static void pd_release(struct dtpm *dtpm)
-- 
2.25.1


