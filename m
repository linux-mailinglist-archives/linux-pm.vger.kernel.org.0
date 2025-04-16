Return-Path: <linux-pm+bounces-25569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20269A90B0D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BE41889875
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A221A434;
	Wed, 16 Apr 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="I6igity2"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB221AF0BC;
	Wed, 16 Apr 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827170; cv=none; b=fCWGbPsHjl/zBNTOcn/6231SuJ87bvb3gG/WuprNvxoMXmHXXLfqhWuwFfjNQMNCLnIQVlk++0XuR1jzJ64JoVWiAxaZnjdNCKm88nH6UsPworbakr1veksrDwU9M1GRD+7kN7jX4jve8KXxRrjPCDDDcmg20zlETBIk77dLm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827170; c=relaxed/simple;
	bh=p6lZpJkVX9UkBcwJa0YIg46R9uDoxvpxGH9F8PLq/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/vTBd6/m7GdsrHa2yNJJHpkUVpoypZC3iz2X91ql2ty3xYSU2bQCT03G5m4bN4Nm2WAaP55hlwiq3LnChUcfNxlfZI6la0mKkMtHS3ZW99MQInPLGtpC9if/pMHOB/dMIzJXe1h0OLqhHW7R2Ot6ludX4sgO94ZbWxZBhTL3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=I6igity2; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4D75B662714;
	Wed, 16 Apr 2025 20:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827165;
	bh=p6lZpJkVX9UkBcwJa0YIg46R9uDoxvpxGH9F8PLq/Q8=;
	h=From:Subject:Date;
	b=I6igity2Dw9lBf3q+iF7XjByV2oQ+CxjerVombDSs9e3eZlfgzmgYrE9ioA1tDt32
	 AYa2vfEWV+3ualUWbVnc58vkEfP9P1G1rtQCIfN6i5yQqhWPLgkIFeW8ZQ/FvJpAKU
	 f5R37AnG108I2I7jW2mp5BAFQQIWxeyIoTCSd+SOdn/8+nbj9WfR02wy0a8nzMivig
	 Kx6ORQMbyzlBEWnGch3sg/KseHdEuea3Tro3LRfBQnATd5EKKCMHBxOfHvpkEJhUAk
	 V/q1uAgMUzY2yUXQeGd/ISQZXXmsJxHWskQrpKEEc1gGW/uQbD0s9ZUKcmFqQO0nqN
	 JoxHsggIi7C9Q==
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
 [RFT][PATCH v1 8/8] cpufreq: intel_pstate: EAS: Increase cost for CPUs using
 L3 cache
Date: Wed, 16 Apr 2025 20:12:07 +0200
Message-ID: <47159248.fMDQidcC6G@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some hybrid platforms some efficient CPUs (E-cores) are not connected
to the L3 cache, but there are no other differences between them and the
other E-cores that use L3.  In that case, it is generally more efficient
to run "light" workloads on the E-cores that do not use L3 and allow all
of the cores using L3, including P-cores, to go into idle states.

For this reason, slightly increase the cost for all CPUs sharing the L3
cache to make EAS prefer CPUs that do not use it to the other CPUs with
the same perf-to-frequency scaling factor (if any).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -979,6 +979,7 @@
 			   unsigned long *cost)
 {
 	struct pstate_data *pstate = &all_cpu_data[dev->id]->pstate;
+	struct cpu_cacheinfo *cacheinfo = get_cpu_cacheinfo(dev->id);
 
 	/*
 	 * The smaller the perf-to-frequency scaling factor, the larger the IPC
@@ -991,6 +992,13 @@
 	 * of the same type in different "utilization bins" is different.
 	 */
 	*cost = div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->scaling) + freq;
+	/*
+	 * Inrease the cost slightly for CPUs able to access L3 to avoid litting
+	 * it up too eagerly in case some other CPUs of the same type cannot
+	 * access it.
+	 */
+	if (cacheinfo->num_levels >= 3)
+		(*cost)++;
 
 	return 0;
 }




