Return-Path: <linux-pm+bounces-28551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDEAD74E7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A63217F5C0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D42701B1;
	Thu, 12 Jun 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnPhl1wc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36526D4F8;
	Thu, 12 Jun 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740361; cv=none; b=QV0nDa3NlbtHS6PYUKX4Zsz/plSAgIPLq658wn+IuXEx7VYrkTS8e7dP2g39j2X2+FibKbK3toa0/t9pvXCsOytdG8QGPG/Uq69CA8kAUeW69XmdzXTI27aWpXk/Rvy8dF7C6XuAuOKJuwToWgfvIi2xGshh/bZTucObhtr/G5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740361; c=relaxed/simple;
	bh=WgLzrP/HBmAzSTOgYFRrJG+fDleiBjNr3X0mdLMrFkU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lal/XrptywDcPCnnIlpO2UONxmNIMd2lHZy3S64CHA6yMoNfC56xm3tLeALy5HlH07HbFgpcTJ9OBFnVOGFciZ7n7YRL49EE9pTtl/di/QCv/Mf5f3wddK+epOaupomBZohio56hiIYeJ/COlEgBmQVgfG5oKkQC7avGo+yK/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnPhl1wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FDDAC4CEEA;
	Thu, 12 Jun 2025 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749740360;
	bh=WgLzrP/HBmAzSTOgYFRrJG+fDleiBjNr3X0mdLMrFkU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fnPhl1wcVmtG4VUDVtxgMeAP0nQ3Ut0iaLA+4krpgjeLvknik17F5hyLU99PtPchj
	 uC7+2MuTGM1gvcDcQs6p4Doq/xRQlwJ1y3Mn1lr3EbT3TShWxp7fbz0IITB6ZvDRz6
	 zC+mc2n3NNrWofBcXigLz6ZRwtV2OG5Z6QaZkF3QJo39uAOSnHDA0JeFUDlCdtUMpj
	 QOiiqL6EC9bfmwDREHt9jt971yq70SoMoWqHbi1SojDT6/YmdQIIw2MgeYCde0AI8T
	 YbhXbnKuxVsfKhJ0BT4jkH8Jvb4I9WhXaguagyZ2HL51yx1sGgZwaZucvy+lfoVXcy
	 P34q2HqQ/3xeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD0CC7113E;
	Thu, 12 Jun 2025 14:59:20 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Subject: [PATCH v7 0/6] add support for pf1550 PMIC MFD-based drivers
Date: Thu, 12 Jun 2025 10:55:42 -0400
Message-Id: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7qSmgC/33OQWrDMBAF0KsYraswsjRynVXvUbqQpVEz0Nip5
 IiU4LtXdcANhWb5h8/7cxWZElMW++YqEhXOPI01dE+N8Ac3vpPkULNooUXAtpOnqBBBBgMqQoB
 ueAZRy6dEkS8r9Pp2y4k+z9Wbb0cxuEzST8cjz/um2J1C8VM8cJ6n9LU+UPTa/LtVtARpMNreo
 PYB1Ut2ZeIUHSf64PF82VV31Yr5FSzoTTBVGGKIqIiw9/6BgHeCgk3AKlCA0JN2zvnugWDvBbU
 JtgraxDaESGCQ/hGWZfkGx7dU65YBAAA=
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
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749740359; l=6030;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=WgLzrP/HBmAzSTOgYFRrJG+fDleiBjNr3X0mdLMrFkU=;
 b=EcTg2V21GNOWe6urm2jw0J1zEol/rtMZdXRDsBgYrpAPd9tS5duSgH7+t7Db9VAQlRZgWnEPl
 TZXBk2NUAwoCewXVV5+HftEQpbeI5BUtjK3NpOVLbHpUpQMPdSCnl1o
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

This series adds support for pf1550 PMIC. It provides the core mfd driver and a
set of three sub-drivers for the regulator, power supply and input subsystems.

Patch 1 adds the DT binding document for the PMIC. Patches 2-5 adds the
pertinent drivers. Last patch adds a MAINTAINERS entry for the drivers.

The patches 3-5 depend on the mfd driver provided in patch 2.

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

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
Samuel Kayode (6):
      dt-bindings: mfd: add pf1550
      mfd: pf1550: add core mfd driver
      regulator: pf1550: add support for regulator
      input: pf1550: add onkey support
      power: supply: pf1550: add battery charger support
      MAINTAINERS: add an entry for pf1550 mfd driver

 .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 137 +++++
 MAINTAINERS                                        |  11 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pf1550-onkey.c                  | 183 ++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/pf1550.c                               | 339 +++++++++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/pf1550-charger.c              | 632 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf1550-regulator.c               | 362 ++++++++++++
 include/linux/mfd/pf1550.h                         | 254 +++++++++
 15 files changed, 1968 insertions(+)
---
base-commit: 0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
change-id: 20250527-pf1550-d401f0d07b80

Best regards,
-- 
Samuel Kayode <samuel.kayode@savoirfairelinux.com>



