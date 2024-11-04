Return-Path: <linux-pm+bounces-17007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D09BBE47
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A46A1F2273C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C09E1CCB56;
	Mon,  4 Nov 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="OrqUN610"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75151CBA1B;
	Mon,  4 Nov 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750067; cv=none; b=gEu+0nWeZ4lG1ATEUlxMnjYwu0tQlVteQxORKAipYI3b2BH6VrVcwVvUEHjANdOPHZKeQ74HW8jUwRXdPvIzvgmzqeRKutvKKxeMLPP9dHofqgkLA3zNjk3qGw0jTfdcnJVapOwGPSjJ0+I6ACkf+gt+Zqatb9P3jHzWXinqfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750067; c=relaxed/simple;
	bh=WBBjJ/jqz8TvGOdTLnGn9x7i+2aFypiIX+wPjxzDS7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qG5OvKauZIlBjPoSYprJdIltad7jbK7oJTgH0uQ6TSaOkeEwp77c9Jyck/3ExVZd0h5ewoTR9AzjF2D8pVz26RAdAezzVKhorWrggclHadVgKTLW75eN/r/a8xaggPpbn1gbRNubhPj7sOb0m2fCy3nZ4JGnUnL3ZTCj5+8xGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=OrqUN610 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 8e7e677638d93cda; Mon, 4 Nov 2024 19:54:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C34E4950B7B;
	Mon,  4 Nov 2024 19:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1730746461;
	bh=WBBjJ/jqz8TvGOdTLnGn9x7i+2aFypiIX+wPjxzDS7A=;
	h=From:Subject:Date;
	b=OrqUN610tTftZjAZjF8i7dzghmHrmKLQAm9PK3Xnra7tclYUaWCd0zJ1MqaZ9eXPT
	 l8caIES0Q4LMV1Xf7SMf+JhRibGb3NZWpb82zDLRDpWJvC8J3c0aCrYxvZJtw18cGl
	 IXlo6T+DK9MODQlPLsZhUmR+rbJi37Y1DpKvFKrl9IH7NXziJIKN+SgDAVOIGrDAaU
	 5Z1j75rydvIx86BPDXQFrtu+ATZ5wRUQF7gcFmnoVS4HlZiS1C0pgpKJdmQdcSTC13
	 Y0zRW/fi0lieMhB5A1df+mVP9LkIdHcV7criCHgqeiFxfmJHjwquICTZm3fE862vWY
	 ckNmyH34Ft1Gg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 1/2] cpufreq: intel_pstate: Clear hybrid_max_perf_cpu before driver
 registration
Date: Mon, 04 Nov 2024 19:51:28 +0100
Message-ID: <4616631.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <12555220.O9o76ZdvQC@rjwysocki.net>
References: <12555220.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrihgtrghrughordhnvghrihdqtggrlhguvghrohhnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 0; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify intel_pstate_register_driver() to clear hybrid_max_perf_cpu
before calling cpufreq_register_driver(), so that asymmetric CPU
capacity scaling is not updated until hybrid_init_cpu_capacity_scaling()
runs down the road.  This is done in preparation for a subsequent
change adding asymmetric CPU capacity computation to the CPU init path
to handle CPUs that are initially offline.

The information on whether or not hybrid_max_perf_cpu was NULL before
it has been cleared is passed to hybrid_init_cpu_capacity_scaling(),
so full initialization of CPU capacity scaling can be skipped if it
has been carried out already.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1034,7 +1034,7 @@ static void __hybrid_init_cpu_capacity_s
 	hybrid_update_cpu_capacity_scaling();
 }
 
-static void hybrid_init_cpu_capacity_scaling(void)
+static void hybrid_init_cpu_capacity_scaling(bool refresh)
 {
 	bool disable_itmt = false;
 
@@ -1045,7 +1045,7 @@ static void hybrid_init_cpu_capacity_sca
 	 * scaling has been enabled already and the driver is just changing the
 	 * operation mode.
 	 */
-	if (hybrid_max_perf_cpu) {
+	if (refresh) {
 		__hybrid_init_cpu_capacity_scaling();
 		goto unlock;
 	}
@@ -1071,6 +1071,18 @@ unlock:
 		sched_clear_itmt_support();
 }
 
+static bool hybrid_clear_max_perf_cpu(void)
+{
+	bool ret;
+
+	guard(mutex)(&hybrid_capacity_lock);
+
+	ret = !!hybrid_max_perf_cpu;
+	hybrid_max_perf_cpu = NULL;
+
+	return ret;
+}
+
 static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
@@ -3352,6 +3364,7 @@ static void intel_pstate_driver_cleanup(
 
 static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
+	bool refresh_cpu_cap_scaling;
 	int ret;
 
 	if (driver == &intel_pstate)
@@ -3364,6 +3377,8 @@ static int intel_pstate_register_driver(
 
 	arch_set_max_freq_ratio(global.turbo_disabled);
 
+	refresh_cpu_cap_scaling = hybrid_clear_max_perf_cpu();
+
 	intel_pstate_driver = driver;
 	ret = cpufreq_register_driver(intel_pstate_driver);
 	if (ret) {
@@ -3373,7 +3388,7 @@ static int intel_pstate_register_driver(
 
 	global.min_perf_pct = min_perf_pct_min();
 
-	hybrid_init_cpu_capacity_scaling();
+	hybrid_init_cpu_capacity_scaling(refresh_cpu_cap_scaling);
 
 	return 0;
 }




