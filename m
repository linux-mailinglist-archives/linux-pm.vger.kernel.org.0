Return-Path: <linux-pm+bounces-27700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE6AC5D18
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B43A800A
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 22:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B4218589;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh0Y52fT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF820FABC;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384785; cv=none; b=BRpsQTfp24gAccG/EBatiykUN6LPB5z+S6dKPtp1X1n9WP/acCKTcrg5X3go7EvEjQiss/nuMbrD0y5AS13kuvfVliKhDniODu4P9BOjXhyelNstGkdTRhLp0JONJKq8iPm73wJVXrL1HQwTuYJ5M1e66KMvJICP0yDqmOc6P8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384785; c=relaxed/simple;
	bh=URe9IVrGZGJyILeVZBhhwONAzc69qPxN2OjxE6CJZ4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VP5XP2cEja3pWsj43tKWjRoe49JZi9BWGVprD6QZX/IRHzru6KjSwgeBXOAxr4srFnWNUPGywkTieb/Ws+l0YEzNrPXirzoAgrUMH89aRUeic9bqT7cn8W8cL5et41jTk0EvtqAD2HaFozwIOLR7Cz6bz7z63NgnWYO4j9egtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh0Y52fT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A62B2C4CEE9;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384784;
	bh=URe9IVrGZGJyILeVZBhhwONAzc69qPxN2OjxE6CJZ4E=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Vh0Y52fTGSrxzjgq7j+zPTTt+1OtkJbWDFOXySGd8jYS0+i8zT2c/RX1/Z8oC7DhT
	 VP+8ms/NuMYKxX8G+Kj0VfajbHbeLKm3jhbJ0vNHc2PzV9tuM+tdnSGtbsAhKID/Ro
	 xwEaBI6U+J/QQ92e0jO58r0uX8fwAeoZmybs7gOicE0savGhB1Vvnd4CkS1QSXYaJ2
	 4BbAxxJbgHmePb5HPriK/ga3iAzoroRsPDrxUNREE3CpXL4aKYi4W+uT8Sl5rW65gT
	 69GGDU8Dd2x/EB5dGAlavzKV0RO1/bJ1ytPxMQf95L+tImkKjT4P+BFY6ijVK6SK3A
	 SAvau0JsuVw3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42DC5B543;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Subject: [PATCH v3 0/6] add support for pf1550 PMIC MFD-based drivers
Date: Tue, 27 May 2025 18:25:32 -0400
Message-Id: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANw7NmgC/yXMywqDMBCF4VcJs27KJHZq8VUkCzWTdhZemqgI4
 rsbdPkdDv8OiaNwgkrtEHmVJOOQUTwUdL9m+LIWnw0WLSHZUk/BEKH2LzQBPZbtByGfp8hBtit
 Uu9uR/0vuzfcIbZNYd2Pfy1yp9f00BO44Tjto7KWBAAAA
X-Change-ID: 20250527-pf1550-d401f0d07b80
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, eballetbo@gmail.com, 
 abelvesa@linux.com, b38343@freescale.com, yibin.gong@nxp.com, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748384783; l=3259;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=URe9IVrGZGJyILeVZBhhwONAzc69qPxN2OjxE6CJZ4E=;
 b=UJ4AcJwLfK4DFqRBhE//y7QyL/NeE6MGisDxCq6MHlHpahCh8CYZPc0hk8Qp9pNPhav7nSXPv
 w1jN1WnfbY6ARElc+dw0DpA8Pp7zaBt/T5Xn4VERhp5hVe3NC4klhf2
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

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
Samuel Kayode (6):
      dt-bindings: mfd: add pf1550
      mfd: pf1550: add core mfd driver
      regulator: pf1550: add support for regulator
      input: pf1550: add onkey support
      power: supply: pf1550: add battery charger support
      MAINTAINERS: add an entry for pf1550 mfd driver

 Documentation/devicetree/bindings/mfd/pf1550.yaml | 139 +++++
 MAINTAINERS                                       |  10 +
 drivers/input/misc/Kconfig                        |  11 +
 drivers/input/misc/Makefile                       |   1 +
 drivers/input/misc/pf1550-onkey.c                 | 202 +++++++
 drivers/mfd/Kconfig                               |  14 +
 drivers/mfd/Makefile                              |   2 +
 drivers/mfd/pf1550.c                              | 277 ++++++++++
 drivers/power/supply/Kconfig                      |  11 +
 drivers/power/supply/Makefile                     |   1 +
 drivers/power/supply/pf1550-charger.c             | 639 ++++++++++++++++++++++
 drivers/regulator/Kconfig                         |   9 +
 drivers/regulator/Makefile                        |   1 +
 drivers/regulator/pf1550-regulator.c              | 353 ++++++++++++
 include/linux/mfd/pf1550.h                        | 241 ++++++++
 15 files changed, 1911 insertions(+)
---
base-commit: 0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
change-id: 20250527-pf1550-d401f0d07b80

Best regards,
-- 
Samuel Kayode <samuel.kayode@savoirfairelinux.com>



