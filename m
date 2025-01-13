Return-Path: <linux-pm+bounces-20368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0208A0C0C5
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5047A2A38
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E41C5F09;
	Mon, 13 Jan 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="grHyiRNm"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA04240251;
	Mon, 13 Jan 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794344; cv=none; b=BoHMpZf1600dG3WJatvr/h4xJANQzQNyKd2PnN8sTnTl2KF0Ej1ymNPRq9GRqrTxCr6hR158RbfDxsbBWyp/hISstpKKCuSwQOU2nUSmQJk8hmCQAQE0wd0EPYEcFYU+IkkDb2VkFp0CsGH0TRNTXG6ZbO+OCy3wmvon6jh0xLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794344; c=relaxed/simple;
	bh=w8yNobx/K7ISkJeO5Hp3sA9eQ1R1X90Mm4HGFIECRuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azuC/M/zkwnEKnxRYHRW99F1lTwlVCMbsAlBFXauLhrk+pB5yvaoTSgtAipNkPKZwUmpPUZNPxtDBMTf9v8Z65VHMiKACG71lH7suPOWpjBh93SCG6H/ddD2t1seHSJzv/aNJA5qhOdxuoJd4k1jpjTkbKnhJTNTMD0BaithfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=grHyiRNm; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id eaaea6503d7afdc5; Mon, 13 Jan 2025 19:52:20 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DAE398E0A24;
	Mon, 13 Jan 2025 19:52:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794340;
	bh=w8yNobx/K7ISkJeO5Hp3sA9eQ1R1X90Mm4HGFIECRuU=;
	h=From:Subject:Date;
	b=grHyiRNm/1hPcPd7WFZKvFfjLRqdoaZJE8yGRUW9L3AiPJMwcwft5DIU+4b3I9fbC
	 zkSXT2NKD69DZuwQYX3etzMFRUUTOuukUxI5Yk/tiOoVtZ5JwxgyByUZZSFkrV0nG1
	 wAY939TVoFPSlrqwpXlTfdOo5p738dFXTNRV9cKpv5cq7SMjloJG9q/UtlCTfSEyHk
	 YdudFQvZoN3JG3AMDJi/5RubdSX9/8pFZzDMaYk4In5esM4P4mS1rkGla4+hwBuZ8k
	 v3C/oyFlQrXNYGLWRllJcQyjBtLPzZwzz9Q/Ag86pKj8WOvANVLvG1BneO4uifesAH
	 9r10ete+96ORg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
Date: Mon, 13 Jan 2025 19:36:57 +0100
Message-ID: <1907276.tdWV9SEqCh@rjwysocki.net>
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

Since constraint_idx may be 0, the candidate state index may change to 0
after assigning constraint_idx to it, so first check if it is greater
than constraint_idx (and update it if so) and then check it against 0.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a rebased variant of

https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/

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
 	if (!idx && prev_intercept_idx) {
 		/*
 		 * We have to query the sleep length here otherwise we don't
@@ -439,13 +447,6 @@
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




