Return-Path: <linux-pm+bounces-24586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E709CA751B0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8631893351
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C61E9B0E;
	Fri, 28 Mar 2025 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="yH0WR7ID"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F2D3C0C;
	Fri, 28 Mar 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195420; cv=none; b=D6R4bwN73fs1UQm0t+Ij6gcvg5UYw2M9FG+88SS7Fw55MN43moBOyVX4ds7xiPyKwsdGxf5gTXBmWzzTJ+3GqJpfAVcP4vvLX355b9X999TpD8bIu2StYTy9XbHhItLLmhefjgyTg/1/78H6+jzva1hkuUjaaqIsvIYnKD62Vsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195420; c=relaxed/simple;
	bh=ycJEX7FuLXeGzXyCuuMpFUIzwIDr+WEtto5p6PVc7x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8YOePkBGJCH+78bNb1y78ou4aJ40Q0WgcGkZSNWkw1TJQurA+qU27I4rY1G8kXL5jGAaBwlTEqMKFPWdzvqaXIDU8zJVmP8NHYIk52sBxQoAk0yDO2Xa16dHUcLRAXBDldMaExJpswV69KP0xebdmKuQnrLXS9xzAEyoej+dyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=yH0WR7ID; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 9f9d1509029a4dea; Fri, 28 Mar 2025 21:56:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B80477F0283;
	Fri, 28 Mar 2025 21:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743195416;
	bh=ycJEX7FuLXeGzXyCuuMpFUIzwIDr+WEtto5p6PVc7x0=;
	h=From:Subject:Date;
	b=yH0WR7IDWnty0oBzXx8Nj8/7zcZSESOSZH9DiBdnRJucNKEfqoVspqvCKrAdaOv0l
	 hN7PWk125sKE6UzIUM93Cx5x+1jZyGMDEv28JXrLQ3ucv4zmo7oE6r7VFxZJ9auKlI
	 c8T9HlMBjYv79w6UGGpusiQ8LVnYcsNVs//KsP3cjq36b/1JP/u/n7uEvYuqpOAXU7
	 CnjD9r6lT/TkgtdebB7QIL+5v74FZhil93HGVQmHMg14nvlqGIiVM7KjaIjtdqTVGT
	 MzHx0vGpvHsr5wK8mQG433GKuUHqhAqQTBVAL7XiIoSc0aVbH5gMu0GDHe4iYnYioQ
	 1lBbZKfcC8kIg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1 07/10] cpufreq: Drop cpufreq_cpu_acquire() and
 cpufreq_cpu_release()
Date: Fri, 28 Mar 2025 21:45:38 +0100
Message-ID: <3880470.kQq0lBPeGt@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since cpufreq_cpu_acquire() and cpufreq_cpu_release() have no more
users in the tree, remove them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   45 ---------------------------------------------
 include/linux/cpufreq.h   |    2 --
 2 files changed, 47 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -255,51 +255,6 @@
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
-/**
- * cpufreq_cpu_release - Unlock a policy and decrement its usage counter.
- * @policy: cpufreq policy returned by cpufreq_cpu_acquire().
- */
-void cpufreq_cpu_release(struct cpufreq_policy *policy)
-{
-	if (WARN_ON(!policy))
-		return;
-
-	lockdep_assert_held(&policy->rwsem);
-
-	up_write(&policy->rwsem);
-
-	cpufreq_cpu_put(policy);
-}
-
-/**
- * cpufreq_cpu_acquire - Find policy for a CPU, mark it as busy and lock it.
- * @cpu: CPU to find the policy for.
- *
- * Call cpufreq_cpu_get() to get a reference on the cpufreq policy for @cpu and
- * if the policy returned by it is not NULL, acquire its rwsem for writing.
- * Return the policy if it is active or release it and return NULL otherwise.
- *
- * The policy returned by this function has to be released with the help of
- * cpufreq_cpu_release() in order to release its rwsem and balance its usage
- * counter properly.
- */
-struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-
-	if (!policy)
-		return NULL;
-
-	down_write(&policy->rwsem);
-
-	if (policy_is_inactive(policy)) {
-		cpufreq_cpu_release(policy);
-		return NULL;
-	}
-
-	return policy;
-}
-
 /*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -241,8 +241,6 @@
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 
-struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu);
-void cpufreq_cpu_release(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);




