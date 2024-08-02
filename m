Return-Path: <linux-pm+bounces-11848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD87E946334
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F581F23265
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30D1ABECE;
	Fri,  2 Aug 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XVDAqyVx"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE51ABEA9;
	Fri,  2 Aug 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623048; cv=none; b=T6XOnkIayLvw6nO3HFgdHHH4Xmd4/dQc3ia2amNq0UCklfovQyG7p32M7G+6oCn872+3ic0b6tsp1o3h92TqFXIkHkfy54Whryp2ubK5+LAR/FzCQTTgjsNHO8VNkBMyl5h+Fvk3wiNFRKbxnFvzargMX3Nw1GQjRMdR54wevPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623048; c=relaxed/simple;
	bh=SGbiGlnwzmqmhpPgTHVszf9CDLsuxBGtN97yKHdTmEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sc0SKBiGtLT1pj42cFpDqz5kl3yaSqQYp5dfDxwF8KDm1cIzHCb6k3vKRs05DEk+z7vGNsyPD8uksKHIH02Ri1IYWcrX4YQU++ylDN7jBDePl88kbRReOf5e3CkJd30GR9DOozNvajIKHLi+6FvKXdIXZ+tge9neYewNO8H6pt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XVDAqyVx reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 982c33be547c8fd8; Fri, 2 Aug 2024 20:24:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EB00A73B540;
	Fri,  2 Aug 2024 20:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722623044;
	bh=SGbiGlnwzmqmhpPgTHVszf9CDLsuxBGtN97yKHdTmEs=;
	h=From:To:Cc:Subject:Date;
	b=XVDAqyVxpDhmEQnCtQixsWXc5ZXI24EeOsOkjCzK4m4EWhZg9CPpkBRHzR6T3t+sc
	 YMtI+R1noyGp6vMVgsSAifsN1JmfxaZbth8bZFSM9e6jgHoTAYhOurimouw5Wtzbyx
	 QPOGAuN3KsfVeZnvXg6XZdFu0Mjk1SZaxsa3Sf54gndZhCTuGA1OqsuKamTlVcf+xI
	 szWyXAGEZNyoVZYceAEZwI5UVxt9APSqYdEi/X5IweI6+6xhWydb7Hyssn+W3XuYZm
	 0tbdjaXadp3wFcWOWEA+UsYicUDYfSEaZPPs/6JJRdX4FgtRecBgd0o4b9vMvD76Wn
	 El/9j1VK0HloQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 [PATCH v1 0/3] x86 / intel_pstate: Set asymmetric CPU capacity on hybrid
 systems
Date: Fri, 02 Aug 2024 20:15:10 +0200
Message-ID: <4908113.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrkedtgdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgv
 lhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=30 Fuz1=30 Fuz2=30

Hi Everyone,

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




