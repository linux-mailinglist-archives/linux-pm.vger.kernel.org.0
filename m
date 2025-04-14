Return-Path: <linux-pm+bounces-25398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D510AA88D5C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE2B17B948
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40FA1E51FB;
	Mon, 14 Apr 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="P5ZMF4zq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0F1A3031;
	Mon, 14 Apr 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663956; cv=none; b=mqn8sluick0XyvgzPJvHBeh4HbX3I6Q0bS71k2COOb216MxWJKbHW69zHSSqdpsK++rJPUxDOYgbIr5oUoDMPzB4oB2GgRsIcWDvRFfk0c6SPZ9UVLDLZ6ZmmMODFSC00yM7AUcRPLRrzyRZGr/8NHfrmsWUSIhlgUoR23B4VZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663956; c=relaxed/simple;
	bh=pZWSsQarRZslv+h8hP8m2w0AENVl4g70iL/csmnKLyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLn6BjGWC5fnIq3R2kT6eFjQd9iR9yRfY0UpRF1nBAb4ioIww2O0m7CsbBZ0TLAYKALwhQJLQv7zbX9lKY9D8tFV4Kq64KXDs0AyQbNoKV2vYoD+ihoOxKrV1uVNv7XW/0ZnwJhTXu7zGm6/098l7ODE8IC8fhMQBfP1rUV5qkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=P5ZMF4zq; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 867F46625BF;
	Mon, 14 Apr 2025 22:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744663952;
	bh=pZWSsQarRZslv+h8hP8m2w0AENVl4g70iL/csmnKLyA=;
	h=From:Subject:Date;
	b=P5ZMF4zqu8SrkOAsC9SjkUEX75z3bPxvwvyBWx/9JtkPKYl9cHz8ETPKhmoLfSSmu
	 K0ahuaM9UGFdqwz+0C0k2jsZ04F3XEkLt5vyxi5C1EQOyH0qQDQhzDkmY/UfzIk58R
	 xim/6/cgbXSEW+wDOIAIqEwf0iVr/J5fikGVmRbPQUMWVOZ9jbG3YyqKe5XqYTAQP6
	 yRzEKIS4HMl31Tdal67K9jilw+awIZqLILj7cg5tevTlGlVzgyU8SRZRMZmtaDZ31b
	 +hgSLNq7dV5mRAuthoZZRKSeyxXkLXcXNSbys9uTeP4hocsnVzgRtfyWMtDyOCU7AO
	 bAZhx3D4XOg+g==
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
Subject: [PATCH v1 5/5] cpufreq: Eliminate clamp_and_resolve_freq()
Date: Mon, 14 Apr 2025 22:51:03 +0200
Message-ID: <8574928.NyiUUSuA9g@rjwysocki.net>
In-Reply-To: <3364921.aeNJFYEL58@rjwysocki.net>
References: <3364921.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fold clamp_and_resolve_freq() into __cpufreq_driver_target() which is
its only remaining caller.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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




