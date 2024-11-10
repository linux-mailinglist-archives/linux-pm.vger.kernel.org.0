Return-Path: <linux-pm+bounces-17283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA1E9C3215
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 14:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711861F2134C
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330415530C;
	Sun, 10 Nov 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DnGbR8tB"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA11527B4;
	Sun, 10 Nov 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731243981; cv=none; b=mk2fTsGr7M6FruOxhBCbfs2jsWjFDx9jqwaFrJyPazj/KdaO0E50qRIbungno1eExPirSabLEQ4SeK2Q3MQZuTuQWxiHj9ny69QXwn+87ViJu+HedqfGJOBYC1no4eUqUUcoQ6EA9+SYqMj3Myn4272s+U3GlFM+o5ZHLFHBSMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731243981; c=relaxed/simple;
	bh=ukpF2+Y5Ke9wT1m8xce/XMCdXKiLhtaqiOtlR3wy6fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIQrMdDsbYe7mHtvyfPWG4qge8TergVaNuP21U8v4hRD3zzmM4mzrV+vGRtFFba+cHxMiAwm0VJSVeOS5Plvj9m2M2Dho3kChlBOcIgK9VfrQorF33efu3nSuN6e6hLbnuPccp3/u8xY3OBem9XE+8fkf00BBRiqIRUmeNuJB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DnGbR8tB; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d13f1c4cd115f8a8; Sun, 10 Nov 2024 14:06:11 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 89CA8838538;
	Sun, 10 Nov 2024 14:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731243971;
	bh=ukpF2+Y5Ke9wT1m8xce/XMCdXKiLhtaqiOtlR3wy6fM=;
	h=From:Subject:Date;
	b=DnGbR8tBBo9EVUmlhPVCsucn3hhKIprzn98YQnh6/pTatQWxQXGrJeF1sEy6hNFlo
	 j+JTaGHArDQs/vLDfRa+eAVAz04M0vm0aBl11aeW8Aph5YIStCuyiXrcJ0OczmoKDe
	 qea/rASZl0ZXcYYeVzPzbRpdIdfnR0KHdKc1A/pwGIbgjM6rxvTruvAysqOxH4p79h
	 KFeNVmOyLtLyYTAIEcMpdPGCSrykgO5Ibr14tnrzCv7HQrxKDc5BbkwITtffMdnudW
	 FEBloj8l3eWU4iiO0PIu1j4ARhT5rn8yPLk9cDzjbgsWaa2DDGqzLuD+u/asjAaetd
	 lH4ewfvOXEVaQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/2] thermal: testing: Simplify tt_get_tt_zone()
Date: Sun, 10 Nov 2024 14:04:47 +0100
Message-ID: <6120304.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <12569620.O9o76ZdvQC@rjwysocki.net>
References: <12569620.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordh
X-DCC--Metrics: v370.home.net.pl 0; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that tt_get_tt_zone() need not use the ret variable in
the tt_thermal_zones list walk and make it return right after
incrementing the reference counter of the matching entry.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/testing/zone.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/testing/zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/testing/zone.c
+++ linux-pm/drivers/thermal/testing/zone.c
@@ -288,19 +288,14 @@ static struct tt_thermal_zone *tt_get_tt
 
 	guard(mutex)(&tt_thermal_zones_lock);
 
-	ret = -EINVAL;
 	list_for_each_entry(tt_zone, &tt_thermal_zones, list_node) {
 		if (tt_zone->id == id) {
 			tt_zone->refcount++;
-			ret = 0;
-			break;
+			return tt_zone;
 		}
 	}
 
-	if (ret)
-		return ERR_PTR(ret);
-
-	return tt_zone;
+	return ERR_PTR(-EINVAL);
 }
 
 static void tt_put_tt_zone(struct tt_thermal_zone *tt_zone)




