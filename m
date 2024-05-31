Return-Path: <linux-pm+bounces-8455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E58D60DC
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D21C23BA3
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED215749D;
	Fri, 31 May 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4oqvGQ6"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD67142642
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155699; cv=none; b=szw0wrAa50UXwSHDNUSVpY7ElCjj9vdJY0wqs5YRxIL/OMMAlS1Glkuhu5cSSjBrjHMAVtJZpUmET6+Sr5kg3Mk0O2e5Qz2yJv2lRqZGagFNIeSYTTAqZbw89R84+rFc/aY+jh+6zftc8rNxi4Mv/uPH3RmxjMA+k4EVHGYGKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155699; c=relaxed/simple;
	bh=Y1m4p/TcgWbBgijIUIAVXXb7JuJ3t/UEeBbhBQZOjl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ne2wB2Usyfcc9U7J1YnR23QIv8croxmn17ezgdIWlrpuF7tEujc/JisuLzXk4TTOhL/C/zWNuIZaFYpMs+0T/WGYdQdMrg5VE1OMyMDJ9Uk8wKKqv9hewlXh2SPDY/1n3av7xmzgpH0EmqaRvAib6dwtoxiIhlcperFIXtp+t4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4oqvGQ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717155696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LhaYMn6Ko6UIAVKT86bloZ0sX/E9fzLv8HDDyDq2PMM=;
	b=N4oqvGQ6ejV9bQv5M4bpul5jRdQ9DSmNZJs/W38VLlYudheWQYFCCTradqbMHT8/gEwWo0
	XpoXiAw7PiOspl4DvjQDq+g6ikgyz0KMEopLAmhWrOGwFIkte1dZnNBCxAx/OrrooI8+IX
	+c75Ibj5CpekPnMA54MjoQqKFuNyw58=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-lxA8LgfqN1WrQlkrCvoi7w-1; Fri,
 31 May 2024 07:41:33 -0400
X-MC-Unique: lxA8LgfqN1WrQlkrCvoi7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE9503C025AD;
	Fri, 31 May 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 62C69740F;
	Fri, 31 May 2024 11:41:30 +0000 (UTC)
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
Subject: [PATCH v10 0/6] KTD2026 indicator LED for X86 Xiaomi Pad2
Date: Fri, 31 May 2024 13:41:18 +0200
Message-ID: <20240531114124.45346-1-hdegoede@redhat.com>
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

Here is v10 of Kate's series to add support for Xiaomi Pad2 indicator LED,
this is unchanged from v9 except for being rebased on top of 6.10-rc1 and
dropping patch 7/7 since that one has been merged through the pdx86 tree.

Patch 6/6 has an Acked-by from Sebastien for merging this patch through
the leds tree since it depends on the earlier patches.

I have some further power-supply LED triggers work pending:
https://lore.kernel.org/linux-pm/20240510194012.138192-1-hdegoede@redhat.com/
which applies on top of this series. So this is going to either require
an IB for Sebastian to merge into his tree before applying those, or
(once ready) that series can be applied through the LEDs tree too. Since this
follow up series deals with LED triggers I think that either way makes sense.

This work includes:
1. Migrate the original driver to fwnode to support x86 platforms.
2. Support for multi-color LED trigger events.
3. The LED shows orange when charging and the LED shows green when the
   battery is full.

--
Changes in v10:
1. Rebased on top of 6.10-rc1
2. Drop patch 7/7 since that one has been merged through the pdx86 tree

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

Kate Hsuan (3):
  leds: rgb: leds-ktd202x: Get device properties through fwnode to
    support ACPI
  leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
  power: supply: power-supply-leds: Add charging_orange_full_green
    trigger for RGB LED

 drivers/leds/led-class-multicolor.c      |  1 +
 drivers/leds/led-core.c                  | 31 +++++++++
 drivers/leds/led-triggers.c              | 20 ++++++
 drivers/leds/rgb/Kconfig                 |  1 -
 drivers/leds/rgb/leds-ktd202x.c          | 80 ++++++++++++++----------
 drivers/power/supply/power_supply_leds.c | 23 +++++++
 include/linux/leds.h                     | 26 ++++++++
 include/linux/power_supply.h             |  2 +
 8 files changed, 149 insertions(+), 35 deletions(-)

-- 
2.45.1


