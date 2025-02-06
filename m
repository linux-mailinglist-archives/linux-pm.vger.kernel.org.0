Return-Path: <linux-pm+bounces-21483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22326A2AB60
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1614916A736
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B561EDA3D;
	Thu,  6 Feb 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="U27uTiQ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407791EDA2D;
	Thu,  6 Feb 2025 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852173; cv=none; b=JLiiu9jpkxOHePes0wok0Kj27mrauakmXpvNU5M11B+vIoFvkYEIA3sXzD62K0+xqpDNKCJU3tvXMEC98n5bRO7Ua6bA8MegIQZLfFqz1RI0SyhUd5ZTtnvHe8jLu3R3ff+GDUuFXidB1MONjOS+/6f0OETYajJ3Y+wRTyPOQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852173; c=relaxed/simple;
	bh=c6+9YDdlax32s2h1vFLHMmcCQPkXHYB7zhzdG4X1org=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCNw+FTUs/15s4oAvHRYe+mnQ4ULqDBIebYTZ/gCpELz2dkclU7z8VxJ7PtUefv5JVtatrURSGIf8ta8FzKEEXtr8WyfzAu/OVgZmIw+j3/a77r/Ymj3OYFX7Vl26DZl0Axu2DDn0m/+4B+NsqgMDnA24NgXV85kSNt2pSS8FZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=U27uTiQ5; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id e8b876c6155304fe; Thu, 6 Feb 2025 15:29:23 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 972086BA972;
	Thu,  6 Feb 2025 15:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738852163;
	bh=c6+9YDdlax32s2h1vFLHMmcCQPkXHYB7zhzdG4X1org=;
	h=From:Subject:Date;
	b=U27uTiQ5XTk9X9OnNac31KZQ9wAkdXowr2LRZ5I7IEMqQKZ5aKyeU8IcgrQr4hJF2
	 lpd0F8Jy1SwwlSsgzrHhU15v+4hzw45xQiyhk3sm3P53R8+AfmCacNKrpukPGuNFCO
	 IiJq7YCQlFuOCpshCLuYYZJ93evorVI+Rth5dVar3Zg27XazwJswTPySaiOmSs9JcY
	 Z1CRC3Pzu7hqoPPnzgXBAD/r3b549X42k1wHZ2rhFNg1mRYPZe3EWWa50CTaNWYRJf
	 DwKjwoJLXf1tkHyrRbJTqPFWnsILvvrIy8vnMJWN4VaXVAO/RopR3dizkXZHLBPX51
	 WUq1CssY0ZXxA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [RFT][PATCH v1 4/5] cpuidle: menu: Eliminate outliers on both ends of the
 sample set
Date: Thu, 06 Feb 2025 15:26:41 +0100
Message-ID: <2301940.iZASKD2KPV@rjwysocki.net>
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

Currently, get_typical_interval() attempts to eliminate outliers at the
high end of the sample set only (probably in order to bias the prediction
toward lower values), but this it problematic because if the outliers are
present at the low end of the sample set, discarding the highest values
will not help to reduce the variance.

Since the presence of outliers at the low end of the sample set is
generally as likely as their presence at the high end of the sample
set, modify get_typical_interval() to treat samples at the largest
distances from the average (on both ends of the sample set) as outliers.

This should increase the likelihood of making a meaningful prediction
in some cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -116,30 +116,37 @@
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	unsigned int max, divisor, thresh = UINT_MAX;
+	s64 value, min_thresh = -1, max_thresh = UINT_MAX;
+	unsigned int max, min, divisor;
 	u64 avg, variance, avg_sq;
 	int i;
 
 again:
 	/* Compute the average and variance of past intervals. */
 	max = 0;
+	min = UINT_MAX;
 	avg = 0;
 	variance = 0;
 	divisor = 0;
 	for (i = 0; i < INTERVALS; i++) {
-		unsigned int value = data->intervals[i];
-
-		/* Discard data points above or at the threshold. */
-		if (value >= thresh)
+		value = data->intervals[i];
+		/*
+		 * Discard the samples outside the interval between the min and
+		 * max thresholds.
+		 */
+		if (value <= min_thresh || value >= max_thresh)
 			continue;
 
 		divisor++;
 
 		avg += value;
-		variance += (u64)value * value;
+		variance += value * value;
 
 		if (value > max)
 			max = value;
+
+		if (value < min)
+			min = value;
 	}
 
 	if (!max)
@@ -175,10 +182,10 @@
 	}
 
 	/*
-	 * If we have outliers to the upside in our distribution, discard
-	 * those by setting the threshold to exclude these outliers, then
+	 * If there are outliers, discard them by setting thresholds to exclude
+	 * data points at a large enough distance from the average, then
 	 * calculate the average and standard deviation again. Once we get
-	 * down to the bottom 3/4 of our samples, stop excluding samples.
+	 * down to the last 3/4 of our samples, stop excluding samples.
 	 *
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
@@ -186,7 +193,12 @@
 	if ((divisor * 4) <= INTERVALS * 3)
 		return UINT_MAX;
 
-	thresh = max;
+	/* Update the thresholds for the next round. */
+	if (avg - min > max - avg)
+		min_thresh = min;
+	else
+		max_thresh = max;
+
 	goto again;
 }
 




