Return-Path: <linux-pm+bounces-13030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB28962663
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 13:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12EA1C210FD
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896411741C3;
	Wed, 28 Aug 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fiM5LoIE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0416D334;
	Wed, 28 Aug 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845961; cv=none; b=qd72EB0F0h2c3Po2ugCk/HHYFBeMX8YAOhM3vh2uNshqdh3KfUjB+C2Qc1IJXLXHx+x2J/M9JFh428gq3IFzZqPUw267oTyDNpWv+SWBPgA3LcpVCMo3F8OoGA4xT+cZZ57yuzmb+aoqFnTnW1bYx57i746L2qbqOgbnqjTRE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845961; c=relaxed/simple;
	bh=RJOnJ5A4TdkFnKq4gpjtqlbLO38nenDCNd9HYf73RnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oCAG4BpFxTcVYU+V5URmJUyvPe4+8TCd+BO85o6i2ZBoHSnVBI7O8qiS1aKzb7+mHspsVYld4I0kkGzMJ6pmKI1TIrxb8G5OGtb7u+f5u02Rkfbt5eeuCcCmQKgxGjqZKpvwrB9e9G9M7fc8+80WmXfaiXoTsSMgsDVUZLYjXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fiM5LoIE reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id bb71734bd8613a60; Wed, 28 Aug 2024 13:52:31 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8620E923483;
	Wed, 28 Aug 2024 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724845951;
	bh=RJOnJ5A4TdkFnKq4gpjtqlbLO38nenDCNd9HYf73RnI=;
	h=From:Subject:Date;
	b=fiM5LoIEjfQ7zAqXf3IMwvACNHuuzSgwEm7Wh/lJ1d2TJmYZSbKquk1xlVzVMp3R4
	 kA31g3ugPLyVXk++LYdLpVcjHfpnv6cbOQE1Rba83T+VD4k00pSV1txlTuTMq78aQI
	 PMn7RWoi6cVpReLbsYoTAPi7k/tZ1+NFj2S3yRAI1sima8Xp/3fnTU1JiuoUtbbeuS
	 qHGgfK/DY7ezjcrjsZhjJeGShOKTA3yN9IctG54Imrxx07ScXHprydk0hI518lv71k
	 Ez2wMV8OGlDv8oABJ6p7MTafhD9l1faiaZ+klP4/ikTXktwHtvkK4RqEYWduAGWMbU
	 MZ4ZlIZUCpirw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 [PATCH v3 0/2] x86 / intel_pstate: Set asymmetric CPU capacity on hybrid
 systems
Date: Wed, 28 Aug 2024 13:45:00 +0200
Message-ID: <3310447.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhu
 thhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/4941491.31r3eYUQgx@rjwysocki.net/

which was an update of

https://lore.kernel.org/linux-pm/4908113.GXAFRqVoOG@rjwysocki.net/

It addresses Ricardo's review comments and fixes an issue with intel_pstate
operation mode changes that would cause it to attempt to enable hybrid CPU
capacity scaling after it has been already enabled during initialization.

The most visible difference with respect to the previous version is that
patch [1/3] has been dropped because it is not needed any more after using
the observation that sched_clear_itmt_support() would cause sched domains
to be rebuilt.

Other than this, there are cosmetic differences in patch [1/2] (previously [2/3])
and the new code in intel_pstate_register_driver() in patch [2/2] (previously [3/3])
has been squashed into hybrid_init_cpu_scaling() which now checks whether or
not to enable hybrid CPU capacity scaling (as it may have been enabled already).

This series is available from the following git branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=intel_pstate-testing

(with an extra debug commit on top).

The original cover letter quoted below still applies:

The purpose of this series is to provide the scheduler with asymmetric CPU
capacity information on x86 hybrid systems based on Intel hardware.

The asymmetric CPU capacity information is important on hybrid systems as it
allows utilization to be computed for tasks in a consistent way across all
CPUs in the system, regardless of their capacity.  This, in turn, allows
the schedutil cpufreq governor to set CPU performance levels consistently
in the cases when tasks migrate between CPUs of different capacities.  It
should also help to improve task placement and load balancing decisions on
hybrid systems and it is key for anything along the lines of EAS.

The information in question comes from the MSR_HWP_CAPABILITIES register and
is provided to the scheduler by the intel_pstate driver, as per the changelog
of patch [3/3].  Patch [2/3] introduces the arch infrastructure needed for
that (in the form of a per-CPU capacity variable) and patch [1/3] is a
preliminary code adjustment.

This is based on an RFC posted previously

https://lore.kernel.org/linux-pm/7663799.EvYhyI6sBW@kreacher/

but differs from it quite a bit (except for the first patch).  The most
significant difference is based on the observation that frequency-
invariance needs to adjusted to the capacity scaling on hybrid systems
for the complete scale-invariance to work as expected.

Thank you!




