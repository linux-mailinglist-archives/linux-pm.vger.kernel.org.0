Return-Path: <linux-pm+bounces-25403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7AA88D66
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC1A1896C70
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D41F3FE3;
	Mon, 14 Apr 2025 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kU+sEdgo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292891EB5D6;
	Mon, 14 Apr 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663965; cv=none; b=XJoGl13kl+uNdljrEbp3oFyzRdTGOp4YrWfygFZv1g2ERtxj8YLhQXxW5QUfhtc5iiH3ixhJK1kKjKckETmChzOCScm9ZPMLtt8gxxaWhComu7v50jhGuZHoTR62eZ1gOU8j4/uaS/9QC7m315Nhh2nObCCawLd36lrszHipguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663965; c=relaxed/simple;
	bh=nd8+9UJ+TOW1+YdlodfI+xvYQNqm7gqnsIfwCuBXWPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AJSZiDHKM8R8HjYvgkap3vrBpKo2tOBwfVS2sB8GvF0aJVeXpzmD6yl7NVeoe102f0xCLoL88+m+xQOyNVYkBTQrZUYo3HaBMoAQvnD2ohB+pL3wEn11SujpN014HVhd8lJ0/UlR6STzOgHBGbSCKGgLomp6nqBx9lYuemYa2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kU+sEdgo; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 275A06625E5;
	Mon, 14 Apr 2025 22:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744663956;
	bh=nd8+9UJ+TOW1+YdlodfI+xvYQNqm7gqnsIfwCuBXWPs=;
	h=From:Subject:Date;
	b=kU+sEdgorq20UccxrPVADnIKzDKR/nQfh0snvRRZp5Mx4AcmQQGqWdetw/jeilJJv
	 g6idjoCN7bhRBSBOliPKhiEaURiAeea1u4raGK3kJaSTiGm1pixOTnA9UmNbmD7yJD
	 C+18xbLWhHwCsgc2Yoq5qa2INWnVatV4V+ydXyV8ah9MeLzYPum5m6XKqvtn4h82th
	 ndeT1JwRkrAcqGBTmvj6GEMZge4FQuzdiEB76xq6ymEXHk+o45GGiyOzbm7GlCmjec
	 dsI973VnblHalqFz8YNgwpHaysN3dtU4w+uLG6SIOZoETaiVA0HlW+dHtjrgMuS4fa
	 UOsPwsXiHFhAw==
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
 [PATCH v1 0/5] cpufreq/sched: Improve synchronization of policy limits
 updates with schedutil
Date: Mon, 14 Apr 2025 22:39:53 +0200
Message-ID: <3364921.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

Hi Everyone,

This series of patches has been inspired by the discussion following a bug
report regarding the patch at

https://lore.kernel.org/lkml/20241212015734.41241-2-sultan@kerneltoast.com/

and its attempted unsuccessful resolution:

https://lore.kernel.org/linux-pm/20250410024439.20859-1-sultan@kerneltoast.com/

which basically leads to the conclusion that cpufreq policy limits updates are
not sufficiently synchronized with the scheditil governor, especially in the
fast switching case in which running the driver callback is the only way to
make the new policy limits take effect.

The purpose of this series is to address this concern.

Patch [1/5] is a fix for the issue introduced by the patch linked above (please
see the patch changelog for details), for 6.15-rc.  The remaining patches are
for 6.16.

Patch [2/5] adds memory barriers in two places in schedutil along with some
WRITE_ONCE()/READ_ONCE() annotations to ensure that policy limits updates will
not be missed due to reordering of instructions.

Patch [3/5] is a preparatory function rename with no functional impact.

Patch [4/5] updates the cpufreq core to avoid situations in which
cpufreq_driver_resolve_freq(), called by schedutil, may see intermediate
values of policy->min and policy->max and makes that function address the
unlikely case in which it may see policy->min > policy->max.

Patch [5/5] cleans up the code after the previous changes.

Please see individual patch changelogs for details.

Thanks!




