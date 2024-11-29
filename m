Return-Path: <linux-pm+bounces-18253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0F9DEAFE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDFD281CF6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE771A0BC1;
	Fri, 29 Nov 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UI2HNgbG"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6319CC02;
	Fri, 29 Nov 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897712; cv=none; b=rdp0msrIp/MLdt+Ujy5qByQ6RcFFjGX9bnIYFUb+O72b/utiBZ4HoPjg7sOgKoKQMvfZ8k/0LSJ+64fUd+bR04SEQ9HZyTUJ4JbH3CFk18Ey/O7DdZ/2WjmY0qF26I/Aup6y1a8a8tQOzK4dSNmZUWug7DMj+RhavlyLZEGI8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897712; c=relaxed/simple;
	bh=wMEd2h7OudxO2dV+sTCknQbfUGqj+8oLnQbaSw+jLb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJPrdy2zk9jPk2orWSyzV7eBw1UiY5k1K+l19ZQS6YdOQoFyfAnPpl3tROORVOPAKqGEBTHaoZbNkKpFwIar9dLcqzd/+mwVOHAazkYMARgYgKAXpCw7yf7dZSwYr+Fn43lm5apjczZezDJPtS4xVFrgfOPmRRyfcAOPsYqKh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UI2HNgbG; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 2c1251ab29003005; Fri, 29 Nov 2024 17:28:23 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E697EA47B8B;
	Fri, 29 Nov 2024 17:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897703;
	bh=wMEd2h7OudxO2dV+sTCknQbfUGqj+8oLnQbaSw+jLb0=;
	h=From:Subject:Date;
	b=UI2HNgbGTg30pamLeA7Hsr7h4WYRqDVBjilad9oCD3WQ78x69MuC0MjbNj/XjphdW
	 7E5fDZBcFaU1oSeNbfxaUiOhAaZiF1uSLLV6aaxAveZD3sG8SDE9WPDJaa2kNb6DW8
	 eBoNycHbR2A/tWIaiHuWGNWn8YnivEXtQgmZgUrlON8u52Vitf1XPh608M/WsR6Okt
	 r+gLwLLbS3J1ci8gtaB6v5TrlUOlU2RYCIy0/XmxfzLjNJfCH15G4n6jvOW0mvFJkl
	 AoMaHka/V25u6sYCP4rj9Ir8akmS9L2/ZqHD9DVV/NUCgbokqioDW0gPmGNGD8FoRH
	 V7oFXb+q9sZpg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
Subject: [RFC][PATCH v021 5/9] PM: EM: Introduce em_dev_expand_perf_domain()
Date: Fri, 29 Nov 2024 17:02:02 +0100
Message-ID: <3353401.44csPzL39Z@rjwysocki.net>
In-Reply-To: <5861970.DvuYhMxLoT@rjwysocki.net>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a helper function for adding a CPU to an existing EM perf
domain.

Subsequently, this will be used by the intel_pstate driver to add new
CPUs to existing perf domains when those CPUs go online for the first
time after the initialization of the driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.1 -> v0.2: No changes

---
 include/linux/energy_model.h |    5 +++++
 kernel/power/energy_model.c  |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

Index: linux-pm/kernel/power/energy_model.c
===================================================================
--- linux-pm.orig/kernel/power/energy_model.c
+++ linux-pm/kernel/power/energy_model.c
@@ -676,6 +676,38 @@ void em_dev_unregister_perf_domain(struc
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
 
+/**
+ * em_dev_expand_perf_domain() - Expand CPU perf domain
+ * @dev: CPU device of a CPU in the perf domain.
+ * @new_cpu: CPU to add to the perf domain.
+ */
+int em_dev_expand_perf_domain(struct device *dev, int new_cpu)
+{
+	struct device *new_cpu_dev;
+	struct em_perf_domain *pd;
+
+	if (IS_ERR_OR_NULL(dev) || !_is_cpu_device(dev))
+		return -EINVAL;
+
+	new_cpu_dev = get_cpu_device(new_cpu);
+	if (!new_cpu_dev)
+		return -EINVAL;
+
+	guard(mutex)(&em_pd_mutex);
+
+	if (em_pd_get(new_cpu_dev))
+		return -EEXIST;
+
+	pd = em_pd_get(dev);
+	if (!pd)
+		return -EINVAL;
+
+	cpumask_set_cpu(new_cpu, em_span_cpus(pd));
+	new_cpu_dev->em_pd = pd;
+
+	return 0;
+}
+
 static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *em_table;
Index: linux-pm/include/linux/energy_model.h
===================================================================
--- linux-pm.orig/include/linux/energy_model.h
+++ linux-pm/include/linux/energy_model.h
@@ -172,6 +172,7 @@ int em_dev_register_perf_domain(struct d
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
+int em_dev_expand_perf_domain(struct device *dev, int new_cpu);
 struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
 void em_table_free(struct em_perf_table __rcu *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
@@ -354,6 +355,10 @@ int em_dev_register_perf_domain(struct d
 static inline void em_dev_unregister_perf_domain(struct device *dev)
 {
 }
+static inline int em_dev_expand_perf_domain(struct device *dev, int new_cpu)
+{
+	return -EINVAL;
+}
 static inline struct em_perf_domain *em_cpu_get(int cpu)
 {
 	return NULL;




