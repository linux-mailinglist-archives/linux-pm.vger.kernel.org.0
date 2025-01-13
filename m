Return-Path: <linux-pm+bounces-20373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7EA0C0CE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D023166EB2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679361CEAD0;
	Mon, 13 Jan 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lx5X7hyR"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1B1C5F0F;
	Mon, 13 Jan 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794347; cv=none; b=XvHP8nfeYRjRCaSKo6P4OxdRO7chRB11VgKiCug5P3QSwHp1luO17AAFeUfPZr/x5ZEeHOy3mD1EGaBgW1YuzpX36nfTzJbnM4UiUD/Ub/ZL79ZFT9ZvB1EyQK6smPxyd1KyWOMYwMfRob/2S6G8XVtCPzRa1+fBcNOyKGJQsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794347; c=relaxed/simple;
	bh=RleYI7ZsSvobMDs6vsPF52tTFOhcxgouKqZS05O2pUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7WAUbGUWxLZVxk+m80hz4eSshci9ce47ennABybty4LUqEAkFHq6sICZxbwhBdzPaMbeFxLbv9fMRFWrXTV3cyHl+rMf1xoxvbYjCVpRJfu3yfmhugnVuuyIGM1kQHiKzOxjDUqbrEINu4m3pGV0q5k8V99bPtIOInhYc7mIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lx5X7hyR; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id deef81434cd9de68; Mon, 13 Jan 2025 19:52:17 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A8FAE8E0A24;
	Mon, 13 Jan 2025 19:52:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794337;
	bh=RleYI7ZsSvobMDs6vsPF52tTFOhcxgouKqZS05O2pUQ=;
	h=From:Subject:Date;
	b=lx5X7hyR38FOWKZedFJ0ttgPnN5vcgCH8whewU8yIdWKZoIi6rXN9U1uT0lRLTna6
	 vDFLVxxuT2nDrOBdxjQHFNSaDNpUQgbAn8RbBrruF6v4qrldcNYi2/DJbTwSKERWI3
	 ApglH9wKruYo+qSFHBzAKZc3Kew0wRbg5D5gDoQYuLN27UAt4Z0l238r5uHzY5Zgcd
	 rMYiOM1XYXOi0rKLkxO/z0ei9HMZGuxULdY+85vuWk0AfDNIKC0XPYLLp5LM51zeVb
	 lfwBcPrQUNWZXpWHvRvosylU5Dy/vTDZRuL5ycYHMgWXkCa7VS00RVE8JLHQSVFeTS
	 yv76k+oUJKmOQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 5/9] cpuidle: teo: Clarify two code comments
Date: Mon, 13 Jan 2025 19:41:55 +0100
Message-ID: <8472971.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <6116275.lOV4Wx5bFT@rjwysocki.net>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdhlohgvhhhlvgesrghrmhdrtghomhdprhgtphhtthhopegrrhhtvghmrdgsihhthihuthhskhhihieslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rewrite two code comments suposed to explain its behavior that are too
concise or not sufficiently clear.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -154,9 +154,10 @@
 
 	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
 		/*
-		 * One of the safety nets has triggered or the wakeup was close
-		 * enough to the closest timer event expected at the idle state
-		 * selection time to be discarded.
+		 * This causes the wakeup to be counted as a hit regardless of
+		 * regardless of the real idle duration which doesn't need to be
+		 * computed because the wakeup has been close enough to an
+		 * anticipated timer.
 		 */
 		measured_ns = U64_MAX;
 	} else {
@@ -302,8 +303,13 @@
 
 	cpu_data->time_span_ns = local_clock();
 	/*
-	 * Set the expected sleep length to infinity in case of an early
-	 * return.
+	 * Set the sleep length to infitity in case the invocation of
+	 * tick_nohz_get_sleep_length() below is skipped, in which case it won't
+	 * be known whether or not the subsequent wakeup is caused by a timer.
+	 * It is generally fine to count the wakeup as an intercept then, except
+	 * for the cases when the CPU is mostly woken up by timers and there may
+	 * be opportunities to ask for a deeper idle state when no imminent
+	 * timers are scheduled which may be missed.
 	 */
 	cpu_data->sleep_length_ns = KTIME_MAX;
 




