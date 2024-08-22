Return-Path: <linux-pm+bounces-12768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EB95BEF6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C431C22FA3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE959188937;
	Thu, 22 Aug 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Op5BHhGk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9528EA;
	Thu, 22 Aug 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355240; cv=none; b=UQ0HMIOi7ku1pmhObaDVo+dSX38zpRhqZCdVG+gmpLWic7iY6Go4jXReDHCrtSmT9PdPv3qSKjZyLerH1SxYqt4pSRvujIeVro/lXFy9HyI7u4GIfbi2M7E7N1D1L/xALaHIUj8HaNHk9QXg7qgFo4noDxHGYPcg9tcVYGet2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355240; c=relaxed/simple;
	bh=QPkDjNuVRVaT7BYRpVMAc8keX9cRsVBul1f/oRkCzRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mhl/Qn6N89pKkZGZ470zD8qPaHsFv8zH5A9Hc2b6zEaT8MOnFfExOYeuX3y8DVVxMi4RngytzQqdJCuT97FhZWyfBdjWOK5TvfpghDciOZKZndcCsh5j0TPNnnn/i748cAf4PMMtzKZHf1iowzUPv54uer+APIkODFFTOjppm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Op5BHhGk reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1730b97eb82e1659; Thu, 22 Aug 2024 21:33:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A594F6F0E2D;
	Thu, 22 Aug 2024 21:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724355236;
	bh=QPkDjNuVRVaT7BYRpVMAc8keX9cRsVBul1f/oRkCzRE=;
	h=From:Subject:Date;
	b=Op5BHhGkCLsSLELLaSVIWLuio3bRHxUwF5aS8ID9dg0iZCibLDGNGtiXUi/JB5FDZ
	 m7b5PqWDR/YQ/jyYKEz13JHkizJsvpQQL7tOB3nWiWor4r7B1nZN6GQmcA/Jorrwim
	 DQWNKNQq5iwUMtcJXXlPPQY0jTRIF3dbBhsGtIrVnYGo7Z5tW7oPBPirAwILrhm0xT
	 REHqQD9qA28R8XDzro9Yh8Jg2EPQkrQ7K48LpLLbJzFfLRfKbli8YqD4mU+WvpzojB
	 /beSbQtPSnicKzNcD+og0gYmYN0Ptsk6gDKhedyjG90oz9r6hFkMwtuQI29190w7HH
	 cVAkNAPiskYIw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject:
 [PATCH v1 2/3] thermal: core: Drop redundant checks from
 thermal_bind_cdev_to_trip()
Date: Thu, 22 Aug 2024 21:26:09 +0200
Message-ID: <4607540.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <12516814.O9o76ZdvQC@rjwysocki.net>
References: <12516814.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdr
 lhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhngheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since thermal_bind_cdev_to_trip() is only called by
thermal_zone_cdev_binding() under the thermal zone lock and the latter
is only called by thermal_zone_device_register_with_trips() and
__thermal_cooling_device_register(), under thermal_list_lock in both
cases, both lockdep_assert_held() assertions can be dropped from it.

Moreover, in both cases thermal_zone_cdev_binding() is called after
both tz and cdev have been added to the global lists of thermal zones
and cooling device, respectively, so the check against their list nodes
in thermal_bind_cdev_to_trip() is redundant and can be dropped either.

Link: https://lore.kernel.org/linux-pm/CAJZ5v0jwkc2PB+osSkkYF9vJ1Vpp3MFE=cGQmQ2Xzjb3yjVfJg@mail.gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -775,12 +775,6 @@ static int thermal_bind_cdev_to_trip(str
 	bool upper_no_limit;
 	int result;
 
-	lockdep_assert_held(&thermal_list_lock);
-	lockdep_assert_held(&tz->lock);
-
-	if (list_empty(&tz->node) || list_empty(&cdev->node))
-		return -EINVAL;
-
 	/* lower default 0, upper default max_state */
 	if (cool_spec->lower == THERMAL_NO_LIMIT)
 		cool_spec->lower = 0;




