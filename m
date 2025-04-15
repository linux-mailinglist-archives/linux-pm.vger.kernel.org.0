Return-Path: <linux-pm+bounces-25460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4DA899AD
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A58A3B9F74
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0A28F527;
	Tue, 15 Apr 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nDRtK2vw"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E028E614;
	Tue, 15 Apr 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712266; cv=none; b=H/iLjq8H4R8PZchNSDFq2d2VScKyr+7Gb9fzUf4luSvRPWrs9ZvbU+qJ2RoWP2VjH1ROhXffU12EsY9WSoBmfudWFf0dyXbUhG1z4hiGHnRLZJrCz0ayD5cIlb5NLUSty7dJzAbgANHmzfx2CTmnneOkAtCpd2RRrLct7FCuwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712266; c=relaxed/simple;
	bh=2exky6TpNJmCLb/70+qqtFeNC9qkVf1vIRZV7J1dmfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/sXRo+TbzxEM+90Ty5v8e5/56YI9EtmtDTafxwfZd/B+Fz1QUh/TmBSsm8F8jkd8bRHbZvo+boqjJ02jFDR+zYxpDUqYq4hmNiYgCLWgSjbvjXO2thSs6kSQ6PEFrJwo5aBFoTfAagpGI160C0UsANgHmrqz+/kd9fpQ1NquoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nDRtK2vw; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B60F066266C;
	Tue, 15 Apr 2025 12:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744712258;
	bh=2exky6TpNJmCLb/70+qqtFeNC9qkVf1vIRZV7J1dmfk=;
	h=From:Subject:Date;
	b=nDRtK2vwcj3AT6VQk3u0CALZ2q8GF5zyptE73PgvppblNA9kGlL/rk3TyENqRAgnW
	 HzxLu1G35UImbEo+NfozHS7PT+IVCxHzmB9/Z//4CRyeU6RoSD6YVulBvtXA5OAlih
	 Igp8HbOQr5nU44sxM+dwudkLuw20qQJnNZh+r7egBySy/Uffn1Z0TATwBjvKwom6hj
	 PJHIQnAo22XQnetI3tq7DS26gwrlSCgMKMu9YsnuoEvsLXGHdk+VP/YQ+IYK4mFJVd
	 lto0OsSAbMwrvmFXOIbxw8diw9I4J9vuyothn0dmypea633Zkcc31SDeINu6rGYhbo
	 Q/rv/rRfnQe1Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject:
 [PATCH v2 1/6] cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
Date: Tue, 15 Apr 2025 11:58:08 +0200
Message-ID: <3010358.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <6171293.lOV4Wx5bFT@rjwysocki.net>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhd
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused
by need_freq_update") modified sugov_should_update_freq() to set the
need_freq_update flag only for drivers with CPUFREQ_NEED_UPDATE_LIMITS
set, but that flag generally needs to be set when the policy limits
change because the driver callback may need to be invoked for the new
limits to take effect.

However, if the return value of cpufreq_driver_resolve_freq() after
applying the new limits is still equal to the previously selected
frequency, the driver callback needs to be invoked only in the case
when CPUFREQ_NEED_UPDATE_LIMITS is set (which means that the driver
specifically wants its callback to be invoked every time the policy
limits change).

Update the code accordingly to avoid missing policy limits changes for
drivers without CPUFREQ_NEED_UPDATE_LIMITS.

Fixes: 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
Closes: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org/
Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Always set need_freq_update when limits_changed is set.
   * Take CPUFREQ_NEED_UPDATE_LIMITS into account in sugov_update_next_freq().

---
 kernel/sched/cpufreq_schedutil.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -83,7 +83,7 @@
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = true;
 		return true;
 	}
 
@@ -95,10 +95,22 @@
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->need_freq_update)
+	if (sg_policy->need_freq_update) {
 		sg_policy->need_freq_update = false;
-	else if (sg_policy->next_freq == next_freq)
+		/*
+		 * The policy limits have changed, but if the return value of
+		 * cpufreq_driver_resolve_freq() after applying the new limits
+		 * is still equal to the previously selected frequency, the
+		 * driver callback need not be invoked unless the driver
+		 * specifically wants that to happen on every update of the
+		 * policy limits.
+		 */
+		if (sg_policy->next_freq == next_freq &&
+		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+			return false;
+	} else if (sg_policy->next_freq == next_freq) {
 		return false;
+	}
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;




