Return-Path: <linux-pm+bounces-17107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961219C05E8
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1488AB21C09
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5F20371D;
	Thu,  7 Nov 2024 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LTV0SmFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C41DBB37;
	Thu,  7 Nov 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982980; cv=none; b=J770IccyPqIw/d27LRt9yQuoNeVB+bmj4hDzSCAgTwzqFNvFG/9rUPHbO7QgTn/LnqBylKOYFJUNGPFuj6RH5YNW8kYdMXj+bcJmLuZ8tCvFcp8G7EJCK4IJcIRV8X8j6Rkts5daQqtSymOHRhugun29K3syQVCefnZnRZuB4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982980; c=relaxed/simple;
	bh=sbTkvX8zM0W1nvhz0TmDavDt9oWt6BvbZDyjOdFFuEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=upOmFe6utKaCabM6t3LaPBAZX5M0aIVuhDB1mNzUSglN9l3ip6EGBRR56f+bO7gOOAcFWY4GGtvhi7Nq9/fawQwO2wLwJw5lFMFCj5uzPPNhUIpsfMbBYcxuEBpkwXxcGnj6st6LXCTZHdCNfrUAszqHuU99cGwgceWUXM9Nm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LTV0SmFW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 6a0efdbee279e3f4; Thu, 7 Nov 2024 13:36:10 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6C24D6A9668;
	Thu,  7 Nov 2024 13:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1730982970;
	bh=sbTkvX8zM0W1nvhz0TmDavDt9oWt6BvbZDyjOdFFuEk=;
	h=From:Subject:Date;
	b=LTV0SmFWBwFcuu5qUQXxZgMjO2cVOZeC6a06xIaED1U8zW8ZIbelPs9EgsbvOddiE
	 qh8ec92HFDjju7Ix8zA32rMEd3WmadNODtaLDd2wsCGHejn6xvnNwJ3pT91TfDI7jr
	 /ND44+62Qw5rvCi5vrxtpVzTGHb4Ejt73ZjvWp5MNxbLcgmxkOuMSt5Lz2U7Db3LNr
	 W+P8cY4KXj+Es5ox45aS4JfTm7+d7YWreG9RKrgkq7sv/21AOtM4n76FaHzd83NqW0
	 lZcR9q1TPkUjdFLeUus46PfUbM8C7eSD+UR73jGrpfiIA4RJ7/uG+kO0u4wJsEhEh3
	 XPPrvEXfK3wug==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Rearrange locking in
 hybrid_init_cpu_capacity_scaling()
Date: Thu, 07 Nov 2024 13:36:10 +0100
Message-ID: <12554508.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitggrrhguohdrnhgvrhhiqdgtrghluggvrhhonheslhhinhh
X-DCC--Metrics: v370.home.net.pl 0; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that hybrid_init_cpu_capacity_scaling() only needs to hold
hybrid_capacity_lock around __hybrid_init_cpu_capacity_scaling()
calls, so introduce a "locked" wrapper around the latter and call
it from the former.  This allows to drop a local variable and a
label that are not needed any more.

Also, rename __hybrid_init_cpu_capacity_scaling() to
__hybrid_refresh_cpu_capacity_scaling() for consistency.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is on top of

https://lore.kernel.org/linux-pm/12555220.O9o76ZdvQC@rjwysocki.net/

---
 drivers/cpufreq/intel_pstate.c |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1028,26 +1028,29 @@ static void hybrid_update_cpu_capacity_s
 	}
 }
 
-static void __hybrid_init_cpu_capacity_scaling(void)
+static void __hybrid_refresh_cpu_capacity_scaling(void)
 {
 	hybrid_max_perf_cpu = NULL;
 	hybrid_update_cpu_capacity_scaling();
 }
 
-static void hybrid_init_cpu_capacity_scaling(bool refresh)
+static void hybrid_refresh_cpu_capacity_scaling(void)
 {
-	bool disable_itmt = false;
+	guard(mutex)(&hybrid_capacity_lock);
 
-	mutex_lock(&hybrid_capacity_lock);
+	__hybrid_refresh_cpu_capacity_scaling();
+}
 
+static void hybrid_init_cpu_capacity_scaling(bool refresh)
+{
 	/*
 	 * If hybrid_max_perf_cpu is set at this point, the hybrid CPU capacity
 	 * scaling has been enabled already and the driver is just changing the
 	 * operation mode.
 	 */
 	if (refresh) {
-		__hybrid_init_cpu_capacity_scaling();
-		goto unlock;
+		hybrid_refresh_cpu_capacity_scaling();
+		return;
 	}
 
 	/*
@@ -1056,19 +1059,13 @@ static void hybrid_init_cpu_capacity_sca
 	 * do not do that when SMT is in use.
 	 */
 	if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_capacity_scale()) {
-		__hybrid_init_cpu_capacity_scaling();
-		disable_itmt = true;
-	}
-
-unlock:
-	mutex_unlock(&hybrid_capacity_lock);
-
-	/*
-	 * Disabling ITMT causes sched domains to be rebuilt to disable asym
-	 * packing and enable asym capacity.
-	 */
-	if (disable_itmt)
+		hybrid_refresh_cpu_capacity_scaling();
+		/*
+		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
+		 * packing and enable asym capacity.
+		 */
 		sched_clear_itmt_support();
+	}
 }
 
 static bool hybrid_clear_max_perf_cpu(void)
@@ -1404,7 +1401,7 @@ static void intel_pstate_update_limits_f
 	mutex_lock(&hybrid_capacity_lock);
 
 	if (hybrid_max_perf_cpu)
-		__hybrid_init_cpu_capacity_scaling();
+		__hybrid_refresh_cpu_capacity_scaling();
 
 	mutex_unlock(&hybrid_capacity_lock);
 }




