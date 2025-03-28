Return-Path: <linux-pm+bounces-24588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB328A751B8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0348F16D698
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 20:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B61EB5F8;
	Fri, 28 Mar 2025 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Iw/7H3A4"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB311E9B17;
	Fri, 28 Mar 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195532; cv=none; b=GvDXMoKNQIFx90dYoXUpjfdAd7cTJYoJfIyIOnjS17BQHCOIvSXO2x3x5DyckSy9wz03Pe+fGYJPfc3QDzTCNr9u/cYjA1ukEq/DxwDLX/fbZYXgC6cqiVUqLk0mqi5gE70aYHWyiinDXIuat1ejyvNIxbbjJDtM1I/irpqwxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195532; c=relaxed/simple;
	bh=yFxH6ctjRQaQ0nSx0gZyMTd+2uQ5yqk5SK1YkHstdHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rctiQrhuqfKrvgx6fCgyDarx+I2T7qjuYu6i/oZ0wYltX7w96EUEa2R70Ki010HGngF034s5GWyRprDbGB7py1V7A6jIsp0RXsbeTrTR2FvmlewlJod9iu0pgT7Ao5qk5kpW7jvhaEfFTg6FI8ivXNxp1QrrE47q8p1t+0nWYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Iw/7H3A4; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 4d40bc7aa4098aae; Fri, 28 Mar 2025 21:58:48 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 097F27F0283;
	Fri, 28 Mar 2025 21:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743195528;
	bh=yFxH6ctjRQaQ0nSx0gZyMTd+2uQ5yqk5SK1YkHstdHc=;
	h=From:Subject:Date;
	b=Iw/7H3A4NXeKPyNS/ee5Rwdcqyaf6b8eU2IDGgfhqagjFSUJlECOEg2eHK7GDtz4W
	 EUa66T/qAQxJqlnUf8j7BhmqXIoa9YmfM6sdlh4O7XODkWwiHjRO0UGBYiXR6wdcon
	 xwKubDDJh1R0qgQaXlf3mpKP/ZsYhw+5rBj0vCNykaPD9ToK6Vcm7OsW16r46a2DkI
	 x4d4vO9zi9M7+WP0Jz6pD0Y3uRXFXwuxZU6gfzVAvd5tyjlvbGHp+0IkI4/EBzpnuW
	 nqqMdNNYtzYuJS5XW+Sc59b1ITF8nn1hzq3dhrDYpwrOVAEaYeMZUMFGgNBZ3L9FRl
	 crImyUXC8dnrA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1 05/10] cpufreq: intel_pstate: Rearrange max frequency updates
 handling code
Date: Fri, 28 Mar 2025 21:43:46 +0100
Message-ID: <2315023.iZASKD2KPV@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=30 Fuz1=30 Fuz2=30

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename __intel_pstate_update_max_freq() to intel_pstate_update_max_freq()
and move the cpufreq policy reference counting and locking into it (and
implement the locking with the recently introduced cpufreq policy "write"
locking guard).

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   52 +++++++++++++----------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1353,9 +1353,16 @@
 		cpufreq_update_policy(cpu);
 }
 
-static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
-					   struct cpufreq_policy *policy)
+static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
 {
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
+
+	policy = cpufreq_cpu_get(cpudata->cpu);
+	if (!policy)
+		return false;
+
+	guard(cpufreq_policy_write)(policy);
+
 	if (hwp_active)
 		intel_pstate_get_hwp_cap(cpudata);
 
@@ -1363,44 +1370,24 @@
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 
 	refresh_frequency_limits(policy);
+
+	return true;
 }
 
 static void intel_pstate_update_limits(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-	struct cpudata *cpudata;
-
-	if (!policy)
-		return;
-
-	cpudata = all_cpu_data[cpu];
-
-	__intel_pstate_update_max_freq(cpudata, policy);
-
-	/* Prevent the driver from being unregistered now. */
-	mutex_lock(&intel_pstate_driver_lock);
+	struct cpudata *cpudata = all_cpu_data[cpu];
 
-	cpufreq_cpu_release(policy);
-
-	hybrid_update_capacity(cpudata);
-
-	mutex_unlock(&intel_pstate_driver_lock);
+	if (intel_pstate_update_max_freq(cpudata))
+		hybrid_update_capacity(cpudata);
 }
 
 static void intel_pstate_update_limits_for_all(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-
-		if (!policy)
-			continue;
-
-		__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
-
-		cpufreq_cpu_release(policy);
-	}
+	for_each_possible_cpu(cpu)
+		intel_pstate_update_max_freq(all_cpu_data[cpu]);
 
 	mutex_lock(&hybrid_capacity_lock);
 
@@ -1840,13 +1827,8 @@
 {
 	struct cpudata *cpudata =
 		container_of(to_delayed_work(work), struct cpudata, hwp_notify_work);
-	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
-
-	if (policy) {
-		__intel_pstate_update_max_freq(cpudata, policy);
-
-		cpufreq_cpu_release(policy);
 
+	if (intel_pstate_update_max_freq(cpudata)) {
 		/*
 		 * The driver will not be unregistered while this function is
 		 * running, so update the capacity without acquiring the driver




