Return-Path: <linux-pm+bounces-12083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731194EE8E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397CE1C219A4
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB217DE2D;
	Mon, 12 Aug 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jGZXVNCJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B717C9E7;
	Mon, 12 Aug 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470287; cv=none; b=SHvTrAX+OeFrcXuQpCIUhvBRN7bovsBOwkOlQVxEx63y5SIOwdVhRNVD2jrwh4xDpVwMWH2XWITsb8dn0KGFRJQgXFd2ApYUSrUNeXMpcaVCSKXHHpl/unfMRnjsc2EvARk+fPD5bdpgn6pTuyY0epqjPBUaH+bnJRnSAIhdczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470287; c=relaxed/simple;
	bh=T5wA5iirf17IPAoaIfmsuzglI86EDARxKtzzujW2xm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E0ojGcYhojqHRxOiNHetqViQ28+V5ZwosW68+a2YWdo1C501N1z6IX0BA0WZIfZHhZiAnNrASoQ3m7Jcw8yOuRir6Lutga0oBWRTPbwN71xBL+6ohYXqoImm1b0r/Gl5BnUdCU1BfkCGM5Y1vkNF7xdQu49c38kjtWFIGzpHiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jGZXVNCJ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9e7af02300961f45; Mon, 12 Aug 2024 14:44:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 127AE6F0D80;
	Mon, 12 Aug 2024 14:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723466684;
	bh=T5wA5iirf17IPAoaIfmsuzglI86EDARxKtzzujW2xm4=;
	h=From:Subject:Date;
	b=jGZXVNCJI4cPaCY0Q/4A67D92ZIjqrACr1wCCWdGougYdcivR20G0u1z3LOmdU7p7
	 VnhVhYhXAGng5c7vPaA/PPF6MhxUTJklT9jdOzRdN2tQMSh2CoajwLd5k0jYjdA4sp
	 gI/4GFf2KppVSuCSwhFRw1n29n9RiXf3r7GtncVEVXOVFfy/udG1CDIUSUPIonugho
	 26n+NgKCZq2jkn10Vn+30Td+bnUfYdqIBPRC3KC0wjHkvi4RiRksaZtckN7kodavBh
	 Zu0S4JIeFwjyyYaC3PW5Vo+VeP3hPbrC0B07xelEdbK645bV1C1r/TMD6cfy/l0XbR
	 cEOQqfX0Lkbuw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 [PATCH v2 0/3] x86 / intel_pstate: Set asymmetric CPU capacity on hybrid
 systems
Date: Mon, 12 Aug 2024 14:35:52 +0200
Message-ID: <4941491.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphht
 thhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/4908113.GXAFRqVoOG@rjwysocki.net/

which addresses a few issues that have transpired since it was posted.

The most visible difference is that hybrid CPU capacity scaling is now
allowed to be used when frequency-invariance is not functional which
simplifies things and gets rid of a couple of corner cases.

The changes in this series are available from this git branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=intel_pstate-testing

(with an extra debug commit on top).  Ricardo has tested them and reports
that they cause task utilization to be mostly scale-invariant, as expected.

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




