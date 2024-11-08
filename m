Return-Path: <linux-pm+bounces-17220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D56E9C225A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECEF1F2444E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F0199EB2;
	Fri,  8 Nov 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FEogs6sT"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF78197A8E;
	Fri,  8 Nov 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084395; cv=none; b=XO1thm97EA/N9793ggiD0X+AVMuA0OP8tb+uLz19f4Y3LtCe+ifGtyd/fMQNtqkualHbFA1mnZKKHDipDiUgMbhXp3ih/RnBelnD9cjRstcYh8BXPROaBickz1XLoe1nWoioEQE4K2LHjpmdg01GN1ANytObznsumzdm3QAbWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084395; c=relaxed/simple;
	bh=EWHBWVq8c2xPlLQOEUYeio/FxqoJ8rmfYy1j7aExdLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS1O+BIEnPCBJGdbrWl7Bf8lF2BvEFsrzG4lkLPtY3HW2AgAKnNJ35GFPz9Rkvql7TsdH1ZrbahnbhrVJ9fhHIvfeHTQCIqK+s+oP9s1HxhS2sK+umcyr1aZqmbRhzY7bJhZesSRcFQVkrj+Ox9SuGI1DB5JhbyI6gjzOWtLNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FEogs6sT reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id db0b5c1feafc1978; Fri, 8 Nov 2024 17:46:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9B10D834811;
	Fri,  8 Nov 2024 17:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731084385;
	bh=EWHBWVq8c2xPlLQOEUYeio/FxqoJ8rmfYy1j7aExdLU=;
	h=From:Subject:Date;
	b=FEogs6sT+okuG0ijr0ZDOsqFcaQXyBgl1+9sPqHe8qm9nODAw4KRdWHMJmTI8H3/s
	 ap9aV4B5IQ2D/yVvH9fB36lfoSWu87YFr3RP1FZy4Uuzo7OynUGqGwJ6P62f4ml+WR
	 SemZ35t6qa8fE44TNPOSpcsXss4bUXuY1BS+aYvJBGnAD1XJ83jzfB85iPiROFZ/8a
	 RAN2PgjJpMSPXiaWoIdngtJ3lbRlueX0NrLCVSwzfH3sx27obZjifl3IleIW1+2ret
	 AwC4Krb/xJfQfv9wWQKZziaIKvinx5NhCS3x7Il6izm8RsYco/UnwUGuEiQPa/uMJv
	 YCk0ck++w1zNw==
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
 [RFC][PATCH v0.1 2/6] PM: EM: Call em_compute_costs() from
 em_create_perf_table()
Date: Fri, 08 Nov 2024 17:37:21 +0100
Message-ID: <1821040.VLH7GnMWUR@rjwysocki.net>
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

In preparation for subsequent changes, move the em_compute_costs()
invocation from em_create_perf_table() to em_create_pd() which is its
only caller.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/energy_model.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/kernel/power/energy_model.c
===================================================================
--- linux-pm.orig/kernel/power/energy_model.c
+++ linux-pm/kernel/power/energy_model.c
@@ -388,10 +388,6 @@ static int em_create_perf_table(struct d
 
 	em_init_performance(dev, pd, table, nr_states);
 
-	ret = em_compute_costs(dev, table, cb, nr_states, flags);
-	if (ret)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -434,6 +430,10 @@ static int em_create_pd(struct device *d
 	if (ret)
 		goto free_pd_table;
 
+	ret = em_compute_costs(dev, em_table->state, cb, nr_states, flags);
+	if (ret)
+		goto free_pd_table;
+
 	rcu_assign_pointer(pd->em_table, em_table);
 
 	if (_is_cpu_device(dev))




