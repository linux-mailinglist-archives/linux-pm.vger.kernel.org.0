Return-Path: <linux-pm+bounces-9360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A3D90B942
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5FE281988
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C7E1991B9;
	Mon, 17 Jun 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="KlgN9XOw"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7571990B7;
	Mon, 17 Jun 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647996; cv=none; b=Cmj+U47PmF1fco6shXfsUj2czhvJJlqmMsjbgaQAa7V0iqE08ej4+E5JjPkyUfXHNSzHPAQ9UIc+WfK2wYIJQf7RSOjuOIhiteUrY/E8y52DX2lB3fQ7LQS8DSfKgrgvJuhJegGrGBx19XNddYWfK+fUjJMcsT8jW3hd+HSjCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647996; c=relaxed/simple;
	bh=KmMhyRmwryZmFf9UlhwvHifgNSUFDVU+PhT5RqTwK+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krbhUBXgvfJ2CICxsHvArvV+n6SPOcEPkbXbSN11tk9z9jFzpvat+73Cal2riKEwrxT1UL9VWzDpd4ctSb7PXGwM0WUxrTIZ8Lm0ur7iGPk7t4m49kqZmluDYglI79kTXbM7ovGCdXgUeZbBPD14vfXQM7HeFTHLHVNyog/HC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=KlgN9XOw; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e54697b8cb00d04a; Mon, 17 Jun 2024 20:13:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CBFA716606FD;
	Mon, 17 Jun 2024 20:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647987;
	bh=KmMhyRmwryZmFf9UlhwvHifgNSUFDVU+PhT5RqTwK+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlgN9XOwrW5Yvm/4F3LF/DMlAFzv14BD6CEGAcxIZZijOpiQ/KTvdt7uP2NlJ+DI2
	 IXX1QOVWQwOgoASSBMLtOTK804tpSf0DAskW+L1gi3jL1MReK/hc32m9gxPH5ZtL3s
	 8hkj2Wag3iruCIqBtIz4Af9+tAdP29sEZUtfJoGkxah6NqC6QKvptEma22fv3tr83Z
	 8SJFW9X6t2/ZSf3FJTc8EeNZ2/EWuHS7FFd39QMVNi9yi5Obw1B0guAwcpCd2w+euQ
	 oIvBspVu2ot0IrubAuLkS5skIi+nCsf9Df33NzLYPm+qJu3nX05cEUi6UjgnSNjLA/
	 i0UvbtpdlI1IA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 11/14] thermal: helpers: Drop get_thermal_instance()
Date: Mon, 17 Jun 2024 20:05:13 +0200
Message-ID: <24232630.ouqheUzb2q@kreacher>
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

There are no more users of get_thermal_instance(), so drop it.

While at it, replace get_instance() returning a pointer to struct
thermal_instance with thermal_instance_present() returning a bool
which is more straightforward.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h    |    5 -----
 drivers/thermal/thermal_helpers.c |   30 ++++++------------------------
 2 files changed, 6 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -191,11 +191,6 @@ void __thermal_cdev_update(struct therma
 
 int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip);
 
-struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
-		     struct thermal_cooling_device *cdev,
-		     int trip);
-
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -39,18 +39,18 @@ int get_tz_trend(struct thermal_zone_dev
 	return trend;
 }
 
-static struct thermal_instance *get_instance(struct thermal_zone_device *tz,
-					     struct thermal_cooling_device *cdev,
-					     const struct thermal_trip *trip)
+static bool thermal_instance_present(struct thermal_zone_device *tz,
+				     struct thermal_cooling_device *cdev,
+				     const struct thermal_trip *trip)
 {
 	struct thermal_instance *ti;
 
 	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
 		if (ti->trip == trip && ti->cdev == cdev)
-			return ti;
+			return true;
 	}
 
-	return NULL;
+	return false;
 }
 
 bool thermal_trip_is_bound_to_cdev(struct thermal_zone_device *tz,
@@ -62,7 +62,7 @@ bool thermal_trip_is_bound_to_cdev(struc
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
-	ret = !!get_instance(tz, cdev, trip);
+	ret = thermal_instance_present(tz, cdev, trip);
 
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
@@ -71,24 +71,6 @@ bool thermal_trip_is_bound_to_cdev(struc
 }
 EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
 
-struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
-		     struct thermal_cooling_device *cdev, int trip_index)
-{
-	struct thermal_instance *ti;
-
-	mutex_lock(&tz->lock);
-	mutex_lock(&cdev->lock);
-
-	ti = get_instance(tz, cdev, &tz->trips[trip_index].trip);
-
-	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
-
-	return ti;
-}
-EXPORT_SYMBOL(get_thermal_instance);
-
 /**
  * __thermal_zone_get_temp() - returns the temperature of a thermal zone
  * @tz: a valid pointer to a struct thermal_zone_device




