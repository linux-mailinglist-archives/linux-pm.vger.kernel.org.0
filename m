Return-Path: <linux-pm+bounces-26747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836EAACEEB
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452379823A2
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7872637;
	Tue,  6 May 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="xS6k0qum"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164A4B1E51;
	Tue,  6 May 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564582; cv=none; b=leVPuU5Nm6ovzm5175wSjfcJL72ps7oum7SqJHkBVisjOrrVRhYYrDtH6MYLz+BHsOm70zdBNZ11I9znm0L15f1k9ojPy4qvwQXQwAhIJSdT5iDKMOigZOfZ14CDW/nd7NgQsL+UzqS2852nrNXVC+ZBYjO3ijHO2ElRH2L/f48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564582; c=relaxed/simple;
	bh=KqFE33HYR89y3K+s5kLFsjki5ks0ZGvXY/r2pVvIkEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H20VSk0R5mGYicfT2pEGZqPP1nMvh3cQN3lgr5mv8OPPphT22HbHBpqc7MoKvq+HkP712xUNa881YzmIb0x4M1yrH/43cGw5JmIJ74XaXhBVCqz6CJx49rqkeTxCrpZD+MJSt/OzjIS1j9xjcFLJh4meYhULBSM+4irgaeHZe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=xS6k0qum; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AC77F666B8B;
	Tue,  6 May 2025 22:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564573;
	bh=KqFE33HYR89y3K+s5kLFsjki5ks0ZGvXY/r2pVvIkEQ=;
	h=From:Subject:Date;
	b=xS6k0qumfy39HfdQkzWLq8oJ8yJntmpScsNv3tZSwrGbIgWCNiCIp5TMdM+5Gi9SK
	 LX8C+QRVQ0pbzHYsHN/fov8qqO6gh2D2oKR7BymD/xdTaK1w0TZyk2iP6flu6JCQ+b
	 +nbacNwhkJy3ZXbfVFgwfJ8c+JeaiHDvXDNrw304twzoG3aIb3Ak0Zfqw5Icv+2TZM
	 h/dtlhnMP2v5owVTW1S8JhOlENwFcRvcNt4PKOLyBt2ZJv37sLZ17RiSyw++ITjfUg
	 jwnL18f/1F8vAq683eDajwXaHFrMhDQaj4CaeV6IvTELRQBIPwaBA4oVrY07cuLuvk
	 hIRbZN2KP+/1Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v2 6/7] cpufreq: intel_pstate: EAS: Increase cost for CPUs using L3
 cache
Date: Tue, 06 May 2025 22:47:53 +0200
Message-ID: <2032776.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <2999205.e9J7NaK4W3@rjwysocki.net>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some hybrid platforms some efficient CPUs (E-cores) are not connected
to the L3 cache, but there are no other differences between them and the
other E-cores that use L3.  In that case, it is generally more efficient
to run "light" workloads on the E-cores that do not use L3 and allow all
of the cores using L3, including P-cores, to go into idle states.

For this reason, slightly increase the cost for all CPUs sharing the L3
cache to make EAS prefer CPUs that do not use it to the other CPUs of
the same type (if any).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Change L3 cache lookup method (the previous one doesn't always work).
   * Adjust the new comment.
   * Increase the cost for CPUs using L3 by 2 (instead of increasing it by 1)
     to make the scheduler select the CPUs without L3 more often.
   * Adjust the changelog.

---
 drivers/cpufreq/intel_pstate.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -982,6 +982,7 @@
 			   unsigned long *cost)
 {
 	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
+	struct cpu_cacheinfo *cacheinfo = get_cpu_cacheinfo(dev->id);
 
 	/*
 	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
@@ -994,6 +995,22 @@
 	 * of the same type in different "utilization bins" is different.
 	 */
 	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
+	/*
+	 * Increase the cost slightly for CPUs able to access L3 to avoid
+	 * touching it in case some other CPUs of the same type can do the work
+	 * without it.
+	 */
+	if (cacheinfo) {
+		unsigned int i;
+
+		/* Check if L3 cache is there. */
+		for (i = 0; i < cacheinfo->num_leaves; i++) {
+			if (cacheinfo->info_list[i].level == 3) {
+				*cost += 2;
+				break;
+			}
+		}
+	}
 
 	return 0;
 }




