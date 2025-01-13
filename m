Return-Path: <linux-pm+bounces-20366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ABBA0C0C1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126C1168614
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4C1C4A26;
	Mon, 13 Jan 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sRaNqfRM"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B881C1F15;
	Mon, 13 Jan 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794343; cv=none; b=ImLvCfNohbSUj1j3OWjsaG41gz6QVp87wcF0wK/6+GryeYB6K+YYqz3J+JcnEwST3lAnFPG7VmlualB2EgNXtXGatQt4jmAOpbenaOSDRjw1KfChCe+8EGrYykfzgNji9mSDxlAL8GbpaDyTwDCXdG6tNAz5QymJ0JYqcAFFzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794343; c=relaxed/simple;
	bh=QH5ZWYilfNjXtFpdyyTNMZ0N+150ByEYYQn1RF/rITk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaPugca6afBep9Xj1hkzLeVCupAxhI/Pzh/15Dk9rAFUg/uo8Jo39H9th+I0J/l4DXZJJs2Or/5vNaESTUb6Cj/msaMb0FRGAunTLNZzFnIT/RIjmH0Z+IunPS9bS2ytYxXgoQWorlv+Yyvd0bDzD2wLtdduiHrEavPjdDwbM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sRaNqfRM; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 5c1d842c927e5258; Mon, 13 Jan 2025 19:52:14 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 704948E0A24;
	Mon, 13 Jan 2025 19:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794333;
	bh=QH5ZWYilfNjXtFpdyyTNMZ0N+150ByEYYQn1RF/rITk=;
	h=From:Subject:Date;
	b=sRaNqfRMx1y1aCpJyMZIg9X/pTZZEpohb7oJBnHDhyxtRCGVMJGtU516oUa1k7UH1
	 6T6sLGbHc+h+0EIPbqmdn6XxcRJyAhhP9FTj44AA2nxhm9QW5WXmndU2jdIAXVlt2s
	 I+J/zTFnJwdDrbvcIzGLu3UzCTZoKcZtY4RX1xtkJCHk8abthy87zhOsjpQI/O66wN
	 HmIhYrPrQMcHuFv4hWvvMWjIyobCIAFxNfNc8VZoHuS8Nrk04TgQPT0mqpzMf2zn41
	 cETbKNOHlnQ6oinkX80BRvOBD1bLcGmdQCLn3LmRzDg/WIFFkrOLUKkODByjODRnPk
	 KcnNCZ7Q5EjvA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 8/9] cpuidle: teo: Simplify handling of total events count
Date: Mon, 13 Jan 2025 19:50:23 +0100
Message-ID: <9388883.CDJkKcVGEf@rjwysocki.net>
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

Instead of computing the total events count from scratch every time,
decay it and add a PULSE value to it in teo_update().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -189,8 +189,6 @@
 		}
 	}
 
-	cpu_data->total = 0;
-
 	/*
 	 * Decay the "hits" and "intercepts" metrics for all of the bins and
 	 * find the bins that the sleep length and the measured idle duration
@@ -202,8 +200,6 @@
 		bin->hits -= bin->hits >> DECAY_SHIFT;
 		bin->intercepts -= bin->intercepts >> DECAY_SHIFT;
 
-		cpu_data->total += bin->hits + bin->intercepts;
-
 		target_residency_ns = drv->states[i].target_residency_ns;
 
 		if (target_residency_ns <= cpu_data->sleep_length_ns) {
@@ -228,6 +224,7 @@
 			cpu_data->tick_intercepts += PULSE;
 	}
 
+	cpu_data->total -= cpu_data->total >> DECAY_SHIFT;
 	cpu_data->total += PULSE;
 }
 




