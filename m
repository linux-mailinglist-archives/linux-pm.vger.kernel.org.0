Return-Path: <linux-pm+bounces-20220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD5A09141
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E578188DDB3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FAC20E00D;
	Fri, 10 Jan 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="EdT9RZjs"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6420B80B;
	Fri, 10 Jan 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513881; cv=none; b=SAmXc/1XSYbHTA9wUg6jZUKWvd/UsVWEI8RmUq+EZhGzJGneKjmsiGje8slIKrCUTJlHL3iA7H+nCb0+IJ5W1Jaex9F7Z06tv1Obny/uQ2vUa+w8COyPU9QNCVIJsIQ3M733pnsvIYMBrHcuB56eHrMbOW3PzqmJe5saJmTTDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513881; c=relaxed/simple;
	bh=aMsxBXTyqbPuNisGPiGLY4/v1IDTWx6PBDk+6e12byE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jt++SN606moTVmeR/GnruDNX+YkGiNSBApwwTLjW97wQumcHSvo4iXBj+AzY0gSLlVOK3jOar1D1/5qYdXeQIjqfDy1HXzXTVRb2254bKbRFI6dOxLFXU/9ddFNx9ptHGSFR9HbFKsxdoY+g0cmEvMVo3vpt5GxvNcCBKY67oCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=EdT9RZjs; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d9eaa60ba3037fd8; Fri, 10 Jan 2025 13:57:57 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DD46A8E05BD;
	Fri, 10 Jan 2025 13:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736513877;
	bh=aMsxBXTyqbPuNisGPiGLY4/v1IDTWx6PBDk+6e12byE=;
	h=From:Subject:Date;
	b=EdT9RZjsQwTLft2QkAi8ktta+ynSzWjHBn026Ul7nUfHr3GmKcu5+Zxm2bue4gtFX
	 SQuJZce0+mEYMz4Madt6Mdl5kqJZLEzgGXbh8kz7FnWppMn/4GOdndd2g+i926GZm9
	 HMqJT2Z8GruSAljHIJ/WrDhpHDbAoiqp3N1tbcxrIuKh2LK310Iqp+ER9xGpYSvBKd
	 L7dTFss52w2Qry3RxOcGo4w6G8H9vpK0ZtQhrWc/2JTFkxNi7EvbD8oX+EDA0qmGW/
	 F6/Fdl6+GLzl7vy7FXMbrWRIvMKemKhwf50R7vVvLns7Xd9JTQEYnI7wVBN85uorbs
	 eYt8axjfH2bPw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 2/4] cpuidle: teo: Rearrange idle state lookup code
Date: Fri, 10 Jan 2025 13:54:39 +0100
Message-ID: <3332506.aeNJFYEL58@rjwysocki.net>
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

Rearrange code in the idle state lookup loop in teo_select() to make it
somewhat easier to follow and update comments around it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
 	if (!idx && prev_intercept_idx &&




