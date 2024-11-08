Return-Path: <linux-pm+bounces-17219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E29C2259
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76D01F246A8
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF0199E88;
	Fri,  8 Nov 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fEX164BH"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C0197A92;
	Fri,  8 Nov 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084395; cv=none; b=DidkJCA9m6Z6Vf1qn1b1bypCjP/7TfQgVCRsHOn1+TmixKnzrnN8KXdIuticg+pWCL1HLKuAatyKINd8FCwAxuMhnF+KKzjE2YYfKN2aB9oqYS2GvOOGe3O6sr54XWJaZuqnFrGxK8CRK4r/UtoYo9MF8N/4v1HFH3up/6UY6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084395; c=relaxed/simple;
	bh=2pHcTBoi9lcMbT1C263b1xLFZScI7/Ijdf7EqoIYlXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DI+kSzUUf4rsblil2nnvyLBeY9GrMvpoUje3EF7YEEX2KoFVOynjWMcNXs2ZJ4Uu5QMF5jfR9ZoQN9jtiBs18B+TtXtbtbz2PWFyCOJfoe48kxNJ6fXpcGOY5JU+M8nciHh98Sczs8giZtd3H74lh6fP6KczPKtn4GGvn6F73+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fEX164BH reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id b28332d376a30c7a; Fri, 8 Nov 2024 17:46:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 62F218384AE;
	Fri,  8 Nov 2024 17:46:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731084386;
	bh=2pHcTBoi9lcMbT1C263b1xLFZScI7/Ijdf7EqoIYlXc=;
	h=From:Subject:Date;
	b=fEX164BHm/h8hCkjkCee3IeihTX0SCu6nzQK83NVhWxnCP6iKYiiI4aVYTfbbk2X9
	 klzjM1ujtOxy398Pow8k742tz4vbbLbvUSa8TAaaYhkVVZ0IsgdR/eihJHHUB9y1zP
	 JQdIGqRYBp43155vp//dCaH5r5xbP5gKSPt5XtuyaU8JIpc12d3g/8pGZgnVwaNp3k
	 qNCVxpBq4IFoaSxCTES1w9SgEl2ppbJNQyOFtt14sEBg106vfCOvXJtTbrY9l06Y6n
	 gEg1XS6w3LRywy56Uys4HzSCEH7fKuDiuYvHFf2HHCQfpU6ls6jgb9vfMcXFe5YNgY
	 D0Iy+j7CXtjYA==
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
 [RFC][PATCH v0.1 0/6] cpufreq: intel_pstate: Enable EAS on hybrid platforms
 without SMT
Date: Fri, 08 Nov 2024 17:09:47 +0100
Message-ID: <3607404.iIbC2pHGDl@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhg
X-DCC--Metrics: v370.home.net.pl 0; Body=10 Fuz1=10 Fuz2=10

Hi Everyone,

This series, on top of

https://lore.kernel.org/linux-pm/12554508.O9o76ZdvQC@rjwysocki.net/

modifies the energy model code, the EAS setup code and the intel_pstate
driver to enable simplified EAS support in the latter.

The underlying observation is that on the platforms targeted by these changes,
Lunar Lake at the time of this writing, the "small" CPUs (E-cores), when run at
the same performance level, are always more energy-efficient than the "big" or
"performance" CPUs (P-cores).  This means that, regardless of the scale-
invariant utilization of a task, as long as there is enough spare capacity on
E-cores, the relative cost of running it there is always lower.

Thus the idea is to register a perf domain per CPU type, which currently are
P-cores and E-cores, to represent the relative costs of running tasks on CPUs
of each type.  The states table in each of these perf domains is one-element
and that element only contains the cost value, which causes EAS to compare the
"E-core cost" with the "P-core cost" every time it has to make a decision, and
because the "E-core cost" is lower, it will always prefer E-cores as long as
there is enough spare capacity to run the given task on one of them.

The intel_pstate driver knows the type of each CPU, so it can create cpumasks
requisite for registering the perf domains as per the above, but the energy
model registration code needs to be adjusted to handle perf domains with
one-element states tables (further referred to as stub perf domains).  It
also needs to allow adding a new CPU to an existing perf domain to handle the
case in which some CPUs are offline to start with and are brought online later
via sysfs.  The first 4 patches in the series make the requisite energy model
change.

Patch [5/6] updates the EAS setup code to allow it to work without the
schedutil cpufreq govenor which need not be used when intel_pstate is in
use (in the "active" mode, intel_pstate uses a built-in governor that can
work with EAS just fine because it also adjusts the CPU performance level to
utilization).

The last patch modifies intel_pstate to register the perf domains described
above and update them when new CPUs become available for the first time.

Please refer to the individual patch changelogs for details.

It has been verified that the behavior after the changes here is as intended,
that is the perf domains are registered and EAS is enabled.

For easier access, the series is available on the intel_pstate-experimental-v2
branch in linux-pm.git:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=intel_pstate-experimental-v2

Thanks!




