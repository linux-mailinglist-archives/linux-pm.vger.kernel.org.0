Return-Path: <linux-pm+bounces-18246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49E9DEAF2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6BB28169D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C2B1684B0;
	Fri, 29 Nov 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="n7H/4bF/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86945BEC;
	Fri, 29 Nov 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897710; cv=none; b=GzbJOxGbps5bKySt1O2xoGEpsWCZjoUgww8fjEUcqAkJAaMxFGlA/H1XByptJgTMA7dJs7EHsVa5Ec0Vownf1ZIugWaB5thZQylBOmIdpLJ85X+a+FhC0hM3zC89LZ6dMnNetzapCy8iQWI70OaPDIMfjJ93OGFOk0F8gKyEjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897710; c=relaxed/simple;
	bh=70VAqg/TQpJWDE7ktXbJySBPdaEm0FcPRiLHVS6/0Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a43uMvjFjt+77QgHcBaOdFQD6g8fbejWV20A8fJD8VFwPHiT8zbu4XqTqoZQx6R1BeHN7826yni2JCQg61jMlbDVPynmodUlg0eBglkPrakb0dSrLyoOFmHdU6WUwQR58YPzvk+eWPZNnlVKZmZWcRAbfTJKNx7o5+WRoi9hHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=n7H/4bF/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 7508729bf5dc54a4; Fri, 29 Nov 2024 17:28:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AEE1EA47B8B;
	Fri, 29 Nov 2024 17:28:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897705;
	bh=70VAqg/TQpJWDE7ktXbJySBPdaEm0FcPRiLHVS6/0Qg=;
	h=From:Subject:Date;
	b=n7H/4bF/KpSAS8A7lDXbh/Z9QenT9BYexxAzDsH4X25avSJLAiTJxIt7NCSiIgTgK
	 gp77dfDRcxrMmve7slXtGSxW/fiJahZyPocChSqhT50bLQTA2070PfQNU/EGwHRDyf
	 11xJ+jRecbASE6OAaUUF39aUx+w1wLa8ffnHyfvqKQJkiYXEBaKOGblXXUdNDZpyTQ
	 WFTNNZxIh2l5VOvkW2czfHGiUe7Ez57ymIaanhWjiDZpnESB++XvefftJsfmtFG/ho
	 yTReavoW7LGrpp2VQ5W7lFD9kijnzw4g4L3mq9/9d7yMrlUju589wGEiZwh6ffqOpb
	 rqaqZLKj6SDiA==
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
Subject:
 [RFC][PATCH v021 3/9] PM: EM: Move perf rebuilding function from schedutil to
 EM
Date: Fri, 29 Nov 2024 16:59:06 +0100
Message-ID: <2229205.irdbgypaU6@rjwysocki.net>
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

The sugov_eas_rebuild_sd() function defined in the schedutil cpufreq
governor implements generic functionality that may be useful in other
places.  In particular, going forward it will be used in the intel_pstate
driver.

For this reason, move it from schedutil to the energy model code and
rename it to em_rebuild_perf_domains().

This also helps to get rid of some #ifdeffery in schedutil which is a
plus.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.1 -> v0.2:
     * Update the comment regarding :register_em() in cpufreq.
     * Changelog edits.

---
 drivers/cpufreq/cpufreq.c        |    2 +-
 include/linux/energy_model.h     |    2 ++
 kernel/power/energy_model.c      |   17 +++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |   33 ++++++---------------------------
 4 files changed, 26 insertions(+), 28 deletions(-)

Index: linux-pm/kernel/power/energy_model.c
===================================================================
--- linux-pm.orig/kernel/power/energy_model.c
+++ linux-pm/kernel/power/energy_model.c
@@ -908,3 +908,20 @@ int em_update_performance_limits(struct
 	return 0;
 }
 EXPORT_SYMBOL_GPL(em_update_performance_limits);
+
+static void rebuild_sd_workfn(struct work_struct *work)
+{
+	rebuild_sched_domains_energy();
+}
+
+static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
+
+void em_rebuild_perf_domains(void)
+{
+	/*
+	 * When called from the cpufreq_register_driver() path, the
+	 * cpu_hotplug_lock is already held, so use a work item to
+	 * avoid nested locking in rebuild_sched_domains().
+	 */
+	schedule_work(&rebuild_sd_work);
+}
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -604,31 +604,6 @@ static const struct kobj_type sugov_tuna
 
 /********************** cpufreq governor interface *********************/
 
-#ifdef CONFIG_ENERGY_MODEL
-static void rebuild_sd_workfn(struct work_struct *work)
-{
-	rebuild_sched_domains_energy();
-}
-
-static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
-
-/*
- * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
- * on governor changes to make sure the scheduler knows about it.
- */
-static void sugov_eas_rebuild_sd(void)
-{
-	/*
-	 * When called from the cpufreq_register_driver() path, the
-	 * cpu_hotplug_lock is already held, so use a work item to
-	 * avoid nested locking in rebuild_sched_domains().
-	 */
-	schedule_work(&rebuild_sd_work);
-}
-#else
-static inline void sugov_eas_rebuild_sd(void) { };
-#endif
-
 struct cpufreq_governor schedutil_gov;
 
 static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
@@ -784,7 +759,11 @@ static int sugov_init(struct cpufreq_pol
 		goto fail;
 
 out:
-	sugov_eas_rebuild_sd();
+	/*
+	 * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
+	 * on governor changes to make sure the scheduler knows about them.
+	 */
+	em_rebuild_perf_domains();
 	mutex_unlock(&global_tunables_lock);
 	return 0;
 
@@ -826,7 +805,7 @@ static void sugov_exit(struct cpufreq_po
 	sugov_policy_free(sg_policy);
 	cpufreq_disable_fast_switch(policy);
 
-	sugov_eas_rebuild_sd();
+	em_rebuild_perf_domains();
 }
 
 static int sugov_start(struct cpufreq_policy *policy)
Index: linux-pm/include/linux/energy_model.h
===================================================================
--- linux-pm.orig/include/linux/energy_model.h
+++ linux-pm/include/linux/energy_model.h
@@ -179,6 +179,7 @@ int em_dev_compute_costs(struct device *
 int em_dev_update_chip_binning(struct device *dev);
 int em_update_performance_limits(struct em_perf_domain *pd,
 		unsigned long freq_min_khz, unsigned long freq_max_khz);
+void em_rebuild_perf_domains(void);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -404,6 +405,7 @@ int em_update_performance_limits(struct
 {
 	return -EINVAL;
 }
+static inline void em_rebuild_perf_domains(void) {}
 #endif
 
 #endif
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1538,7 +1538,7 @@ static int cpufreq_online(unsigned int c
 
 		/*
 		 * Register with the energy model before
-		 * sugov_eas_rebuild_sd() is called, which will result
+		 * em_rebuild_perf_domains() is called, which will result
 		 * in rebuilding of the sched domains, which should only be done
 		 * once the energy model is properly initialized for the policy
 		 * first.




