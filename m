Return-Path: <linux-pm+bounces-23649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707FA5724B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 20:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D913B84DF
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E62561A0;
	Fri,  7 Mar 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eQLSakU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B4183CB0;
	Fri,  7 Mar 2025 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376571; cv=none; b=iPoXC7qRi3/koYuqtkcL+ff2oKckZXT3ix2abAOPF+noCQD2ZCzysfD8FVIYVTGbzroDnQfDU5dQS+CIZ5pBzYh8DSeiHdOLZ8w+dlT5cDPf5ldnkdr3SWuneiLgggT09aXamijvBS3Y6CdHTLowhgbsOfndR+jX8UepPaMtfgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376571; c=relaxed/simple;
	bh=jSPlM41dWFTbPXF7V5lCIMCIGH9Lb5+mtbSwIByMCl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR2AzoxQKCkpDSuqvLJbYueu+LoXP9xdUCPTlsup4f30Rji4NIRORaGScXuUsJmQuBhSUYTpQN4+Qet9sOpxpEgMs44l9hU2MDnVy8A/JYbIUvhG004iXdOvreH0q9vYiL7yLcaxZGbNYyjC0LlsvVuZts4RbHJe1E9g3gAHn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eQLSakU8; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id f32e28ba78c6fdc3; Fri, 7 Mar 2025 20:42:41 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A53B59A0BFB;
	Fri,  7 Mar 2025 20:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741376561;
	bh=jSPlM41dWFTbPXF7V5lCIMCIGH9Lb5+mtbSwIByMCl0=;
	h=From:Subject:Date;
	b=eQLSakU86HKhbNp0rrOsCLm8V04zzVHJU6+vfHK4TlXD7aZNSgGUtQ88U2MO6qH8I
	 7nch8+tnET/wdRgC0gt0GsDvMY3wWqFiI8gT0nZ0dot+zLlR7wKPLi+27Q8nd/vcB9
	 vpZX3qqcS1MyJKHrwuOEnKiYVD2SG2TF1QAG8qo1LPKAJTEnz3mvh0I0SnwB4Y6W5E
	 Ge8TFAWuI3jRNQT3gJyoUKB47e5E2AcXGby8CNcxpAC0LH8dBE/oNZIR8uG6qwvpPb
	 CXzskM671AgeV3eOyMWpkYR+oyre06A6zDXuEtJlK9v3T1He/4eXUHck2h05thscXD
	 Wffvm7kRPqYTg==
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
 Christian Loehle <christian.loehle@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC][PATCH v0.3 5/6] PM: EM: Introduce em_adjust_cpu_capacity()
Date: Fri, 07 Mar 2025 20:39:34 +0100
Message-ID: <2446858.NG923GbCHz@rjwysocki.net>
In-Reply-To: <22640172.EfDdHjke4D@rjwysocki.net>
References: <22640172.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a function for updating the Energy Model for a CPU after its
capacity has changed, which subsequently will be used by the
intel_pstate driver.

An EM_PERF_DOMAIN_ARTIFICIAL check is added to em_adjust_new_capacity()
to prevent it from calling em_compute_costs() for an "artificial" perf
domain with a NULL cb parameter which would cause it to crash.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note that this function is needed because the performance level values
in the EM "state" table need to be adjusted on CPU capacity changes.  In
the intel_pstate case the cost values associated with them don't change
because they are artificial anyway, so replacing the entire table just
in order to update the performance level values is a bit wasteful, but
it seems to be an exception (in the other cases when the CPU capacity
changes, the cost values change too AFAICS).

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
@@ -405,6 +406,7 @@
 {
 	return -EINVAL;
 }
+void em_adjust_cpu_capacity(unsigned int cpu) {}
 static inline void em_rebuild_sched_domains(void) {}
 #endif
 
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -698,10 +698,12 @@
 {
 	int ret;
 
-	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
-			       pd->flags);
-	if (ret)
-		goto free_em_table;
+	if (!(pd->flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
+		ret = em_compute_costs(dev, em_table->state, NULL,
+				       pd->nr_perf_states, pd->flags);
+		if (ret)
+			goto free_em_table;
+	}
 
 	ret = em_dev_update_perf_domain(dev, em_table);
 	if (ret)
@@ -751,6 +753,24 @@
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




