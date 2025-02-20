Return-Path: <linux-pm+bounces-22581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C60A3E5A6
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 21:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6A7A9232
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2E26388E;
	Thu, 20 Feb 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="d2zKj+ZE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE032212B02;
	Thu, 20 Feb 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082397; cv=none; b=M0V8Vp2M3joCQKydGeSlCgMA9SVy8nHF1fPsB0C6UOhhGABfquE07S2aesikhw19Dr9dvMMt99aCQBIDIMV+OGaQOcmO8PiFPd8HvLIwqi0u5oPVHkSRDT5Z/K9XIyXKvDzoFdsK3g0UPCpdZMFHsN2BEg3GtjZ5YjECA7gumoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082397; c=relaxed/simple;
	bh=rPMZsZQ/f5XM8ZG+qBG6oki5T3WjncRONAEhW1vp4KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PYh8LUucvDUrR9F7UeLWLsw9i0XIxoNIiVKeVeAO6r6vfJo2qLM/eVjmncbIw1uc1gQ2oqF6IpJA2QaM+IhcGYNf4/J/9cDyyvYKjucNaiyPnswxBesZUdMTiEv7fHL6q4mHAvL30od7I1Cogd1h4tr8u7Dg0ZjUFGb9H1fbJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=d2zKj+ZE; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id eb3119b8c62ee698; Thu, 20 Feb 2025 21:13:12 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 635267F624E;
	Thu, 20 Feb 2025 21:13:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740082392;
	bh=rPMZsZQ/f5XM8ZG+qBG6oki5T3WjncRONAEhW1vp4KA=;
	h=From:Subject:Date;
	b=d2zKj+ZEolohJ5yuwPueQpkrA3kuR+o43CIDd4pDGvVRT6ORjmpSIQJijPn0RlsMD
	 YYMBvyh1EwCC31rwBu/DQ0rMK+msVfeFq/oNYHsDO85Wtj5hM9qnHKxTNfUCSWxaUO
	 QKxXLE64S+CesExXmpgtpG8ud87VP87/oP+d5qHhmcE9mXaLYZOKRmmh0D1C2Siwvf
	 0YX/e/WR4poTwKC/JiA9jcS1tDvZB4sVlAt79kuLyhZmcX2O/pWOX+k7QkSfTt0tkO
	 KAUrwCSU+ct7+eJPIEp7MHqbYIeVfeKSyDlgU5/GZPopiyhGTC0GJSwgOkQi1nDFi0
	 c2Z1SD3mcVpiw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v1] cpuidle: menu: Update documentation after previous changes
Date: Thu, 20 Feb 2025 21:13:12 +0100
Message-ID: <4998484.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikedthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdhlohgvhhhlvgesrghrmhdrtghomhdprhgtphhtthhopegrrhhtvghmrdgsihhthihuthhskhhihieslhhinhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The documentaion of the menu cpuidle governor needs to be updated
to match the code bevavior after some changes made recently.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst |   27 ++++++++++++++++-----------
 drivers/cpuidle/governors/menu.c         |   29 ++++++++++-------------------
 2 files changed, 26 insertions(+), 30 deletions(-)

--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -275,20 +275,25 @@
 and variance of them.  If the variance is small (smaller than 400 square
 milliseconds) or it is small relative to the average (the average is greater
 that 6 times the standard deviation), the average is regarded as the "typical
-interval" value.  Otherwise, the longest of the saved observed idle duration
+interval" value.  Otherwise, either the longest or the shortest (depending on
+which one is farther from the average) of the saved observed idle duration
 values is discarded and the computation is repeated for the remaining ones.
+
 Again, if the variance of them is small (in the above sense), the average is
 taken as the "typical interval" value and so on, until either the "typical
-interval" is determined or too many data points are disregarded, in which case
-the "typical interval" is assumed to equal "infinity" (the maximum unsigned
-integer value).
+interval" is determined or too many data points are disregarded.  In the latter
+case, if the size of the set of data points still under consideration is
+sufficiently large, the next idle duration is not likely to be above the largest
+idle duration value still in that set, so that value is taken as the predicted
+next idle duration.  Finally, if the set of data points still under
+consideration is too small, no prediction is made.
 
-If the "typical interval" computed this way is long enough, the governor obtains
-the time until the closest timer event with the assumption that the scheduler
-tick will be stopped.  That time, referred to as the *sleep length* in what follows,
-is the upper bound on the time before the next CPU wakeup.  It is used to determine
-the sleep length range, which in turn is needed to get the sleep length correction
-factor.
+If the preliminary prediction of the next idle duration computed this way is
+long enough, the governor obtains the time until the closest timer event with
+the assumption that the scheduler tick will be stopped.  That time, referred to
+as the *sleep length* in what follows, is the upper bound on the time before the
+next CPU wakeup.  It is used to determine the sleep length range, which in turn
+is needed to get the sleep length correction factor.
 
 The ``menu`` governor maintains an array containing several correction factor
 values that correspond to different sleep length ranges organized so that each
@@ -302,7 +307,7 @@
 The sleep length is multiplied by the correction factor for the range that it
 falls into to obtain an approximation of the predicted idle duration that is
 compared to the "typical interval" determined previously and the minimum of
-the two is taken as the idle duration prediction.
+the two is taken as the final idle duration prediction.
 
 If the "typical interval" value is small, which means that the CPU is likely
 to be woken up soon enough, the sleep length computation is skipped as it may
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -41,7 +41,7 @@
  * the  C state is required to actually break even on this cost. CPUIDLE
  * provides us this duration in the "target_residency" field. So all that we
  * need is a good prediction of how long we'll be idle. Like the traditional
- * menu governor, we start with the actual known "next timer event" time.
+ * menu governor, we take the actual known "next timer event" time.
  *
  * Since there are other source of wakeups (interrupts for example) than
  * the next timer event, this estimation is rather optimistic. To get a
@@ -50,30 +50,21 @@
  * duration always was 50% of the next timer tick, the correction factor will
  * be 0.5.
  *
- * menu uses a running average for this correction factor, however it uses a
- * set of factors, not just a single factor. This stems from the realization
- * that the ratio is dependent on the order of magnitude of the expected
- * duration; if we expect 500 milliseconds of idle time the likelihood of
- * getting an interrupt very early is much higher than if we expect 50 micro
- * seconds of idle time. A second independent factor that has big impact on
- * the actual factor is if there is (disk) IO outstanding or not.
- * (as a special twist, we consider every sleep longer than 50 milliseconds
- * as perfect; there are no power gains for sleeping longer than this)
- *
- * For these two reasons we keep an array of 12 independent factors, that gets
- * indexed based on the magnitude of the expected duration as well as the
- * "is IO outstanding" property.
+ * menu uses a running average for this correction factor, but it uses a set of
+ * factors, not just a single factor. This stems from the realization that the
+ * ratio is dependent on the order of magnitude of the expected duration; if we
+ * expect 500 milliseconds of idle time the likelihood of getting an interrupt
+ * very early is much higher than if we expect 50 micro seconds of idle time.
+ * For this reason, menu keeps an array of 6 independent factors, that gets
+ * indexed based on the magnitude of the expected duration.
  *
  * Repeatable-interval-detector
  * ----------------------------
  * There are some cases where "next timer" is a completely unusable predictor:
  * Those cases where the interval is fixed, for example due to hardware
- * interrupt mitigation, but also due to fixed transfer rate devices such as
- * mice.
+ * interrupt mitigation, but also due to fixed transfer rate devices like mice.
  * For this, we use a different predictor: We track the duration of the last 8
- * intervals and if the stand deviation of these 8 intervals is below a
- * threshold value, we use the average of these intervals as prediction.
- *
+ * intervals and use them to estimate the duration of the next one.
  */
 
 struct menu_device {




