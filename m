Return-Path: <linux-pm+bounces-25574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B3A90B15
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350014604D3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137B22154B;
	Wed, 16 Apr 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="MM3I5nJJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03121CFF6;
	Wed, 16 Apr 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827175; cv=none; b=Jyl21wUue4vrwPPqOzRgJmjbb7wQEFly8X5LCvOOppPhacuM6gJgEQihFLHpjaS48wt8l1tndMW1gma80+SA3s+Jdz51c2EF5Teq73wPkvKB9y7m5NQqmFelh3pE9j3ekADlX3F70HUSuYWHQhi7UA6dPqRMkyS9wwBWGKSpKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827175; c=relaxed/simple;
	bh=uaq6qM+Ck6AxQX9+RJSqmkPle2TaQ7kI+Uy3iMaX6a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmEUKyziQF62A0JYi5gtFkyUVkCAnqjLM9a1AT+lPF5DyjWpudaP8ERcStfN7OXFn1IGD0YsLnu4xb0aoxihp4RwrxrOAonh66mD2knnIof3quEKCWYdKOfvaVKmCNrMlPBUH3sUC9U5XZA9OiuIxFi3WxJedyeB9L/Kg9+oGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=MM3I5nJJ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7A676662719;
	Wed, 16 Apr 2025 20:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827171;
	bh=uaq6qM+Ck6AxQX9+RJSqmkPle2TaQ7kI+Uy3iMaX6a0=;
	h=From:Subject:Date;
	b=MM3I5nJJjWyN4SOSGReaZWFXzqWI9ybsdE62U0zfPtnueHY6SNmTgtyOfSFuxSjRm
	 yuw9FSkM/gLQ6JSN7bsNnPIZBqxq+a0q179cFZeepvjQoPsktOHK53zrsZm51Mv5vZ
	 h449YANwSfdVkBWvD7Pa7YrSWZkTJWVjWr9kYb91bvZD+qmRPcUZ2kAYyzy95VHl2d
	 +82xwHaR7+5ne02yHc1hnixQTelZqCxRmanPBiwpeDXrVHWEn7/Ge0KvsH7bOEJvWk
	 8CbnarFmNN7RBTWMPte/gi8x/BEq2oTegRqwJi/jU0D+hFTnv2239gd3svrjesXgyS
	 L02ABIvmdQVoA==
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
 [RFT][PATCH v1 3/8] cpufreq/sched: Allow .setpolicy() cpufreq drivers to
 enable EAS
Date: Wed, 16 Apr 2025 20:01:06 +0200
Message-ID: <8554829.NyiUUSuA9g@rjwysocki.net>
In-Reply-To: <3344336.aeNJFYEL58@rjwysocki.net>
References: <3344336.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some cpufreq drivers, like intel_pstate, have built-in governors that
are used instead of regular cpufreq governors, schedutil in particular,
but they can work with EAS just fine, so allow EAS to be used with
those drivers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.3 -> v1
     * Rebase on top of the new [1-2/8].
     * Update the diagnostic message printed if the conditions are not met.

This patch is regarded as a cleanup for 6.16.

---
 drivers/cpufreq/cpufreq.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -3054,7 +3054,16 @@
 
 	guard(cpufreq_policy_read)(policy);
 
-	return sugov_is_governor(policy);
+	/*
+	 * For EAS compatibility, require that either schedutil is the policy
+	 * governor or the policy is governed directly by the cpufreq driver.
+	 *
+	 * In the latter case, it is assumed that EAS can only be enabled by the
+	 * cpufreq driver itself which will not enable EAS if it does not meet
+	 * the EAS' expectations regarding performance scaling response.
+	 */
+	return sugov_is_governor(policy) || (!policy->governor &&
+		policy->policy != CPUFREQ_POLICY_UNKNOWN);
 }
 
 bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
@@ -3064,7 +3073,7 @@
 	/* Do not attempt EAS if schedutil is not being used. */
 	for_each_cpu(cpu, cpu_mask) {
 		if (!cpufreq_policy_is_good_for_eas(cpu)) {
-			pr_debug("rd %*pbl: schedutil is mandatory for EAS\n",
+			pr_debug("rd %*pbl: EAS requirements not met\n",
 				 cpumask_pr_args(cpu_mask));
 			return false;
 		}




