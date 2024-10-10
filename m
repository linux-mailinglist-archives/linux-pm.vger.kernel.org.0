Return-Path: <linux-pm+bounces-15501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D2999514
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B861B217CC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EBB1E6DD5;
	Thu, 10 Oct 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="IrJH9oWK"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1B1E2315;
	Thu, 10 Oct 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598958; cv=none; b=ZdQb4my/rLhT+mgHqj5zEEafklPx2nC8cFpZOXlIxZnnyYlq1adehkHwrzKZjb5kPxaiRmVZU34TeKG6C35XFhRqa9nGdl8QNjChuWWsVPaoxufwmIY4ozoqCEF6ohQHC7LG6bGbItHVeMTatld61foS6kpsk+Fc9AYG8m6/oaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598958; c=relaxed/simple;
	bh=6wJf8qwNZabXARs2oRAqCqXVBZZc0JIY1+aXfocLsq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZ1AmHjnE49Jo7vfuGhNzqCjUseBLLFZzC3dSns0YOe1ZEPGkpgKhhuSIg0Ap01LdZQuB4LZGOM82hD6omWbVj5HFVZO4QvtJzFE5QNwL1JJB8JRswkkjIWUDfQq5kT7DFZuX6hah1PQ0DwZUMwvBC7Y62Lwait6ak88cplZM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=IrJH9oWK reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 173ccb3c50bd765f; Fri, 11 Oct 2024 00:22:26 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 890B969EF02;
	Fri, 11 Oct 2024 00:22:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598946;
	bh=6wJf8qwNZabXARs2oRAqCqXVBZZc0JIY1+aXfocLsq0=;
	h=From:Subject:Date;
	b=IrJH9oWKwBNavtG94OtlC6mg+d8ZQk/aLlO3DyrNo91K/E40LmHQyhr0j8GUwAPby
	 TTTo8AylsRTKlGi30SGHFAEUKnpDuXXYe9zLppGzoCmosc9iqQvy4Pg66D/k6tCobV
	 aetgIKnVCj295XukDg3+C4ab/LThyu1sZIHCdN5XqzML3B7ECwXUnBIHk/u0PpfitJ
	 ytNn8wcu6CUgQFkHxd5cNYI+IOW0e1YXzRTQrc6poDgOQ2bAIldlXfZbRK6Of1ngBJ
	 bXLIt4n9Ciglp1mhtsF0JWMOMEQz+UaCePGkcevAo6SmMbtkFFRcbZoT6yeVhZP6Lj
	 zMGxywOoRAotA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 08/11] thermal: core: Introduce thermal_cdev_update_nocheck()
Date: Fri, 11 Oct 2024 00:16:54 +0200
Message-ID: <1835097.VLH7GnMWUR@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Three thermal governors call __thermal_cdev_update() under the
cdev lock without doing any checks, so in order to reduce the
related code duplication, introduce a new helper function called
thermal_cdev_update_nocheck() for them and make them use it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/3791590.MHq7AAxBmi@rjwysocki.net/

---
 drivers/thermal/gov_bang_bang.c       |    4 +---
 drivers/thermal/gov_fair_share.c      |    4 +---
 drivers/thermal/gov_power_allocator.c |    5 ++---
 drivers/thermal/thermal_core.h        |    1 +
 drivers/thermal/thermal_helpers.c     |   13 +++++++++++++
 5 files changed, 18 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -30,9 +30,7 @@ static void bang_bang_set_instance_targe
 
 	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 
-	mutex_lock(&instance->cdev->lock);
-	__thermal_cdev_update(instance->cdev);
-	mutex_unlock(&instance->cdev->lock);
+	thermal_cdev_update_nocheck(instance->cdev);
 }
 
 /**
Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -89,9 +89,7 @@ static void fair_share_throttle(struct t
 		}
 		instance->target = div_u64(dividend, divisor);
 
-		mutex_lock(&cdev->lock);
-		__thermal_cdev_update(cdev);
-		mutex_unlock(&cdev->lock);
+		thermal_cdev_update_nocheck(cdev);
 	}
 }
 
Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -322,9 +322,8 @@ power_actor_set_power(struct thermal_coo
 		return ret;
 
 	instance->target = clamp_val(state, instance->lower, instance->upper);
-	mutex_lock(&cdev->lock);
-	__thermal_cdev_update(cdev);
-	mutex_unlock(&cdev->lock);
+
+	thermal_cdev_update_nocheck(cdev);
 
 	return 0;
 }
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -213,6 +213,7 @@ static inline bool cdev_is_power_actor(s
 }
 
 void thermal_cdev_update(struct thermal_cooling_device *);
+void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip);
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -206,6 +206,19 @@ void thermal_cdev_update(struct thermal_
 }
 
 /**
+ * thermal_cdev_update_nocheck() - Unconditionally update cooling device state
+ * @cdev: Target cooling device.
+ */
+void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev)
+{
+	mutex_lock(&cdev->lock);
+
+	__thermal_cdev_update(cdev);
+
+	mutex_unlock(&cdev->lock);
+}
+
+/**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
  * @tz: thermal zone device with the slope attribute
  *




