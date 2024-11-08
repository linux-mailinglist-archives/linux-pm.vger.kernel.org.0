Return-Path: <linux-pm+bounces-17222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20909C2260
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42116B22C78
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3921F4268;
	Fri,  8 Nov 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CziqCWxg"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543D1946C7;
	Fri,  8 Nov 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084396; cv=none; b=VZ4QlpAsUlXsFok+WyFJa1dwvQr/MfSmJmVDVej6d+R6tSnBdhzPpJo7yMP8pYjunzMqZc3IFpmEloMSIcYYUoCEJE6K+c5txSsyinMfVppFO3+ZDN0YLd5WYH0qGzxapI7H3O+7AGRgTpRb8Mu99fQeKGiBXCT6M5/CCU8Snyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084396; c=relaxed/simple;
	bh=I/l6yS2A34mcKFYeAnorgxbnF2qkABDnsse+by9CHTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zp3XDddMo8GxI3SFz6EhjjnfTnN/g4EEnwYo5vCaG3sqnhsMq6DLK55zgUoFPZJBu5n0Wgt2C0ch0as0Tiz04BLIrdLGQ1fmQfCOR85kE+2O1KwiFtdRQ1Q1t/mENBLDUFkNg5hbp2Kr9A6X2RJUP/4gzqY8TG0N3M9+WMuqC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CziqCWxg reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 5734cae46dce7224; Fri, 8 Nov 2024 17:46:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 39B41834811;
	Fri,  8 Nov 2024 17:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731084385;
	bh=I/l6yS2A34mcKFYeAnorgxbnF2qkABDnsse+by9CHTU=;
	h=From:Subject:Date;
	b=CziqCWxg+n7ku4VAECHUivC9CqvzabHHFcHiozFgZyZYFvb+ZXCvFBbz4eVGPUrs/
	 8Ro999u4XvOmPOgk0s2nGXHE1L6SVLbNSnhlP1uYXzgArwrZG7bhSZ9B/Xn6mzp0AC
	 MIgpVU9q1pqoezHIQEBBtLb6y22XpDwLHm7hZ23Yfg3avGqo8DxuJu03TxSuUBQikv
	 Ho8bKxQDSEfUiSRzgOKyzLUZt5VhSY1STh7z6O8Hr5jkUgApmORom6PuKSy/f9Vbft
	 vrgzmY8Ln6udaPv142z4qkFun2MNUyY34H2JuLAXQM263Cxo9/cKRYzVC/ecJ9rQ0O
	 hvMSyg+EeUqpw==
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
 [RFC][PATCH v0.1 3/6] PM: EM: Add special case to
 em_dev_register_perf_domain()
Date: Fri, 08 Nov 2024 17:38:11 +0100
Message-ID: <2017201.usQuhbGJ8B@rjwysocki.net>
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

Allow em_dev_register_perf_domain() to register a cost-only stub
perf domain with one-element states table if the .active_power()
callback is not provided.

Subsequently, this will be used by the intel_pstate driver to register
stub perf domains for CPUs on hybrid systems.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/energy_model.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

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
@@ -561,11 +563,20 @@ int em_dev_register_perf_domain(struct d
 {
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;
+	bool stub_pd = false;
 	int cpu, ret;
 
 	if (!dev || !nr_states || !cb)
 		return -EINVAL;
 
+	if (!cb->active_power) {
+		if (!cb->get_cost || nr_states > 1 || microwatts)
+			return -EINVAL;
+
+		/* Special case: a stub perf domain. */
+		stub_pd = true;
+	}
+
 	/*
 	 * Use a mutex to serialize the registration of performance domains and
 	 * let the driver-defined callback functions sleep.
@@ -590,6 +601,15 @@ int em_dev_register_perf_domain(struct d
 				ret = -EEXIST;
 				goto unlock;
 			}
+
+			/*
+			 * The capacity need not be the same for all CPUs in a
+			 * stub perf domain, so long as the average cost of
+			 * running on each of them is approximately the same.
+			 */
+			if (stub_pd)
+				continue;
+
 			/*
 			 * All CPUs of a domain must have the same
 			 * micro-architecture since they all share the same




