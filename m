Return-Path: <linux-pm+bounces-25455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FBA899A0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCF73B8A54
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE827EC9A;
	Tue, 15 Apr 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hkgA6vXv"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1B5A79B;
	Tue, 15 Apr 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712258; cv=none; b=DkfL4WlWzt3eClC1pIyF2t4rniimzSR1vmWnxdg5W30dcgLzCCM8wN3RQ9N53Vb/33NbjgoGuGfarDUcQN+57UvsnG4SOlJnpfRs5r1rcQfEbVa4el5ssgB3Nc3HgsFSp/gQhESlsCLoCkPifXyr6d0YfannHUHuOn6T5+WUhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712258; c=relaxed/simple;
	bh=3evzT+2AlWEasWA69QIuvzmFxJexD9EPpHYlvvq7348=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syWV4Q1yjJARsxnaojj8iGQJRZu16BEYtvITYqTx7VX+cwsVMxnffdwwwvY31rhNvdZeXSQ5UVAM4HJLkTrxpyXvRmQ30Vjj33nXJFASOhCkrPYpKJRZrHG5gSPFzFjZT8mTJ3MIga2xKoRxH4kvKDyF9LGr+gWQLt2eGISz3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hkgA6vXv; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CEB07662667;
	Tue, 15 Apr 2025 12:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744712253;
	bh=3evzT+2AlWEasWA69QIuvzmFxJexD9EPpHYlvvq7348=;
	h=From:Subject:Date;
	b=hkgA6vXvx0L+GnrpLy9yz0KXM3zrTG4Tu9dJ6nh9BJPX/t/Cur5EkPg0HNk34Z5ua
	 HY4Y6HWtnEPHFAUcQkxcbTpdFMjNufQZIFXHdSmP4CJ4ckf21xog5LIrLYdNpW6LL/
	 5BztGouqq4H8hpvL6+TIH8Ei6AC3+7urxUAvF2rFH7ZX44/KZoZZZUa7pGq+xP/HOX
	 rM04R/tsP+Lb17uX9+ke00/xdZO4C6Bsqo6TWLTZzcr5P7T0jiFyBW2+2Ww4Hp6h+U
	 NZVimO3nIx2+OQGMTEpqHgQmoDqnmD6StSLKOS6FVKT/B8IMzrXt5KSgJrDqcuZs6s
	 oN3wetJBzeBLA==
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
Subject: [PATCH v2 6/6] cpufreq: Eliminate clamp_and_resolve_freq()
Date: Tue, 15 Apr 2025 12:05:09 +0200
Message-ID: <3301325.5fSG56mABF@rjwysocki.net>
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

Fold clamp_and_resolve_freq() into __cpufreq_driver_target() which is
its only remaining caller.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/cpufreq/cpufreq.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -505,15 +505,6 @@
 	return policy->freq_table[idx].frequency;
 }
 
-static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
-					   unsigned int target_freq,
-					   unsigned int relation)
-{
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
-
-	return __resolve_freq(policy, target_freq, relation);
-}
-
 /**
  * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
  * one.
@@ -2361,7 +2352,8 @@
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	target_freq = clamp_and_resolve_freq(policy, target_freq, relation);
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = __resolve_freq(policy, target_freq, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);




