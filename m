Return-Path: <linux-pm+bounces-7719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA48C26A0
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFAA282BFA
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F85116D336;
	Fri, 10 May 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gpAKfkfL"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280D12CD84;
	Fri, 10 May 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350843; cv=none; b=sLfJA4LcCza2v9QqmwlLpE5yxytjU/y6caficJtsYy47MFDHP31kZiiuV8H5fp14Pr/R4yPGasn5scz4q6oaCSIWb1C01ZUqwEm+qwJjfNIrg4ORsHUuJxKS4qT1kdsvURPhm89TT5HKG8myZUwE2oT8+ir+6feDr+OQ/0A0Cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350843; c=relaxed/simple;
	bh=jX8k0sZA/4NpcGMGcCtPRk72afCKR9YSs6kcGWfY9AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObSEqINBmQLFJkIyK6xVWhESBGvSz/Ihx7Lotold1Grehhu2vBfEaII4aJPOPStBh+FHy3sFQ8ItbG9paRUWPi93PP8nfsAHorMKPE/EBTZ4rE7tSUkekDjX7RqVlNCW+AXy8fXHs9upUztuPB4gmqSy8uCGA2ihBF6aOb7weKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gpAKfkfL reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 9527010a85f4ad71; Fri, 10 May 2024 16:20:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E19892102F3F;
	Fri, 10 May 2024 16:20:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715350839;
	bh=jX8k0sZA/4NpcGMGcCtPRk72afCKR9YSs6kcGWfY9AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpAKfkfLAtUDGJnYn4LXEue43eipYfwWyXEopoIggcbuTkVBr46nx7tWs7l5l1bWS
	 E6ilDz3lDZHjfRgXsnl4mXXjUr+GV6Fs32U+gqbGU0hlYzl3QSajbS59RRUl9+Qi5A
	 afXH01wQIOiy2rN46RjkYH8gQadBTSyAe741J7jxJvE/IKqML4rGqmEDuHlWprLLdu
	 J6ClL1qskFFBTcalo/2xkbjGRkwGuxN18gOEV0lMO3x0QkHBhtWyU/CDLJvVUURyHg
	 jRygbXoP2riaMdoKBeEJZvbmVp1lGGYEoGYriH/j8W7PyeaBH2qjfbyQ2Nm4mVdeCn
	 LmaYmb7DI99Aw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 5/6] thermal: gov_bang_bang: Drop unnecessary cooling device target
 state checks
Date: Fri, 10 May 2024 16:19:32 +0200
Message-ID: <3570512.iIbC2pHGDl@kreacher>
In-Reply-To: <13518388.uLZWGnKmhe@kreacher>
References: <13518388.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some cooling device target state checks in bang_bang_control()
done before setting the new target state are not necessary after
recent changes, so drop them.

Also avoid updating the target state before checking it for
unexpected values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -57,24 +57,16 @@ static void bang_bang_control(struct the
 		if (instance->trip != trip)
 			continue;
 
-		if (instance->target == THERMAL_NO_TARGET)
-			instance->target = 0;
-
-		if (instance->target != 0 && instance->target != 1) {
+		if (instance->target != 0 && instance->target != 1 &&
+		    instance->target != THERMAL_NO_TARGET)
 			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
 				 instance->target, instance->name);
 
-			instance->target = 1;
-		}
-
 		/*
 		 * Enable the fan when the trip is crossed on the way up and
 		 * disable it when the trip is crossed on the way down.
 		 */
-		if (instance->target == 0 && crossed_up)
-			instance->target = 1;
-		else if (instance->target == 1 && !crossed_up)
-			instance->target = 0;
+		instance->target = crossed_up;
 
 		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 




