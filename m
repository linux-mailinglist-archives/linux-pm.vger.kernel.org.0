Return-Path: <linux-pm+bounces-18254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E39DEAFF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D5B214BE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC31A0BE1;
	Fri, 29 Nov 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Zai49uL5"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC901547FF;
	Fri, 29 Nov 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897713; cv=none; b=KtvYWwgEChj0HjHVXsu5eEXJtsYxBHHv0FAZciXpMKbWDUJvWAwB4cq/tk7QMt+IAe9Yy15hlE0o91nWdOrM7P9B2RjcRyzKuECY2CZ/JORz8jOyGPU2dhhCnRnHWDWxDCmx39ItHENwfE5SIBWx1G9bhOluWAZyiRK2L6zl9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897713; c=relaxed/simple;
	bh=XX0C2Et9q0+fKcYAwfuxgwl2sGZuOMtPTUd6hhHkFNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLHnFCr0GxCDYk4sjatIZ2Hs2xlYAjfCc7PeyY1Q+7uoQMZRx/pTxY9OFT7srRTVbIhdzwhbGSP7zRDVdCSXuAXtxEeeZx+VXwqtJfre6//vrS4gKCkY/L8ZWjElMFj6uVOvSFJWZbmL6SPRcbdHiq+RWFJLNSACiGDIETSmTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Zai49uL5; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 6c5d0463aa7c4814; Fri, 29 Nov 2024 17:28:28 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7827CA47B8B;
	Fri, 29 Nov 2024 17:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732897708;
	bh=XX0C2Et9q0+fKcYAwfuxgwl2sGZuOMtPTUd6hhHkFNM=;
	h=From:Subject:Date;
	b=Zai49uL5kavDQ1GzqDEGlTZiuaHXweevroflx4QEtTgc+OcG3PiBxyxnTT2DNwb4m
	 R1hZIGPMrY1TUckWGrFwXH13VDw7I7XBacmRezX2XC/eLyI/CiI8fIgmVEoAQEF++6
	 60xEaNjZcJfQyZ0lpyc5znwxudThusbqfKeSNNL3LbtDJhqYBGemp8F0sh2CHhprQN
	 kZXuTu7bK3oy4TFTyzXPqGaOyMi8Ca6bN7M30etyg0aL0NRjEAkmQCPX0NUFjun4m1
	 /V8ebXRX8jufZb/Y83B7Q3YfDLsyCDUloTVW5c7gZQup4CRhrmnApE8t+VjkX6/XDV
	 Boa0Q54i5lgww==
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
 [RFC][PATCH v021 0/9] cpufreq: intel_pstate: Enable EAS on hybrid platforms
 without SMT
Date: Fri, 29 Nov 2024 16:55:12 +0100
Message-ID: <5861970.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

Hi Everyone,

This is a new iteration of the "EAS for intel_pstate" work:

https://lore.kernel.org/linux-pm/3607404.iIbC2pHGDl@rjwysocki.net/

It contains a few new patches and almost all of the patches sent previously
have been updated.

The following paragraph from the original cover letter still applies:

"The underlying observation is that on the platforms targeted by these changes,
Lunar Lake at the time of this writing, the "small" CPUs (E-cores), when run at
the same performance level, are always more energy-efficient than the "big" or
"performance" CPUs (P-cores).  This means that, regardless of the scale-
invariant utilization of a task, as long as there is enough spare capacity on
E-cores, the relative cost of running it there is always lower."

Thus the idea is still to register a perf domain per CPU type, but this time
there may be more than just two of them because of the first patch.

The states table in each of these perf domains is still one-element and that
element only contains the cost value, but this time the costs are computed
and not prescribed (see the last patch).  Nevertheless, the expected effect
is still that the perf domains (or CPU types) with lower cost values will
be preferred so long as there is enough spare capacity in them.

The first two patches are not really RFC, but they are included here because
patches [8-9/9] depend on patch [1/9].  They will be resent next week as
non-RFC 6.14-candidate material.

The difference made by them is significant because it is now not known in
advance how many CPU types will be there and the cost values for each of
them cannot be prescribed.

Patch [3/9] is also a change that I'd like to make regardless of what
happens to the rest of the series because it effectively moves EM code
from the schedutil governor to EM where it belongs.  Of course, it is also
depended on by patch [9/9].

Patch [4/9] differs from its previous version,

https://lore.kernel.org/linux-pm/1889415.atdPhlSkOF@rjwysocki.net/

because gov is NULL not only when it is not used at all, but also during the
cpufreq policy init and exit, so the check in the patch had to be adjusted
to match the former case only.  [As a side note, I don't think that the code
modified by patch [4/9] belongs to sched/topology as it messes around the
cpufreq internals.  At least, it should be moved to cpufreq and called by
sched_is_eas_possible(), but I'm also not convinced that it is necessary
at all.  This is not directly related to the $subject series, though.]

Patch [5/9] adds a new function needed by patch [9/9] and it is the same as
its previous version:

https://lore.kernel.org/linux-pm/2223963.Mh6RI2rZIc@rjwysocki.net/

Patch [6/9] is almost the same as its previous version:

https://lore.kernel.org/linux-pm/1821040.VLH7GnMWUR@rjwysocki.net/

but its changelog has been expanded a bit as suggested by Dietmar.  It
simply rearranges the EM code without changing its functionality, so the
next patch looks more straightforward.

Patch [7/9] is a somewhat updated counterpart of

https://lore.kernel.org/linux-pm/2017201.usQuhbGJ8B@rjwysocki.net/

It still changes the EM code to allow a perf domains with one-element states
table to be registered without providing the :active_power() callback (which
is then done in the last patch), but it is somewhat simpler.  It also
contains some discussion regarding the requirement that the capacity of
all CPUs in a perf domain must be the same.  In a short summary, I'm not
convinced that it is actually valid.

Patches [8-9/9] modify intel_pstate.  The first one is preparatory, but it
is useful for explaining the basic concept, which is "hybrid domains" that
each contain CPUs of the same type.

The last patch is just the registration of EM perf domains (one for each hybrid
domain), expanding them when needed and rebuilding sched domains in some corner
cases.  It also contains some discussion that doesn't technically belong to the
changelog, but is useful for explaining the background for some decisions.

Please refer to the individual patch changelogs for details.

For easier access, the series is available on the experimental/intel_ostate
branch in linux-pm.git:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate

Thanks!

or

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate

Thanks!




