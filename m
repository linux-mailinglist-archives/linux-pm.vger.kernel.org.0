Return-Path: <linux-pm+bounces-17341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B570D9C489E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D70B2EB56
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1CA1BC094;
	Mon, 11 Nov 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c1vjcDsC"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B2159596;
	Mon, 11 Nov 2024 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361212; cv=none; b=iv4asz4UDETTdseosllhIqgP+s1/xGB71vZHMSNdpwdR+g+cStnDfJq14k+CDho+Kkg5y8UsQQT6GKj8rHpO1WzzrmOzvodEQEpv7YeZaCIfaVMU5z1sV/eFg3Joivr7McKDOGwUgQLUs5aW4XkLQyP8cJPc35iySXgO44ANTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361212; c=relaxed/simple;
	bh=sA4S5GrurcnvZwXK+Q7lWveGwLgSBYO/MtiyCWSY88g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TGbuhmP3HS0POMsrRstLTSffSxWR4umNFMLixgyDao4lc6nLgYvU94x5/zvRTLec/9mBdTV+3p08Gm0jW3x1RBpc7gNBe1+TbN7Z784+JezIClPv/xeLgRfn4LAeSMKgUnm+/fuF7EjT91es49vBgLZi/ykQGvcNleNhexsPY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c1vjcDsC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361208;
	bh=sA4S5GrurcnvZwXK+Q7lWveGwLgSBYO/MtiyCWSY88g=;
	h=From:Subject:Date:To:Cc:From;
	b=c1vjcDsCvMUttwepDX2XEXb9W10YiQkrUR+19fl6eixaQSlEjX4PSX/Tgd7xMEXai
	 Ojlf2eOc1VJFTjsiwGirHkS69iepXVwf9CqzNnAnOTyADvHAnYNmRJN1yiXQQCPHuc
	 1Z7XD/4Af2mijd3ZUNnZO8mtjAgOADkq6dr8w1fY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 0/9] power: supply: extension API
Date: Mon, 11 Nov 2024 22:40:02 +0100
Message-Id: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALJ5MmcC/3XQ3Q6CMAwF4Fchu3amlDGZV76H8UJYkSUGcAXUG
 N7d4U80US5Pk35tzk0weUcs1tFNeBocu6YOQS0iUVT7+kDS2ZAFAirQgLJtzuQl9217vEq6dFR
 PKyxhZY0yZQrGGhG2W0+luzzk7S7kynHX+Ovj0BBP07epZ80hliBzlWpt0EBui82ZHDMXVV8ta
 +rEBA/4jWXzGAYMbWGTNIcY9/YvlnwwA2oeSwKmkUrKTVJm9PvZ+OzA06kPpXavIsbxDkd0+GJ
 yAQAA
X-Change-ID: 20240602-power-supply-extensions-07d949f509d9
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=4188;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sA4S5GrurcnvZwXK+Q7lWveGwLgSBYO/MtiyCWSY88g=;
 b=uYldgXVTiNhz+gLJBqywFV59dxJa69QAU+2IInUNJYgpDJHNP1ryCIvuVQvcPn0dSkoWQvH4t
 XIe3TwT62V2AA9677YWAngGVVrmO+AYWHrr2XHkiSw2sge2ul+9UAXJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Introduce a mechanism for drivers to extend the properties implemented
by a power supply.

Motivation
----------

Various drivers, mostly in platform/x86 extend the ACPI battery driver
with additional sysfs attributes to implement more UAPIs than are
exposed through ACPI by using various side-channels, like WMI,
nonstandard ACPI or EC communication.

While the created sysfs attributes look similar to the attributes
provided by the powersupply core, there are various deficiencies:

* They don't show up in uevent payload.
* They can't be queried with the standard in-kernel APIs.
* They don't work with triggers.
* The extending driver has to reimplement all of the parsing,
  formatting and sysfs display logic.
* Writing a extension driver is completely different from writing a
  normal power supply driver.
* ~Properties can not be properly overriden.~
  (Overriding is now explicitly forbidden)

The proposed extension API avoids all of these issues.
An extension is just a "struct power_supply_ext" with the same kind of
callbacks as in a normal "struct power_supply_desc".

The API is meant to be used via battery_hook_register(), the same way as
the current extensions.

When testing, please enable lockdep to make sure the locking is correct.

Contents
--------

* Patch 1 to 6 are preparation patches.
* Patch 7 implements the extension API itself.
* Patch 8 adds extension support to test_power.c
* Patch 9 converts the in-tree cros_charge-control driver to the
  extension API.

Open issues
-----------

* As this is only useful with the hooks of CONFIG_ACPI_BATTERY, should
  it also be gated behind this or another config?
* Is an rw_semaphore acceptable?

[0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v4:
- Drop RFC state
- Integrate locking commit
- Reregister hwmon device
- Link to v3: https://lore.kernel.org/r/20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net

Changes in v3:
- Make naming more consistent
- Readd locking
- Allow multiple active extensions
- Allow passing a "void *ext_data" when registering
- Switch example driver from system76 to cros_charge-control
- Link to v2: https://lore.kernel.org/r/20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net

Changes in v2:
- Drop locking patch, let's figure out the API first
- Allow registration of multiple extensions
- Pass extension to extension callbacks as parameter
- Disallow property overlap between extensions and core psy
- Drop system76/pdx86 maintainers, as the system76 changes are only RFC
  state anyways
- Link to v1: https://lore.kernel.org/r/20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net

---
Thomas Weißschuh (9):
      power: supply: sysfs: print single value in uevent for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
      power: supply: core: rename psy_has_property() to psy_desc_has_property()
      power: supply: core: introduce power_supply_has_property()
      power: supply: hwmon: prepare for power supply extensions
      power: supply: sysfs: prepare for power supply extensions
      power: supply: sysfs: rework uevent property loop
      power: supply: core: implement extension API
      power: supply: test-power: implement a power supply extension
      power: supply: cros_charge-control: use power_supply extensions

 drivers/power/supply/cros_charge-control.c | 205 +++++++++++------------------
 drivers/power/supply/power_supply.h        |  16 +++
 drivers/power/supply/power_supply_core.c   | 175 ++++++++++++++++++++++--
 drivers/power/supply/power_supply_hwmon.c  |  50 ++++---
 drivers/power/supply/power_supply_sysfs.c  |  85 ++++++------
 drivers/power/supply/test_power.c          | 102 ++++++++++++++
 include/linux/power_supply.h               |  32 +++++
 7 files changed, 456 insertions(+), 209 deletions(-)
---
base-commit: 83bce34420eaf91506957703bf9a31d8581ed6cb
change-id: 20240602-power-supply-extensions-07d949f509d9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


