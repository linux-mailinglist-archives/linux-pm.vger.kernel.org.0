Return-Path: <linux-pm+bounces-25458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A0A899A6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD34F1780E6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCD028DF1C;
	Tue, 15 Apr 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="xZcGktxB"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4F28DEE1;
	Tue, 15 Apr 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712263; cv=none; b=GNfU3UNOQec2UVWlsyjssmHH38yBN8N/GKJ2kk/U41acF25j0QuNgFkLCKhz7HKBE4P54j/h3iCAJ0zdNqjohe7rXJ6VzuVRYGU5hyfT7ASup/S//hfbsjfv09gotxtJqG52cL2xlOXKPaJcyO9+O+PxnGjCrA25MXrBRlzXP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712263; c=relaxed/simple;
	bh=qb6MiwdjSvOZkaf22QO5qTTORGUfV38HfJ+qetBWDVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki/Us/hAjqJ42RsTwujligZBWHDWBEMvBIJD3QZLAftHJTurJ3Lf+JaeNmS5Fs8BcNB0Ml5PFDQYjnEXJnkPbDJocjHIf+CpJmj/FANn/i/+ci4pOhJh5nfHha94qe9IjzqHXZsewBaJj8S4NU5SmaePikQTK7cfFcnXwAdc8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=xZcGktxB; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6F92966266A;
	Tue, 15 Apr 2025 12:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744712256;
	bh=qb6MiwdjSvOZkaf22QO5qTTORGUfV38HfJ+qetBWDVw=;
	h=From:Subject:Date;
	b=xZcGktxBm0FjbON8Jcl+Glc6/JhiCuKMfsoC5jbseWkDVPxLKtlvOgdpXIjuPE+SJ
	 BxrP6F2PN5Bd42wZVbtmSzxIWMXsD8rqni6+cW5vzix64yNnFnA+8VmNTPXtjSvzC3
	 3w97a2EB6ddxSbSsJpvsk4EEGJfbhO4pyCAe7H4f576w4gA2kTuotbtsFPC2Q8FoGM
	 lD+2YW5Ckc7brba6+C1hdZ7oDV/G/gYWwhskUbZsdZqdKJWSY747e7gn/jnWZkqnqs
	 g6hWRH2XRNoeHWTd2GbIbNQ2fF+UkWMVGMTScJoNBRlUuUFXScsoywXxefUU4oTxyY
	 CZG73+RYhQSwA==
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
 [PATCH v2 3/6] cpufreq/sched: Set need_freq_update in ignore_dl_rate_limit()
Date: Tue, 15 Apr 2025 12:00:52 +0200
Message-ID: <10666429.nUPlyArG6x@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that ignore_dl_rate_limit() need not piggy back on the
limits_changed handling to achieve its goal (which is to enforce a
frequency update before its due time).

Namely, if sugov_should_update_freq() is updated to check
sg_policy->need_freq_update and return 'true' if it is set when
sg_policy->limits_changed is not set, ignore_dl_rate_limit() may
set the former directly instead of setting the latter, so it can
avoid hitting the memory barrier in sugov_should_update_freq().

Update the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -96,6 +96,9 @@
 		smp_mb();
 
 		return true;
+	} else if (sg_policy->need_freq_update) {
+		/* ignore_dl_rate_limit() wants a new frequency to be found. */
+		return true;
 	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
@@ -388,7 +391,7 @@
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
-		WRITE_ONCE(sg_cpu->sg_policy->limits_changed, true);
+		sg_cpu->sg_policy->need_freq_update = true;
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,




