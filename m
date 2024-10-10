Return-Path: <linux-pm+bounces-15505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CF99951B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AACB1C22E94
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675A1E8855;
	Thu, 10 Oct 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M7JpjWAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9041C6888;
	Thu, 10 Oct 2024 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598959; cv=none; b=TkgQiRyrG67NvCsTOfaoW5jdd6C/SlGJqpx70KMeyHZb8HYtnnEO9INllt+klN0DXlzUMityN39ZsoPO6wEmPY4Ik98rHR02lRhe2+4drz5PMOBtUMP2T641KSB/5aW93O8MuPlus76qHrKKW68O3Crfu7yAIyb4HqV0JsPmsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598959; c=relaxed/simple;
	bh=sumzPsL3VbmEtcDQCWE1kYMW/Hf/2uP3ESM+uYcdUgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhzF5x8ES+PJWk07v4GWF51P/MgogeS4m1vqYnaNW1DjG/YLHCumOwprEV+wLBKoyw7Y2cvkHK2lz9PvlqAUySpzSufe7jEIOyloTO7S6i/AzBlEHf5/XUHgo11KjIGZZq9Yzz/1v9A4vZ+z/ED4F1XSWmiiP0s3rQvrA6XNI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M7JpjWAd reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3c4a7756e0b0421a; Fri, 11 Oct 2024 00:22:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C3D9E69EF02;
	Fri, 11 Oct 2024 00:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598948;
	bh=sumzPsL3VbmEtcDQCWE1kYMW/Hf/2uP3ESM+uYcdUgo=;
	h=From:Subject:Date;
	b=M7JpjWAdbHV1rJb3EnupvpjsYhqyFUBhuLYTf+L5LvKHTob3xQy7DymkH/2qiYxS7
	 y7N1boqNGbL6dk0z7aS1BOa8BGwGlkchmD2e0CaTStEc9RkAPyFxuS5mIaSM18BMI8
	 nsMb3DMbgVA9AWE77tNgW2myQqcIGqp6kV9mTjC1ZKNxN0JbKpfF+YGBSmz9YbCdgn
	 37IBIIG+YjPiGOEAJhCBk6wdH3aud6JfhLJ4+6jjM278JmLAu/knLiOHj5mje7WLL9
	 iQTdvHYPzVEoeOhTJNDpslckkNSNPr7f1FLqC/XnGqfuM+HEdCakBknnzAHYoLFuXx
	 iY+lJTEDITdxw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 02/11] thermal: core: Add and use a reverse thermal zone guard
Date: Fri, 11 Oct 2024 00:07:11 +0200
Message-ID: <3344086.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a guard for unlocking a locked thermal zone temporarily and use it
in thermal_zone_pm_prepare().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new patch

---
 drivers/thermal/thermal_core.c |    8 +++-----
 drivers/thermal/thermal_core.h |    3 +++
 2 files changed, 6 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1702,11 +1702,9 @@ static void thermal_zone_pm_prepare(stru
 		 * acquired the lock yet, so release it to let the function run
 		 * and wait util it has done the work.
 		 */
-		mutex_unlock(&tz->lock);
-
-		wait_for_completion(&tz->resume);
-
-		mutex_lock(&tz->lock);
+		scoped_guard(thermal_zone_reverse, tz) {
+			wait_for_completion(&tz->resume);
+		}
 	}
 
 	tz->state |= TZ_STATE_FLAG_SUSPENDED;
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -148,6 +148,9 @@ struct thermal_zone_device {
 DEFINE_GUARD(thermal_zone, struct thermal_zone_device *, mutex_lock(&_T->lock),
 	     mutex_unlock(&_T->lock))
 
+DEFINE_GUARD(thermal_zone_reverse, struct thermal_zone_device *,
+	     mutex_unlock(&_T->lock), mutex_lock(&_T->lock))
+
 /* Initial thermal zone temperature. */
 #define THERMAL_TEMP_INIT	INT_MIN
 




