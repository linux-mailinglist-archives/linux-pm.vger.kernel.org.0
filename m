Return-Path: <linux-pm+bounces-12769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF395BEFA
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 21:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92368285AA1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378331CE6FD;
	Thu, 22 Aug 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sa0Ey35s"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1A1C9ED9;
	Thu, 22 Aug 2024 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355365; cv=none; b=dU5l8e10u/0RPzCKSE/hZznk0PoKQ4LQcAB+Emn26vqLMoBPY1h+QDj7ocDzY/sum+SfSMKXfPCpzcZ2nZIAR7hGYVfsTx49G/tgmN1BgfQbk2I8B43COiSawQxRV5MSRi2rTmVR3i00pC0oGOCdCW6nrQ3roOZfdotQ/Z+HUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355365; c=relaxed/simple;
	bh=T+iCPLKGp1giRFibjyR4hsCwo3Qni64/av4ClDCe4II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVElOFQ04cYelTF6U6zZTKPAKoR5E2RLgQnGk1XhY2QbrQo3bn3ZyJ/YgYYmu4+wJi0TViXugXS2nyRjROORc5mXlum/vvLwX8OyC8Hj8x5PmJ4md52Qj7KRzjJiRg8Hh3opDjylHqbqpMNFwRlEqKT7NOVnabqNcw3IPFBEKa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sa0Ey35s reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3997934921ddacdf; Thu, 22 Aug 2024 21:36:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8CD556F0E2D;
	Thu, 22 Aug 2024 21:36:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724355361;
	bh=T+iCPLKGp1giRFibjyR4hsCwo3Qni64/av4ClDCe4II=;
	h=From:Subject:Date;
	b=sa0Ey35scqCCNm7XeCvsQHJGeCXix7BVXCfNOC+hvETXnmKbY5RgmTUjok9vyPp4I
	 QfjvEpZF6rCbRu+FkhI/Eyljw3IDGAcAP3qdfWzZ+nz2PO9IWsB3TstK1LpQuorZ5r
	 tc9Lwe3Iy/XD3eaKHJ0Z54DZgH2Fv1K98+ainRlO48tkJgXAf9SWL4/VoxrnCZecTq
	 57Y0ZC8EK6h0vmpsAnzK0h4ACGddT/X962gJYtnk8dQGhOH3lwBpOzfTegETV9WjYS
	 CCxZGdAdLinzGovz4Lns8fSJPgGdkT+L3XSmyZJSDCvg/RwQxwqJONzFyBjeBfX65O
	 y33y36ejUZwrw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject:
 [PATCH v1 1/3] thermal: core: Rename cdev-to-thermal-zone bind/unbind
 functions
Date: Thu, 22 Aug 2024 21:24:35 +0200
Message-ID: <6093162.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdr
 lhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhngheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename thermal_zone_cdev_binding() and thermal_zone_cdev_unbinding()
to thermal_zone_cdev_bind() and thermal_zone_cdev_unbind(), respectively,
to make the naming more consistent with the rest of the code.

No functional impact.

Link: https://lore.kernel.org/linux-pm/19beefd9-d3f9-4d43-a45d-d241996de2d0@linaro.org/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -937,8 +937,8 @@ void print_bind_err_msg(struct thermal_z
 		cdev->type, thermal_zone_trip_id(tz, trip), ret);
 }
 
-static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
-				      struct thermal_cooling_device *cdev)
+static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
+				   struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
 
@@ -1063,7 +1063,7 @@ __thermal_cooling_device_register(struct
 
 	/* Update binding information for 'this' new cdev */
 	list_for_each_entry(pos, &thermal_tz_list, node)
-		thermal_zone_cdev_binding(pos, cdev);
+		thermal_zone_cdev_bind(pos, cdev);
 
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
@@ -1264,8 +1264,8 @@ unlock_list:
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
-static void thermal_zone_cdev_unbinding(struct thermal_zone_device *tz,
-					struct thermal_cooling_device *cdev)
+static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
+				     struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
 
@@ -1304,7 +1304,7 @@ void thermal_cooling_device_unregister(s
 
 	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node)
-		thermal_zone_cdev_unbinding(tz, cdev);
+		thermal_zone_cdev_unbind(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1517,7 +1517,7 @@ thermal_zone_device_register_with_trips(
 
 	/* Bind cooling devices for this zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		thermal_zone_cdev_binding(tz, cdev);
+		thermal_zone_cdev_bind(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1611,7 +1611,7 @@ void thermal_zone_device_unregister(stru
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		thermal_zone_cdev_unbinding(tz, cdev);
+		thermal_zone_cdev_unbind(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 




