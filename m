Return-Path: <linux-pm+bounces-30916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD58B0792D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06D01710F8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478628BA8D;
	Wed, 16 Jul 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umuis4Br"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE626FD8F;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678714; cv=none; b=raqSmdWe4wS2Ekt5kE1Y1jjk2xuhYv6gZq7DmsoRSJuEgawpFG761UOBJqcwzRqrAHJs8trOdT5OOaTap+OWQKZQ/Il9h98VAriAZ8Pv9+x15A7Zr3uuwCyNA2ArISlp3K2V3vAfx0/rfplZ6E0T4ozkbXq9tWlN+g26RUY8IfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678714; c=relaxed/simple;
	bh=UtM958aqz1YHnOTOGs9smbhIoh1KXaJY4XPn+XVCi/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DooXo6qnQpd9hRnvT2E6FohljeTzgouH2YAldeD4NVctKI9misHaO04iW4RrUCAESHS7YutYrRJp/7L/LvovlaHXZ2G0BoeoxKkzdPCIkGE/xgUc4I4rCdTRkFKH+op+n7ewUchlogfLOZH1AvnK/edtVPrq96vErMDaho/vR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umuis4Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87DE7C4CEE7;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678713;
	bh=UtM958aqz1YHnOTOGs9smbhIoh1KXaJY4XPn+XVCi/c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=umuis4BrfPUlJTEFJEwQychHtaCauKjBvuufF6Nj+5Kta2bw/ZReEebE0TNmTlAkt
	 bkvaAsOLYSDL0hx2/Q2El0UyXdHcCTR69GCnYU9wU24uS1eolhIdvKQLLAepzb+qwK
	 OsUN8U8Aw2BMSReGF2kaTCcuxBctdwtnhMObMOooZMeSr1G4aL0FO78Eacqnltp9DO
	 OS7AC1iNCD+VDnB4wp1Wc3n+RXfS/qZWFX1f3K4gIi6knpO4T2Ha5kMg053AyBNO6B
	 07SxLWet017xJvqae2MIeEQiWPNStBqSa0QwdMnGYNHyPQywVBNN5F9PezwoeDdK6+
	 hGloLYRhaG0VQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B50C83F27;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Subject: [PATCH v9 0/6] add support for pf1550 PMIC MFD-based drivers
Date: Wed, 16 Jul 2025 11:11:43 -0400
Message-Id: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/Bd2gC/33QTWrDMBAF4KsEreswsjSSnVXvUbrQz6gRNHYqO
 SYl+O5VHbBNoV6+4fHNMA+WKUXK7HR4sERjzLHvSmhfDsydTfdBVfQlsxpqBKx1dQ0cESovgQf
 woG0DrJSviUK8z9Db+zMn+roVb3gOmTWZKtdfLnE4HUZ15Mh+i+eYhz59zweMYm7+3TWKCiqJQ
 bUShfPIX7MZ+5iCiYk+Y3e7H4s7a6NcBQViEWQRbPABORG2zu0IuBE4LAIWgTz4loQxxukdQW0
 FvgiqCEKG2vtAIJF2BL0V6kXQRQASrbAQJPq9G5pV0LB+simCsoqs0g6EgX+EaZp+AKWakoIaA
 gAA
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752678712; l=7369;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=UtM958aqz1YHnOTOGs9smbhIoh1KXaJY4XPn+XVCi/c=;
 b=rToN1rBQ3nyLowp+lou6hnMpN695fupPLytIBKKozgQYugw/omApEQKFGEQ5bxUn0IZ7JiaPD
 2+2wN8odKfNDRT0pzsjenqfaoVYulhz40p93DCmdhTy4TZCZQx4jBD6
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

This series adds support for pf1550 PMIC. It provides the core driver and a
three sub-drivers for the regulator, power supply and input subsystems.

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

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
Samuel Kayode (6):
      dt-bindings: mfd: add pf1550
      mfd: pf1550: add core driver
      regulator: pf1550: add support for regulator
      input: pf1550: add onkey support
      power: supply: pf1550: add battery charger support
      MAINTAINERS: add an entry for pf1550 mfd driver

 .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 144 +++++
 MAINTAINERS                                        |  11 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pf1550-onkey.c                  | 196 +++++++
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/pf1550.c                               | 374 ++++++++++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/pf1550-charger.c              | 636 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf1550-regulator.c               | 429 ++++++++++++++
 include/linux/mfd/pf1550.h                         | 271 +++++++++
 15 files changed, 2113 insertions(+)
---
base-commit: 0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
change-id: 20250527-pf1550-d401f0d07b80

Best regards,
-- 
Samuel Kayode <samuel.kayode@savoirfairelinux.com>



