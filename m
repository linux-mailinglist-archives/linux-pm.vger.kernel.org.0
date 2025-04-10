Return-Path: <linux-pm+bounces-25097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6DA8409A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21073AC688
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2140C280CCA;
	Thu, 10 Apr 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BpJeU/3i"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86FB280A5E;
	Thu, 10 Apr 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280455; cv=none; b=igPidyvshw1ftALER4pvDZXrS9yFHlgwqWzo4yU4KoWTNRipv/QPF03in2pmv4CTBp049K6rA356NLH/8Ydl0xy5p7anzxk1+HfgQ+QZ6E+9K3DkSUtXSJAb81lG+4jkAnS8lGOeCPGWCZPMr2t2Fc1qE9gtfk84qKPOcxmpBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280455; c=relaxed/simple;
	bh=1IKsX9rjaHiAEr7/mQDOAhjFE6YbmjKCSxhS3PGU7jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYkZwjXxyH4CWlFkPD8UNilFt4LNq+q1HhNOQaNo3OU3W8ylZbOJqKnCfBbfJxt+nk5nAU36OUwaAh29DCiq1J4zjpGhur6wLhAag87MXH3LGOn3FHa/OV5GPqxQpMqZtSPwb8udfQ/laxuXw/c9sx0vTpoyH1O8PoMm4aqHWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BpJeU/3i; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 000B68A24E8;
	Thu, 10 Apr 2025 12:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744280444;
	bh=1IKsX9rjaHiAEr7/mQDOAhjFE6YbmjKCSxhS3PGU7jE=;
	h=From:Subject:Date;
	b=BpJeU/3ivkedSnXS2mXJIdZrp+ogpJ1DFVi1ktrokkQ6KrlatdLx2+zO97GGa//tb
	 RvTITTs4mrDEGZ7FoZaWVWS9SyThpIpciB2QahttghDut4+il8B2HD5//gtHn14RE4
	 mXAWPLaPL7k2nm3bH4eFTpFVdOgao1pYdqyCtlwxYK/iY60rzSnZctQfywMNLYJ+Qs
	 ahtYSyLQQ7Y3hQhhEXmuKGpqBGrfy4pb0rsP6bxLtZmeMTHAd21WqBUIGvB3eiItJ+
	 K15MPTjdXOwPBFIYH336xhsNKsBQXfHG3GGVIaTF4Ri4B0kwQyDO5pGuOIRWAkvWS9
	 UtqD2rXShht2w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1] cpufreq: Drop unused cpufreq_get_policy()
Date: Thu, 10 Apr 2025 12:20:43 +0200
Message-ID: <2802770.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A recent change has introduced a bug into cpufreq_get_policy(), but this
function is not used, so it's better to drop it altogether.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   25 -------------------------
 include/linux/cpufreq.h   |    1 -
 2 files changed, 26 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2549,31 +2549,6 @@
  *                          POLICY INTERFACE                         *
  *********************************************************************/
 
-/**
- * cpufreq_get_policy - get the current cpufreq_policy
- * @policy: struct cpufreq_policy into which the current cpufreq_policy
- *	is written
- * @cpu: CPU to find the policy for
- *
- * Reads the current cpufreq policy.
- */
-int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
-{
-	struct cpufreq_policy *cpu_policy __free(put_cpufreq_policy);
-
-	if (!policy)
-		return -EINVAL;
-
-	cpu_policy = cpufreq_cpu_get(cpu);
-	if (!cpu_policy)
-		return -EINVAL;
-
-	memcpy(policy, cpu_policy, sizeof(*policy));
-
-	return 0;
-}
-EXPORT_SYMBOL(cpufreq_get_policy);
-
 DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
 
 /**
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -241,7 +241,6 @@
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 
-int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);




