Return-Path: <linux-pm+bounces-25461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B9A899B0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2237A3BB5FF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632F28F539;
	Tue, 15 Apr 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HIkj3hXa"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72A28E603;
	Tue, 15 Apr 2025 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712268; cv=none; b=i5D4qlTBvqv9RDQLkb3e5VN5XCUo2aGfhzBQ22/ZGKjnZ+QoI24rlWAnkjUrMW4rqOHCLId3ei/NHUkeYBs2BIVorUN9pCejzc/PkavdQckW+Gb3bUGYC1mZhq9qjcbJ3H3DczDcsDbu2J1yFr8mbRDAljKbu8mYDosvrsyEI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712268; c=relaxed/simple;
	bh=rTjRFIAfHD4DB+9hVzG2jvqsve39fU1uZXYWiFw8EcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ozwKTbLnUPd/jYKqmnaeGPjAoX3wqXDUGSb3cS0mu9gbEcuSU0zccVQbEcB6lBdKGpaKz+dBcKxG6jNSAzJx5K/9aO1rgM/4nv+cEYDIEfDBLGHILJsmajHb9rWmGInUYTs9wb1ROrf9nnDXwIypxu2xZdTPEb3KoWfF8u5Swa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HIkj3hXa; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9CA13662667;
	Tue, 15 Apr 2025 12:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744712259;
	bh=rTjRFIAfHD4DB+9hVzG2jvqsve39fU1uZXYWiFw8EcI=;
	h=From:Subject:Date;
	b=HIkj3hXaJh4egXuWilkzCDhgrJn8X+omM+hM2urQww6y5foUbzUGPD+AQ/ryAbaRb
	 iAQCWWLVzJyjtFftz/O8MUVqNZTmODRFpWLa5JbkEwubLsrwgBa4gZts/FA4YhlbbA
	 zJsTnWhpLsYdGl/Iqksx8UZ3JT+OVT7o08DDftZKuRScH5ZcdrItuJU/wTvdSPYNDA
	 WkuZlUh3qcB0T2Ov+ChUp+jU7/gwksN/RDqf1R229gBxX2qy97UGF3x5m6G60HkZ1R
	 LhpP2ip+FYU48eWdA6sUNpcAL1JnmXRHfS/mMm6NIS8RYh7uNPMek1zLl/HQ4Rv8KR
	 L7/1+F5mbnZUA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject:
 [PATCH v2 0/6] cpufreq/sched: Improve synchronization of policy limits
 updates with schedutil
Date: Tue, 15 Apr 2025 11:52:10 +0200
Message-ID: <6171293.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/3364921.aeNJFYEL58@rjwysocki.net/

that replaces the first patch with a better fix and adds one more patch
after the second one.

The original cover letter is still generally applicable:

"This series of patches has been inspired by the discussion following a bug
 report regarding the patch at

 https://lore.kernel.org/lkml/20241212015734.41241-2-sultan@kerneltoast.com/

 and its attempted unsuccessful resolution:

 https://lore.kernel.org/linux-pm/20250410024439.20859-1-sultan@kerneltoast.com/

 which basically leads to the conclusion that cpufreq policy limits updates are
 not sufficiently synchronized with the scheditil governor, especially in the
 fast switching case in which running the driver callback is the only way to
 make the new policy limits take effect.

 The purpose of this series is to address this concern."

Patch [1/6] is a fix for the issue introduced by the patch linked above (please
see the patch changelog for details), for 6.15-rc.  The remaining patches are
for 6.16.

Patch [2/6] adds memory barriers in two places in schedutil along with some
WRITE_ONCE()/READ_ONCE() annotations to ensure that policy limits updates will
not be missed due to reordering of instructions.

Patch [3/6] prevents limits_changed from being used for purposes unrelated to
changing the policy limits.

Patch [4/6] is a preparatory function rename with no functional impact.

Patch [5/6] updates the cpufreq core to avoid situations in which
cpufreq_driver_resolve_freq(), called by schedutil, may see intermediate
values of policy->min and policy->max and makes that function address the
unlikely case in which it may see policy->min > policy->max.

Patch [6/6] cleans up the code after the previous changes.

Please see individual patch changelogs for details.

Thanks!




