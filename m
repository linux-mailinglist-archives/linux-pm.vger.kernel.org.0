Return-Path: <linux-pm+bounces-8264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECF8D2207
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8A4B24D2F
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571C17556A;
	Tue, 28 May 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="P2ezMosy"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8D173344;
	Tue, 28 May 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915267; cv=none; b=iswEScv96MtHuPDWC15vgmrVA1hW4ngQStpnz2qo32LG8EhUu2nk7Gqei2+H9emSvLF3lRLBvhjjM4oVEf0TvKDzZoTzCV+rA2WPAuuyaS1vUjQwWKwfQ8Lqecv4V23KoOgDG8lLM5BA2JHUIALv50Mr87jhaJS54efGfkzdvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915267; c=relaxed/simple;
	bh=Al4s7Z4rKuBFGP+EYqZnU1TfJh1ZbOKpczMH2SefqCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPqvOTtU4QmCjagqAGyhG8rwJSJLJva5R4FrL7B7bwi3RbPtM6G5YQaUa8FFdfspHegNGPmwnqmoGsi7GnF+LOLIJECtAIv9aHfcuxa8jHQdbPpAe87Y5bZRHdxJZDOqMmel1/nAUF9kGJfGxeN0p7zhxGgaMRrnBm5VJZUBHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=P2ezMosy reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 215b1d134f804519; Tue, 28 May 2024 18:54:23 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 275746A5036;
	Tue, 28 May 2024 18:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716915263;
	bh=Al4s7Z4rKuBFGP+EYqZnU1TfJh1ZbOKpczMH2SefqCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2ezMosyfCfERI8VbHozmmMo8dt6tZ0qwUxaGI8nSiH1N+2LK6Slpg0Bhmje2+97J
	 0rNhIKMt15qcQaGf8u3GFf+Bm4ygdXSN03PDU1IkEt2+egGI/WRKxOZB40Pv9T+6IU
	 gALNzwLzAydWXSPzvVJIJ2a2l79WGvggCbuomyrhodDj1Ml/Ls2t7MbzCnTOgojR59
	 QTgqkgrlo8AzvA/G2Yezx2fPagJTxzKXZ74qhLj9EkIsPH+exwd1thaLx+0so/esnR
	 o58JWkPK/Efn2ZmIwfya4Q8G5uJDu4WiU8fgqViQWJ7Ii82Nd+og1XijNRCmRkp3wq
	 TKFWYvlg2f+SA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 1/5] thermal: trip: Rename __thermal_zone_set_trips() to
 thermal_zone_set_trips()
Date: Tue, 28 May 2024 18:50:09 +0200
Message-ID: <4937015.31r3eYUQgx@kreacher>
In-Reply-To: <12458899.O9o76ZdvQC@kreacher>
References: <12458899.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the pointless double underline prefix from the function name as per
the subject.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_core.c |    2 +-
 drivers/thermal/thermal_core.h |    2 +-
 drivers/thermal/thermal_trip.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -513,7 +513,7 @@ void __thermal_zone_device_update(struct
 	if (tz->temperature == THERMAL_TEMP_INVALID)
 		return;
 
-	__thermal_zone_set_trips(tz);
+	thermal_zone_set_trips(tz);
 
 	tz->notify_event = event;
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -242,7 +242,7 @@ void thermal_governor_update_tz(struct t
 
 const char *thermal_trip_type_name(enum thermal_trip_type trip_type);
 
-void __thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_t
  *
  * It does not return a value
  */
-void __thermal_zone_set_trips(struct thermal_zone_device *tz)
+void thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	const struct thermal_trip_desc *td;
 	int low = -INT_MAX, high = INT_MAX;




