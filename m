Return-Path: <linux-pm+bounces-21349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36861A27CF7
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 21:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E364F18859F4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2664C219E98;
	Tue,  4 Feb 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="C9W1B5Kk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12245206F16;
	Tue,  4 Feb 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702710; cv=none; b=oR2lu1dAQ0rf45zyczqbqnBAlAKsuAfI79UcadnO39ziqXj7P9XMylVXhssnZP7GcElSfpYmKyOWFGQ7VOXNEwTYrnzB83kbp5oLO1rMiAIroZKxkO1TPg1vM+qwSyI1lcaYzWrWEHTlxYXUuTGao0gXPHLDtjhv9kqiubU++iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702710; c=relaxed/simple;
	bh=bd49s9n1RiJ/STXaReO0I+d0CBUSCzhNE2UcYmxqo78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etLv2ifeuK1YlTGP3C606on8DnIvFUcA0sNJ3o6Awl1d5N7nDhGIXSAUEZeA9jOVBFuX0GZlKu196bMo6gtHbZMw2Xdk2MjMoWDKcQJLX65gB5H8PHIZjCNizxe4Kb19wZR1uGuKrkegVUekuVl2oqOxck/BoJyrTGm2xGIZSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=C9W1B5Kk; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d802d552b2d24223; Tue, 4 Feb 2025 21:58:19 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C579283011A;
	Tue,  4 Feb 2025 21:58:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738702699;
	bh=bd49s9n1RiJ/STXaReO0I+d0CBUSCzhNE2UcYmxqo78=;
	h=From:Subject:Date;
	b=C9W1B5KkH1ubCDrnOTnJSDFOseA8fmhbtK+JWCJPZkfbrEGTVS26bFGKtkwCFK/Xl
	 dVYH4aDNet/jRd2HZYW4rduW1dCOBSLWzhppx+7ef1yj9Tw5h7LHkkk3Yu7AXN0atV
	 rm4kPxn48aER2u11QQVCLd979OnuGgGh1evigJGX/ScDoJn5yGz8ZPZcKBp8ZqaohM
	 U6tCsEk/EMLaJKrrvmrZwYsEl8b4NSwu+aN/9WcSZy1H224rSNcSZzTTz0hxJNO+7P
	 F9TAgzTMmWBUxWSwM+qexbB9nW90OVqsGNIBHvvZXzSJIdI2lDGckHa/7wsK1VJl6k
	 5oFTEvwU/AXaw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
Date: Tue, 04 Feb 2025 21:58:18 +0100
Message-ID: <12630185.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegudfhvdfgieehudfhjeefuedtledvfeeileeikeejudeugfekiedvudfgudeuheenucffohhmrghinhepshhpvggtrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtoheprghrthg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It has been observed that the recent teo governor update which concluded
with commit 16c8d7586c19 ("cpuidle: teo: Skip sleep length computation
for low latency constraints") caused the max-jOPS score of the SPECjbb
2015 benchmark [1] on Intel Granite Rapids to decrease by around 1.4%.
While it may be argued that this is not a significant increase, the
previous score can be restored by tweaking the inequality used by teo
to decide whether or not to preselect the deepest enabled idle state.
That change also causes the critical-jOPS score of SPECjbb to increase
by around 2%.

Namely, the likelihood of selecting the deepest enabled idle state in
teo on the platform in question has increased after commit 13ed5c4a6d9c
("cpuidle: teo: Skip getting the sleep length if wakeups are very
frequent") because some timer wakeups were previously counted as non-
timer ones and they were effectively added to the left-hand side of the
inequality deciding whether or not to preselect the deepest idle state.

Many of them are now (accurately) counted as timer wakeups, so the left-
hand side of that inequality is now effectively smaller in some cases,
especially when timer wakeups often occur in the range below the target
residency of the deepest enabled idle state and idle states with target
residencies below CPUIDLE_FLAG_POLLING are often selected, but the
majority of recent idle intervals are still above that value most of
the time.  As a result, the deepest enabled idle state may be selected
more often than it used to be selected in some cases.

To counter that effect, add the sum of the hits metric for all of the
idle states below the candidate one (which is the deepest enabled idle
state at that point) to the left-hand side of the inequality mentioned
above.  This will cause it to be more balanced because, in principle,
putting both timer and non-timer wakeups on both sides of it is more
consistent than only taking into account the timer wakeups in the range
above the target residency of the deepest enabled idle state.

Link: https://www.spec.org/jbb2015/
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -349,13 +349,13 @@
 	}
 
 	/*
-	 * If the sum of the intercepts metric for all of the idle states
-	 * shallower than the current candidate one (idx) is greater than the
+	 * If the sum of the intercepts and hits metric for all of the idle
+	 * states below the current candidate one (idx) is greater than the
 	 * sum of the intercepts and hits metrics for the candidate state and
 	 * all of the deeper states, a shallower idle state is likely to be a
 	 * better choice.
 	 */
-	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
+	if (2 * (idx_intercept_sum + idx_hit_sum) > cpu_data->total) {
 		int first_suitable_idx = idx;
 
 		/*




