Return-Path: <linux-pm+bounces-20219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D0A0913F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F355A188E015
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77C20DD65;
	Fri, 10 Jan 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Cv2PqwJ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EE20A5E9;
	Fri, 10 Jan 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513880; cv=none; b=qnh7CUSFws/Ju3CUyf7GXddK+0OpLl/D7ZeV6X30LnjzHseRhQ+XZ3ARkwmRabmd4/q/lyq0SuhIcfZAXVYLoG2SwcELVsz0YY8M3q/AN3tb6zWIyCB4XGhDDnKJKtFRUkISuqSclwRFeFzpk7VeofdO0AuvIjUOA9m9sHSvJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513880; c=relaxed/simple;
	bh=JwT38iZan3te1sUrNeDmcKgV3zvQtH2PT7sDx6rv1bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5iQMkcEY3VxdNF7cIVcI9kZS8mrznA36GIcfjSeaJpfemxh89rbR24pHaZHjNxWM7xKcLmqF+rOb9oTm1UL/ZSgBPBB+98/2Tnu5Nm1IxUmKWyGnv1lN1cIaKwgnf26C2H/GtypkK0A3XL3Cua1ejVsXnf/LMrNXTTAoeBkOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Cv2PqwJ/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id faff95d8c2ca581f; Fri, 10 Jan 2025 13:57:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D69BD8E05BD;
	Fri, 10 Jan 2025 13:57:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736513876;
	bh=JwT38iZan3te1sUrNeDmcKgV3zvQtH2PT7sDx6rv1bM=;
	h=From:Subject:Date;
	b=Cv2PqwJ/sANhOJtTpO9Vk9qRQJPxJAwVeXr2Q5GMsXqGCS+Vq4ps5kRE7ScjP+mrB
	 pkiwdNNHIFIMmOfwaSqBvI0DjBFuS52KaH8yLcT6/bfMdtkuyDiMCvxGamhYmzVhik
	 kgP0BVq+rj04arc9I2THVdC9BrnN4AleX63FAFn+owtn6hIE7R8Qi8jcHqinW7lfJB
	 7gVQOzwDH3Z++Q5EpvwnGanXG1x6Bgk9z2AASDvd17Kbs9LrLYE6Ipj01biAfeBNBE
	 sD0ipYmEypRyW7yJeiTQ0nbCThnpPsKDKWLwyKkcwmtlIj3JMrK1lvDrNjiihLMIZt
	 W02UV//X6tsow==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 3/4] cpuidle: teo: Reorder candidate state index checks
Date: Fri, 10 Jan 2025 13:55:29 +0100
Message-ID: <8476650.T7Z3S40VBb@rjwysocki.net>
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

Since constraint_idx may be 0, the candidate state index may change to 0
after assinging constraint_idx to it, so first check if it is greater
than constraint_idx (and update it if so) and then check it against 0.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -428,6 +428,14 @@
 				break;
 		}
 	}
+
+	/*
+	 * If there is a latency constraint, it may be necessary to select an
+	 * idle state shallower than the current candidate one.
+	 */
+	if (idx > constraint_idx)
+		idx = constraint_idx;
+
 	if (!idx && prev_intercept_idx &&
 	    !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
 		/*
@@ -440,13 +448,6 @@
 	}
 
 	/*
-	 * If there is a latency constraint, it may be necessary to select an
-	 * idle state shallower than the current candidate one.
-	 */
-	if (idx > constraint_idx)
-		idx = constraint_idx;
-
-	/*
 	 * Skip the timers check if state 0 is the current candidate one,
 	 * because an immediate non-timer wakeup is expected in that case.
 	 */




