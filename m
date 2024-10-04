Return-Path: <linux-pm+bounces-15168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71BA990FED
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333DE1F24961
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD001E2820;
	Fri,  4 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kS0B1Gv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16491E04A3;
	Fri,  4 Oct 2024 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070994; cv=none; b=m78k2XlSr27Wz25qs1CUcuIpTgMRIqTfS2qICbXZEGeA2Ji31RNCNXoTaMq6wUgS53ECn7dyqNKQY0fkwSQpAt+3UalyDOd+VVciPRSeEcNlWjeWsM5+jU/zzSPDUWQineoDEUp2FNjuwZD/562OF70e2PLWKvDnCImY8ctBz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070994; c=relaxed/simple;
	bh=XDknYcHwRJCGRiktQeXSdagSDdi3Gy/O0jox8ywDg7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpeFrDip5KTHIO9ltqvQvOx5vDTfXEqmDX8ecOjFkHL305vuWD3aWg4vqUvj+Pc4vh9YEutag0DPy2yJvmInE+IsyKbcaIn8rUFWN17HFG38ZvN7+VKYw7pJdu2/2QXuZ+09y10rjRyPJOUDVzxHHOr4tiBB4iv8vewN5poFtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kS0B1Gv6; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1181a698366aaaa3; Fri, 4 Oct 2024 21:43:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F3A196A9505;
	Fri,  4 Oct 2024 21:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070988;
	bh=XDknYcHwRJCGRiktQeXSdagSDdi3Gy/O0jox8ywDg7o=;
	h=From:Subject:Date;
	b=kS0B1Gv6ch0y9cLw020dsscYAXrVs71ovPwTgJKvI+xg03bETXolcUAB/XRjJQV41
	 cXemUPV7c0OUkE7RfgOEl4JpZiprHQQzPj85xi/U5vDq2OS8v6cZGcZ6zhdL7cNsBw
	 fE18v20qsPFhh4LsxFpOUiw0ewNfORlAZxGwqYFFcBFi+FNT1kD35XyPX3/CfdXXL5
	 5kSY+wNDttq8rf2Ab5FzYdkBBC+oEFuEr6z8CICkSdNKMHABElodS2kKRn75qoB14o
	 sEYGl2fH0eI5YTgb4RlVxMabfKofaSR1iazzvlcOn3ibGcVhefAVLrr1smOx/bVZzU
	 FIdPPbdwnGrdA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 02/12] thermal: core: Rearrange PM notification code
Date: Fri, 04 Oct 2024 21:09:23 +0200
Message-ID: <2299090.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2215082.irdbgypaU6@rjwysocki.net>
References: <2215082.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdi
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the code run for each thermal zone by the thermal PM notify
handler to separate functions.

This will help to make some subsequent changes look somewhat more
straightforward, among other things.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/4940614.GXAFRqVoOG@rjwysocki.net/

v1 -> v2: The thermal zone guard has not been defined yet, so use lock/unlock
          directly on the thermal zone lock and update the changelog accordingly.

---
 drivers/thermal/thermal_core.c |   88 +++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1675,6 +1675,48 @@ static void thermal_zone_device_resume(s
 	mutex_unlock(&tz->lock);
 }
 
+static void thermal_zone_pm_prepare(struct thermal_zone_device *tz)
+{
+	mutex_lock(&tz->lock);
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
+
+	mutex_unlock(&tz->lock);
+}
+
+static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
+{
+	mutex_lock(&tz->lock);
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
+
+	mutex_unlock(&tz->lock);
+}
+
 static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
@@ -1686,27 +1728,8 @@ static int thermal_pm_notify(struct noti
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
@@ -1715,27 +1738,8 @@ static int thermal_pm_notify(struct noti
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




