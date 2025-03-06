Return-Path: <linux-pm+bounces-23571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9C5A551E0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2233B5F5A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7316125B677;
	Thu,  6 Mar 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="m4pRAUPk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65025B671;
	Thu,  6 Mar 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279766; cv=none; b=ljnLx/d64MzK5gqgdwWt6XpWId7G3ss6dED8/aaKJ5XnRDcSKdTJdB3VDD85X9A0D7/ydiP5ym+L4matLTNF1WXx1nmHYVtjLGCG9Oq9rrqs7nTvpggDc25c4TLPVM36/tigwhlKR1OSlWl/lecTFJqfWuPkU9QOQhubSDBk5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279766; c=relaxed/simple;
	bh=+wkndGRtSmkZkJvjBN2WDtpkolwfhZgzVBcYIcmaWXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQZJs4AmRNzCGyMuZPWdVRUXaSMDYYx401uK5m5+bFWxNUvHLj5PYyFcnzQu7XVCd19mgdP6sOjjCc4ChyF2EbI0tFc2J3Cfof6r+5iNB7bO8qggYDoA18sJAYGNH1pTVMtJHZ219ACaeaWZ0nM/0NOR0omuh6dHUxBFeie5NZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=m4pRAUPk; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 27ddc17bb2263b0b; Thu, 6 Mar 2025 17:49:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 671A29A0DA7;
	Thu,  6 Mar 2025 17:49:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741279760;
	bh=+wkndGRtSmkZkJvjBN2WDtpkolwfhZgzVBcYIcmaWXY=;
	h=From:Subject:Date;
	b=m4pRAUPkku/K5kY1KfVF3H4RMXVmYImnZKu/D2KPGi2dW2uYZYslgoxPwvSSKH84O
	 y872bT1qJb003YbP9tPaizkiJC1Cjt9faVTJspYrHgBkmHBu1g1OmcxGR1p0NqBNfl
	 6uYMYxZ7o1c0Vyz3e43kEV9boX6SvcwrcUx3TZe/DKBbCu5DskWHpRuL9gfbztYolD
	 XkNkI6eKRsVJ9CEHXmaIkJgUfgoLO7iY1fr+rRQmZHf5NzlEnOn4kF46t1+RkQXFG9
	 C2GAdCL0yd/QQ4nzfUB4aaqHl5fxTGUDV678rWCBkjyt9FoqmDERlv/LkcQH9u948O
	 6BGBpsD90MSSg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v2] PM: EM: Address RCU-related sparse warnings
Date: Thu, 06 Mar 2025 17:49:20 +0100
Message-ID: <5885405.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomhdprhgtphhtthhopehrihgtrghrugh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The usage of __rcu in the Energy Model code is quite inconsistent
which causes the following sparse warnings to trigger:

kernel/power/energy_model.c:169:15: warning: incorrect type in assignment (different address spaces)
kernel/power/energy_model.c:169:15:    expected struct em_perf_table [noderef] __rcu *table
kernel/power/energy_model.c:169:15:    got struct em_perf_table *
kernel/power/energy_model.c:171:9: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:171:9:    expected struct callback_head *head
kernel/power/energy_model.c:171:9:    got struct callback_head [noderef] __rcu *
kernel/power/energy_model.c:171:9: warning: cast removes address space '__rcu' of expression
kernel/power/energy_model.c:182:19: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:182:19:    expected struct kref *kref
kernel/power/energy_model.c:182:19:    got struct kref [noderef] __rcu *
kernel/power/energy_model.c:200:15: warning: incorrect type in assignment (different address spaces)
kernel/power/energy_model.c:200:15:    expected struct em_perf_table [noderef] __rcu *table
kernel/power/energy_model.c:200:15:    got void *[assigned] _res
kernel/power/energy_model.c:204:20: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:204:20:    expected struct kref *kref
kernel/power/energy_model.c:204:20:    got struct kref [noderef] __rcu *
kernel/power/energy_model.c:320:19: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:320:19:    expected struct kref *kref
kernel/power/energy_model.c:320:19:    got struct kref [noderef] __rcu *
kernel/power/energy_model.c:325:45: warning: incorrect type in argument 2 (different address spaces)
kernel/power/energy_model.c:325:45:    expected struct em_perf_state *table
kernel/power/energy_model.c:325:45:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:425:45: warning: incorrect type in argument 3 (different address spaces)
kernel/power/energy_model.c:425:45:    expected struct em_perf_state *table
kernel/power/energy_model.c:425:45:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:442:15: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:442:15:    expected void const *objp
kernel/power/energy_model.c:442:15:    got struct em_perf_table [noderef] __rcu *[assigned] em_table
kernel/power/energy_model.c:626:55: warning: incorrect type in argument 2 (different address spaces)
kernel/power/energy_model.c:626:55:    expected struct em_perf_state *table
kernel/power/energy_model.c:626:55:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:681:16: warning: incorrect type in assignment (different address spaces)
kernel/power/energy_model.c:681:16:    expected struct em_perf_state *new_ps
kernel/power/energy_model.c:681:16:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:699:37: warning: incorrect type in argument 2 (different address spaces)
kernel/power/energy_model.c:699:37:    expected struct em_perf_state *table
kernel/power/energy_model.c:699:37:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:733:38: warning: incorrect type in argument 3 (different address spaces)
kernel/power/energy_model.c:733:38:    expected struct em_perf_state *table
kernel/power/energy_model.c:733:38:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:855:53: warning: dereference of noderef expression
kernel/power/energy_model.c:864:32: warning: dereference of noderef expression

This is because the __rcu annotation for sparse is only applicable to
pointers that need rcu_dereference() or equivalent for protection, which
basically means pointers assigned with rcu_assign_pointer().

Make all of the above sparse warnings go away by cleaning up the usage
of __rcu and using rcu_dereference_protected() where applicable.

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This replaces

https://lore.kernel.org/linux-pm/1929404.tdWV9SEqCh@rjwysocki.net/

and

https://lore.kernel.org/linux-pm/13728396.uLZWGnKmhe@rjwysocki.net/

---
 include/linux/energy_model.h |   12 ++++++------
 kernel/power/energy_model.c  |   39 ++++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -167,13 +167,13 @@
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table);
+			      struct em_perf_table *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				const struct em_data_callback *cb,
 				const cpumask_t *cpus, bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
-void em_table_free(struct em_perf_table __rcu *table);
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd);
+void em_table_free(struct em_perf_table *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
@@ -373,14 +373,14 @@
 	return 0;
 }
 static inline
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
 {
 	return NULL;
 }
-static inline void em_table_free(struct em_perf_table __rcu *table) {}
+static inline void em_table_free(struct em_perf_table *table) {}
 static inline
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
+			      struct em_perf_table *new_table)
 {
 	return -EINVAL;
 }
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -163,12 +163,8 @@
 
 static void em_release_table_kref(struct kref *kref)
 {
-	struct em_perf_table __rcu *table;
-
 	/* It was the last owner of this table so we can free */
-	table = container_of(kref, struct em_perf_table, kref);
-
-	kfree_rcu(table, rcu);
+	kfree_rcu(container_of(kref, struct em_perf_table, kref), rcu);
 }
 
 /**
@@ -177,7 +173,7 @@
  *
  * No return values.
  */
-void em_table_free(struct em_perf_table __rcu *table)
+void em_table_free(struct em_perf_table *table)
 {
 	kref_put(&table->kref, em_release_table_kref);
 }
@@ -190,9 +186,9 @@
  * has a user.
  * Returns allocated table or NULL.
  */
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *table;
+	struct em_perf_table *table;
 	int table_size;
 
 	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
@@ -300,9 +296,9 @@
  * Return 0 on success or an error code on failure.
  */
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
+			      struct em_perf_table *new_table)
 {
-	struct em_perf_table __rcu *old_table;
+	struct em_perf_table *old_table;
 	struct em_perf_domain *pd;
 
 	if (!dev)
@@ -319,7 +315,8 @@
 
 	kref_get(&new_table->kref);
 
-	old_table = pd->em_table;
+	old_table = rcu_dereference_protected(pd->em_table,
+					      lockdep_is_held(&em_pd_mutex));
 	rcu_assign_pointer(pd->em_table, new_table);
 
 	em_cpufreq_update_efficiencies(dev, new_table->state);
@@ -392,7 +389,7 @@
 			const cpumask_t *cpus,
 			unsigned long flags)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -552,6 +549,7 @@
 				const struct em_data_callback *cb,
 				const cpumask_t *cpus, bool microwatts)
 {
+	struct em_perf_table *em_table;
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;
 	int cpu, ret;
@@ -624,7 +622,9 @@
 	dev->em_pd->min_perf_state = 0;
 	dev->em_pd->max_perf_state = nr_states - 1;
 
-	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
+	em_table = rcu_dereference_protected(dev->em_pd->em_table,
+					     lockdep_is_held(&em_pd_mutex));
+	em_cpufreq_update_efficiencies(dev, em_table->state);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
@@ -661,7 +661,8 @@
 	mutex_lock(&em_pd_mutex);
 	em_debug_remove_pd(dev);
 
-	em_table_free(dev->em_pd->em_table);
+	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
+						lockdep_is_held(&em_pd_mutex)));
 
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
@@ -669,9 +670,9 @@
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
 
-static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
+static struct em_perf_table *em_table_dup(struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_state *ps, *new_ps;
 	int ps_size;
 
@@ -693,7 +694,7 @@
 }
 
 static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
-				struct em_perf_table __rcu *em_table)
+				struct em_perf_table *em_table)
 {
 	int ret;
 
@@ -723,7 +724,7 @@
 static void em_adjust_new_capacity(struct device *dev,
 				   struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 
 	em_table = em_table_dup(pd);
 	if (!em_table) {
@@ -814,7 +815,7 @@
  */
 int em_dev_update_chip_binning(struct device *dev)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	int i, ret;
 




