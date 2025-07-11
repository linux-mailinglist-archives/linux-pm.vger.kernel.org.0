Return-Path: <linux-pm+bounces-30654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC4B01068
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDED41C23C0D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62613AA53;
	Fri, 11 Jul 2025 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="i6h8AFrn"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E087FBA1;
	Fri, 11 Jul 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195226; cv=none; b=hahICiaAsNEnXpMzFpyPFYq7hNDGvsTN8ujNcs8w7U51zXhVOI/RvNScILEirx5DuPAwP69YCgyNmCVw+nNYZz8DiSDZt+4H4iTX43QpC0s2nFu/AjpQyaeBHcBZEmTh25i7ov3B+zVcHUIHjbPyts/Kpy1VCddIwc3yBjGql+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195226; c=relaxed/simple;
	bh=2HgT+WN2UxSuaxVoGYR4Mk3NCTQms2rlYvrqmGgkFGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep+kgspg5GIn7jYzEqKJl9+Jwqtdd1Qt96jtFW46N2XIcI65lSUUBDSbDpNlvleWd4Te4v1XcuTA7aA4GFyotepb0J3XN3cxlSp2FukVK1Zgk8GBGpkXygxQQykmjOe7x1VqYGH0rd5G39cry++K3ywHIpsL78jYHINkrMvOB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=i6h8AFrn; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=axmYQghQ8qyycEuVlszvS6P+XkO6VAObIC7vNTuWQ38=; b=i6h8AFrnvSSGnzwRhOaW/IWfN+
	rSf5HHTg9h3HViNes5nmMJrd68DrOf4I08Kjw6eWVJ1oeOKre6jxulqWEUZluZVG5RtN0ujio8t/m
	9riI3p9YqupJdqyW1RpR+wlADQRv9C9YKVGPDHaGjwJ5Fbd1PkHBK/a7HAfscyGvvAoTZAVLeOQhi
	o8/dcs6b3PxyJN73kVix68JMlibZSsrYl23f4W/HkIWSJGa/OdRe9wMaIrYCY2N2TqA4qD9ROV9Ya
	4xhsnsiTh/44/6M46Faq9LqJdP4HHi4ZSPs85zpgk/m8ZOwyTy0h74lijAwyRlXbesk3J2QKp83kz
	gBJ+lV6Q==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua21A-00FAmd-Q0; Fri, 11 Jul 2025 02:53:37 +0200
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
Subject: [PATCH v3 03/10] PM: EM: Assign a unique ID when creating a performance domain.
Date: Fri, 11 Jul 2025 09:53:03 +0900
Message-ID: <20250711005310.20740-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711005310.20740-1-changwoo@igalia.com>
References: <20250711005310.20740-1-changwoo@igalia.com>
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
index 7fa1eb3cc823..2f5c73fcdfe5 100644
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
index ea7995a25780..58671ac142db 100644
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
 
@@ -639,6 +657,10 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	if (_is_cpu_device(dev))
 		em_check_capacity_update();
 
+	mutex_lock(&em_pd_list_mutex);
+	list_add_tail(&dev->em_pd->node, &em_pd_list);
+	mutex_unlock(&em_pd_list_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
@@ -657,6 +679,10 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	if (_is_cpu_device(dev))
 		return;
 
+	mutex_lock(&em_pd_list_mutex);
+	list_del_init(&dev->em_pd->node);
+	mutex_unlock(&em_pd_list_mutex);
+
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
@@ -668,6 +694,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
 						lockdep_is_held(&em_pd_mutex)));
 
+	ida_free(&em_pd_ida, dev->em_pd->id);
+
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
 	mutex_unlock(&em_pd_mutex);
-- 
2.50.0


