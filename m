Return-Path: <linux-pm+bounces-18252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616A9DEAFD
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0055F281804
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9FF1A0731;
	Fri, 29 Nov 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="c2ed2Rff"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44414F9F9;
	Fri, 29 Nov 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897712; cv=none; b=eaQJpNplpnlyJe+U6eWRkUeUPNjV//0pEv+sKxuJMzVe9pBJbnJ4xwWEFZ6O+FNlDOlQoFWfllSRv7dXx39zyStL2GwKH+7TEtxKWLdG32M0hGJj1uv6LkspViuC++OYTZJ+UkWKojulY0uKWAV1PRCh9imEzXmiAN9p0wDUVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897712; c=relaxed/simple;
	bh=CoHMWva7c4OBH0vaKdTvFtpcFV5sbCOP/HbkqDCr2Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSLNKzWZLLhGrjBOtxPvdUGadC3lQKRJMYMSbyaTevHgKs0iK+3fYHZCQtaaq6AsnkTQhlOlaV+FXSzbIk7AmnaZHcEn/u37+4URss9nBc+bR6UFsW0law/yCQTqt0KeUcsJCgqRBuG0/WuPg6PAWd4vbiQkMP23LCqTBbgGFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=c2ed2Rff; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 9c33acf31241bace; Fri, 29 Nov 2024 17:28:22 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C2718A47B8C;
	Fri, 29 Nov 2024 17:28:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897702;
	bh=CoHMWva7c4OBH0vaKdTvFtpcFV5sbCOP/HbkqDCr2Vw=;
	h=From:Subject:Date;
	b=c2ed2RffCGnatxCZCe71yEGTndSOihyIqjmIl2FmrWtkAGDJCa9K51FFGD/SA7S3Y
	 8GRSyBopH/eUp9rOWhLXM/wM+U1RSU5OrZkhkGBmGfJTcY2LZWzhnbz9RtrhDFzn+m
	 Zd0a5UioeZWadeQckotiJfmfYav0x87Z9jZwRKFNqSoXssZFt4r0t3sN74SddoAt1p
	 JYV/QuGn9s7UrbddDfF6N4vWutSqVztUsk6v5d+xJ1y2kMcQw9LabNXgXapiuUUziP
	 hBtJJGZY6b4S7OIUlkiWAYDytlROhzYkot+GjEP7BpK+iNkSGt3FAaab3Yu+9OjfOe
	 E7XQWsY/94d+Q==
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
 [RFC][PATCH v021 6/9] PM: EM: Call em_compute_costs() from
 em_create_perf_table()
Date: Fri, 29 Nov 2024 17:06:52 +0100
Message-ID: <2010024.PYKUYFuaPT@rjwysocki.net>
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

In preparation for subsequent changes, move the em_compute_costs()
invocation from em_create_perf_table() to em_create_pd() which is its
only caller.

This helps to prepare the EM registration code for handling the case in
which the :active_power() EM callback is NULL.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.1 -> v0.2: Update changelog to explain what subsequent change depends
              on this patch.

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




