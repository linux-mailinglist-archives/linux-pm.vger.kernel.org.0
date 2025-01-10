Return-Path: <linux-pm+bounces-20218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03BA0913D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366BC188DCF4
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7DE20D4F2;
	Fri, 10 Jan 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ONkfwFYD"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237D20B7FA;
	Fri, 10 Jan 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513879; cv=none; b=Zesk/4HiYFcaGmBblguBmGjMBW8iYPPl0PelzZyM7NNgx8IB4TvWDRRjo/v67cnTE3y/Lj4SO1Xx5cC8tQ9I0AuMn6lR5SfbYZmN2x+7UKllrN60EKOroZl/QZwrrsqezqKA8Ie3u6t4ZMnv5wVIJ+IvY7fMgmWlWYKWht2C/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513879; c=relaxed/simple;
	bh=CcDF7WwwV59H8UViLxsSQlOdaroZnGiK3JoHgMgnESI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyftYSa9LTZ+VtZhfTZ2bXHFm4TzVjXUrzK4lgRByidVqL9yEc/fLYvLYy+6ZMpCkdw9+x9RNCRTncrNaYnJRhKSiHR2v3v5nf85WS/MGcMlcAJAoe5gS1r7Xg822BeFBlVCzFkGYuZCiIZIN7Xwq8Nu6auG2Fj/V8bq8gMNUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ONkfwFYD; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 562bfbd173d43376; Fri, 10 Jan 2025 13:57:55 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8E78B8E05BD;
	Fri, 10 Jan 2025 13:57:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736513875;
	bh=CcDF7WwwV59H8UViLxsSQlOdaroZnGiK3JoHgMgnESI=;
	h=From:Subject:Date;
	b=ONkfwFYDjL/2DBLoKbnOC/zcWv3naYS8hgsg3K36xYYI5s/e5A9YWeScYSeTwxdp1
	 Y/6tjdInJjv5n7elqTdGyxhTZjFVC/Z9AtTjYLU4xZ8wU+/g9gKfjX5G7pKlg7a7af
	 AcirrnF0JbGBnPcaCigYvEmTu5dlL7H7Gzy00kvei44mbmU7HmuZwVRaEaYtdqHEqu
	 u2o84VRGwCu4ex3cAYRpPpbOySTUGcTnM42nJ2vG+Wf8EN/IYslJJUwRVBNtAyA+RP
	 Ztb6mADRrOLydzGTzB3osWtHWArLixyJBoEJ8hxvm2nGW321z9WKG0GB5/Pcw8nYgH
	 +wm5v6g/fkkjw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1 4/4] cpuidle: teo: Combine candidate state index checks against 0
Date: Fri, 10 Jan 2025 13:56:07 +0100
Message-ID: <2296767.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <4953183.GXAFRqVoOG@rjwysocki.net>
References: <4953183.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtoheprghrthgvmhdrsghithihuhhtshhkihihsehlihh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are two candidate state index checks against 0 in teo_select()
that need not be separate, so combine them and update comments around
them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -436,25 +436,25 @@
 	if (idx > constraint_idx)
 		idx = constraint_idx;
 
-	if (!idx && prev_intercept_idx &&
-	    !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
+
+	if (!idx) {
 		/*
-		 * We have to query the sleep length here otherwise we don't
-		 * know after wakeup if our guess was correct.
+		 * Skip the timers check if state 0 is the current candidate
+		 * one because an immediate non-timer wakeup is expected then.
 		 */
-		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
-		cpu_data->sleep_length_ns = duration_ns;
+		if (prev_intercept_idx &&
+		    !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
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




