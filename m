Return-Path: <linux-pm+bounces-20221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA752A09143
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9353B188E020
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A74820E039;
	Fri, 10 Jan 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qeuxRRoi"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8C20DD53;
	Fri, 10 Jan 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513882; cv=none; b=ZU4s889mjLqPjq974OAIECzgZiP4YE5jNIMJejT3ciFYzfZEfYIichWSSU0XGLgVQsn5kRJV0YeUKMdmE/JXFqZAf+2Rlex22bVa0W0nPx1fR3yeiPOVZ7hGPtfeHAuogrhMDENVccA+E/TKVy9tDV+nFnvmxFzG8W2Q9r/drPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513882; c=relaxed/simple;
	bh=LVbRvsshn0Bs3rOsCebMtDGzdAIaFrarmaICvHLvZXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWkcuHCGORtxCDpCPFKRe8dWb/NsOjxrXR6vWv2x9qPa9aPUdPFm43XAgORTxu01aHjoK5k1Gzir9IxIqaBWNoyhG9AccyQmPfzdVH4zJJp64vvw8k9x/J3fZD+qgtAuXimn+xgUnx8+tgjyaji/jlynM4rTspDqCNHEqWmfj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qeuxRRoi; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id c174eccfaff98ff8; Fri, 10 Jan 2025 13:57:58 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C9E218E05BD;
	Fri, 10 Jan 2025 13:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736513878;
	bh=LVbRvsshn0Bs3rOsCebMtDGzdAIaFrarmaICvHLvZXY=;
	h=From:Subject:Date;
	b=qeuxRRoimgov9x5B42OBeP6un08ahbecTIPd8XlU8VVz7M/mHOKh7lVLOGLSddkJz
	 X7J1TGDDDSu3dAwZmWoCQeUDauowx1ZtuLWxuKDuX3IIPPSgWeN93hn9BgMfPfBtl0
	 wPC/yzVY75BSFVCqwhqMjnKDYdD9hCkkdb375PWmhsnxjoPSlHzs9eSZU/HJLMizD+
	 fqG2mtEGK2H+obOBVC2masyq0R/2xekZPCbmg3Yov5RFNOzyWBCn2ARn2/nsZQlwYy
	 1sDehnISXsjbYygslTEjxQC40eVYG/E2GxRpSBUyrL3PsGMOA4fo/BT7zIdf+o/kdv
	 empTo5Wq6bvqw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early return path
Date: Fri, 10 Jan 2025 13:53:57 +0100
Message-ID: <13679187.uLZWGnKmhe@rjwysocki.net>
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

After commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length()
call in some cases") the teo governor behaves a bit differently on
systems where idle state 0 is a "polling" state (that is, it is not
really an idle state, but a loop continuously executed by the CPU).
Namely, on such systems it skips the tick_nohz_get_sleep_length() call
if the target residency of the current candidate idle state is small
enough.

However, if state 0 itself was to be returned, it would be returned
right away without calling tick_nohz_get_sleep_length() even on systems
where it was not a "polling" state until commit 4b20b07ce72f ("cpuidle:
teo: Don't count non-existent intercepts") that attempted to fix this
problem.

Unfortunately, commit 4b20b07ce72f has made the governor always call
tick_nohz_get_sleep_length() when about to return state 0 early, even
if that state is a "polling" one, which is inconsistent and defeats
the purpose of commit 6da8f9ba5a87 in that case.

Address this by adding a CPUIDLE_FLAG_POLLING check to the path where
state 0 is returned early to prevent tick_nohz_get_sleep_length() from
being called if it is a "polling" state.

Fixes: 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -422,7 +422,8 @@
 			first_suitable_idx = i;
 		}
 	}
-	if (!idx && prev_intercept_idx) {
+	if (!idx && prev_intercept_idx &&
+	    !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
 		/*
 		 * We have to query the sleep length here otherwise we don't
 		 * know after wakeup if our guess was correct.




