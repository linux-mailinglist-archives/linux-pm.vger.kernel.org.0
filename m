Return-Path: <linux-pm+bounces-21486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE24A2AB61
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 15:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA9E7A58A9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2B2451D5;
	Thu,  6 Feb 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="bF3E5A9/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C71EDA34;
	Thu,  6 Feb 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852175; cv=none; b=YxK+vIos/tAGIHP7XZEIxKRDKelGbi5TQ7tuLj+HzinR6TMfjUDx+cTm7J6nbyOM12J5/59RUoss2/seEJvEZteiOphLsDt9FtkZNHk67BODZXqWOjoOYymxraZwN5WfxovVSmi/+bgeb0J3/12wjL+roYe3W/ywm2Z/cN6i6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852175; c=relaxed/simple;
	bh=ALEieubBgccz3ujIHX0fEgcGmndFC4PRDsNOYLwOPKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTXi1I/Wm1ZIip/CgYUtEjoCL6uPTl+6Kb1xZZJVdgGNkS+PwkcXjVBT0ZYX/9CXkscNJzqVSZEM20+k0ZpkOo2RsIoeB0+pqXzHEPUa76U/I2y1GVwigsAk+fB3NvWQbgIgr6wrgwV1DoiJisB4jjxOIEftSx+XSppLDDKdx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=bF3E5A9/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 1b2af6f2bbd46cd0; Thu, 6 Feb 2025 15:29:24 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 452FE6BA970;
	Thu,  6 Feb 2025 15:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738852164;
	bh=ALEieubBgccz3ujIHX0fEgcGmndFC4PRDsNOYLwOPKI=;
	h=From:Subject:Date;
	b=bF3E5A9/bTCp6+LXbwm183ynq/nffQxfvQIwJjnw6EALGeC6v/fXsBMa8Fhuq6rvk
	 uraaSb7IzDCYiyusUKopobwiVfV0wu0pZoPCOT4rT8GqQ5mMygIRwQeq3X7TM6eRKa
	 cGMQA7iTTSspW81IZAMBqo2ch8GXTH6zbOfZECnCj8j4Cb88/g6Ern/yv8PoAj1nJq
	 BlnOyKUjTHwFBMIeVJSo8g1MtartIL+08NlOrLF4lW2CDzyQVkTHE5ddlw38dZHFrD
	 lDMCCRfp0Mn/zfGeyZ1RBYGugP1pG614wlSWnIOw9rVR2ZHj8DX6wtu+oiwfZrdkOn
	 hIzwUtJbJLGEg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [RFT][PATCH v1 2/5] cpuidle: menu: Use one loop for average and variance
 computations
Date: Thu, 06 Feb 2025 15:24:18 +0100
Message-ID: <3339073.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <1916668.tdWV9SEqCh@rjwysocki.net>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdhlohgvhhhlvgesrghrmhdrtghomhdprhgtphhtthhopegrrhhtvghmrdgsihhthihuthhskhhihieslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use the observation that one loop is sufficient to compute the average
of an array of values and their variance to eliminate one of the loops
from get_typical_interval().

While at it, make get_typical_interval() consistently use u64 as the
64-bit unsigned integer data type and rearrange some white space and the
declarations of local variables in it (to make them follow the reverse
X-mas tree pattern).

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   61 +++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -116,49 +116,45 @@
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	int i, divisor;
-	unsigned int max, thresh, avg;
-	uint64_t sum, variance;
-
-	thresh = INT_MAX; /* Discard outliers above this value */
+	unsigned int max, divisor, thresh = INT_MAX;
+	u64 avg, variance, avg_sq;
+	int i;
 
 again:
-
-	/* First calculate the average of past intervals */
+	/* Compute the average and variance of past intervals. */
 	max = 0;
-	sum = 0;
+	avg = 0;
+	variance = 0;
 	divisor = 0;
 	for (i = 0; i < INTERVALS; i++) {
 		unsigned int value = data->intervals[i];
-		if (value <= thresh) {
-			sum += value;
-			divisor++;
-			if (value > max)
-				max = value;
-		}
+
+		/* Discard data points above the threshold. */
+		if (value > thresh)
+			continue;
+
+		divisor++;
+
+		avg += value;
+		variance += (u64)value * value;
+
+		if (value > max)
+			max = value;
 	}
 
 	if (!max)
 		return UINT_MAX;
 
-	if (divisor == INTERVALS)
-		avg = sum >> INTERVAL_SHIFT;
-	else
-		avg = div_u64(sum, divisor);
-
-	/* Then try to determine variance */
-	variance = 0;
-	for (i = 0; i < INTERVALS; i++) {
-		unsigned int value = data->intervals[i];
-		if (value <= thresh) {
-			int64_t diff = (int64_t)value - avg;
-			variance += diff * diff;
-		}
-	}
-	if (divisor == INTERVALS)
+	if (divisor == INTERVALS) {
+		avg >>= INTERVAL_SHIFT;
 		variance >>= INTERVAL_SHIFT;
-	else
+	} else {
+		do_div(avg, divisor);
 		do_div(variance, divisor);
+	}
+
+	avg_sq = avg * avg;
+	variance -= avg_sq;
 
 	/*
 	 * The typical interval is obtained when standard deviation is
@@ -173,10 +169,9 @@
 	 * Use this result only if there is no timer to wake us up sooner.
 	 */
 	if (likely(variance <= U64_MAX/36)) {
-		if ((((u64)avg*avg > variance*36) && (divisor * 4 >= INTERVALS * 3))
-							|| variance <= 400) {
+		if ((avg_sq > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
+		    variance <= 400)
 			return avg;
-		}
 	}
 
 	/*




