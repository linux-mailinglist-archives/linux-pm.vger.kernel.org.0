Return-Path: <linux-pm+bounces-18250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9FB9DEAF9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D752BB222C8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73A19DFAB;
	Fri, 29 Nov 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="iyxU5GY/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489D14C5B3;
	Fri, 29 Nov 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897711; cv=none; b=McruElrG1nyD4qqTqXNeN7xj2el/kFSgNJ4RLHfJlL3lXqzj768Ko7tfnLwkf2gHd3EL1RIIshM1YbxgVJwgKugziHkx/1SfRXJsCrPtV8YnuprAGifiuvD+1wlGkU4wx5duXDhzTHVSbgh/Ygxfr/QXixXxJFNpHeC/v7XmQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897711; c=relaxed/simple;
	bh=OYoXq9Htw15pDNwhKe3wmKi9nfDTgqvonQ9dTbuSg84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOhYPIr40MFmlcX9VcHMXfFdn50SbYfebkApmPCiUYROzGiXkO5RvRruSZ8pzto4ptSIBI6Udd7FS87OnD3ZWXfNJ6Cz6TdGeEt0r6NsCH2M/uKHA8h345mzyohcAvxJjNTeMnxUbs/8dbpqDQTrKwN481Lt7oCy6XdVOZPndjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=iyxU5GY/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 5f518de4bde3e1e6; Fri, 29 Nov 2024 17:28:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D5E56A47B8B;
	Fri, 29 Nov 2024 17:28:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897701;
	bh=OYoXq9Htw15pDNwhKe3wmKi9nfDTgqvonQ9dTbuSg84=;
	h=From:Subject:Date;
	b=iyxU5GY/ArKuU8HnZM+epBBnOro2bqsKPxWgzpzvZ8DNMNQFXXjnKY7X9OfmRwZrD
	 2bOAQpi+XKBLJqrdArSchnvurDoSO19PUpBuNjoi822povcdACcdRuddwJIphl7PDj
	 I1inSGuwhLDpRZngzTRwi05TL6nEVzTq1IxE+3jag6g4UrrW7uanGig/2S88LlP1jZ
	 2a2Tdteh51I4/uVWWBtKF9KQgZY1RrCXI83NJ59CZZ87Vkpc3cewxr9Q6d6G8+/iDc
	 +ESxhmkK76AxPu1PX+jHGVyFUOeENO8jvDPYv2OZw8q7gsLQQpMaJBLySnVVNl+nfw
	 S4y/vzxX4XGeQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
Subject:
 [RFC][PATCH v021 7/9] PM: EM: Register perf domains with ho :active_power()
 callbacks
Date: Fri, 29 Nov 2024 17:15:45 +0100
Message-ID: <3278518.5fSG56mABF@rjwysocki.net>
In-Reply-To: <5861970.DvuYhMxLoT@rjwysocki.net>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Allow em_dev_register_perf_domain() to register a cost-only perf domain
with a one-element states table if the :active_power() callback is not
provided.

Subsequently, this will be used by the intel_pstate driver to register
such perf domains for CPUs on hybrid systems.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.1 -> v0.2:
     * Do not add one more local variable to em_dev_register_perf_domain()
       and make it skip the capacity check if the :active_power() callback
       is NULL.  Add a comment explaining why it is correct to do so.

For the time being, intel_pstate will only need to be able to say
something like "this group of CPUs is preferred to that other group
of CPUs for energy-efficiency reasons regardless of the required
performance level" (and there may be multiple groups).

For this purpose, it only needs a one-element states table in a perf
domain for each of the groups and it only needs to set the cost value
for each of them to reflect the preference.

However, it may need to put CPUs of different capacity into the same
group because of favored cores and this doesn't mean that one
group will contain CPUs of different mincro-architectures.  Favored
cores essentially follow the same power-performance curve as the
other CPUs of the same type up to a certain point, but they can get
beyond that point on the curve which the other CPUs of the same type
cannot do.  Thus it would make sense to use the same states table
for favored cores and the other CPUs of the same type even if there
were multiple states in it, and em_pd_get_efficient_state() could
easily take that into account by only using the states where
"performance" is at most equal to the current CPU capacity.

Unfortunately, this doesn't match the em_create_perf_table() code
design and in particular em_init_performance() which scales the
"performance" values the the current capacity of the "domain leader"
CPU represented by "dev".

IMV, it should instead scale them to the maximum possible capacity
of the highest-capacity CPU in the domain (without requiring equal
capacity at all).

That would also help to handle the cases when CPU capacity changes,
at least on Intel platforms, if it's necessary to worry about this some
day.  Namely, when CPU capacity is reduced, say by the platform firmware
(for thermal or power distribution reasons, for example), this effectively
means chopping off the top-most section of the power-performance curve,
but the rest of it remains intact, so the same states table as before
can be used, only the current CPU capacity needs to be changed to
prevent the top-most performance states from being taken into
consideration (and analogously when CPU capacity increases).

Turbo works pretty much in the same way: When it's enabled, the
power-performance curve is effectively extended by adding some states to
it and when turbo is disabled, the top-most part of the power-performance
curve effectively gets chopped off.

This observation may help to avoid having to update the energy model for
a chip.

---
 kernel/power/energy_model.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/power/energy_model.c
===================================================================
--- linux-pm.orig/kernel/power/energy_model.c
+++ linux-pm/kernel/power/energy_model.c
@@ -426,9 +426,11 @@ static int em_create_pd(struct device *d
 	if (!em_table)
 		goto free_pd;
 
-	ret = em_create_perf_table(dev, pd, em_table->state, cb, flags);
-	if (ret)
-		goto free_pd_table;
+	if (cb->active_power) {
+		ret = em_create_perf_table(dev, pd, em_table->state, cb, flags);
+		if (ret)
+			goto free_pd_table;
+	}
 
 	ret = em_compute_costs(dev, em_table->state, cb, nr_states, flags);
 	if (ret)
@@ -566,6 +568,9 @@ int em_dev_register_perf_domain(struct d
 	if (!dev || !nr_states || !cb)
 		return -EINVAL;
 
+	if (!cb->active_power && (!cb->get_cost || nr_states > 1 || microwatts))
+		return -EINVAL;
+
 	/*
 	 * Use a mutex to serialize the registration of performance domains and
 	 * let the driver-defined callback functions sleep.
@@ -594,7 +599,19 @@ int em_dev_register_perf_domain(struct d
 			 * All CPUs of a domain must have the same
 			 * micro-architecture since they all share the same
 			 * table.
+			 *
+			 * If the :active_power() callback is present, the
+			 * performance values for different states in the table
+			 * computed by em_create_perf_table() depend on the CPU
+			 * capacity which therefore must be the same for all
+			 * CPUs in the domain.  However, if the :active_power()
+			 * callback is not NULL, em_create_perf_table() doesn't
+			 * run and there is no requirement regarding CPU
+			 * capacity any more.
 			 */
+			if (!cb->active_power)
+				continue;
+
 			cap = arch_scale_cpu_capacity(cpu);
 			if (prev_cap && prev_cap != cap) {
 				dev_err(dev, "EM: CPUs of %*pbl must have the same capacity\n",




