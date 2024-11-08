Return-Path: <linux-pm+bounces-17217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06E89C2255
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27291C22C80
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40011990C5;
	Fri,  8 Nov 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="p8U1bJIQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773D192D66;
	Fri,  8 Nov 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084394; cv=none; b=trnWbRPHwCmjecFCrStK4T7N7SBS/8nTw02DjjLzvsJwdnEA8vGiZDrdXfVkiUPLw1iwnSDtdKtsNOFYiufg2LkFLppU96iZMooqHpSBJgSwRLtd1vWsbj337FrshwkE5lymFqPBJnKgFO87fdWEjEBC7OZmt0jwmyPk5TELaM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084394; c=relaxed/simple;
	bh=cXtVfwFYXyFlu1k+EOgWZE3VZkVVkEP5zIbiuP7gwes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+UXBn/az1/ZlVDjDPLXuktWhghAYCCBpqcXxYzqv4kTDHIp3vE0AgxrO3ia1D7NJAIHbIRhyVP7bQf9+rul4+quj2BQIuhtMvSe1W4mc10WJkISJ2boWDxYav2D7tYbstgltxO3lwMi7RRNIELkPeabiZY4IUjDIzilDb/aqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=p8U1bJIQ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id dbc142109ede4b49; Fri, 8 Nov 2024 17:46:24 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 61161834811;
	Fri,  8 Nov 2024 17:46:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731084384;
	bh=cXtVfwFYXyFlu1k+EOgWZE3VZkVVkEP5zIbiuP7gwes=;
	h=From:Subject:Date;
	b=p8U1bJIQybDVQeK04Vd1xUPcQDDCOi4Vlb9UURclUy7kZHg2qmAMsnZafTJK6ro3J
	 QSwjvOUlAOwR3AmUmjqROvC2R6v49YNfFYoKLp4+3c4xPGaSj+LIdaDhWd9XNsO7j2
	 XnnkOnGtvC22TxRvHoC1BxGZSIlSs/DwwxNw8e4w3Hioe83CWwKAqX7mEYFqfC3SMO
	 ZmIwsRdzzNd2YqO5YN61Dk3KCf/ElMmcIsFpDmuYVBcIkHT8q8wsc2rOtgShU0BO/0
	 cVN7Q+RPv1bn1ZAuUkNnfm5wnqwiERtRtow8T5hKW/+Loa/BReL0lZruXa9orlyT91
	 enf2Y6yA9iHYg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [RFC][PATCH v0.1 5/6] sched/topology: Allow .setpolicy() cpufreq drivers to
 enable EAS
Date: Fri, 08 Nov 2024 17:41:22 +0100
Message-ID: <1889415.atdPhlSkOF@rjwysocki.net>
In-Reply-To: <3607404.iIbC2pHGDl@rjwysocki.net>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthg
X-DCC--Metrics: v370.home.net.pl 0; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some cpufreq drivers, like intel_pstate, have built-in governors that
are used instead of regular cpufreq governors, schedutil in particular,
but they can work with EAS just fine, so allow EAS to be used with
those drivers.

Also update the debug message printed when the cpufreq governor in
use is not schedutil and the related comment, to better match the
code after the change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I'm not sure how much value there is in refusing to enable EAS without
schedutil in general.  For instance, if there are no crossover points
between the cost curves for different perf domains, EAS may as well be
used with the performance and powersave governors AFAICS.

---
 kernel/sched/topology.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/sched/topology.c
===================================================================
--- linux-pm.orig/kernel/sched/topology.c
+++ linux-pm/kernel/sched/topology.c
@@ -251,7 +251,7 @@ static bool sched_is_eas_possible(const
 		return false;
 	}
 
-	/* Do not attempt EAS if schedutil is not being used. */
+	/* Do not attempt EAS with a cpufreq governor other than schedutil. */
 	for_each_cpu(i, cpu_mask) {
 		policy = cpufreq_cpu_get(i);
 		if (!policy) {
@@ -263,9 +263,9 @@ static bool sched_is_eas_possible(const
 		}
 		gov = policy->governor;
 		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
+		if (gov && gov != &schedutil_gov) {
 			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
+				pr_info("rd %*pbl: Checking EAS, cpufreq governor is not schedutil\n",
 					cpumask_pr_args(cpu_mask));
 			}
 			return false;




