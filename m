Return-Path: <linux-pm+bounces-28048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FB6ACCCF6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 20:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE818936F0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D6289361;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWhC5gTI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F23288C87;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975278; cv=none; b=Jj7/Wbb7/Oo1F2IT4NH8fj4IB7hk4WfXulAYeWDKkQGJ1pR/vtv954LavIwhTEilJhn7WWf5u8jOUX/Ry95usobDg8m6Z6JYNJB0hhre7qKszC5DXflWsg+vQX+wu7BGz/g6Pvv1f9EpnBZMMydKQagrmGpXUqf3iGeSnMg6hnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975278; c=relaxed/simple;
	bh=wsUfhvnq5OFTsdC4hfMvdgqsUI4J7n85xA5R/cCvMOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ryHtRRB7/paDtZNZIGFZ1TLjc+zwh/4a4h+fT3qbMGk5u/dHjHYxshFGstbHpuBNEyuBDQa6CwLlfDaOSdLjU1H1CstzW36ZSFCmCwCUA/pyhYz/fPsk7yIeTlK8hKquHYv3Og2n+ZN7ouHdvbxVS2L+cDxSdHVRqZkgx9nId8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWhC5gTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7ABDC4CEED;
	Tue,  3 Jun 2025 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975278;
	bh=wsUfhvnq5OFTsdC4hfMvdgqsUI4J7n85xA5R/cCvMOk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sWhC5gTIIoxemZWCIW1xwSsOwx8HNpNEjf6y7SjWaArLUIwdmalQP8VVkaSktflqk
	 fRUnxvgHweoCASkfZE+N6YM+DIVd4DOYM+J8Wzm6qXNspjpTZIsBkIMWMOHMqZKzDz
	 816N0ga5Wvrr9aJXfhTv/jOgk4OwCO++aS7UtBDiPFydtGWuFTdzrQPukXNv9HUIX+
	 Fy2f/8hhxSo+MqEc4VW60UQ+tu2Jv15PIgcqt64nxnokHhwW6ZaaUWUDPnC40p3PcW
	 kO/qjD8q5AkcSYsrGlUCZBDBmrJIVpJ11GUC6CvhmRcPpqiZ2dDxOl4vBhngY2Hrqs
	 WXEvOIv+02Uyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D98C5AE59;
	Tue,  3 Jun 2025 18:27:57 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Subject: [PATCH v4 0/6] add support for pf1550 PMIC MFD-based drivers
Date: Tue, 03 Jun 2025 14:27:44 -0400
Message-Id: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKA+P2gC/12OQQ6CMBBFr0JmbUmBDigr72FYFNrKJEKxhQZDu
 LsVdi7f5OX92cBrR9pDnWzgdCBPdowgLgl0vRyfmpGKDDnPkWNesclkiJwpwTPDFa/aK4coT04
 bWo/QoznZ6fcSe/N5hFZ6zTo7DDTXSSjTDOEn9uRn6z7HA6E4zP+tUDDOBJryJrDoFGZ3L4MlZ
 yQ5/aJxWdPYhWbf9y/t8l9Z0AAAAA==
X-Change-ID: 20250527-pf1550-d401f0d07b80
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
 Robin Gong <b38343@freescale.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748975277; l=4890;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=wsUfhvnq5OFTsdC4hfMvdgqsUI4J7n85xA5R/cCvMOk=;
 b=B4kysBQMyDUvbTUn6Tc3Rw9pUYvq22xVuuBMri75JHKMU45qnyB6mIeJqhSgeRKCG7dPZJQOG
 VXQEOwmbmauBD1I/IEZy+u29jf+sYZp5/aJ4uprb1ntw3GJxSjhW2IV
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

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
To: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Samuel Kayode (6):
      dt-bindings: mfd: add pf1550
      mfd: pf1550: add core mfd driver
      regulator: pf1550: add support for regulator
      input: pf1550: add onkey support
      power: supply: pf1550: add battery charger support
      MAINTAINERS: add an entry for pf1550 mfd driver

 .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 139 +++++
 MAINTAINERS                                        |  10 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pf1550-onkey.c                  | 184 ++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/pf1550.c                               | 305 ++++++++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/pf1550-charger.c              | 654 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf1550-regulator.c               | 361 ++++++++++++
 include/linux/mfd/pf1550.h                         | 244 ++++++++
 15 files changed, 1947 insertions(+)
---
base-commit: 0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
change-id: 20250527-pf1550-d401f0d07b80

Best regards,
-- 
Samuel Kayode <samuel.kayode@savoirfairelinux.com>



