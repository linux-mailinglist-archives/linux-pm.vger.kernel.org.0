Return-Path: <linux-pm+bounces-18249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4640C9DEAF5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96016B21FB6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770A19C566;
	Fri, 29 Nov 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="finRUTKA"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1014B077;
	Fri, 29 Nov 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897710; cv=none; b=bqEqfMJBrEjzHJ138/qPI5Aw+hUB+i6jQOimokkgxC3kKjzImzDRYGV/6qTSxA+AFaGMsARSLKDX89nTXNqS5AlwyNdoQCKST18AU57Wazm/J5wrkNIHoLUgdDKnLBGLpnlwNlXaFwcQ7XJzZQDRdUivDNYzZMObVluniwpu0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897710; c=relaxed/simple;
	bh=FKnPnu8hfFeXCZahpuSL24QHqbxqLu0B1VJ0LBdPyqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYsvj4N9cBcAAY0Td7wdolI3SE/8KHw8I+F8Vr81Z6hmvSLEHMYQrQZHSJfBUAyqIBpYZrGRq8bl1Sk4UEMLS1f21L73r0xN6ekoO38Oh0M3tGeZ1NHKOBzeXD9405/uFPe+k4XSCvIrDMQTwD6bsjS0FZcXf8qy1e/r2gnruEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=finRUTKA; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 3fe91fa265978409; Fri, 29 Nov 2024 17:28:20 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D642DA47B8B;
	Fri, 29 Nov 2024 17:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897700;
	bh=FKnPnu8hfFeXCZahpuSL24QHqbxqLu0B1VJ0LBdPyqk=;
	h=From:Subject:Date;
	b=finRUTKAc6mmyu2v7utao5Bq/H5hBGGiG7fH21Cb5C6jnyFxXsoJwD72ZIThKw/kX
	 HzH0m5uuvsWyMGRydyfzjbHXFohACJI45ZHtLge6X8MAiyjEXhwqHnG30c4T/+xCKE
	 Ah55s1Jwx9g8iZXvxRUL3QkOMe/miJfafgCi3pLLdy5JKbXALreMrcBnDc1Ij8Wr0g
	 Qc8/V9tP5gHnrdZ4p7lM68isMgZ+8hD8H0i5jJE2M5W7KuWcn+iQpHLsbXMsaln5fv
	 IxDRt7BKhjJFfrWxTjIOKGjsvgZdgycNRO/TwskKN/3LeEA5u58c/UzxxqEcGbEIpY
	 +uAkyfnoUtOXQ==
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
Subject: [RFC][PATCH v021 8/9] cpufreq: intel_pstate: Introduce hybrid domains
Date: Fri, 29 Nov 2024 17:21:40 +0100
Message-ID: <2030654.usQuhbGJ8B@rjwysocki.net>
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

Hybrid platforms contain different types of CPUs.  They may differ
by micro-architecture, by cache topology, by manufacturing process, by
the interconnect access design etc.  Of course, this means that power-
performance curves for CPUs of different types are generally different.

Because of these differences, CPUs of different types need to be handled
differently in certain situations and so it is convenient to operate
groups of CPUs that each contain CPUs of the same type.  In intel_pstate,
each of them will be represented by a struct hybrid_domain object and
referred to as a hybrid domain.

A key problem is how to identify the type of a CPUs so as to know which
hybrid domain it belongs to.  In principle, there are a few ways to do
it, but none of them is perfectly reliable.

From the computational perspective, an important factor is how many
instructions (on average) can be executed by the given CPU when it is
running at a specific frequency, often referred to as the IPC
(instructions per cycle) ratio of the given CPU to the least-capable
CPU in the system.  In intel_pstate this ratio is represented by the
performance-to-frequency scaling factor which needs to be used to get
a frequency in kHz for a given HWP performance level of the given CPU.
Since HWP performance levels are in the same units for all CPUs in a
hybrid system, the smaller the scaling factor, the larger the IPC ratio
for the given CPU.

Of course, the performance-to-frequency scaling factor must be the
same for all CPUs of the same type.  While it may be the same for CPUs
of different types, there is only one case in which that actually
happens (Meteor Lake platforms with two types of E-cores) and it is not
expected to happen again in the future.  Moreover, when it happens,
there is no straightforward way to distinguish CPUs of different types
with the same scaling factor in general.

For this reason, the scaling factor is as good as it gets for CPU
type identification and so it is used for building hybrid domains in
intel_pstate.

On hybrid systems, every CPU is added to a hybrid domain at the
initialization time.  If a hybrid domain with a matching scaling
factor is already present at that point, the CPU will be added to it.
Otherwise, a new hybrid domain will be created and the CPU will be
put into it.  The domain's scaling factor will then be set to the
one of the new CPU.

So far, the new code doesn't do much beyond printing debud messages,
but subsequently the EAS support for intel_pstate will be based on it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -943,6 +943,62 @@ static struct cpudata *hybrid_max_perf_c
  */
 static DEFINE_MUTEX(hybrid_capacity_lock);
 
+#ifdef CONFIG_ENERGY_MODEL
+/*
+ * A hybrid domain is a collection of CPUs with the same perf-to-frequency
+ * scaling factor.
+ */
+struct hybrid_domain {
+	struct hybrid_domain *next;
+	cpumask_t cpumask;
+	int scaling;
+};
+
+static struct hybrid_domain *hybrid_domains;
+
+static void hybrid_add_to_domain(struct cpudata *cpudata)
+{
+	int scaling = cpudata->pstate.scaling;
+	int cpu = cpudata->cpu;
+	struct hybrid_domain *hd;
+
+	/* Do this only on hubrid platforms. */
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return;
+
+	guard(mutex)(&hybrid_capacity_lock);
+
+	/* Look for an existing hybrid domain matching this CPU. */
+	for (hd = hybrid_domains; hd; hd = hd->next) {
+		if (hd->scaling == scaling) {
+			if (cpumask_test_cpu(cpu, &hd->cpumask))
+				return;
+
+			cpumask_set_cpu(cpu, &hd->cpumask);
+
+			pr_debug("CPU %d added to hybrid domain %*pbl\n", cpu,
+				 cpumask_pr_args(&hd->cpumask));
+			return;
+		}
+	}
+
+	/* No match.  Add a new one. */
+	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
+	if (!hd)
+		return;
+
+	cpumask_set_cpu(cpu, &hd->cpumask);
+	hd->scaling = scaling;
+	hd->next = hybrid_domains;
+	hybrid_domains = hd;
+
+	pr_debug("New hybrid domain %*pbl: scaling = %d\n",
+		 cpumask_pr_args(&hd->cpumask), hd->scaling);
+}
+#else /* CONFIG_ENERGY_MODEL */
+static inline void hybrid_add_to_domain(struct cpudata *cpudata) {}
+#endif /* !CONFIG_ENERGY_MODEL */
+
 static void hybrid_set_cpu_capacity(struct cpudata *cpu)
 {
 	arch_set_cpu_capacity(cpu->cpu, cpu->capacity_perf,
@@ -2273,6 +2329,7 @@ static void intel_pstate_get_cpu_pstates
 				intel_pstate_hybrid_hwp_adjust(cpu);
 				hwp_is_hybrid = true;
 			}
+			hybrid_add_to_domain(cpu);
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}




