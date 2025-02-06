Return-Path: <linux-pm+bounces-21487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B754A2AB68
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F13F16B4C5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7992475D3;
	Thu,  6 Feb 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="es0YU7PC"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A521C9E1;
	Thu,  6 Feb 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852176; cv=none; b=aBsiT0n+FAJ9Gaig8JRrWV2yeT/awnxgOJlNO085YPnSFs2RlAg+BDjT1PQ3w4vZ8XT4BoRLgvSYLbpFNOvNzr7W/qA1B0u3ZZCpB7SCJwRRcJc0qt2fB3wMMJv2B5z5d6zkRR9uaFP3qmW8OHiMqj4+jJ0gSbUSDNXOd1MlTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852176; c=relaxed/simple;
	bh=ErWXixg523GBpVutAwglAFanD0ZU/6hOsgeYkUyeJBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+gcrnKNVRAoG5NX3FM0av+sImFiVN0LTzcWi+1iVPe1ZvhK/7QEOR/9zgqfMb2B0njT9sCvpXhOVCrwG4AD0Oll7fpIo6Ipd6ofw6ANKVwOUwrv0tq6e8q1WT4nDTaZGBjaUpXnYqeZz0Bmf3NBimMRYpY6bp8bc0HUvIMwkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=es0YU7PC; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id c532acd172b77253; Thu, 6 Feb 2025 15:29:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 028836BA970;
	Thu,  6 Feb 2025 15:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738852166;
	bh=ErWXixg523GBpVutAwglAFanD0ZU/6hOsgeYkUyeJBk=;
	h=From:Subject:Date;
	b=es0YU7PCzTwaqBv67FTPblqBOgY9joZxQI9Ae5YTIbV6kQ1U3jyDtFUCqWQIY5V1d
	 QKxyj/CvsCdP2uqzIt/9EXC03y+2bE9Cv/sIksNdRgnF2Gr95OTySPb/jLaemWZtbD
	 e/R6eFHEC8n4UdE6OZriJkkRRb7kLlX3cFfFAcTnfCS8/sR71yStUPT/jPuOq9F6Vv
	 NHvWNEYMSdh4IRqKCYRlK70G6nwDWfe3W4Cp/N2GX6IkT3jKD3DPZUUC2s2Ipl+Ks7
	 U7Ke+CRvHkcV25RzFIJjLSDPhLHF9K71UKs86k+CTYFCGY9TJGiyPFX20vHksQ3RN1
	 7722br6kch0YA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful information when
 processing recent idle intervals
Date: Thu, 06 Feb 2025 15:21:58 +0100
Message-ID: <1916668.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevkefffeehgfethfffteekvddvtdduueetvdfhjedukeehuedugfeileevueekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsphgvtgdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdhlohgvhhhlvgesrghrmhdrtghomhd
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This work had been triggered by a report that commit 0611a640e60a ("eventpoll:
prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metric of
the SPECjbb 2015 benchmark [1] to drop by around 50% even though it generally
reduced kernel overhead.  Indeed, it was found during further investigation
that the total interrupt rate while running the SPECjbb workload had fallen as
a result of that commit by 55% and the local timer interrupt rate had fallen by
almost 80%.

That turned out to cause the menu cpuidle governor to select the deepest idle
state supplied by the cpuidle driver (intel_idle) much more often which added
significantly more idle state latency to the workload and that led to the
decrease of the critical-jOPS score.

Interestingly enough, this problem was not visible when the teo cpuidle
governor was used instead of menu, so it appeared to be specific to the
latter.  CPU wakeup event statistics collected while running the workload
indicated that the menu governor was effectively ignoring non-timer wakeup
information and all of its idle state selection decisions appeared to be
based on timer wakeups only.  Thus, it appeared that the reduction of the
local timer interrupt rate caused the governor to predict a idle duration
much more often while running the workload and the deepest idle state was
selected significantly more often as a result of that.

A subsequent inspection of the get_typical_interval() function in the menu
governor indicated that it might return UINT_MAX too often which then caused
the governor's decisions to be based entirely on information related to timers.

Generally speaking, UINT_MAX is returned by get_typical_interval() if it
cannot make a prediction based on the most recent idle intervals data with
sufficiently high confidence, but at least in some cases this means that
useful information is not taken into account at all which may lead to
significant idle state selection mistakes.  Moreover, this is not really
unlikely to happen.

One issue with get_typical_interval() is that, when it eliminates outliers from
the sample set in an attempt to reduce the standard deviation (and so improve
the prediction confidence), it does that by dropping high-end samples only,
while samples at the low end of the set are retained.  However, the samples
at the low end very well may be the outliers and they should be eliminated
from the sample set instead of the high-end samples.  Accordingly, the
likelihood of making a meaningful idle duration prediction can be improved
by making it also eliminate low-end samples if they are farther from the
average than high-end samples.  This is done in patch [4/5].

Another issue is that get_typical_interval() gives up after eliminating 1/4
of the samples if the standard deviation is still not as low as desired (within
1/6 of the average or within 20 us if the average is close to 0), but the
remaining samples in the set still represent useful information at that point
and discarding them altogether may lead to suboptimal idle state selection.

For instance, the largest idle duration value in the get_typical_interval()
data set is the maximum idle duration observed recently and it is likely that
the upcoming idle duration will not exceed it.  Therefore, in the absence of
a better choice, this value can be used as an upper bound on the target
residency of the idle state to select.  Patch [5/5] works along these lines,
but it takes the maximum data point remaining after the elimination of
outliers.

The first two patches in the series are straightforward cleanups (in fact,
the first patch is kind of reversed by patch [4/5], but it is there because
it can be applied without the latter) and patch [3/5] is a cosmetic change
made in preparation for the subsequent ones.

This series turns out to restore the SPECjbb critical-jOPS metric on affected
systems to the level from before commit 0611a640e60a and it also happens to
increase its max-jOPS metric by around 3%.

For easier reference/testing it is present in the git branch at

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/menu

based on the cpuidle material that went into 6.14-rc1.

If possible, please let me know if it works for you.

Thanks!


[1] Link: https://www.spec.org/jbb2015/




