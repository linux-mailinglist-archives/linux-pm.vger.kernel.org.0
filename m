Return-Path: <linux-pm+bounces-14278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0071979059
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F361C20E2A
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802C71CEEB8;
	Sat, 14 Sep 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ZkcvyjT8"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5B7A15A;
	Sat, 14 Sep 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312443; cv=none; b=HES8K190u0tpoTitrA+uyeRgm0K/jU89psJfvzKp4ETKiMzfXXiDsgP5BZyJt+oaIGBPhcXFu5M1uL1KL+qakud4rPohpF4E6/aYBkm1J3e7PNAaKgp8gJl2iE2aEIi6wkj+knlU9x18znqU4rl3sQMe7269bwvi7XUZBsrYix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312443; c=relaxed/simple;
	bh=FdlwvppnGhrvw2CWlzVf8Z4HuHTXJ0bu2PxvguLALyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQjW1SepfTw7Hg8ZageKQ/nxMZvdXl0sOhSRS/B1xa0SW5eO5jj/NHGOL4hE0f/VRtmWnrPSZ4Z7lTmzYwvVFJpJoNhwCPWLjRAfk+f+9PgVUVSzwPsWbZxje2QiQw3SaHcttKjIojKwY5OY5MsFOJ0Xhq/xd42IAd2AWPFvzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ZkcvyjT8 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 500d8a0d6220b94c; Sat, 14 Sep 2024 13:13:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0E95D8532AE;
	Sat, 14 Sep 2024 13:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312439;
	bh=FdlwvppnGhrvw2CWlzVf8Z4HuHTXJ0bu2PxvguLALyo=;
	h=From:Subject:Date;
	b=ZkcvyjT8J516BckV0W81lZy0ds0iQunUyoKC4tCXGXyq21t68aCCjIIjniWhJUJ3+
	 5LQJV9LWOsX6Nu5aGp6GUgE1lXavWx95OtNABBcHRCjpI666IU3MXs3mf4U/DCW3LS
	 V4TfD5xXEh/NoOt9DVi/XUjFtvg8B3/pTt8H0mx2Ts5Stmtj0uqiG+E+WFtLJOHsTU
	 auawDa7NLS0uI9dxGUNA5ysamFrq65vzMaOexKyScefoWlmjktKcWeh06mOwDTATfc
	 k4JX+jfg3TiULb79nFismyUdtyICPOCfcEy6wqHKZKBuo76ibwaApCCIBBQXU+2CEI
	 63cz0LIpfVyiw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 02/20] thermal: core: Rearrange PM notification code
Date: Sat, 14 Sep 2024 12:27:17 +0200
Message-ID: <4940614.GXAFRqVoOG@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=45 Fuz1=45 Fuz2=45

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the code run for each thermal zone by the thermal PM notify
handler to separate functions and use the thermal zone guard to
implement locking in them.

This will help to make some subsequent changes look somewhat more
straightforward, among other things.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   84 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1662,6 +1662,44 @@ static void thermal_zone_device_resume(s
 	tz->resuming = false;
 }
 
+static void thermal_zone_pm_prepare(struct thermal_zone_device *tz)
+{
+	guard(thermal_zone)(tz);
+
+	if (tz->resuming) {
+		/*
+		 * thermal_zone_device_resume() queued up for this zone has not
+		 * acquired the lock yet, so release it to let the function run
+		 * and wait util it has done the work.
+		 */
+		mutex_unlock(&tz->lock);
+
+		wait_for_completion(&tz->resume);
+
+		mutex_lock(&tz->lock);
+	}
+
+	tz->suspended = true;
+}
+
+static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
+{
+	guard(thermal_zone)(tz);
+
+	cancel_delayed_work(&tz->poll_queue);
+
+	reinit_completion(&tz->resume);
+	tz->resuming = true;
+
+	/*
+	 * Replace the work function with the resume one, which will restore the
+	 * original work function and schedule the polling work if needed.
+	 */
+	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
+	/* Queue up the work without a delay. */
+	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
+}
+
 static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
@@ -1673,27 +1711,8 @@ static int thermal_pm_notify(struct noti
 	case PM_SUSPEND_PREPARE:
 		mutex_lock(&thermal_list_lock);
 
-		list_for_each_entry(tz, &thermal_tz_list, node) {
-			mutex_lock(&tz->lock);
-
-			if (tz->resuming) {
-				/*
-				 * thermal_zone_device_resume() queued up for
-				 * this zone has not acquired the lock yet, so
-				 * release it to let the function run and wait
-				 * util it has done the work.
-				 */
-				mutex_unlock(&tz->lock);
-
-				wait_for_completion(&tz->resume);
-
-				mutex_lock(&tz->lock);
-			}
-
-			tz->suspended = true;
-
-			mutex_unlock(&tz->lock);
-		}
+		list_for_each_entry(tz, &thermal_tz_list, node)
+			thermal_zone_pm_prepare(tz);
 
 		mutex_unlock(&thermal_list_lock);
 		break;
@@ -1702,27 +1721,8 @@ static int thermal_pm_notify(struct noti
 	case PM_POST_SUSPEND:
 		mutex_lock(&thermal_list_lock);
 
-		list_for_each_entry(tz, &thermal_tz_list, node) {
-			mutex_lock(&tz->lock);
-
-			cancel_delayed_work(&tz->poll_queue);
-
-			reinit_completion(&tz->resume);
-			tz->resuming = true;
-
-			/*
-			 * Replace the work function with the resume one, which
-			 * will restore the original work function and schedule
-			 * the polling work if needed.
-			 */
-			INIT_DELAYED_WORK(&tz->poll_queue,
-					  thermal_zone_device_resume);
-			/* Queue up the work without a delay. */
-			mod_delayed_work(system_freezable_power_efficient_wq,
-					 &tz->poll_queue, 0);
-
-			mutex_unlock(&tz->lock);
-		}
+		list_for_each_entry(tz, &thermal_tz_list, node)
+			thermal_zone_pm_complete(tz);
 
 		mutex_unlock(&thermal_list_lock);
 		break;




