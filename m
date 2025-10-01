Return-Path: <linux-pm+bounces-35640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A2BB1220
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA35194694A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58727FD76;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI2Lp/gE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B02045B7;
	Wed,  1 Oct 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333362; cv=none; b=tPiMCuwDCPRiOXup0q8lLjzCByfTNHpKm9gDtpCt8zPnXBhiJ8fKjBdnnxy9E+8s6VOdLnaS6SqdbXzNxprgkiD2678i9bUvQFcm58uhSDOzqyNRxmr2MhTTftGvNTa4sEm55POM7JxE+66/Fqidd5MXtCwX53GZIXY7QgiAKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333362; c=relaxed/simple;
	bh=P5cRnlUVXDRgHSrz1R7UALrb6nzM8jdRinrnuIrXiOY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fY0FeicsOFfGm/ng5veF2+/e3rpbHtjdVdPbViGZtCWgRL0L9SKQFikoMfRizJH+2lNA0/7t6BAcZJis1tepH4nPkNuIwfnPRFFFKmbJpMLGHgmcawg+N1Qy6n5NiYDEMnugNXwbF0RrmDuaVjbBI0BNjjVEdJ4DJGUUrKfDptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI2Lp/gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79AC2C4CEF1;
	Wed,  1 Oct 2025 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333361;
	bh=P5cRnlUVXDRgHSrz1R7UALrb6nzM8jdRinrnuIrXiOY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mI2Lp/gEYBhVKo1G9n+GmH17mO+M/KzAZ1yNWzItsbElFFpJqPmiEroPpVfVcIZDI
	 oGos0VKS4dXwMztXT46nsXnSTJs+YdX2CldpmWGRTr4wY2UnGFEJkGUlCO3fX0/10+
	 yoAjPQpcfbBiAKKiGAFU3j6IOeHW8LXIrYPOWtU+j73vYAZY9f/JEunvFoHSsjEbaN
	 wWhyqBtRaxS6WgGRpA2mDOj/ySgkdeGMNARCD8WM3yQ6LdIBtqBDMWOjnQVXMEl5z6
	 xnGev8UDwdML7kGkdAJxr2iIs/bnnWGKEePfxKvqj8PHYQe0C/oZL9b9ZGcitbgkRy
	 a4i97aRDytwLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FACCA474;
	Wed,  1 Oct 2025 15:42:41 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Subject: [PATCH v12 0/6] add support for pf1550 PMIC MFD-based drivers
Date: Wed, 01 Oct 2025 11:42:36 -0400
Message-Id: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxL3WgC/33RzWrDMAwH8FcpPi9F/o572nuMHRxbXg1r0zlp6
 Ch992kpxGGwHCXEz/JfdzZgyTiww+7OCk55yP2ZCi5ediwc/fkDmxypwQQIDVrY5pK41tBEBTx
 BBNu1wGj4UjDl2yy9vT/rgl9XAsdnk3V+wCb0p1MeD7vJ7Lllv4PHPIx9+Z43mOQ8+fetSTbQK
 J2MU1qGqPnr4Kc+l+Rzwc98vt725M7apKpgQC6CIqFLMWmOqF0IG4JeCRwWQZOAEaJD6b0PdkM
 wa4EvgiFBqiRiTAhK44Zg14JYBEsCoHSyg6R03NqhrYKFmmRLgukMdsYGkB42BLcSuFkER4IG4
 Y2yCRSmDYFDJVpRo6RU6Z4BaA+lKAi5ZfBqOF4/QrnSPcAo1wqRQnD/GI/H4wceLgUO5QIAAA=
 =
X-Change-ID: 20250527-pf1550-d401f0d07b80
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, 
 Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759333360; l=8102;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=P5cRnlUVXDRgHSrz1R7UALrb6nzM8jdRinrnuIrXiOY=;
 b=ojBzFaDZzwJLxNFrfzZ8of3V4JRFENLlBRoPkFFXPUhlhXRNsTm9ZV20bn4aFNNwEGI1wjSnh
 Joi+K0xcwHkBjnf9zEMmvfS6yvAMOGqN/vXGhV42/uao9bciB/7VKk3
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

This series adds support for pf1550 PMIC. It provides the core driver and
sub-drivers for the regulator, power supply and input subsystems.

Patch 1 adds the DT binding document for the PMIC. Patches 2-5 adds the
pertinent drivers. Last patch adds a MAINTAINERS entry for the drivers.

The patches 3-5 depend on the core driver provided in patch 2.

Changes since v1:
   - DT bindings for all devices included
   - Add onkey driver
   - Add driver for the regulators
   - Ensure charger is activated as some variants have it off by default
   - Update mfd and charger driver per feedback from eballetbo@gmail.com
   - Add myself as maintainer for these drivers
   - Link to v1: https://lore.kernel.org/1523974819-8711-1-git-send-email-abel.vesa@nxp.com/

Changes since v2:
   - Rebase on recent mainline kernel v6.15
   - Single yaml file containing dt bindings for all pf1550 devices
   - irq mapping done in MFD driver as suggested by Dmitry Torokhov
   - Drop unnecessary includes in drivers
   - Replace dev_err with dev_err_probe in probe method of drivers
   - Drop compatible string from drivers of the sub-devices
   - Remove dependency on OF from drivers of the sub-devices
   - onkey: move driver from input/keyboard into input/misc
   - onkey: remove dependency on OF
   - onkey: use onkey virqs instead of central irq
   - onkey: fix integer overflow for regmap_write when unmasking
     interrupts during pf1550_onkey_resume
   - charger: add support for monitored-battery which is used in setting
     a constant voltage for the charger.
   - Address other feedback from Dmitry Torokhov and Krzysztof Kozlowski
   - Link to v2: https://lore.kernel.org/cover.1747409892.git.samuel.kayode@savoirfairelinux.com/

Changes since v3:
   - Update manufacturer from Freescale to NXP in compatible,
     dt-binding and Kconfigs
   - Use C++ style comments for SPDX license in .c code
   - Add portions copyright to source code
   - irqs are defined as struct resource in mfd cell such that
     platform_get_irq is used in the sub-devices
   - Make struct pf1550_dev of type const in sub-device driver
   - irq variable dropped from sub-device driver struct
   - EXPORT_SYMBOL of global pf1550_read_otp function for use in
     regulator driver
   - Drop unneeded info in driver_data when defining device table id
   - regulator: validate ramp_delay
   - regulator: report overcurrent and over temperature events
   - onkey: drop unnecessary keycode variable
   - onkey: change wakeup variable to type bool
   - onkey: replace (error < 0) with error in if statement when possible
   - onkey: use pm_sleep_ptr when defining driver.pm
   - charger: finish handling of some interrupts in threaded irq handler
   - Link to v3: https://lore.kernel.org/20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com/

Changes since v4:
   - Use top level interrupt to minimize number of registers checked on
     each interrupt
   - Fix bad offset for temperature interrupts of regulator irq chip
   - Address Krzysztof's comments for dt-binding
   - regulator: add comments to clarify difference in its interrupts
   - regulator: issue warn event for _LS interrupt and error event for
     _HS interrupt
   - regulator: validate maximum and minimum ramp_delay
   - charger: drop lock in battery and charger delayed_work
   - charger: more conservative locking for vbus delayed_work
   - charger: apply lock when setting power_supply type during register
     intialization
   - Link to v4: https://lore.kernel.org/r/20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com

Changes since v5:
   - Ensure lowercase when assigning hex values
   - Add imx@lists.linux.dev to relevant mailing list in MAINTAINERS file
   - Use GENMASK macro
   - Drop unused chips variable
   - Read the OTP in the mfd driver probe for new dvs_enb variable
   - Hardcode IRQ flags in pf1550_add_child function
   - charger: drop the mutex entirely
   - charger: reverse christmas tree style local variable definition in
     probe
   - Link to v5: https://lore.kernel.org/r/20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com

Changes since v6:
   - Use reverse christmas tree order
   - Drop 0 in table id's driver data
   - charger: store virq to avoid reinvoking platform_get_irq in ISR
   - Link to v6: https://lore.kernel.org/r/20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com

Changes since v7:
  - Thanks everyone for the reviews
  - Use C++ comment only for SPDX license header in core, charger and
    onkey drivers
  - Drop filenames from comments
  - Rename pf1550_dev to pf1550_ddata
  - Define OTP register for accessing status of DVS
  - core: rename from `mfd driver` to `core driver`
  - core: add child devices in a cleaner manner
  - charger: define two power supplies: battery and external power
  - charger: use devm_delayed_work_autocancel
  - Link to v7: https://lore.kernel.org/r/20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com

Changes since v8:
  - Collect Frank's `Reviewed-by` tags
  - core: use consistent whitespace
  - regulator: add standby support for regulators requested by Sean Nyekjaer
  - regulator: add support for SW1 DVS enable/disable
  - regulator: fix improper DVS activation
  - regulator: add map_voltage for regulators
  - regulator: add enable/disable for regulators
  - charger: use datasheet thermal regulation temperature ranges
  - charger: select charger operation mode based on the application
  - onkey: add support for disabling system power down via onkey
  - dt-bindings: changed temperature ranges
  - dt-bindings: added `disable-key-power`
  - Link to v8: https://lore.kernel.org/r/20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com

Changes since v9:
  - add Sean's Tested-by tag
  - core: style changes
  - dt-bindings: add regulator-state-mem to examples
  - onkey: use regmap_clear_bits to avoid overwriting all bits of the
    PWRCTRL register
  - Link to v9: https://lore.kernel.org/r/20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com

Changes since v10:
  - add Sean's Tested-by tag on mfd patch
  - charger: separate battery properties from charger properties
  - Link to v10: https://lore.kernel.org/r/20250820-pf1550-v10-0-4c0b6e4445e3@savoirfairelinux.com

Changes since v11:
  - rebase on v6.17
  - charger: add Sebastian's `Acked-by` tag
  - Link to v11: https://lore.kernel.org/r/20250917-pf1550-v11-0-e0649822fcc9@savoirfairelinux.com

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
Samuel Kayode (6):
      dt-bindings: mfd: add pf1550
      mfd: pf1550: add core driver
      regulator: pf1550: add support for regulator
      input: pf1550: add onkey support
      power: supply: pf1550: add battery charger support
      MAINTAINERS: add an entry for pf1550 mfd driver

 .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 161 ++++++
 MAINTAINERS                                        |  11 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pf1550-onkey.c                  | 197 +++++++
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/pf1550.c                               | 367 ++++++++++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/pf1550-charger.c              | 641 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf1550-regulator.c               | 429 ++++++++++++++
 include/linux/mfd/pf1550.h                         | 273 +++++++++
 15 files changed, 2131 insertions(+)
---
base-commit: 6063257da111c7639d020c5f15bfb37fb839d8b6
change-id: 20250527-pf1550-d401f0d07b80

Best regards,
-- 
Samuel Kayode <samuel.kayode@savoirfairelinux.com>



