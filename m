Return-Path: <linux-pm+bounces-17218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4A9C2256
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32A71C22B3F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D1199222;
	Fri,  8 Nov 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="TcP8y+xZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BD19415E;
	Fri,  8 Nov 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084395; cv=none; b=jXNS46LC6+t+FTZ1EMDdt7chSU10m7BHp9N1ykGBl1rECSt5y3QtXJ5EbVNFJuSx0WbmDhJf/RuKDGmGdTob/csG4hMzCiC7ILd+Y1ESxDWMvJ9tJNPaPtURbLYy+FIvb4kGqWfo5SmIze3KbN15nk6AwVu3bCGaA/F8jqESlpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084395; c=relaxed/simple;
	bh=a6aZwa1LaDJUrUWhlEpL2OK9yCO3CgJqQ0flWFySIkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZR/Lw7j9vOVDMZt1tw7AmqgbOEY2n//pkUA+u8PRjLk0s0Y/GLCQvzY2ApuIO8FayABKyzVcxPiqv1YGLmqADKhnEAZ3HHeH2Dm9sudAODC5ugJneLPYp+Lm5RtwdKElLGy5+K4dibTp0bSeLDS+/RAY7fEjtsKeg2sChzTj3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=TcP8y+xZ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 2ee52bafb25240cc; Fri, 8 Nov 2024 17:46:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C8A3B834811;
	Fri,  8 Nov 2024 17:46:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731084384;
	bh=a6aZwa1LaDJUrUWhlEpL2OK9yCO3CgJqQ0flWFySIkE=;
	h=From:Subject:Date;
	b=TcP8y+xZec1zibPMd3rSHYuDZrlkkw3pqp22gJyG4t8AzPMAhO5YttS0FokY4iyAI
	 h0sEXFDrNkhGw3TTA6al/g9Z/gGIx2qPrS6uzD7agOqZEAh7XtXyth+hE0TBmZc4AU
	 y3kep/SXiz9d6nIjphUmgjdexJ1sG12AMos+QC/22jLuQR3dlpQUJDGxBSUsSKJuTv
	 6ryWlReHX+tNnVOZPhSVW0xiM9Az3G404N1sdO3IZwr7AriyFe5cNuuLjqOt2JumOg
	 ahPp5ce7usuea8t0RKcnvVQWpq8xeW+J3M81sOnKl/d3bGy/+ydjmvWGwiSSMfjMHH
	 AIJCq4a9M0CVA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [RFC][PATCH v0.1 4/6] PM: EM: Introduce em_dev_expand_perf_domain()
Date: Fri, 08 Nov 2024 17:40:53 +0100
Message-ID: <2223963.Mh6RI2rZIc@rjwysocki.net>
In-Reply-To: <3607404.iIbC2pHGDl@rjwysocki.net>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthg
X-DCC--Metrics: v370.home.net.pl 0; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a helper function for adding a CPU to an existing EM perf
domain.

Subsequently, this will be used by the intel_pstate driver to add new
CPUs to existing perf domains when those CPUs go online for the first
time after the initialization of the driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/energy_model.h |    5 +++++
 kernel/power/energy_model.c  |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

Index: linux-pm/kernel/power/energy_model.c
===================================================================
--- linux-pm.orig/kernel/power/energy_model.c
+++ linux-pm/kernel/power/energy_model.c
@@ -696,6 +696,38 @@ void em_dev_unregister_perf_domain(struc
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




