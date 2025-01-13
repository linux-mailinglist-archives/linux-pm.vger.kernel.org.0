Return-Path: <linux-pm+bounces-20374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8EA0C0CF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63533A24CB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1721BBBF1;
	Mon, 13 Jan 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gvZHae1J"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F981C8FD6;
	Mon, 13 Jan 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794348; cv=none; b=HrD6OyQxTNDt47tEgnXg2YTDKPDnjluP1U1oAb7HoCKVBE94BaimxPZyARDqNSxtSmDNC0FrJAfsPIPsd3fUNJg+KzmAK7ZrERZJ/vU6nckc7SGoAoF40Ed8BEH7VuHCVPboLMk/KzfbyHOUharUFKXcWHJT9BW2BmDOwSWhmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794348; c=relaxed/simple;
	bh=ESmGqVNghGq4d4aCfeSlu5Its3vfzmw4fKdoea49AxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uL5sM08FwGTSHHktd4cyi1MxwaAM8lhcsBR12iWvkGc7WxyYxL29tlWdxuS6vtYWRlTrtaHyi0BQBf2HP2x197bgnhit56mUsFvGujq/+QHDU2/aO64YRACa3P/zkhT6If+UYhoU0B8N3acX1z7KK6rFGKgmVJzOn5X+2CfoBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gvZHae1J; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id db67787b251bd98b; Mon, 13 Jan 2025 19:52:18 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AE6138E0A25;
	Mon, 13 Jan 2025 19:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794338;
	bh=ESmGqVNghGq4d4aCfeSlu5Its3vfzmw4fKdoea49AxU=;
	h=From:Subject:Date;
	b=gvZHae1J+rQw/uMburX9LGmDo+rxwxHkTTE+EhuwSG8lUIctUOOe+lLVdDUqu8Yoe
	 xkjScNhrpeLPIL5oaQSASAFgDV8jm/FnLYeadHQFQu85BdBIIX4BbL4S4gz2kO8I/w
	 UsUnobcmil3DoOwQ4z1u5nkdoRJ3kAyPviQUETZpIr0dK+u2PheLfoHa1Er8BXN/HJ
	 jN8ZePFdkSDvAougqFbSx2U6D8vzTfsPzBW0L3K0bnD5+6dFy+Jq9KbGCIqfhuv0ob
	 gvAPgHw8sfq6aGzdv/FZSGk78lhmMlZjugeAJjzVFWsda4PKdGglJfumZg6tCBJ0dW
	 NJ7n08LUqTG4A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 4/9] cpuidle: teo: Drop local variable prev_intercept_idx
Date: Mon, 13 Jan 2025 19:40:49 +0100
Message-ID: <3327997.aeNJFYEL58@rjwysocki.net>
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

Local variable prev_intercept_idx in teo_select() is redundant becase
it cannot be 0 when candidate state index is 0.

The prev_intercept_idx value is the index of the deepest enabled idle
state, so if it is 0, state 0 is the deepest enabled idle state, in
which case it must be the only enabled idle state, but then teo_select()
would have returned early before initializing prev_intercept_idx.

Thus prev_intercept_idx must be nonzero and the check of it against 0
always passes, so it can be dropped altogether.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -292,7 +292,6 @@
 	unsigned int hit_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
-	int prev_intercept_idx;
 	s64 duration_ns;
 	int i;
 
@@ -370,7 +369,6 @@
 	 * all of the deeper states, a shallower idle state is likely to be a
 	 * better choice.
 	 */
-	prev_intercept_idx = idx;
 	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
 		int first_suitable_idx = idx;
 
@@ -437,14 +435,11 @@
 		idx = constraint_idx;
 
 	if (!idx) {
-		if (prev_intercept_idx) {
-			/*
-			 * Query the sleep length to be able to count the wakeup
-			 * as a hit if it is caused by a timer.
-			 */
-			duration_ns = tick_nohz_get_sleep_length(&delta_tick);
-			cpu_data->sleep_length_ns = duration_ns;
-		}
+		/*
+		 * Query the sleep length to be able to count the wakeup as a
+		 * hit if it is caused by a timer.
+		 */
+		cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
 		goto out_tick;
 	}
 




