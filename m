Return-Path: <linux-pm+bounces-20367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2512A0C0C2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A529E3A06BA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC851C5D50;
	Mon, 13 Jan 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jyRwV7ej"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE81C3BF0;
	Mon, 13 Jan 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794344; cv=none; b=OWDeuSyPOG+VOIOmN8y9GrWVhXCONClCbqxT0BwSqfD7t9Xw5TIxmh/WiaXy+FPXx4wflLz9ETegHxxkNwQKcl7Tz7e7ENwu5e4GtCDu/KZXIvznOiekb13cTw8aZv6ZdKEriP1XTgbol0pAb/6yYYwboBoxUMp1kIBfJ6zfv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794344; c=relaxed/simple;
	bh=OGoFtC6JKRTQWneUVXdbJ9xSV+uQMbEiyGqw9nUFUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjjfBEjriT5QA1jscwwg7lfsrUbWYtLfVmYnYdtHpQu5V5/q3LhVv14FPPhJXb75CR5w8GiygqF7VYH3oq/iQf6u0VVPGyqrV/RAHbA75VA51lZO7D6q3OGUQzoPoUDl6sfNE7UflrkBfpo9JXPI8YmvH/4GBTw9p5kqolOWmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jyRwV7ej; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id bd7286f9a0bcf4f2; Mon, 13 Jan 2025 19:52:19 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E21028E0A24;
	Mon, 13 Jan 2025 19:52:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794339;
	bh=OGoFtC6JKRTQWneUVXdbJ9xSV+uQMbEiyGqw9nUFUFI=;
	h=From:Subject:Date;
	b=jyRwV7ejLGyh1lUpve5jEd8TwCofMMJ39Oy+VloAW+yMPBxHUokVQdtz1VTCM345t
	 7t8MQEDIZHTSLQLmk5UASbdTlF97hRosXJxNikw1n+p+upoznpZWUM92NWvnv4ive8
	 l01lVBZXW2SVa/mGlrsNP40FF2itl5DAyA6kV07Jvp7WYTlppH3tDIltBcNv+s+Dio
	 ihFPREg51XgGAUP2qFM25c2iOdu9lMz+b8PmbFoH8xuPKQW2DoMhNPjWHhd2lRs/cD
	 M33xz9kvANsZx+nfaxIiDn4n/ArDSP5SUgA5k/uJrlPUbBa83ywwu/Po9ZMEqo0CY/
	 DwBK7kogtQm6g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1 3/9] cpuidle: teo: Combine candidate state index checks against 0
Date: Mon, 13 Jan 2025 19:39:00 +0100
Message-ID: <13676346.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtohe
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are two candidate state index checks against 0 in teo_select()
that need not be separate, so combine them and update comments around
them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a rebased variant of

https://lore.kernel.org/linux-pm/2296767.iZASKD2KPV@rjwysocki.net/

---
 drivers/cpuidle/governors/teo.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -436,24 +436,19 @@
 	if (idx > constraint_idx)
 		idx = constraint_idx;
 
-	if (!idx && prev_intercept_idx) {
-		/*
-		 * We have to query the sleep length here otherwise we don't
-		 * know after wakeup if our guess was correct.
-		 */
-		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
-		cpu_data->sleep_length_ns = duration_ns;
+	if (!idx) {
+		if (prev_intercept_idx) {
+			/*
+			 * Query the sleep length to be able to count the wakeup
+			 * as a hit if it is caused by a timer.
+			 */
+			duration_ns = tick_nohz_get_sleep_length(&delta_tick);
+			cpu_data->sleep_length_ns = duration_ns;
+		}
 		goto out_tick;
 	}
 
 	/*
-	 * Skip the timers check if state 0 is the current candidate one,
-	 * because an immediate non-timer wakeup is expected in that case.
-	 */
-	if (!idx)
-		goto out_tick;
-
-	/*
 	 * If state 0 is a polling one, check if the target residency of
 	 * the current candidate state is low enough and skip the timers
 	 * check in that case too.




