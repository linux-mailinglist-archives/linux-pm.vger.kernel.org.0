Return-Path: <linux-pm+bounces-22251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD8A38D96
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC843B4DE0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6723FC67;
	Mon, 17 Feb 2025 20:40:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174D23FC68
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824854; cv=none; b=H+mQSte4c/B3vLINAw43gIOFeqayyaXCDflPSb+EjQ3s4GZyx99UNkU7EmotDkCeDR2l+fGbidWWDqG4HxZnFnTU4cFVMSFhQqgX/X99LzUw4V1v+VrH4ffI18ws8JZPQqvlk2cDJsWZKClp/PSdIzvL3tktry3ddgKoLq3o05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824854; c=relaxed/simple;
	bh=zDIKCGmFawq4J0UKmtrX8pzoj6BuLW5GYA0ZehoiuqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bh6TcbTSWcSbAwiHgXqxQUQoByzImGiLT45amLDK9U+QehEVh8tyfYq6v3Hj9CihYcHrt6r3rQiw3brBgFoCJXOSVLwLZGGqeJ9okn6/dIlPpEmaaYzICNGduWVN+U2sRayILlDS27eWRW2EYDbMPsn/EXVFe1WS1UBNQwFYBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uZ-0007oE-CW; Mon, 17 Feb 2025 21:40:15 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-001TFt-2h;
	Mon, 17 Feb 2025 21:40:13 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-000W9t-2N;
	Mon, 17 Feb 2025 21:40:13 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v3 00/12] reboot: support runtime configuration of
 emergency hw_protection action
Date: Mon, 17 Feb 2025 21:39:40 +0100
Message-Id: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyes2cC/3XNwQ6CMAyA4VchOzuzbjDEk+9hjMGtg10Y2ebEE
 N7dQcJJPf5N+3UmAb3FQM7FTDwmG6wbcohDQVTfDh1Sq3MTzngJHE60f91H7yKqmDepx4dzkTa
 yqUTZiJrLluTT0aOx08Zeb7l7G6Lz7+1LgnW6g81vMAFllEvRMgXanBi/jDh0z+jdYKejRrKqi
 e9SxQDEH4lnCSRoYVQtSsO+pGVZPpvROUQHAQAA
X-Change-ID: 20241218-hw_protection-reboot-96953493726a
To: Andrew Morton <akpm@linux-foundation.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Fabio Estevam <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Matteo Croce <mcroce@microsoft.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

We currently leave the decision of whether to shutdown or reboot to
protect hardware in an emergency situation to the individual drivers.

This works out in some cases, where the driver detecting the critical
failure has inside knowledge: It binds to the system management controller
for example or is guided by hardware description that defines what to do.

This is inadequate in the general case though as a driver reporting e.g.
an imminent power failure can't know whether a shutdown or a reboot would
be more appropriate for a given hardware platform.

To address this, this series adds a hw_protection kernel parameter and
sysfs toggle that can be used to change the action from the shutdown
default to reboot. A new hw_protection_trigger API then makes use of
this default action.

My particular use case is unattended embedded systems that don't
have support for shutdown and that power on automatically when power is
supplied:

  - A brief power cycle gets detected by the driver
  - The kernel powers down the system and SoC goes into shutdown mode
  - Power is restored
  - The system remains oblivious to the restored power
  - System needs to be manually power cycled for a duration long enough
    to drain the capacitors

With this series, such systems can configure the kernel with
hw_protection=reboot to have the boot firmware worry about critical
conditions.

---
Changes in v3:
- Added Tzung-Bi's Acked-by and Reviewed-by tags (Thanks!)
- Fix typo in documentation s/emergency restart()/emergency_restart()/
  (Tzung-Bi)
- Advance Date/KernelVersion tags for sysfs-kernel-reboot ABI documentation
  (Tzung-Bi)
- Added Matti's Reviewed-by tags (Thanks!)
- Link to v2: https://lore.kernel.org/r/20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de

Changes in v2:
- Added Rob's dt-bindings Acked-by
- Add kernel-doc for all newly introduced enums, functions and
  function parameters (lkp)
- Fix kernel-doc warning for do_kernel_restart even though it
  wasn't introduced in this series (lkp)
- Rename the work function and object in patch 2 already to align
  with the functional change
-
- Link to v1: https://lore.kernel.org/r/20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de

---
Ahmad Fatoum (12):
      reboot: replace __hw_protection_shutdown bool action parameter with an enum
      reboot: reboot, not shutdown, on hw_protection_reboot timeout
      docs: thermal: sync hardware protection doc with code
      reboot: describe do_kernel_restart's cmd argument in kernel-doc
      reboot: rename now misleading __hw_protection_shutdown symbols
      reboot: indicate whether it is a HARDWARE PROTECTION reboot or shutdown
      reboot: add support for configuring emergency hardware protection action
      regulator: allow user configuration of hardware protection action
      platform/chrome: cros_ec_lpc: prepare for hw_protection_shutdown removal
      dt-bindings: thermal: give OS some leeway in absence of critical-action
      thermal: core: allow user configuration of hardware protection action
      reboot: retire hw_protection_reboot and hw_protection_shutdown helpers

 Documentation/ABI/testing/sysfs-kernel-reboot      |   8 ++
 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |   5 +-
 Documentation/driver-api/thermal/sysfs-api.rst     |  25 ++--
 drivers/platform/chrome/cros_ec_lpc.c              |   2 +-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/irq_helpers.c                    |  16 +--
 drivers/thermal/thermal_core.c                     |  17 +--
 drivers/thermal/thermal_core.h                     |   1 +
 drivers/thermal/thermal_of.c                       |   7 +-
 include/linux/reboot.h                             |  36 ++++--
 include/uapi/linux/capability.h                    |   1 +
 kernel/reboot.c                                    | 140 ++++++++++++++++-----
 13 files changed, 195 insertions(+), 73 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20241218-hw_protection-reboot-96953493726a

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


