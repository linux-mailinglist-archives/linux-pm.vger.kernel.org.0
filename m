Return-Path: <linux-pm+bounces-10713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63439928DC8
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE536284B0C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21930171095;
	Fri,  5 Jul 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dAZtqxuq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C452170843;
	Fri,  5 Jul 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208045; cv=none; b=Gf+GDpO4ieZlgzTetLO6iz48aVoGHIw4j/NSZZ+ygMab51PucBEiO3ax9wZpGT/rHmKCN1a7TaLQx8P7lWRVDhH4+8Tf9LSrtaOeKHjpL4426mQr1uqEs26ElLEmhI2kL8wHlGDhI+OSPTBuWZVlrqcZu06oHVGHzEFEkLAFj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208045; c=relaxed/simple;
	bh=hOnndz40p3dLR7Q7W8bzL2Ty5pUkFq6GNMa34qE/HUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lu6MBiwsZHiXcUFQycaPvYqGCBI37EQ+yTsG0r8REZ7xURkS/FKN3hrr5qrveng4AFC5sU7IJ+6lcub7mUg1lMYpz6tC4FvVvWvmJ4KDZq/brW9+vCr6kvRW4Z3oZE7YSWv8DaEY95oqXDF4RVWiDuxyR/D5ziavJqJMbX02Pqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dAZtqxuq reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 21aecca496d61b59; Fri, 5 Jul 2024 21:34:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CA10F7F5773;
	Fri,  5 Jul 2024 21:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720208040;
	bh=hOnndz40p3dLR7Q7W8bzL2Ty5pUkFq6GNMa34qE/HUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dAZtqxuqRIyLYa17RiBEE7Ch33F6c2f8i7HJOc2VTxljI4lwmEmUdmKLFMztvClPz
	 TvTGtes9Y63y8AItiJahaOfSgrpJ2yptRnIqt70nympT2qM/OIAtxbLuNmif0yUOJC
	 yCnocHH3IjxdeCkvqZrw9MoBxQurIu0r6qgpYGUp0dtC2KadHrKhUWqDYRS7TIdSZc
	 /D2KqzTqizgbH6FZXzUy9PbOOBf1uubdVmsyihQG8IhohqdeJJkC7bb57eIDUNyS5R
	 cA7u/PW+ud3beDoHt6k6W2TjDk1VPvdpyBkdjLZDRa6okIvcIoiUZ2Zqo8vAjaKPeT
	 GwZ8v3frYalpw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 1/2] thermal: core: Change passive_delay and polling_delay data
 type
Date: Fri, 05 Jul 2024 21:32:40 +0200
Message-ID: <1898833.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <4585590.LvFx2qVVIh@rjwysocki.net>
References: <4585590.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddufeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is better to use unsigned int as the data type for the passive_delay
and polling_delay arguments of thermal_zone_device_register_with_trips()
because they are implicitly cast to unsigned int anyway in
thermal_set_delay_jiffies() and if they happen to be negative at that
point, the resulting behavior may not be as desired.

Update the thermal_zone_device_register_with_trips() definition
accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This also allows the second patch to be simpler because it need not
worry about possible negative polling delay values.

---
 drivers/thermal/thermal_core.c |    3 ++-
 include/linux/thermal.h        |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1359,7 +1359,8 @@ thermal_zone_device_register_with_trips(
 					int num_trips, void *devdata,
 					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
-					int passive_delay, int polling_delay)
+					unsigned int passive_delay,
+					unsigned int polling_delay)
 {
 	const struct thermal_trip *trip = trips;
 	struct thermal_zone_device *tz;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -221,7 +221,8 @@ struct thermal_zone_device *thermal_zone
 					int num_trips, void *devdata,
 					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
-					int passive_delay, int polling_delay);
+					unsigned int passive_delay,
+					unsigned int polling_delay);
 
 struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const char *type,




