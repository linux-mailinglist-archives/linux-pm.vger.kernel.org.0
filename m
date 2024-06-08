Return-Path: <linux-pm+bounces-8816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A590134E
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 21:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98396B21605
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F2210E7;
	Sat,  8 Jun 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fdhTEszS"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF53208BC;
	Sat,  8 Jun 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717874389; cv=none; b=hSNyCuYQsd5WENbn4dJKrxOXQrwTjVWb9c1YHm1fL9SK1C1hyYF7fc/toz+mvoNFwoonUfvMOr7D1sFVmJpFWD70IVtU/YNZpxfJO7RcH1N39WUXU/FSGiE4fQfjvB6Xe3h8s80vngJbhSX9MozYj/cINS0PqWBkbo21wLZTeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717874389; c=relaxed/simple;
	bh=J1etHWagkLZNC0OHxEnXYX9GyyQjfOeFSw+XvKeDAI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aJdi/8yhl71/xpvj1uYq8px+8fg+6MtU/tO18/ZYLQrPUbHUCMS4vYg+zPLNUAF4tnoL6OP358rkGf8P7lOcnzowl6/frThsAiYEeMpiq9wTfHeoJ4DxBGSNoYwSNEpHdWgMeAwz+BOz+fZ7ZrYbl4c7o9XCj/+zZBOExD7xKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fdhTEszS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717874384;
	bh=J1etHWagkLZNC0OHxEnXYX9GyyQjfOeFSw+XvKeDAI4=;
	h=From:Subject:Date:To:Cc:From;
	b=fdhTEszSf+DB06gOHW3zQvtZle6G4kJP5ITg1+S2euPeZ6ckBlFtQb1lX6wRGvlzB
	 Rk8egs79UvEmTUnhne8t8eY0ZCg+xRPTeWTlqUHoz8vYRr1jTTC2oFCwypIbS7E2fA
	 grsjKZsCxh4yDLSyx96aoNu3dBujARRy6l7zyyDc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC v2 0/5] power: supply: extension API
Date: Sat, 08 Jun 2024 21:19:36 +0200
Message-Id: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMiuZGYC/3WNzQrCMBCEX6Xs2ZU0tJF4EgQfwKv0YJutCUgas
 v2l9N2NxavHmeH7ZgWm6IjhnK0QaXTsOp+CPGTQ2Kd/ETqTMkghC6GExNBNFJGHEN4L0tyT/yK
 M4mR0odtSaKMh0SFS6+bd/ID77QpVKq3jvovL/jbm+/QTq7/iMUeBdVEqpaUWtWkuEzlmbuxgj
 556qLZt+wBNXL7OyAAAAA==
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717874383; l=3873;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=J1etHWagkLZNC0OHxEnXYX9GyyQjfOeFSw+XvKeDAI4=;
 b=jY6G1/pWwQmlugzzchGwOFfF8FqgDjtzl33TcfbnsZO/B9X2ztY1bcbxqV4xGfjdD4wpwZday
 kIC2lcQvqqtBa0MKosgYWae0oIJ5emFBrhMBJyewrTEcogX/vqsEtqY
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
  (Overriding is not implemented anymore, can be readded)

The proposed extension API avoids all of these issues.
An extension is just a "struct power_supply_ext" with the same kind of
callbacks as in a normal "struct power_supply_desc".

The API is meant to be used via battery_hook_register(), the same way as
the current extensions.

For example my upcoming cros_ec charge control driver[0] saves 80 lines
of code with this patchset.

Contents
--------

* Patch 1 and 2 are generic preparation patches, that probably make
  sense without this series.
* Patch 3 implements the extension API itself.
* Patch 4 implements a PoC locking scheme for the extension API.
* Patch 5 adds extension support to test_power.c
* Patch 6 converts the in-tree platform/x86/system76 driver to the
  extension API.

Open issues
-----------

* Newly registered properties will not show up in hwmon.
  To do that properly would require some changes in the hwmon core.
  As far as I know, no current driver would extend the hwmon properties anyways.
* As this is only useful with the hooks of CONFIG_ACPI_BATTERY, should
  it also be gated behind this or another config?
* Only one extension can be used at a time.
  So far this should be enough, having more would complicate the
  implementation.
* Is an rw_semaphore acceptable?

[0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Drop locking patch, let's figure out the API first
- Allow registration of multiple extensions
- Pass extension to extension callbacks as parameter
- Disallow property overlap between extensions and core psy
- Drop system76/pdx86 maintainers, as the system76 changes are only RFC
  state anyways
- Link to v1: https://lore.kernel.org/r/20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net

---
Thomas Weißschuh (5):
      power: supply: sysfs: use power_supply_property_is_writeable()
      power: supply: core: avoid iterating properties directly
      power: supply: core: implement extension API
      power: supply: test-power: implement a power supply extension
      platform/x86: system76: Use power_supply extension API

 drivers/platform/x86/system76_acpi.c      |  93 ++++++++++++----------
 drivers/power/supply/power_supply.h       |  12 +++
 drivers/power/supply/power_supply_core.c  | 128 ++++++++++++++++++++++++++++--
 drivers/power/supply/power_supply_hwmon.c |  48 +++++------
 drivers/power/supply/power_supply_sysfs.c |  50 +++++++++---
 drivers/power/supply/test_power.c         | 101 +++++++++++++++++++++++
 include/linux/power_supply.h              |  26 ++++++
 7 files changed, 371 insertions(+), 87 deletions(-)
---
base-commit: 061d1af7b0305227182bd9da60c7706c079348b7
change-id: 20240602-power-supply-extensions-07d949f509d9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


