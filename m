Return-Path: <linux-pm+bounces-24590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53BA751D9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 22:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3613B2563
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C71EF365;
	Fri, 28 Mar 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="yBJvRBlu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D91E8345;
	Fri, 28 Mar 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196015; cv=none; b=rJ59Ev4CnmxlratoDcJkAOrF7wgN83p8mTUj27n0hMQCYdNAXTcMecuJebQs4whAgOgufERaHbpNQyg9xWfQnmevFeHAs5+JsrvpdFsZ9xgmiUEz4y2SGDpfAV8if1pFYWDgKRzgyKTdijL/5Xyj1hYoc0BEfCC9WxRblkGJP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196015; c=relaxed/simple;
	bh=a1xv9EpsP/+/ehojnYzEuMlyDZDCV4bekm+FwyPkkv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7sWcT0BJio89uB2cJwPo/RASqekUS0rHpXxqzLcbH7zDX1wNLP1G8oak++52+1Og5FWTuxK0ZvYCMLr8DhkKl7inacN6PSE7XKzDTBsIG3G6YuUD/vB5WDUrKAkwIZp+AMLIOUanQzO/57Ugq/RLaENid6e9GdCVVfFZISVNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=yBJvRBlu; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 1cc9b4706a57c22c; Fri, 28 Mar 2025 22:06:51 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A5B9B7F0283;
	Fri, 28 Mar 2025 22:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743196011;
	bh=a1xv9EpsP/+/ehojnYzEuMlyDZDCV4bekm+FwyPkkv0=;
	h=From:Subject:Date;
	b=yBJvRBlumTpmntxvG7hBZxjwAUet341Uh8AcgTG5ifG4t+SpIRdJL4dkSrba6eJFQ
	 fMCF0yULQatZUSVXmpDMg1+dAT+INE02aNmrS4os/m5wIYvs5h2MsjGMJtutlfNl5K
	 pW55LBVZ+wzB7ZilNQqir6HF4uUFS34GBf4FnNo9PANvfETzs3aD9W3J7U1ofam1YZ
	 U7GYnEXhGlRRc4x5CYNFFNybD+Bfa01HOw/UHxaeq5j2m/AROnEGyJ47VL/GSknNXz
	 4bDEneaFkKFkM5QHUuhwqbvhKXaApayc1skwvh/05av9n3r/L7IMkq0N2+gJT0RZtI
	 80hMVrTxhOZLg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v1 03/10] cpufreq: Split cpufreq_online()
Date: Fri, 28 Mar 2025 21:41:49 +0100
Message-ID: <3354747.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <4651448.LvFx2qVVIh@rjwysocki.net>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=54 Fuz1=54 Fuz2=54

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In preparation for the introduction of cpufreq policy locking guards,
move the part of cpufreq_online() that is carried out under the policy
rwsem into a separate function called cpufreq_policy_online().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   95 ++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1374,32 +1374,13 @@
 	kfree(policy);
 }
 
-static int cpufreq_online(unsigned int cpu)
+static int cpufreq_policy_online(struct cpufreq_policy *policy,
+				 unsigned int cpu, bool new_policy)
 {
-	struct cpufreq_policy *policy;
-	bool new_policy;
 	unsigned long flags;
 	unsigned int j;
 	int ret;
 
-	pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
-
-	/* Check if this CPU already has a policy to manage it */
-	policy = per_cpu(cpufreq_cpu_data, cpu);
-	if (policy) {
-		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
-		if (!policy_is_inactive(policy))
-			return cpufreq_add_policy_cpu(policy, cpu);
-
-		/* This is the only online CPU for the policy.  Start over. */
-		new_policy = false;
-	} else {
-		new_policy = true;
-		policy = cpufreq_policy_alloc(cpu);
-		if (!policy)
-			return -ENOMEM;
-	}
-
 	down_write(&policy->rwsem);
 
 	policy->cpu = cpu;
@@ -1426,7 +1407,7 @@
 		if (ret) {
 			pr_debug("%s: %d: initialization failed\n", __func__,
 				 __LINE__);
-			goto out_free_policy;
+			goto out_clear_policy;
 		}
 
 		/*
@@ -1577,8 +1558,59 @@
 		goto out_destroy_policy;
 	}
 
+out_unlock:
 	up_write(&policy->rwsem);
 
+	return ret;
+
+out_destroy_policy:
+	for_each_cpu(j, policy->real_cpus)
+		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
+
+out_offline_policy:
+	if (cpufreq_driver->offline)
+		cpufreq_driver->offline(policy);
+
+out_exit_policy:
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+out_clear_policy:
+	cpumask_clear(policy->cpus);
+
+	goto out_unlock;
+}
+
+static int cpufreq_online(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	bool new_policy;
+	int ret;
+
+	pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
+
+	/* Check if this CPU already has a policy to manage it */
+	policy = per_cpu(cpufreq_cpu_data, cpu);
+	if (policy) {
+		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
+		if (!policy_is_inactive(policy))
+			return cpufreq_add_policy_cpu(policy, cpu);
+
+		/* This is the only online CPU for the policy.  Start over. */
+		new_policy = false;
+	} else {
+		new_policy = true;
+		policy = cpufreq_policy_alloc(cpu);
+		if (!policy)
+			return -ENOMEM;
+	}
+
+	ret = cpufreq_policy_online(policy, cpu, new_policy);
+	if (ret) {
+		cpufreq_policy_free(policy);
+		return ret;
+	}
+
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 
 	/* Callback for handling stuff after policy is ready */
@@ -1605,25 +1637,6 @@
 	pr_debug("initialization complete\n");
 
 	return 0;
-
-out_destroy_policy:
-	for_each_cpu(j, policy->real_cpus)
-		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
-
-out_offline_policy:
-	if (cpufreq_driver->offline)
-		cpufreq_driver->offline(policy);
-
-out_exit_policy:
-	if (cpufreq_driver->exit)
-		cpufreq_driver->exit(policy);
-
-out_free_policy:
-	cpumask_clear(policy->cpus);
-	up_write(&policy->rwsem);
-
-	cpufreq_policy_free(policy);
-	return ret;
 }
 
 /**




