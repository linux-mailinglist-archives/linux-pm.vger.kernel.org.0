Return-Path: <linux-pm+bounces-18255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C409DEB00
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5BFB209A9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFF1A265D;
	Fri, 29 Nov 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="uqdnLilb"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DEE19F487;
	Fri, 29 Nov 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897713; cv=none; b=V4tZNyQtrjHHgMQ0kR5XndtenMZz4lOE+35fZQlRZsIoap4+2Xf3Zc9c8mnGfr6HnDqzYaeknXsratYKWZ9dhKohV08Qk89Vo8AGFFerS0z214DHUKoqPtPwt9+0Wj5VKEBM+34OSLdVwQWIeHXzcp+A8sh4Vx+6Hggd4KqvVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897713; c=relaxed/simple;
	bh=DvLkM9d0KNOiudzMFfjoKtE0E+UoCa929oHu3SnD37M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDyQH4JdnytJrIsKARz3ON6kYVfG52kCx2RJfNvbbSzTqbi17KV0WFmLcJ3hR1kFBhiuRFxg2ECP43F71j/Klwn5SFgkppoR4ntEp1yRE0divlFInAsgw8PqDO03TseGVHL7HOmXGReCLWSa5Uwmoxqh13vbPUFpnbKAEd7T2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=uqdnLilb; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 9c19526eca5e3f77; Fri, 29 Nov 2024 17:28:24 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CDA8BA47B8B;
	Fri, 29 Nov 2024 17:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897704;
	bh=DvLkM9d0KNOiudzMFfjoKtE0E+UoCa929oHu3SnD37M=;
	h=From:Subject:Date;
	b=uqdnLilbd66jLccEp56jTtqWkpNdifnu97jfpKjw1rVwmTZ5kySK3Xyc8mJK+f9or
	 fKppbAvNGrrx0jZMuqs39/QkFxgTuzfeY3YTQ+wyqAfYw8edFHOVP0rCnDMaRqfo8c
	 F8RpL07GaHEEzEiFguVQBElos5iLZSlDmMuUzpMwxUMXa+6YOiSOuioDzqYwLtsu5y
	 8cDPSYpqtzrzGlU3ICTEmkpTgmuD77UBaXD4nARARd97lARx2rFN89iiVInYMIm3jn
	 2zk1Gj3ZHU+mDhiMK3XFJTEXgt4eigzA63aAUnvL0hRMbHNpSr9AV5McDdx6ixTZ61
	 ZQ4aYqS3H6Nlw==
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
Subject: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
Date: Fri, 29 Nov 2024 17:00:59 +0100
Message-ID: <2989520.e9J7NaK4W3@rjwysocki.net>
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

Make it possible to use EAS with cpufreq drivers that implement the
:setpolicy() callback instead of using generic cpufreq governors.

This is going to be necessary for using EAS with intel_pstate in its
default configuration.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is the minimum of what's needed, but I'd really prefer to move
the cpufreq vs EAS checks into cpufreq because messing around cpufreq
internals in topology.c feels like a butcher shop kind of exercise.

Besides, as I said before, I remain unconvinced about the usefulness
of these checks at all.  Yes, one is supposed to get the best results
from EAS when running schedutil, but what if they just want to try
something else with EAS?  What if they can get better results with
that other thing, surprisingly enough?

---
 kernel/sched/topology.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/sched/topology.c
===================================================================
--- linux-pm.orig/kernel/sched/topology.c
+++ linux-pm/kernel/sched/topology.c
@@ -217,6 +217,7 @@ static bool sched_is_eas_possible(const
 	bool any_asym_capacity = false;
 	struct cpufreq_policy *policy;
 	struct cpufreq_governor *gov;
+	bool cpufreq_ok;
 	int i;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
@@ -251,7 +252,7 @@ static bool sched_is_eas_possible(const
 		return false;
 	}
 
-	/* Do not attempt EAS if schedutil is not being used. */
+	/* Do not attempt EAS if cpufreq is not configured adequately */
 	for_each_cpu(i, cpu_mask) {
 		policy = cpufreq_cpu_get(i);
 		if (!policy) {
@@ -261,11 +262,14 @@ static bool sched_is_eas_possible(const
 			}
 			return false;
 		}
+		/* Require schedutil or a "setpolicy" driver */
 		gov = policy->governor;
+		cpufreq_ok = gov == &schedutil_gov ||
+				(!gov && policy->policy != CPUFREQ_POLICY_UNKNOWN);
 		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
+		if (!cpufreq_ok) {
 			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
+				pr_info("rd %*pbl: Checking EAS, unsuitable cpufreq governor\n",
 					cpumask_pr_args(cpu_mask));
 			}
 			return false;




