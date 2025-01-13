Return-Path: <linux-pm+bounces-20370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415BA0C0C9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A782E18860A3
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D922B2DA;
	Mon, 13 Jan 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="liA7adHz"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CC1C461F;
	Mon, 13 Jan 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794345; cv=none; b=PhdcJEYngacUlRveUt6tZNmQQ3ummZZgaPMZNQFFcMKReHt8E6VlmPpFLncmsghqvNqjuYapCOlVE7T49/LOswCHVONVxCTmrTVp1iX3klEO/SRBEGrmg8aa6zXQSpxeXFhx41MDzblWAGV46wYQCuVuO4FlIgmqm5RqIFmdtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794345; c=relaxed/simple;
	bh=qYd5TYoB2ojjcXN+vcCmoVbhkzP4shjziDv7NnctqGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwbl/kFqWPkw79t3Fr14Rtu3LqQIcrfoLFEshg2WlvCxkyrRMvTcOLPqaEDZ72+PEgpYNp2TaT4XGbFMiUsjrlMLD0FFgN2y5REe/NThr9pn077z+vY5TbjeMcvXiFDgMFd8w3O+ZoBVq639XjMOwyqOVzNcFwKKif3HWXQpsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=liA7adHz; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d641750d55090115; Mon, 13 Jan 2025 19:52:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BBF418E0A24;
	Mon, 13 Jan 2025 19:52:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794341;
	bh=qYd5TYoB2ojjcXN+vcCmoVbhkzP4shjziDv7NnctqGc=;
	h=From:Subject:Date;
	b=liA7adHztet6/HzIgOb53rrBmzhMst75elvEdreWgO9cpZUOjhtcD1QGHTq++SJME
	 4nJy5HLpssWxlZgnI5ijrTAD1dvCpdbrBERKOYClPC0J648exb6gbXsJnZqZK432z9
	 7VFBOmgwAHe91Fpf5/5/rZs+MpW6n2VLtJadgTxc6QhcTP6ufAL9EkN5wYEYTVkd++
	 Ib/vModPdnirZcuKpPbXMTDPpn0r8MApgPoVhd15ZhB33172pVydqiHT9ggYfYg/1B
	 QvduHx7Eux0hbsQQ3h4QE+xV4Nw0+CHOX1aZvnrggqqwZMA4eP2C0XksiPbidUG6y4
	 L+bSwNsZGDovw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 1/9] cpuidle: teo: Rearrange idle state lookup code
Date: Mon, 13 Jan 2025 19:34:22 +0100
Message-ID: <4619938.LvFx2qVVIh@rjwysocki.net>
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

Rearrange code in the idle state lookup loop in teo_select() to make it
somewhat easier to follow and update comments around it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is the same patch as

https://lore.kernel.org/linux-pm/3332506.aeNJFYEL58@rjwysocki.net/

---
 drivers/cpuidle/governors/teo.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -367,7 +367,7 @@
 	 * If the sum of the intercepts metric for all of the idle states
 	 * shallower than the current candidate one (idx) is greater than the
 	 * sum of the intercepts and hits metrics for the candidate state and
-	 * all of the deeper states a shallower idle state is likely to be a
+	 * all of the deeper states, a shallower idle state is likely to be a
 	 * better choice.
 	 */
 	prev_intercept_idx = idx;
@@ -396,30 +396,36 @@
 				 * first enabled state that is deep enough.
 				 */
 				if (teo_state_ok(i, drv) &&
-				    !dev->states_usage[i].disable)
+				    !dev->states_usage[i].disable) {
 					idx = i;
-				else
-					idx = first_suitable_idx;
-
+					break;
+				}
+				idx = first_suitable_idx;
 				break;
 			}
 
 			if (dev->states_usage[i].disable)
 				continue;
 
-			if (!teo_state_ok(i, drv)) {
+			if (teo_state_ok(i, drv)) {
 				/*
-				 * The current state is too shallow, but if an
-				 * alternative candidate state has been found,
-				 * it may still turn out to be a better choice.
+				 * The current state is deep enough, but still
+				 * there may be a better one.
 				 */
-				if (first_suitable_idx != idx)
-					continue;
-
-				break;
+				first_suitable_idx = i;
+				continue;
 			}
 
-			first_suitable_idx = i;
+			/*
+			 * The current state is too shallow, so if no suitable
+			 * states other than the initial candidate have been
+			 * found, give up (the remaining states to check are
+			 * shallower still), but otherwise the first suitable
+			 * state other than the initial candidate may turn out
+			 * to be preferable.
+			 */
+			if (first_suitable_idx == idx)
+				break;
 		}
 	}
 	if (!idx && prev_intercept_idx) {




