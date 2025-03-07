Return-Path: <linux-pm+bounces-23647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3492FA57247
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 20:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDFA189A08A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE9253330;
	Fri,  7 Mar 2025 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nUstl2fO"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7424FC1F;
	Fri,  7 Mar 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376570; cv=none; b=Y51Y8S4hHEGRDWqnCIsnieduoPg1kuioa2+Gs9enQCqkKAg0p8OIna4cci6J8NTmHveyi9hgvnlKtvQArMXdbCM9A+UF21npTXSOIKGiQxnLrDglh+bKbg4uXBVYWH3OabRC/JZipufdayWDL6RSRRJgBIMaibH47Hl5rKXczxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376570; c=relaxed/simple;
	bh=bntwyWnrMdWDSe4vnVdSyZBMiRO/ZRUZNY4KsjH/rsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gS4XwikVhhpH6CqUOniwndyfBEFsq81mUgiwERUNUVn8UA+7jAJb5gun7bVTHzGFhSPtGIU86uS7cCmQSfwQZ0sfNt9nxtH5DmOiCvmP5xIQfTxCQNlZpoJKoPWFTLH5qJqRJjlrKFORC5siMCbFoOmj4yqfvvFpbwd7hhkgVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nUstl2fO; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id bd548913f5f0793d; Fri, 7 Mar 2025 20:42:45 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 581269A0BFB;
	Fri,  7 Mar 2025 20:42:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741376565;
	bh=bntwyWnrMdWDSe4vnVdSyZBMiRO/ZRUZNY4KsjH/rsE=;
	h=From:Subject:Date;
	b=nUstl2fOjsDJTZ3H1jC9w8CqcwhArq6Q7ElmCXlnurofh79vYmjWSCpuXf+Cl3eyE
	 HtsbNujM4Vd4zy47Oagr9/5f89lDF98oOtOqubO0vrBxtbv6uoB+wTfYGDimO950rk
	 84FrT2zAVPl8IaYSdMAH6vNKhUAH28SFl5xk1KajlmFMVCvyAtxtsRaqx7sKEG6ud3
	 lTq4TH941JmYHRFo4DLaYd52gPYAgDRHT9F3uGi02YTuC1eqMMI+ifKq2y8mJo9als
	 /vI5MRI3V7dnxVvQqt+KOHbGztaLt1N2wdB99wbSwRxmg2nX+vtG8qOPyyeITqRqZG
	 5r+O52ybKq21A==
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
 [RFC][PATCH v0.3 0/6] cpufreq: intel_pstate: Enable EAS on hybrid platforms
 without SMT - alternative
Date: Fri, 07 Mar 2025 20:12:11 +0100
Message-ID: <22640172.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

Hi Everyone,

This is a new take on the "EAS for intel_pstate" work:

https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/

with refreshed preparatory patches and a revised energy model design.

The following paragraph from the original cover letter still applies:

"The underlying observation is that on the platforms targeted by these changes,
Lunar Lake at the time of this writing, the "small" CPUs (E-cores), when run at
the same performance level, are always more energy-efficient than the "big" or
"performance" CPUs (P-cores).  This means that, regardless of the scale-
invariant utilization of a task, as long as there is enough spare capacity on
E-cores, the relative cost of running it there is always lower."

However, this time perf domains are registered per CPU and in addition to the
primary cost component, which is related to the CPU type, there is a small
component proportional to performance whose role is to help balance the load
between CPUs of the same type.

This is done to avoid migrating tasks too much between CPUs of the same type,
especially between E-cores, which has been observed in tests of the previous
iteration of this work.

The expected effect is still that the CPUs of the "low-cost" type will be
preferred so long as there is enough spare capacity on any of them.

The first two patches in the series rearrange cpufreq checks related to EAS so
that sched_is_eas_possible() doesn't have to access cpufreq internals directly
and patch [3/6] changes those checks to also allow EAS to be used with cpufreq
drivers that implement internal governors (like intel_pstate).

Patches [4-5/6] deal with the Energy Model code.  Patch [4/6] simply rearranges
it so as to allow the next patch to be simpler and patch [5/6] adds a function
that's used in the last patch.

Patch [6/6] is the actual intel_pstate modification which now is significantly
simpler than before because it doesn't need to track the type of each CPU
directly in order to put into the right perf domain.

Please refer to the individual patch changelogs for details.

For easier access, the series is available on the experimental/intel_pstate/eas-take2
branch in linux-pm.git:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
experimental/intel_pstate/eas-take2

or

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate/eas-take2

Thanks!




