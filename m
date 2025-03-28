Return-Path: <linux-pm+bounces-24587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A120DA751B6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC8169A4B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4A01EB5C4;
	Fri, 28 Mar 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LPPVmqzG"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38821E25E3;
	Fri, 28 Mar 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195531; cv=none; b=qb0+noR+i9FOK2tGjiKeN9zuB9CspUX3k/Kfpyklmx65KHLrsw5L8pYB5M0MVBe6E54sirOTHqbG2jZDfnAHb0oFUwS0h4oKPYAAkMTUp1uuN13FRdu3d5PpVZmi4CK4qN+419INUjdd7AZOGQDnFRWSrEYED7ZosqLxC7G+JOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195531; c=relaxed/simple;
	bh=djGhZzE6eLMYp0j+OqW1ilC9MRSQzuEl1M9RfT+4Mqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9RJbe2XUDYzhcUWN4hSM1C+d9uy9fiOEX14/kK3hwdcoMbBL97NGtfzgjM5Wk6lP6569KADAI/AKDfIRrsk4TiqaEctsIfw1Ls7BuvspRRWbrawWsLipahwCKcP6eXXDI0EHQil+QhfUWfSY5CxywUHw94SJpLb3xkgY0twnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LPPVmqzG; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id f86c11881f77e46e; Fri, 28 Mar 2025 21:58:47 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 361997F0283;
	Fri, 28 Mar 2025 21:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743195527;
	bh=djGhZzE6eLMYp0j+OqW1ilC9MRSQzuEl1M9RfT+4Mqc=;
	h=From:Subject:Date;
	b=LPPVmqzGsYGqfBSeYJkbcKjmrvcIvjfb907I1ZK6MmdUw+3NNAKlBteTDcCCW29TX
	 DiM6M/P9OjzPZrnPLSndgvfIEoYIISluI4Uw6eiLgv0Cavjx/Y8FLfsZwv76NWduth
	 mp2qUmBFZv9IDfqPBnKo0NuzYuU+at+aN1JtC4fKOZ5rxEtUSjmTBNBMR7oMunx0mR
	 L+lOQ4KPyV0X+XCs+7wb4XMGKhj/ra+VLMUA9sjOeRc2UAN0ZC4SInwmUvUQCWlmvg
	 r0IkoTxmof8L9KhQGwas5GOvQORNEmRUXnJZ5NYlRt0pDmCunUsxqny3mTKljShQYa
	 pAjMERfp9+t1A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1 06/10] cpufreq: Use locking guard and __free() in
 cpufreq_update_policy()
Date: Fri, 28 Mar 2025 21:44:50 +0100
Message-ID: <22654186.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=30 Fuz1=30 Fuz2=30

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using cpufreq_cpu_acquire() and cpufreq_cpu_release() in
cpufreq_update_policy(), which is the last user of these functions,
make it use __free() for policy reference counting cleanup and the
"write" locking guard for policy locking.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2752,23 +2752,23 @@
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
 
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return;
 
+	guard(cpufreq_policy_write)(policy);
+
 	/*
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
 	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
-		goto unlock;
+		return;
 
 	refresh_frequency_limits(policy);
-
-unlock:
-	cpufreq_cpu_release(policy);
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 




