Return-Path: <linux-pm+bounces-40024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D9CE8C68
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 07:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7FF93009F28
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA52EA749;
	Tue, 30 Dec 2025 06:20:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6CC2EA;
	Tue, 30 Dec 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767075639; cv=none; b=otfD/vdNmAiUTeEUVPrGHT+OeIV92RHTpcsvq1VQUlQeUwoxgtM51mIhzZy8/PpUw187W3UpZwByVdbFF1aKbiKKbfxn0dsLK3Eblx/pipHEKp0jgIfJra5kp/bJFxAcEFhF/eg7DqpslEUcBpWkdFL51Rxx9CAKXhB1tV4BRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767075639; c=relaxed/simple;
	bh=mtipBztjhkcYROUTtamc1RFKv/uV8z1GPHBVIBQmMRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hD/Wxz9vzZEkUOgkXbzsFWre/OHo+wwVtX1LtvYwRrrr6LrnNYE/5BBjrs9Y+s2Jk5gxQH1P8UkMrnoYtBNkuQbqub5WH3MaRcgjmsYtflCOTlAumO56dbLY49aalt+n8RtRzDIHFoLmi6HP48FrMQNt0t0YFyNsdMzGoTvmh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9c6f6c7ce54711f0a38c85956e01ac42-20251230
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4189b097-2a4a-4e8d-9d20-6b826c7d1254,IP:85,U
	RL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:60
X-CID-INFO: VERSION:1.3.6,REQID:4189b097-2a4a-4e8d-9d20-6b826c7d1254,IP:85,URL
	:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:60
X-CID-META: VersionHash:a9d874c,CLOUDID:28c22ffa91906e1cb12fc2639411d8f0,BulkI
	D:251230142020FNSFMLCH,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|12
	7|850|898,TC:nil,Content:0|15|50,EDM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_IMR,TF_CID_SPAM_SNR,TF_CID_SPAM_ASC,
	TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9c6f6c7ce54711f0a38c85956e01ac42-20251230
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.157.141)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2046672310; Tue, 30 Dec 2025 14:20:17 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 2/2] PM: EM: Simplify mutex-related code in energy_model.c using scoped_guard
Date: Tue, 30 Dec 2025 14:20:13 +0800
Message-Id: <20251230062013.829064-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251230061534.816894-1-tianyaxiong@kylinos.cn>
References: <20251230061534.816894-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code cleanup with no functional changes. Use scoped_guard() instead of
open-coded mutex_lock/mutex_unlock.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/power/energy_model.c | 173 ++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 95 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 11af9f64aa82..cf2a8e958ecb 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -333,25 +333,21 @@ int em_dev_update_perf_domain(struct device *dev,
 		return -EINVAL;
 
 	/* Serialize update/unregister or concurrent updates */
-	mutex_lock(&em_pd_mutex);
-
-	if (!dev->em_pd) {
-		mutex_unlock(&em_pd_mutex);
-		return -EINVAL;
-	}
-	pd = dev->em_pd;
-
-	kref_get(&new_table->kref);
+	scoped_guard(mutex, &em_pd_mutex) {
+		if (!dev->em_pd)
+			return -EINVAL;
+		pd = dev->em_pd;
 
-	old_table = rcu_dereference_protected(pd->em_table,
-					      lockdep_is_held(&em_pd_mutex));
-	rcu_assign_pointer(pd->em_table, new_table);
+		kref_get(&new_table->kref);
 
-	em_cpufreq_update_efficiencies(dev, new_table->state);
+		old_table = rcu_dereference_protected(pd->em_table,
+							lockdep_is_held(&em_pd_mutex));
+		rcu_assign_pointer(pd->em_table, new_table);
 
-	em_table_free(old_table);
+		em_cpufreq_update_efficiencies(dev, new_table->state);
 
-	mutex_unlock(&em_pd_mutex);
+		em_table_free(old_table);
+	}
 
 	em_notify_pd_updated(pd);
 	return 0;
@@ -623,82 +619,70 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
 	 * Use a mutex to serialize the registration of performance domains and
 	 * let the driver-defined callback functions sleep.
 	 */
-	mutex_lock(&em_pd_mutex);
-
-	if (dev->em_pd) {
-		ret = -EEXIST;
-		goto unlock;
-	}
+	scoped_guard(mutex, &em_pd_mutex) {
+		if (dev->em_pd)
+			return -EEXIST;
 
-	if (_is_cpu_device(dev)) {
-		if (!cpus) {
-			dev_err(dev, "EM: invalid CPU mask\n");
-			ret = -EINVAL;
-			goto unlock;
-		}
-
-		for_each_cpu(cpu, cpus) {
-			if (em_cpu_get(cpu)) {
-				dev_err(dev, "EM: exists for CPU%d\n", cpu);
-				ret = -EEXIST;
-				goto unlock;
+		if (_is_cpu_device(dev)) {
+			if (!cpus) {
+				dev_err(dev, "EM: invalid CPU mask\n");
+				return -EINVAL;
 			}
-			/*
-			 * All CPUs of a domain must have the same
-			 * micro-architecture since they all share the same
-			 * table.
-			 */
-			cap = arch_scale_cpu_capacity(cpu);
-			if (prev_cap && prev_cap != cap) {
-				dev_err(dev, "EM: CPUs of %*pbl must have the same capacity\n",
-					cpumask_pr_args(cpus));
-
-				ret = -EINVAL;
-				goto unlock;
+
+			for_each_cpu(cpu, cpus) {
+				if (em_cpu_get(cpu)) {
+					dev_err(dev, "EM: exists for CPU%d\n", cpu);
+					return -EEXIST;
+				}
+				/*
+				 * All CPUs of a domain must have the same
+				 * micro-architecture since they all share the same
+				 * table.
+				 */
+				cap = arch_scale_cpu_capacity(cpu);
+				if (prev_cap && prev_cap != cap) {
+					dev_err(dev, "EM: CPUs of %*pbl must have the same capacity\n",
+						cpumask_pr_args(cpus));
+
+					return -EINVAL;
+				}
+				prev_cap = cap;
 			}
-			prev_cap = cap;
 		}
-	}
 
-	if (microwatts)
-		flags |= EM_PERF_DOMAIN_MICROWATTS;
-	else if (cb->get_cost)
-		flags |= EM_PERF_DOMAIN_ARTIFICIAL;
+		if (microwatts)
+			flags |= EM_PERF_DOMAIN_MICROWATTS;
+		else if (cb->get_cost)
+			flags |= EM_PERF_DOMAIN_ARTIFICIAL;
 
-	/*
-	 * EM only supports uW (exception is artificial EM).
-	 * Therefore, check and force the drivers to provide
-	 * power in uW.
-	 */
-	if (!microwatts && !(flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
-		dev_err(dev, "EM: only supports uW power values\n");
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	ret = em_create_pd(dev, nr_states, cb, cpus, flags);
-	if (ret)
-		goto unlock;
+		/*
+		 * EM only supports uW (exception is artificial EM).
+		 * Therefore, check and force the drivers to provide
+		 * power in uW.
+		 */
+		if (!microwatts && !(flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
+			dev_err(dev, "EM: only supports uW power values\n");
+			return -EINVAL;
+		}
 
-	dev->em_pd->flags |= flags;
-	dev->em_pd->min_perf_state = 0;
-	dev->em_pd->max_perf_state = nr_states - 1;
+		ret = em_create_pd(dev, nr_states, cb, cpus, flags);
+		if (ret)
+			return ret;
 
-	em_table = rcu_dereference_protected(dev->em_pd->em_table,
-					     lockdep_is_held(&em_pd_mutex));
-	em_cpufreq_update_efficiencies(dev, em_table->state);
+		dev->em_pd->flags |= flags;
+		dev->em_pd->min_perf_state = 0;
+		dev->em_pd->max_perf_state = nr_states - 1;
 
-	em_debug_create_pd(dev);
-	dev_info(dev, "EM: created perf domain\n");
+		em_table = rcu_dereference_protected(dev->em_pd->em_table,
+							lockdep_is_held(&em_pd_mutex));
+		em_cpufreq_update_efficiencies(dev, em_table->state);
 
-unlock:
-	mutex_unlock(&em_pd_mutex);
-	if (ret)
-		return ret;
+		em_debug_create_pd(dev);
+		dev_info(dev, "EM: created perf domain\n");
+	}
 
-	mutex_lock(&em_pd_list_mutex);
-	list_add_tail(&dev->em_pd->node, &em_pd_list);
-	mutex_unlock(&em_pd_list_mutex);
+	scoped_guard(mutex, &em_pd_list_mutex)
+		list_add_tail(&dev->em_pd->node, &em_pd_list);
 
 	em_notify_pd_created(dev->em_pd);
 
@@ -720,9 +704,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	if (_is_cpu_device(dev))
 		return;
 
-	mutex_lock(&em_pd_list_mutex);
-	list_del_init(&dev->em_pd->node);
-	mutex_unlock(&em_pd_list_mutex);
+	scoped_guard(mutex, &em_pd_list_mutex)
+		list_del_init(&dev->em_pd->node);
 
 	em_notify_pd_deleted(dev->em_pd);
 
@@ -731,17 +714,17 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	 * from potential clean-up/setup issues in the debugfs directories.
 	 * The debugfs directory name is the same as device's name.
 	 */
-	mutex_lock(&em_pd_mutex);
-	em_debug_remove_pd(dev);
+	scoped_guard(mutex, &em_pd_mutex) {
+		em_debug_remove_pd(dev);
 
-	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
-						lockdep_is_held(&em_pd_mutex)));
+		em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
+							lockdep_is_held(&em_pd_mutex)));
 
-	ida_free(&em_pd_ida, dev->em_pd->id);
+		ida_free(&em_pd_ida, dev->em_pd->id);
 
-	kfree(dev->em_pd);
-	dev->em_pd = NULL;
-	mutex_unlock(&em_pd_mutex);
+		kfree(dev->em_pd);
+		dev->em_pd = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
 
@@ -983,10 +966,10 @@ int em_update_performance_limits(struct em_perf_domain *pd,
 
 
 	/* Guard simultaneous updates and make them atomic */
-	mutex_lock(&em_pd_mutex);
-	pd->min_perf_state = min_ps;
-	pd->max_perf_state = max_ps;
-	mutex_unlock(&em_pd_mutex);
+	scoped_guard(mutex, &em_pd_mutex) {
+		pd->min_perf_state = min_ps;
+		pd->max_perf_state = max_ps;
+	}
 
 	return 0;
 }
-- 
2.25.1


