Return-Path: <linux-pm+bounces-24768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07CCA7AFB5
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 22:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2D13AF915
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5E2505D6;
	Thu,  3 Apr 2025 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XUasF8mO"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DD230985;
	Thu,  3 Apr 2025 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708299; cv=none; b=WG2nDPWszn3DNlJnuu4jzTqM9XjqeGzdLA4dCRxtUb28GEYfl7qRzVygn80GlktUlZ292b467ecCBdQYLenUa+18eTHVG5MifGdTJzqleCsp2Ft836wzRek3lqYJ9JA6mn0EHTt6DM0FymlHyHNrwFK+Mw5x1eegf1FMRf35fxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708299; c=relaxed/simple;
	bh=M0B7DYBkTlQRKyQ+laESOGNy2whZ2BwQqOZRb/DqqjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4+XmQlW7AIbJxejZJAzmMiKwQRzMZrxm+Iz9Nu8Cn6qcGILC91b6M6+cOLCY/Co1D28HJB0OB3XR0udwG/IPKOhjv1bi+NuQtlr2aL7xmzYEyZqafQon7N2V8M49w5PAcTvWU/PpDG7IUfnTVDudqzNudU5sfjL2hC4dMVgovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XUasF8mO; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 07fea8c86a4f491e; Thu, 3 Apr 2025 21:24:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0E9B99014E8;
	Thu,  3 Apr 2025 21:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743708294;
	bh=M0B7DYBkTlQRKyQ+laESOGNy2whZ2BwQqOZRb/DqqjE=;
	h=From:Subject:Date;
	b=XUasF8mOaPYG+wQJtAcQbKOaZX6/9wTo0gU4Cf/n3azEHJc8ejngA2aWYUKmamOe8
	 PGCz41VFLrUY6klUoL7+OGckJW37SZRudnEVagSiJVaP7U9ypakfAQAHhlrqiNU+Ou
	 MJAFnCzxK8HP7GGEYG7pa2K0v9IFjPfN+03XX4zsk5MiN9AEFYCm9jF5wHLcqcmlZP
	 yuO+CFTtH8wYqwYNxODxvPKsxiFnXCkr5OBOsY3kPi5Camw4QTTPBYZ16j4bs3yU4v
	 tNSAubaNznEbEks5HPTdznLonOS3/DVQFM2eThkN/Bt6jsSlTd39JY1oMeUpIUNkJ5
	 yrqfSGVEe73pg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [PATCH v1 1/2] cpuidle: teo: Move candidate state lookup to separate function
Date: Thu, 03 Apr 2025 21:16:47 +0200
Message-ID: <4991828.GXAFRqVoOG@rjwysocki.net>
In-Reply-To: <4661520.LvFx2qVVIh@rjwysocki.net>
References: <4661520.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeelfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the code looking up a new candidate idle state in teo, after
deciding that the initial candidate (the deepest enabled idle state) is
likely too deep, into a separate function in preparation for subsequent
changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |  120 +++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 57 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -259,6 +259,67 @@
 	return state_idx;
 }
 
+static int teo_get_candidate(struct cpuidle_driver *drv,
+			     struct cpuidle_device *dev,
+			     struct teo_cpu *cpu_data,
+			     int idx, unsigned int idx_intercepts)
+{
+	int first_suitable_idx = idx;
+	unsigned int intercepts = 0;
+	int i;
+
+	/*
+	 * Look for the deepest idle state whose target residency had
+	 * not exceeded the idle duration in over a half of the relevant
+	 * cases in the past.
+	 *
+	 * Take the possible duration limitation present if the tick
+	 * has been stopped already into account.
+	 */
+	for (i = idx - 1; i >= 0; i--) {
+		intercepts += cpu_data->state_bins[i].intercepts;
+		if (2 * intercepts > idx_intercepts) {
+			/*
+			 * Use the current state unless it is too
+			 * shallow or disabled, in which case take the
+			 * first enabled state that is deep enough.
+			 */
+			if (teo_state_ok(i, drv) && !dev->states_usage[i].disable) {
+				idx = i;
+				break;
+			}
+
+			idx = first_suitable_idx;
+			break;
+		}
+
+		if (dev->states_usage[i].disable)
+			continue;
+
+		if (teo_state_ok(i, drv)) {
+			/*
+			 * The current state is deep enough, but still
+			 * there may be a better one.
+			 */
+			first_suitable_idx = i;
+			continue;
+		}
+
+		/*
+		 * The current state is too shallow, so if no suitable
+		 * states other than the initial candidate have been
+		 * found, give up (the remaining states to check are
+		 * shallower still), but otherwise the first suitable
+		 * state other than the initial candidate may turn out
+		 * to be preferable.
+		 */
+		if (first_suitable_idx == idx)
+			break;
+	}
+
+	return idx;
+}
+
 /**
  * teo_select - Selects the next idle state to enter.
  * @drv: cpuidle driver containing state data.
@@ -355,63 +416,8 @@
 	 * all of the deeper states, a shallower idle state is likely to be a
 	 * better choice.
 	 */
-	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
-		int first_suitable_idx = idx;
-
-		/*
-		 * Look for the deepest idle state whose target residency had
-		 * not exceeded the idle duration in over a half of the relevant
-		 * cases in the past.
-		 *
-		 * Take the possible duration limitation present if the tick
-		 * has been stopped already into account.
-		 */
-		intercept_sum = 0;
-
-		for (i = idx - 1; i >= 0; i--) {
-			struct teo_bin *bin = &cpu_data->state_bins[i];
-
-			intercept_sum += bin->intercepts;
-
-			if (2 * intercept_sum > idx_intercept_sum) {
-				/*
-				 * Use the current state unless it is too
-				 * shallow or disabled, in which case take the
-				 * first enabled state that is deep enough.
-				 */
-				if (teo_state_ok(i, drv) &&
-				    !dev->states_usage[i].disable) {
-					idx = i;
-					break;
-				}
-				idx = first_suitable_idx;
-				break;
-			}
-
-			if (dev->states_usage[i].disable)
-				continue;
-
-			if (teo_state_ok(i, drv)) {
-				/*
-				 * The current state is deep enough, but still
-				 * there may be a better one.
-				 */
-				first_suitable_idx = i;
-				continue;
-			}
-
-			/*
-			 * The current state is too shallow, so if no suitable
-			 * states other than the initial candidate have been
-			 * found, give up (the remaining states to check are
-			 * shallower still), but otherwise the first suitable
-			 * state other than the initial candidate may turn out
-			 * to be preferable.
-			 */
-			if (first_suitable_idx == idx)
-				break;
-		}
-	}
+	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum)
+		idx = teo_get_candidate(drv, dev, cpu_data, idx, idx_intercept_sum);
 
 	/*
 	 * If there is a latency constraint, it may be necessary to select an




