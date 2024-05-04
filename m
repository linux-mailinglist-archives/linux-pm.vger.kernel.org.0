Return-Path: <linux-pm+bounces-7500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4088BBD23
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5D4B211B6
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB929482FA;
	Sat,  4 May 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X61yxeLl"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37B1D52D
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714840882; cv=none; b=GdQUgYrq7ml0Sm6WrELjlywdyAR5opvPOKUHHHVsdZ9JczkgAPhkbjCwuTrJDumAGeUR2YCHHczG0eKpVL18j33poTWv8Ajcq8Ge6/pdFjGhkgZjTjm4nVm7N1nXRwzblxv2QQT5cEcB5xkJf1UgDxYbBs6Dy9/fpx8R2Oa/CzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714840882; c=relaxed/simple;
	bh=JeI5i/otSBcDw8mTqhlf1BX/XHs5LWB2JJksuQBUeY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hh3H4EeqsGKQpMb/5tDh5dgR3Y/yWemOYR+fROsXRTQtwM2tVMozHpSOPHztrf0ag/mFcRM+1kwDGGPi8kHy/NUOe+aLKW+rMfZHkLgdYrhlzGnsC+e0ht8TX6QAxKvXkbkUweqTrBMkcjv7C9Uwl5YoFVvAY5VU+H/XGI8OQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X61yxeLl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714840880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=18lnBJSoaMwnVu6kENVrRhHhONw4WlOFml4NZ1B7Ob8=;
	b=X61yxeLlB3D5bPEOXu6Bx7Crrsn9svj7r5y3yHx19Rn0WKiR51PkZePIorAeHGeoqdt8KD
	lqjdgROFvskFwFRr6z3pqgZDKNqJO5u5GzGtcbe2OJsiIEgIG+73eQJltg/7+PsZWOhLNi
	JvlTYPzwKkDtAbC2u2TPEgx1Ngux/h8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-4PxbQ9v_O_WMCr-a47i-Jg-1; Sat, 04 May 2024 12:41:16 -0400
X-MC-Unique: 4PxbQ9v_O_WMCr-a47i-Jg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6200580E95D;
	Sat,  4 May 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA438EC680;
	Sat,  4 May 2024 16:41:13 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Kate Hsuan <hpa@redhat.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v9 0/7] KTD2026 indicator LED for X86 Xiaomi Pad2
Date: Sat,  4 May 2024 18:40:58 +0200
Message-ID: <20240504164105.114017-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi All,

Here is v9 of Kate's series to add support for Xiaomi Pad2 indicator LED.

I believe this is ready for merging now. Patch 6/7 has an Acked-by from
Sebastien for merging this patch through the leds tree since it depends
on the earlier patches. LEDs tree maintainers please merge patches 1-6,
then patch 7 can be merged through the pdx86 tree independently.

This applies on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git ib-leds-locking-v6.10

This work includes:
1. Added the KTD2026 swnode description to describe the LED controller.
2. Migrated the original driver to fwnode to support x86 platform.
3. Support for multi-color LED trigger events.
4. The LED shows orange when charging and the LED shows green when the
   battery is full.

Moreover, the LED trigger is set to the new trigger, called
"bq27520-0-charging-orange-full-green" for Xiaomi Pad2 so the LED shows
orange when charging and the LED shows green when the battery is full.

--
Changes in v9:
1. Switch to devm_mutex_init()
2. Add Andy's Reviewed-by to the series

Changes in v8:
1. New bugfix: "leds: rgb: leds-ktd202x: Initialize mutex earlier"
2. Make charging_orange_full_green triggers set the colors in RGB order
3. Modify the Pad2 ktd202x fwnode to have the colors in RGB order

Changes in v7:
1. Platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
   indicator LED was included in Hans' branch.
2. Included the tags from the previous version in the commit message.
3. Fixed the comma issue for the structure initialiser.

Changes in v6:
1. The I2C ID table was moved to a separate patch.
2. The LED shows orange when charging.
3. The trigger name was renamed to charging-orange-full-green.
4. The default trigger of Xiaomi Pad2 is
   "bq27520-0-charging-orange-full-green".

Changes in v5:
1. Fix swnode LED color settings.
2. Improve the driver based on the comments.
3. Introduce a LED new API- led_mc_trigger_event() to make the LED
   color can be changed according to the trigger.
4. Introduced a new trigger "charging-red-full-green". The LED will be
   red when charging and the LED will be green when the battery is full.
5. Set the default trigger to "bq27520-0-charging-red-full-green" for
   Xiaomi Pad2.

Changes in v4:
1. Fix double casting.
2. Since force casting a pointer value to int will trigger a compiler
   warning, the type of num_leds was changed to unsigned long.

Changes in v3:
1. Drop the patch "leds-ktd202x: Skip regulator settings for Xiaomi
   pad2"

Changes in v2:
1. Typo and style fixes.
2. The patch 0003 skips all the regulator setup for Xiaomi pad2 since
   KTD2026 on Xiaomi pad2 is already powered by BP25890RTWR. So, the
   sleep can be removed when removing the module.

Regards,

Hans


Hans de Goede (3):
  leds: rgb: leds-ktd202x: Initialize mutex earlier
  leds: core: Add led_mc_set_brightness() function
  leds: trigger: Add led_mc_trigger_event() function

Kate Hsuan (4):
  leds: rgb: leds-ktd202x: Get device properties through fwnode to
    support ACPI
  leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
  power: supply: power-supply-leds: Add charging_orange_full_green
    trigger for RGB LED
  platform: x86-android-tablets: Xiaomi pad2 RGB LED fwnode updates

 drivers/leds/led-class-multicolor.c           |  1 +
 drivers/leds/led-core.c                       | 31 +++++++
 drivers/leds/led-triggers.c                   | 20 +++++
 drivers/leds/rgb/Kconfig                      |  1 -
 drivers/leds/rgb/leds-ktd202x.c               | 80 +++++++++++--------
 .../platform/x86/x86-android-tablets/other.c  |  6 +-
 drivers/power/supply/power_supply_leds.c      | 23 ++++++
 include/linux/leds.h                          | 26 ++++++
 include/linux/power_supply.h                  |  2 +
 9 files changed, 152 insertions(+), 38 deletions(-)

-- 
2.44.0


