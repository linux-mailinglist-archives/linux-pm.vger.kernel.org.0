Return-Path: <linux-pm+bounces-10108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732F91A513
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B3B285F15
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA51494CA;
	Thu, 27 Jun 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LSeEZ27p"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6913C3C2;
	Thu, 27 Jun 2024 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487630; cv=none; b=jOxo7zSt2cIpcG6lAawVWUkz8nUbEzAbf0O690t0ltNgy2AF94KozC9bvR/JdHCS/CnoIYolNEzUJFgcUlIh2G/NajnRCcpKHjgS0Q/0lV8QwcUWbiaaXrpRBK/DaAVvZhY/ax89ckZbbKZsBN+UjPundBEuOTxh3UZABh8EEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487630; c=relaxed/simple;
	bh=DWXEX0dsaB+15LsahYeUPqUoI2O6h4hgJP6Eyd+7JFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sa/k8ndWPKa1hpucp4jcw9p4TwypaN+mmTAMua7nIw4tbXQT7bmeNv7IDrOSFwk1dx5IMhzhjTLcxtNmUIMQj6lGtIYjW3R+nO4FSXQv4uFQETjku/QAV+HQl60MRvWEr2VoXK2uhCfw6qB0hXhVrcNzQhCR7yOgqMiwggSCyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LSeEZ27p reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 70e98f95df2867ef; Thu, 27 Jun 2024 13:26:58 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CFF7BA56084;
	Thu, 27 Jun 2024 13:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719487617;
	bh=DWXEX0dsaB+15LsahYeUPqUoI2O6h4hgJP6Eyd+7JFg=;
	h=From:To:Cc:Subject:Date;
	b=LSeEZ27pgbigSohAIZiRsVwbBWQQ9dHzhUSVrCab916LhGaLMJNWFWUUriDV90QVo
	 MspulKIXvDMvHxTUktsACLUjgaF9Obkt5FZ2GPCKKOmQc6B24+vIffEbNviETJAjRB
	 ga9p4hsPUwyeqt9dNmr4wdZgaFTvT/239GSkw/SBtJtWMsmaQ6m7CznY13HVjogYuJ
	 gjOWhGLpBM1teU09NGtz6J9pxfPOJ/ROGQoFuX/RKZlq7VHiYG3bYtxZi900u2Wyog
	 x/3cabuz3M+3fBb3KKHs8vTH7ba01JDOigL3b+2KSS0ylONyhaWSah9Z/3p5QAxSSL
	 QI4gmZ+cxq3Kw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1] thermal: core: Call monitor_thermal_zone() if zone temperature is
 invalid
Date: Thu, 27 Jun 2024 13:26:48 +0200
Message-ID: <2745114.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhrihhnihhv
 rghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
if zone temperature is invalid") caused __thermal_zone_device_update()
to return early if the current thermal zone temperature was invalid.

This was done to avoid running handle_thermal_trip() and governor
callbacks in that case which led to confusion.  However, it went too
far because monitor_thermal_zone() still needs to be called even when
the zone temperature is invalid to ensure that it will be updated
eventually in case thermal polling is enabled and the driver has no
other means to notify the core of zone temperature changes (for example,
it does not register an interrupt handler or ACPI notifier).

Accordingly, make __thermal_zone_device_update() call
monitor_thermal_zone() when it skips the other actions due to
invalid zone temperature.

Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -514,7 +514,7 @@ void __thermal_zone_device_update(struct
 	update_temperature(tz);
 
 	if (tz->temperature == THERMAL_TEMP_INVALID)
-		return;
+		goto monitor;
 
 	tz->notify_event = event;
 
@@ -536,6 +536,7 @@ void __thermal_zone_device_update(struct
 
 	thermal_debug_update_trip_stats(tz);
 
+monitor:
 	monitor_thermal_zone(tz);
 }
 




