Return-Path: <linux-pm+bounces-8719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EB8FF019
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8830728C464
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E41A255B;
	Thu,  6 Jun 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ECxqKI+m"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9661A2544;
	Thu,  6 Jun 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685467; cv=none; b=Vjji2MktD9UQrnoxPEUOUhbSZZ6fOn76p0y9hVjT4X2dDaVtkCwbdU0AgC35VZUBmawuYEW0ND6p3SFwd9Oi++OW9j9ltpBmX3Fqs4wAxq45X3KgNSRSKvOdaGAX1FSRV/tJDbhzo4hivYC918f+QH2mtyp7ZGjT5qIb9YVJANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685467; c=relaxed/simple;
	bh=bdXFxi8tnEgbfjdU5btF0ytSOB3GTwGldFvQDL6lPaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XbfUdi38O/S/Tz27749PqBV9mFVu02/Stqj9cgzzuLX1DgCGpVyBGieQ8EUnPUPiSrZz2sLFzfPVDLBhKtijrN3DlZW0HntVCdTXUI8dGXUOx74yc1Osq+Ho74rfxkWjRjJX1XN8a51BgHOXw+WEQ1EsrUWrRjV/L05Q+8uFxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ECxqKI+m; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717685463;
	bh=bdXFxi8tnEgbfjdU5btF0ytSOB3GTwGldFvQDL6lPaU=;
	h=From:Subject:Date:To:Cc:From;
	b=ECxqKI+mk0WDSHshu3UnOyOOpTrdOykq2TzeANMawHE4o9iHVz+meClLJTAxcQhBi
	 X+HVbqZzB892lJhHedLw8sucAbvM6FpF7CJQGugMyJnlqTOMayU7XBUm5LcT7zKWO4
	 i8bHz1OwzW4AGeFz51gVXOA2s08XQTWHzq+L86m0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 0/6] power: supply: extension API
Date: Thu, 06 Jun 2024 16:50:54 +0200
Message-Id: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM7MYWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMj3YL88tQi3eLSgoKcSt3UipLUPJCWYl0D8xRLE8s0UwPLFEsloO6
 CotS0zAqwydFKQW7OSrG1tQBcwKYubgAAAA==
To: Sebastian Reichel <sre@kernel.org>, Jeremy Soller <jeremy@system76.com>, 
 System76 Product Development <productdev@system76.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717685463; l=3433;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bdXFxi8tnEgbfjdU5btF0ytSOB3GTwGldFvQDL6lPaU=;
 b=AxoBqHX/LVFjRTc3+iH+Ep8JhFgtL3uiKsc7KN6uCaTsZjrAigmZ7ItvJJaYeMVpK36qytGBy
 8BzYFJ520I1BqEvWgqXunFdUcKUQNM2NKwzvUqIHeknJpeSxPMOqpkf
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
* Properties can not be properly overriden.

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
Thomas Weißschuh (6):
      power: supply: sysfs: use power_supply_property_is_writeable()
      power: supply: core: avoid iterating properties directly
      power: supply: core: implement extension API
      power: supply: core: add locking around extension access
      power: supply: test-power: implement a power supply extension
      platform/x86: system76: Use power_supply extension API

 drivers/platform/x86/system76_acpi.c      |  83 +++++++++---------
 drivers/power/supply/power_supply.h       |   9 ++
 drivers/power/supply/power_supply_core.c  | 136 ++++++++++++++++++++++++++++--
 drivers/power/supply/power_supply_hwmon.c |  48 +++++------
 drivers/power/supply/power_supply_sysfs.c |  39 ++++++---
 drivers/power/supply/test_power.c         | 102 ++++++++++++++++++++++
 include/linux/power_supply.h              |  25 ++++++
 7 files changed, 357 insertions(+), 85 deletions(-)
---
base-commit: 2df0193e62cf887f373995fb8a91068562784adc
change-id: 20240602-power-supply-extensions-07d949f509d9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


