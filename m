Return-Path: <linux-pm+bounces-19067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190949ED6E5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2A02824CE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119092210E5;
	Wed, 11 Dec 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sxIkc2cz"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DAE200BA9;
	Wed, 11 Dec 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947085; cv=none; b=aveAQyqcteKA1O/dq+nshXZHO+nuz3ozY/uSSg7sMG9WrqkN9xxGLstG5aqUP+ZgEtyIbPi0zTlkYSnfJVNqD5uznkPrQ6f1o+1Ec8DoqWjJOTZ04p8zJRRJM8Wq3VjrOxMdePbqZQ/9TQwV6KbsqbcG5jUM7HiYKgn3UzHyW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947085; c=relaxed/simple;
	bh=K9yc/Ys1CTbFvSWOmqHUjMgumzjvSVyWlxbVSYFSEYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=igCBtscO1Wgms+KCuhzfYPlEZwEUD36tuLUxQkeadDBaBKbXCAgkVoSk0Ii6sEMJDS0LAloZSM20UVrNumfLdzY8ldPcHvVppa5wPOcRr2xDM7kIKORQ0Mb+2LIGgit9qeSh8v1bApfeOwQIViQjLTamzrRPGzqCOlWR5VZrVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sxIkc2cz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733947079;
	bh=K9yc/Ys1CTbFvSWOmqHUjMgumzjvSVyWlxbVSYFSEYE=;
	h=From:Subject:Date:To:Cc:From;
	b=sxIkc2czWxgHvbnmj/729epw7ynwppG2nql9bh1BsYYp+RCiu1/MqPs9gMY+jJwgp
	 NA0U1/QOp1/aMTcwxfu2CIdudFdnZli6jEAoe+gFaPMKM0s7Q2o8NwsUjqKW9UnkRx
	 f36jWVQo7kLRK7uKLx77EIJUkWc6zmwq8ytu90bg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 0/4] power: supply: extension API
Date: Wed, 11 Dec 2024 20:57:54 +0100
Message-Id: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMLuWWcC/3XRTW6DMBAF4KtEXtfV2NgGd9V7VFkAHhdLFVAbS
 KKIu2dIf1Kp2Ltnab4Z6V1ZwhgwsZfDlUVcQgpDT8E8HVjb1f078uAoMwlSgQHJx+GEkad5HD8
 uHM8T9ttI4lA6q6zXYJ1lND1G9OF8l9+OlLuQpiFe7osWsf3+mCZrLoIDb5Q2xkoLjWtfTxhSS
 m03d889TmyDF/kXq/KYJEy61hW6ASFrt4sVD8yCymMFYUaix8YWvsL9y9QvJujlMUVYSRuFUq6
 uK9zF9AOToPOYJsyDt9a4RhWq/IetX+1E/Jyp7um7onW9ARLPDdgMAgAA
X-Change-ID: 20240602-power-supply-extensions-07d949f509d9
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733947078; l=4647;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K9yc/Ys1CTbFvSWOmqHUjMgumzjvSVyWlxbVSYFSEYE=;
 b=tt178b2xZNdHPRXo0xYqx035UAXyRX1iIb/2ucabjHIoOaMBEu5K/r3k/r6qByVcbhMHsPAYV
 8+M8sbBglvzCkDLVbYw46wp0vjcNnXOZFKI9mTLF8GsmXFKIM4DsAnU
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
Further usecases are fuel gauges and the existing battery_info
properties.

When testing, please enable lockdep to make sure the locking is correct.

The series is based on the linux-power-supply/for-next branch.
It also depends on some recent fixes not yet available in the for-next
branch [0].

[0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v6:
- Drop alreay picked up ACPI battery hook rename patch
- Only return bool from power_supply_property_is_writeable()
- Improve naming for test_power symbols
- Integrate cros_charge-control fixes from the psy/fixes branch
- Add sysfs UAPI for extension discovery
- Use __must_check on API
- Make power_supply_for_each_extension() safer.
  (And uglier, ideas welcome)
- Link to v5: https://lore.kernel.org/r/20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net

Changes in v5:
- Drop already picked up patches
- Simplify power_supply_ext_has_property()
- Handle failure of power_supply_update_sysfs_and_hwmon()
- Reduce some locking scopes
- Add missing locking to power_supply_show_charge_behaviour()
- Improve sanity checks in power_supply_register_extension()
- Implement writeable property in test_power battery
- Rename ACPI battery hook messages for clarity
- Link to v4: https://lore.kernel.org/r/20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net

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
Thomas Weißschuh (4):
      power: supply: core: implement extension API
      power: supply: test-power: implement a power supply extension
      power: supply: cros_charge-control: implement a power supply extension
      power: supply: core: add UAPI to discover currently used extensions

 Documentation/ABI/testing/sysfs-class-power |   9 ++
 drivers/power/supply/cros_charge-control.c  | 200 ++++++++++++----------------
 drivers/power/supply/power_supply.h         |  19 +++
 drivers/power/supply/power_supply_core.c    | 177 ++++++++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c   |  36 ++++-
 drivers/power/supply/test_power.c           | 113 ++++++++++++++++
 include/linux/power_supply.h                |  35 +++++
 7 files changed, 467 insertions(+), 122 deletions(-)
---
base-commit: 810dde9dad8222f3b831cf5179927fc66fc6a006
change-id: 20240602-power-supply-extensions-07d949f509d9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


