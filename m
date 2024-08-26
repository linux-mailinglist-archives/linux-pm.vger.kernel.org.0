Return-Path: <linux-pm+bounces-12892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F695F6DB
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF11C21ED5
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC971990D1;
	Mon, 26 Aug 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UAQev5N9"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27789195805;
	Mon, 26 Aug 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690366; cv=none; b=uRaG9CPzD2JDzA0U93998zOkKjcfRP+doWByl/MT4LahhldE7pmXK79nJcgLGlT6g939Xm/S+Q6siy4yBq4So7wEBDal1BdSPCNuzWTJDWFEJjs9iOqE475ukNL/JUu8tJ00/GxncWnzJrtEj0EZbNVcCRqawgjKLwKHqCDRqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690366; c=relaxed/simple;
	bh=zmx6kFpyVT5IfRf2UW1B3t25cvlhZfOlajPkJYOuAnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDmfPiH3WaLZR1IqR4egQksbEmBCEZZ5rBr5vFtx8q12kCOq/1cXj1i7CooE/icFz8lWt310f8Ke8+fvF+RpnO9+OEyJUWOMLsOF3PPSs9LEEvSsIbCXjsrmQJqSIA3yhsJt+9hiikMFTcSL5/reof8LliTk01Al6pdP1YBfDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UAQev5N9 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 12cef64563457834; Mon, 26 Aug 2024 18:39:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id ACCA5921952;
	Mon, 26 Aug 2024 18:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724690362;
	bh=zmx6kFpyVT5IfRf2UW1B3t25cvlhZfOlajPkJYOuAnY=;
	h=From:Subject:Date;
	b=UAQev5N9VpAsG0fSPW/6cig7AD3yU1pX39UqcbC84dl8UtytslaR1HwTQbgP8GSuL
	 97VRI+2YBn/pDrnja86uTJPKWJnv9J9pDBpwcID209/5EZTi+3AIoSmDlfUABgdp9r
	 vy6lG6UixgWdSMkHC8m5CAVHyhpYCnNIC/jXp8rJSGLNdiolM6V5CRI1x3RdqDLstA
	 ysm0xE76rGFaVdhDH9p2tVkNle0PaKJ3A57lhk1qVUWdt/I9jI/VWVHTUihAuqM1Wi
	 22aNIKzF/WbXipbsMpuUdTVhCEA1LGgApZYH7xlNxN13wY9ENRIaHMhpjJYmal4h8Y
	 ohhs8/hia1c6w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject:
 [PATCH v1 2/4] thermal: core: Drop dead code from monitor_thermal_zone()
Date: Mon, 26 Aug 2024 18:31:32 +0200
Message-ID: <10547425.nUPlyArG6x@rjwysocki.net>
In-Reply-To: <2979211.e9J7NaK4W3@rjwysocki.net>
References: <2979211.e9J7NaK4W3@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdp
 rhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhhuhhishhonhhgsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since monitor_thermal_zone() is only called when the given thermal zone
has been enabled, as per the thermal_zone_device_is_enabled() check in
__thermal_zone_device_update(), the tz->mode check in it always
evaluates to "false" and the thermal_zone_device_set_polling()
invocation depending on it is dead code, so drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -364,9 +364,7 @@ static void thermal_zone_recheck(struct
 
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
-	if (tz->mode != THERMAL_DEVICE_ENABLED)
-		thermal_zone_device_set_polling(tz, 0);
-	else if (tz->passive > 0)
+	if (tz->passive > 0)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);




