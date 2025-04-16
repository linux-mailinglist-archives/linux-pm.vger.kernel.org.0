Return-Path: <linux-pm+bounces-25577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A8A90B1E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90D65A0A24
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8592222AA;
	Wed, 16 Apr 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="xT57oqYN"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53A221D80;
	Wed, 16 Apr 2025 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827178; cv=none; b=JPnu8/gObIOYZcjpvqvQTVvKRSPBENfZTqmdNjbYeao4MMo1a43iDqDullCU/2Wwn0u6yZBDmSE2d5veVmtvVqZLgwa6lw55ENjlpWPX32ilPLhgq7zg2Opsjtr0docja/hoO/TCOTLkzL6eP8i23KuuY8XgqLQMe++deXxnJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827178; c=relaxed/simple;
	bh=SXPUl90BjvGcpXMvmbXxCsof9c3BOGco/bFN/nHJFmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibIknG6lMl5UtXgBEZDTe5qH22WDTiZAshHjqIVl6WfsLVsKkv4AfAkX2qs0A5RhgQynSuvA8DcjputdByxNAl9m47h3w2y2HRM8M7AkkafycGb4+G88roPGerFwxs5MsFfL8pOyZDi0WHC2MxVlKUDN7KEaxmt0MaGPRpjSgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=xT57oqYN; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 73572662716;
	Wed, 16 Apr 2025 20:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827174;
	bh=SXPUl90BjvGcpXMvmbXxCsof9c3BOGco/bFN/nHJFmI=;
	h=From:Subject:Date;
	b=xT57oqYNKhSfN3LgVlcpUWX8w/K2GWnDdEl1KZ3TtBmOpI2981uCUqUuAHCs+zFCy
	 /BTJNP5EaZyVib/0FodXuC41vNftwI6nKZVQmLZ89JJ2zQ08blESOIHNm/vavVQLS8
	 DfEWzgL7Xb6+T95uD6AqJugjKA4dLl1qcl5VHvIoc3QL3Thdjq/Oj5vAO+8XwKZigy
	 5Ok87vtcGabzs5KVJwogUKPIAcDizn5CuV1LOYGNEV/Z1Bmw8jlAkIgT2yDsukaiX/
	 taADtHZfKsYiFLMR12KdygJ69cXaxq5gtJI/pMCEgf+Tf2LzMoCes18A83JfyRC0yO
	 MeFJ+H/zcpcIg==
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
 [RFT][PATCH v1 0/8] cpufreq: intel_pstate: Enable EAS on hybrid platforms
 without SMT
Date: Wed, 16 Apr 2025 19:44:43 +0200
Message-ID: <3344336.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

Hi Everyone,

This is a new version of

https://lore.kernel.org/linux-pm/22640172.EfDdHjke4D@rjwysocki.net/

which is not regarded as RFC any more.  It appears to be better than

https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/

but still requires more testing, so I'd appreciate any help here.

The following paragraph from the original cover letter still applies:

"The underlying observation is that on the platforms targeted by these changes,
Lunar Lake at the time of this writing, the "small" CPUs (E-cores), when run at
the same performance level, are always more energy-efficient than the "big" or
"performance" CPUs (P-cores).  This means that, regardless of the scale-
invariant utilization of a task, as long as there is enough spare capacity on
E-cores, the relative cost of running it there is always lower."

The first 3 patches have been updated since v0.3 and they now depend on the new
cpufreq material in linux-next.

The next 2 patches (Energy Model code changes) have been reviewed in the
meantime, but they are only needed for the last 3 patches.

Patch [6/8] is essentially the same as before.  It causes perf domains to be
registered per CPU and in addition to the primary cost component, which is
related to the CPU type, there is a small component proportional to performance
whose role is to help balance the load between CPUs of the same type.

This is done to avoid migrating tasks too much between CPUs of the same type,
especially between E-cores, which has been observed in tests of

https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/

The expected effect is still that the CPUs of the "low-cost" type will be
preferred so long as there is enough spare capacity on any of them.

The last 2 patches are new.

Patch [7/8] looks at the cache topology to avoid creating per-CPU perf domains
for CPUs sharing an L2 cache.  Typically, on the chips that will be affected
by this patch, CPUs sharing an L2 cache also share a voltage regulator and a
clock, so they technically belong to the same OPP domain and they will be put
into a shared perf domain after this patch.

Patch [8/8] makes CPUs sharing the L3 cache look slightly more expensive to
cause the scheduler to prefer placing tasks on CPUs that don't use the L3,
which in some cases should allow all of the CPUs sharing the L3 to stay in
idle states and the energy usage should be reduced.

Please refer to the individual patch changelogs for details.

Since patches [7-8/8] also apply on top of the v0.3, I have created a git branch at

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
experimental/intel_pstate/eas-take2-extended

or

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate/eas-take2-extended

to allow the difference they make with respect to the v0.3 to be seen (if any).

Later, I'm going to put this series as a whole into a new git branch on top of
the mainline and the cpufreq material queued up for 6.16.

Thanks!




