Return-Path: <linux-pm+bounces-26753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE3AACEF8
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379DE982662
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6761F2BB8;
	Tue,  6 May 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sLUtSPjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EC1B87F0;
	Tue,  6 May 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564586; cv=none; b=suuH+IBS8iUWCt2d2atXa+cqcXdS42OWo+Qz7gN8J5ZBbk460PWvkMufrkZxI6Mr2GNH1Zclri1C10Vi/8FgNNy5ebN9PeGN7Ylw/EwT7CAYp/sDZlCAKsIkhNxwbwanOjEoFmWKWymC3OE9fTc77kcdf+vb01z0vKXa3vV8ZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564586; c=relaxed/simple;
	bh=4lV2ajf8SHgMeBPWlu1efq9ktIyLStrRYprfISF89l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FA22/a6Iaqr+7MWQ+oyWL9cKFeHu8Ye3FzDUHcyaJCqJ440Iem4cXLtL7fOgW+8fXK/CZX1An+0tIP5ZCCc6ekMWaathxIKXi6y6IMo9ulkTERcGt9mNlYjRDBiB6qyxrD2Op9voj+wusXI38ygYBnHsybEawwntVFujPSrzBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sLUtSPjQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 82249666BAF;
	Tue,  6 May 2025 22:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564575;
	bh=4lV2ajf8SHgMeBPWlu1efq9ktIyLStrRYprfISF89l0=;
	h=From:Subject:Date;
	b=sLUtSPjQNvUHP4Y6tkGqHQOscenpc/iGkWYMNBIiELaO0LcwhDaF7CUoZmyRsbooY
	 hf2xjxt9JNg3T3IlcMx6YAoejqFgiTuIwvVR+o0eZ9KkUCT5egxcksjqiXbp5UE5Qn
	 hrah1tTPWW2Kot9lj853gGhZhFS5dPoxWYrCkUrARIeF1jPu6PsAUddB4Km5094viS
	 wsC1uY1kavVICu7qmH8jz+sMq2ESu3tSWlMIY71ldu+17Ur82Q0yjS4Rl38ntGRPcY
	 2mcOR/SJA7KRpvBM2sQlkAC5mGk0MY/M9cgOZ9BV2th0uz4xt06Kg0LIsdT1jfhYFm
	 8ITmHY/h/qtLA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 4/7] PM: EM: Introduce em_adjust_cpu_capacity()
Date: Tue, 06 May 2025 22:41:21 +0200
Message-ID: <3637203.iIbC2pHGDl@rjwysocki.net>
In-Reply-To: <2999205.e9J7NaK4W3@rjwysocki.net>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a function for updating the Energy Model for a CPU after its
capacity has changed, which subsequently will be used by the
intel_pstate driver.

An EM_PERF_DOMAIN_ARTIFICIAL check is added to em_recalc_and_update()
to prevent it from calling em_compute_costs() for an "artificial" perf
domain with a NULL cb parameter which would cause it to crash.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

v1 -> v2:
   * Use em_is_artificial() in the new check (Dietmar).
   * Pick up tags.

---
 include/linux/energy_model.h |    2 ++
 kernel/power/energy_model.c  |   28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -179,6 +179,7 @@
 int em_dev_update_chip_binning(struct device *dev);
 int em_update_performance_limits(struct em_perf_domain *pd,
 		unsigned long freq_min_khz, unsigned long freq_max_khz);
+void em_adjust_cpu_capacity(unsigned int cpu);
 void em_rebuild_sched_domains(void);
 
 /**
@@ -403,6 +404,7 @@
 {
 	return -EINVAL;
 }
+static inline void em_adjust_cpu_capacity(unsigned int cpu) {}
 static inline void em_rebuild_sched_domains(void) {}
 #endif
 
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -702,10 +702,12 @@
 {
 	int ret;
 
-	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
-			       pd->flags);
-	if (ret)
-		goto free_em_table;
+	if (!em_is_artificial(pd)) {
+		ret = em_compute_costs(dev, em_table->state, NULL,
+				       pd->nr_perf_states, pd->flags);
+		if (ret)
+			goto free_em_table;
+	}
 
 	ret = em_dev_update_perf_domain(dev, em_table);
 	if (ret)
@@ -755,6 +757,24 @@
 	em_recalc_and_update(dev, pd, em_table);
 }
 
+/**
+ * em_adjust_cpu_capacity() - Adjust the EM for a CPU after a capacity update.
+ * @cpu: Target CPU.
+ *
+ * Adjust the existing EM for @cpu after a capacity update under the assumption
+ * that the capacity has been updated in the same way for all of the CPUs in
+ * the same perf domain.
+ */
+void em_adjust_cpu_capacity(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	struct em_perf_domain *pd;
+
+	pd = em_pd_get(dev);
+	if (pd)
+		em_adjust_new_capacity(cpu, dev, pd);
+}
+
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;




