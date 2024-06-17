Return-Path: <linux-pm+bounces-9361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A690B944
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880891C21311
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A21991CC;
	Mon, 17 Jun 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LOjM8/m9"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AB198E9A;
	Mon, 17 Jun 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647996; cv=none; b=cmFhF0eXe7Udjtwv53udsudz5AhaFuHjXe8ihpcKJgErml/cnkVxDd3jGszad9PeWfgPMFbvqzI7bD68sFOFxTeu4Mkhdb5/SVpn6ni5fAMliqI3+Pnd5XySZ+g3+fUWbLhTk7NlnzO7yySXPbr+9QIQZca3BxPlv9L/nJ9DH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647996; c=relaxed/simple;
	bh=t3L9pZlb1ef35gxwiB6BgoFgkgtd/qn6lkvONqjIbpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKvt649rVT7QZfAfALfUcPUyX2p/RvaT9Drfl62e5MBeK/lXPJFsuY/8H5E4PNAzmS0lrae+J9SYt4JvHmNHQnltjL8alcR5g0AGHRsnlVqFqCZgCQ55gk54rLN9Y4WyIAkJNAoGc3U9pehMiNOwigfWxHJJwkR8GU5Ylelbsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LOjM8/m9; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5d05b64116b05cc2; Mon, 17 Jun 2024 20:13:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 77D3516606FD;
	Mon, 17 Jun 2024 20:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647985;
	bh=t3L9pZlb1ef35gxwiB6BgoFgkgtd/qn6lkvONqjIbpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOjM8/m9DD9PABgboSa26GQeQXU5Bj1Bgg10zdBAQQ47FictLxjfZ3Ity6e8ihs8B
	 pgIUEe06gd0HlAQopzMxMljNKTJo/Pv8Z7pT7zpjnUVs3J3Nnp65l2TE5EU/mYdHMv
	 zLoXZbMJCDC3Du4jwisaqj0VxYtxjus7cxAWWWzLEc9ezdU3iYdeB9qx2IBq9tUPXh
	 hquQnZR6r+Q/dynpAHdlTE72NAPpJqihnp7viPgo3TtKPrv95uHGNaaNu2sOjOjc+t
	 nNoBEh/94NVVN387CTS/Iqu1FhxXWIJwNZDwWZTK5/DBGIOAmM9EqDWHDUokxdeca6
	 pZoVntxKyDPvQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 14/14] thermal: trip: Drop thermal_zone_get_trip()
Date: Mon, 17 Jun 2024 20:12:50 +0200
Message-ID: <6713673.4vTCxPXJkl@kreacher>
In-Reply-To: <8409966.T7Z3S40VBb@kreacher>
References: <8409966.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no more callers of thermal_zone_get_trip() in the tree, so
drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_trip.c |   14 --------------
 include/linux/thermal.h        |    2 --
 2 files changed, 16 deletions(-)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -114,20 +114,6 @@ void thermal_zone_set_trips(struct therm
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
 
-int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			  struct thermal_trip *trip)
-{
-	if (!tz || !trip || trip_id < 0 || trip_id >= tz->num_trips)
-		return -EINVAL;
-
-	mutex_lock(&tz->lock);
-	*trip = tz->trips[trip_id].trip;
-	mutex_unlock(&tz->lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
-
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip)
 {
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -202,8 +202,6 @@ static inline void devm_thermal_of_zone_
 }
 #endif
 
-int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			  struct thermal_trip *trip);
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data);




