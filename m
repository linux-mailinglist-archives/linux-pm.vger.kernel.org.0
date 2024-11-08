Return-Path: <linux-pm+bounces-17221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371989C225C
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1C51F248C5
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D81C3F28;
	Fri,  8 Nov 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="L+uvjbMu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65E1974FA;
	Fri,  8 Nov 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084395; cv=none; b=kgViCzX/CvAys0mentgFMng3e60+2GuTqb9ZS3YZm9ix5STC/UVvhWt1M1FrKTCWJ0+NXrGF1X7eIg6ZbtHW0X8h5wUXkEnsQAl60jb29xUvk7QpDLYmNkqA0nOKnaAuOLDkbJyr2vmW/80bKk7KOBF6gUkyLUe67l0JAq65l7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084395; c=relaxed/simple;
	bh=TULGYlML1sIhPReD5NLf2WnpNAK3uqkDVsOXeFWx3Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1Ih4zFNYiY/NVC+u1ajGeV+Ag+kalY3kp60VPubUQ7vrCm6e5BmHtqE4pWWPjdzNxAsyDUxJKkZ1hbfd/EKnTyAAt1ssT9mFMxz3k044BZ6yqyowK9qkP/bFkcpyMgEeMi3djYD1H7MJ3S1WjUqVKHRihBYfAB+ODE3qViivjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=L+uvjbMu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 816be685936a7f17; Fri, 8 Nov 2024 17:46:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 03B14834811;
	Fri,  8 Nov 2024 17:46:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731084386;
	bh=TULGYlML1sIhPReD5NLf2WnpNAK3uqkDVsOXeFWx3Gw=;
	h=From:Subject:Date;
	b=L+uvjbMuK9pjUTo6SZn+P63DXXYsKpy5vMm98PaeSakg5NcIXCXdV9/Dz7Fapg+7b
	 DdpGN0lubgwWrmn5VIq9sItWsVRHNFvPqE6Neq0wtrA/409/U5D+/cBTrAq40xxhG0
	 mDCAsfXnLcpaDtiNNjSmLBh6u6ECh14P6sY5RPNmo8DirrNrV1JQl4nLAn0wUc87NJ
	 qzVAayKKryPDRNi8880vXD58UbrE1Dk9zbz9CNn/sWc5Z8tpvSiH1SyZJktw9daz7B
	 sqReUkXvtODBrQ8xz42OzKgMVHg2ySmeDw0gqxbEK9GkXIai2lyVgS5cyU2ucmWpiH
	 +bp1hA6SHxUoA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [RFC][PATCH v0.1 1/6] PM: EM: Move perf rebuilding function from schedutil to
 EM
Date: Fri, 08 Nov 2024 17:36:29 +0100
Message-ID: <3263759.5fSG56mABF@rjwysocki.net>
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

The sugov_eas_rebuild_sd() function defined in the schedutil cpufreq
governor implements generic functionality that may be useful in other
places.  In particular, going forward it will be used in the intel_pstate
driver.

For this reason, move it from schedutil to the energy model code and
rename it to em_rebuild_perf_domains().

This also involves getting rid of some #ifdeffery in schedutil which
is a plus.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/energy_model.h     |    2 ++
 kernel/power/energy_model.c      |   17 +++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |   33 ++++++---------------------------
 3 files changed, 25 insertions(+), 27 deletions(-)

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
@@ -783,7 +758,11 @@ static int sugov_init(struct cpufreq_pol
 	if (ret)
 		goto fail;
 
-	sugov_eas_rebuild_sd();
+	/*
+	 * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
+	 * on governor changes to make sure the scheduler knows about it.
+	 */
+	em_rebuild_perf_domains();
 
 out:
 	mutex_unlock(&global_tunables_lock);
@@ -827,7 +806,7 @@ static void sugov_exit(struct cpufreq_po
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




