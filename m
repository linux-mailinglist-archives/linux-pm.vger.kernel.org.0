Return-Path: <linux-pm+bounces-36016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31950BD6D89
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 02:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1486E422B0C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63F4F5E0;
	Tue, 14 Oct 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GYVdnbke"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549012BAF4;
	Tue, 14 Oct 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400682; cv=none; b=OVHccasKXxX+7P6wIDV9HR7TrXtnKnGiXiW71CDUs4Aqxcz3KOMJJjzgTl98gXVaTpHoL1KvQlDUhfSXA1lu4HljUhjvna7RntL0RoOUpL9mQ+Wo6lMZ73CjTwuShNohVja1ZPDUXHCWo+d7dvFVWKg5CS55LRShyFeNeYhgdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400682; c=relaxed/simple;
	bh=wlQBcPZyWi4XJKZtUGEByh7ydZiyuKMFouVRuIWp7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9fz0y5t19yPMflzngAgVAouqVju1XOUviAEbkiNT0WP1y/gkRk4LMfhl0ZXVpq44yZDqHF2LPFTgXwbLGz41kUqY4/qPdNT/PfLV9K1whov+Xqzqw/ezB0I8qYB1gscHJcqlwkwZuEtSb7TxXfCGPiS6krZ919lneubLuJb/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GYVdnbke; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wNeq7npuhqJJtVTAMtq3WXXIqglRKR2ENbm4FZ5tNQY=; b=GYVdnbkeEIxkc2QJBuvlxoZgdR
	cmw0WSfI+49dAgoHHRrEchRyLzAIZ97V3cKblKQn2XcwpOU9mgafO5WmAaN5QS9O+Q1H0IqBTlbC0
	UrLTkiX7WPkFuMFF29tT8vMdgZJXBGK10VoCs0HbnkHTtf+TGcppN+98fVHDSDXak5jCwpyJo303n
	ozL2ccPk9zpol5o+Px2eKoCJeOmUqq97uksXjqDJJ2mo3sSOMf2hAfu8e3KdG+QWLpy3j+2nUBdvB
	G4ZKZ9QtxlNjQn99EN7cI8vgS8R1ozvHhu1SlHN9QJfJ65haaa2Gs4MOLSKUwkpYu3ShmX8C5gVLc
	gS+JizYQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8SdC-009A0V-G8; Tue, 14 Oct 2025 02:11:11 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v5 01/10] PM: EM: Assign a unique ID when creating a performance domain
Date: Tue, 14 Oct 2025 09:10:46 +0900
Message-ID: <20251014001055.772422-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014001055.772422-1-changwoo@igalia.com>
References: <20251014001055.772422-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is necessary to refer to a specific performance domain from a
userspace. For example, the energy model of a particular performance
domain is updated.

To this end, assign a unique ID to each performance domain to address it,
and manage them in a global linked list to look up a specific one by
matching ID. IDA is used for ID assignment, and the mutex is used to
protect the global list from concurrent access.

Note that the mutex (em_pd_list_mutex) is not supposed to hold while
holding em_pd_mutex to avoid ABBA deadlock.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/linux/energy_model.h |  4 ++++
 kernel/power/energy_model.c  | 30 +++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 61d50571ad88..43aa6153dc57 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -54,6 +54,8 @@ struct em_perf_table {
 /**
  * struct em_perf_domain - Performance domain
  * @em_table:		Pointer to the runtime modifiable em_perf_table
+ * @node:		node in	em_pd_list (in energy_model.c)
+ * @id:			A unique ID number for each performance domain
  * @nr_perf_states:	Number of performance states
  * @min_perf_state:	Minimum allowed Performance State index
  * @max_perf_state:	Maximum allowed Performance State index
@@ -71,6 +73,8 @@ struct em_perf_table {
  */
 struct em_perf_domain {
 	struct em_perf_table __rcu *em_table;
+	struct list_head node;
+	int id;
 	int nr_perf_states;
 	int min_perf_state;
 	int max_perf_state;
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 5f17d2e8e954..2047b546ad11 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -23,6 +23,16 @@
  */
 static DEFINE_MUTEX(em_pd_mutex);
 
+/*
+ * Manage performance domains with IDs. One can iterate the performance domains
+ * through the list and pick one with their associated ID. The mutex serializes
+ * the list access. When holding em_pd_list_mutex, em_pd_mutex should not be
+ * taken to avoid potential deadlock.
+ */
+static DEFINE_IDA(em_pd_ida);
+static LIST_HEAD(em_pd_list);
+static DEFINE_MUTEX(em_pd_list_mutex);
+
 static void em_cpufreq_update_efficiencies(struct device *dev,
 					   struct em_perf_state *table);
 static void em_check_capacity_update(void);
@@ -396,7 +406,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
-	int cpu, ret, num_cpus;
+	int cpu, ret, num_cpus, id;
 
 	if (_is_cpu_device(dev)) {
 		num_cpus = cpumask_weight(cpus);
@@ -420,6 +430,13 @@ static int em_create_pd(struct device *dev, int nr_states,
 
 	pd->nr_perf_states = nr_states;
 
+	INIT_LIST_HEAD(&pd->node);
+
+	id = ida_alloc(&em_pd_ida, GFP_KERNEL);
+	if (id < 0)
+		return -ENOMEM;
+	pd->id = id;
+
 	em_table = em_table_alloc(pd);
 	if (!em_table)
 		goto free_pd;
@@ -444,6 +461,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 	kfree(em_table);
 free_pd:
 	kfree(pd);
+	ida_free(&em_pd_ida, id);
 	return -EINVAL;
 }
 
@@ -660,6 +678,10 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
 unlock:
 	mutex_unlock(&em_pd_mutex);
 
+	mutex_lock(&em_pd_list_mutex);
+	list_add_tail(&dev->em_pd->node, &em_pd_list);
+	mutex_unlock(&em_pd_list_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
@@ -678,6 +700,10 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	if (_is_cpu_device(dev))
 		return;
 
+	mutex_lock(&em_pd_list_mutex);
+	list_del_init(&dev->em_pd->node);
+	mutex_unlock(&em_pd_list_mutex);
+
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
@@ -689,6 +715,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
 						lockdep_is_held(&em_pd_mutex)));
 
+	ida_free(&em_pd_ida, dev->em_pd->id);
+
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
 	mutex_unlock(&em_pd_mutex);
-- 
2.51.0


