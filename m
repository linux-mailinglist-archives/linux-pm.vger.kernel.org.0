Return-Path: <linux-pm+bounces-13613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9A96C76E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA01287F9B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980E1E6DD7;
	Wed,  4 Sep 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cpGmUWwy"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46514037F;
	Wed,  4 Sep 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477954; cv=none; b=QvLpMAbmoyGh6ObpDGcWFaVTwlEBHio7oBhgPXsRhdqjc0jiZa+g/pvFceyEdRHu9qhZd3xohE23E69fZPp0S9SJeSBh6sPMY6LFySpBXxVwQo7IRA15MRdrPlf4MuwJA8ulbanmudVMxFJdHp7nWf7PaVSvFMcdyNLmhWkeubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477954; c=relaxed/simple;
	bh=fTt3UQDXWr0WfqkNcK9NRses1WpSjmsB2JnJm1vdGOY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pE3Tzp48Zh6PfhtikY4v10eZxR2awJt2kg0Otnho+s5TqyDl0ym6kyC2xOniAHkLfkZjLsu0p0S7b5pzA+hRMwukjej01njZCt4GcNYhrWHh+mrSNdD75Z8KeVfQStLFfVX72nFLaRPq5+cbQIA+iqmiLsvTa/m+JIcpCE7X8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cpGmUWwy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477949;
	bh=fTt3UQDXWr0WfqkNcK9NRses1WpSjmsB2JnJm1vdGOY=;
	h=From:Subject:Date:To:Cc:From;
	b=cpGmUWwyRbLk07iw6nkisli9TBMBcC3KbnZAiisyRPL+KNK+/iEwbkH6ZBxMgIojD
	 nBBmVk0d0ZRDrvI592VNZdYUh/Z6iC3wY7E+L9F/ybUFUZRqnl1YfbCyqQoe1TSQXq
	 3Pw99s+cWsQfHzI942jP4FR8hGVxnkp0fi3uDH+c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC v3 0/9] power: supply: extension API
Date: Wed, 04 Sep 2024 21:25:33 +0200
Message-Id: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC202GYC/3XNywrCMBAF0F8pWRtJpw+NK0HwA9yKi7aZ2oCkI
 dMnpf9uDC4E6fLe4Z5ZGKHTSOwULczhoEm3xodkF7GqKcwTuVY+MxCQilwAt+2IjlNv7WvmOHV
 oPhPi4qBkKutMSCWZX1uHtZ6CfGe364U9fNlo6lo3h29DHE5fON+Eh5gLXqZZnkuQolTVeURNR
 FXTN3uDXYAH+MWO2xh4DFSlkqwUMRTqD1vX9Q1pSBn4FQEAAA==
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=4259;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fTt3UQDXWr0WfqkNcK9NRses1WpSjmsB2JnJm1vdGOY=;
 b=P4z4DlIB1CoKXerK5LU2fOjcn0VUhUp95g3cwDh8jwMpVF5bcqIh6v52VfmL6J5bZzYa9Y2H/
 PcKTxhnk6CUATawpJU06tzA1cho7BNIBkqgO4ewQe4mhh7lgWFIuMDe
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

* Patch 1 to 5 are preparation patches.
* Patch 6 implements the extension API itself.
* Patch 7 implements a locking scheme for the extension API.
* Patch 8 adds extension support to test_power.c
* Patch 9 converts the in-tree cros_charge-control driver to the
  extension API.

Open issues
-----------

* Newly registered properties will not show up in hwmon.
  To do that properly would require some changes in the hwmon core.
  As far as I know, no current driver would extend the hwmon properties anyways.
* As this is only useful with the hooks of CONFIG_ACPI_BATTERY, should
  it also be gated behind this or another config?
* Is an rw_semaphore acceptable?

[0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
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
      power: supply: core: rename psy_has_property() to psy_desc_has_property()
      power: supply: core: register thermal zone for battery
      power: supply: hwmon: register battery properties
      power: supply: sysfs: register battery properties
      power: supply: sysfs: rework uevent property loop
      power: supply: core: implement extension API
      power: supply: core: add locking around extension access
      power: supply: test-power: implement a power supply extension
      power: supply: cros_charge-control: use power_supply extensions

 drivers/power/supply/cros_charge-control.c | 207 +++++++++++------------------
 drivers/power/supply/power_supply.h        |  18 +++
 drivers/power/supply/power_supply_core.c   | 169 +++++++++++++++++++++--
 drivers/power/supply/power_supply_hwmon.c  |  52 ++++----
 drivers/power/supply/power_supply_leds.c   |   2 +
 drivers/power/supply/power_supply_sysfs.c  |  65 +++++----
 drivers/power/supply/test_power.c          | 104 +++++++++++++++
 include/linux/power_supply.h               |  33 +++++
 8 files changed, 453 insertions(+), 197 deletions(-)
---
base-commit: d8abb73f584772eaafa95a447c90f1c02dba0dec
change-id: 20240602-power-supply-extensions-07d949f509d9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


