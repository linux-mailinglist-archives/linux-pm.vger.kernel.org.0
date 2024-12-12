Return-Path: <linux-pm+bounces-19120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55E9EE631
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 13:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4471418864CA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD49B213E84;
	Thu, 12 Dec 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="oTQ0inJu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32C2135DE;
	Thu, 12 Dec 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004875; cv=none; b=c3M3w4u98jyizM2ncW3W2mVrEXK7RLuHohKZcMvWvTBZ+K7HDQ/ZLb55S43g8VRoPW4UgWVNtYHt4TnWIrszh7/JVRCWf/VRwVgaPtk9zs2uvnReAolcmXOelsV8kXlrp0bw+yhkowz5hSKbU8b2WP9rGG6E45cchH7+URmDrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004875; c=relaxed/simple;
	bh=dkBozgEhWhJDJ/kLU6yjkHZ1LcjDuX0+NbLxBHsMdl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMBmMB8caRITDX6bjLyKWe28zFswFbrvRWjdlYu0Jy9gNR8Y22tNRa2k8sOx4v48bg5vdjEILBTLojmFT/T99zoQr33pbbEBygoCFoljGh+yQbQNwURxBntlEMuBj344nMYNLGFq5lLFznGVT0QI/eT74FQFYqF2o9iRNatCwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=oTQ0inJu; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 727f3259d2d0f307; Thu, 12 Dec 2024 13:01:04 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 27B6F7F5D79;
	Thu, 12 Dec 2024 13:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1734004864;
	bh=dkBozgEhWhJDJ/kLU6yjkHZ1LcjDuX0+NbLxBHsMdl8=;
	h=From:Subject:Date;
	b=oTQ0inJuUhY1rXnO85svM8tOFU+sAMrLgiDr2ylPPk7YCHBphlhdCFHryDDcyEaMQ
	 r4ODc3kf835Z8IWeHEdUTAsEuel4EXSpJuI5jpyTFFT6yZ8xZS050EZ5SlChxKU3zY
	 snQ/eryHSMmkmmJVgkBlpRynNKXzphNpG0I4R9SOiyWAc8zU58CTcQBPbx7DohtdjR
	 yTlGOcLwvn14TmDu74Y3TTsQD2Ett2+VUghBoFg4eEwzP8KODfzDE5J4KN1fRicAFs
	 CogdkjBxL6SUC3FlHPXax9wh87dlGfN1NtHOU+eID0i2aJ7nFROebZhV2uofmZln9K
	 8EZHPoyxlsRIQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1] PM: EM: Move sched domains rebuild function from schedutil to EM
Date: Thu, 12 Dec 2024 13:01:02 +0100
Message-ID: <4977135.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnugh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Function sugov_eas_rebuild_sd() defined in the schedutil cpufreq governor
implements generic functionality that may be useful in other places.  In
particular, there is a plan to use it in the intel_pstate driver in the
future.

For this reason, move it from schedutil to the energy model code and
rename it to em_rebuild_sched_domains().

This also helps to get rid of some #ifdeffery in schedutil which is a
plus.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The previous RFC version of this patch is here:

https://lore.kernel.org/linux-pm/2229205.irdbgypaU6@rjwysocki.net/

Changes since the RFC:

 * The new function is called em_rebuild_sched_domains() now.
 * Update the subject and changelog.
 * Reword the comment in sugov_policy_alloc().

---
 drivers/cpufreq/cpufreq.c        |    2 +-
 include/linux/energy_model.h     |    2 ++
 kernel/power/energy_model.c      |   17 +++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |   33 ++++++---------------------------
 4 files changed, 26 insertions(+), 28 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1538,7 +1538,7 @@
 
 		/*
 		 * Register with the energy model before
-		 * sugov_eas_rebuild_sd() is called, which will result
+		 * em_rebuild_sched_domains() is called, which will result
 		 * in rebuilding of the sched domains, which should only be done
 		 * once the energy model is properly initialized for the policy
 		 * first.
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -179,6 +179,7 @@
 int em_dev_update_chip_binning(struct device *dev);
 int em_update_performance_limits(struct em_perf_domain *pd,
 		unsigned long freq_min_khz, unsigned long freq_max_khz);
+void em_rebuild_sched_domains(void);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -404,6 +405,7 @@
 {
 	return -EINVAL;
 }
+static inline void em_rebuild_sched_domains(void) {}
 #endif
 
 #endif
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -908,3 +908,20 @@
 	return 0;
 }
 EXPORT_SYMBOL_GPL(em_update_performance_limits);
+
+static void rebuild_sd_workfn(struct work_struct *work)
+{
+	rebuild_sched_domains_energy();
+}
+
+void em_rebuild_sched_domains(void)
+{
+	static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
+
+	/*
+	 * When called from the cpufreq_register_driver() path, the
+	 * cpu_hotplug_lock is already held, so use a work item to
+	 * avoid nested locking in rebuild_sched_domains().
+	 */
+	schedule_work(&rebuild_sd_work);
+}
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -604,31 +604,6 @@
 
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
@@ -784,7 +759,11 @@
 		goto fail;
 
 out:
-	sugov_eas_rebuild_sd();
+	/*
+	 * Schedutil is the preferred governor for EAS, so rebuild sched domains
+	 * on governor changes to make sure the scheduler knows about them.
+	 */
+	em_rebuild_sched_domains();
 	mutex_unlock(&global_tunables_lock);
 	return 0;
 
@@ -826,7 +805,7 @@
 	sugov_policy_free(sg_policy);
 	cpufreq_disable_fast_switch(policy);
 
-	sugov_eas_rebuild_sd();
+	em_rebuild_sched_domains();
 }
 
 static int sugov_start(struct cpufreq_policy *policy)




