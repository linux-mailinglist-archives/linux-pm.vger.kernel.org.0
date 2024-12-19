Return-Path: <linux-pm+bounces-19495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B407F9F75BE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCA6188BD73
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884E21885C;
	Thu, 19 Dec 2024 07:32:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A872185B9
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593540; cv=none; b=rhSs7NIv8wKqKih32ne7EkwqP/f9aSBMLNhnH2et7z6tQougP1vHAdAuCwzSpLLJSivkgOchI9hori+9Zue5PO+8QaLSTGbunbVD4Cen5JWZyNaum1dOKO4+oQMrchCsj9cX+2fnsa4XZYvmwN59bswdEaS5jnvvyXB7og8MKyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593540; c=relaxed/simple;
	bh=7RTxGMyJEufyqyVhoa0s2MPskpvrfhslVr1jsWa99KE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=POy2ZS59CESBFlCslX3Ac3KkMka6demKy9xvVqzXjyFwuWjqi3m/65LrxFLx67m47kr9GIODCNLgdg5vI7txrByag49jKIFYJxS4BI8mQrxeA8aRl12Jlnr3gZy0U3EbaT9bB/eVn/c19IcUX3G+OxSOb22xNoGuwFrBdM+e2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0O-00088T-1S; Thu, 19 Dec 2024 08:31:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0L-004APo-1p;
	Thu, 19 Dec 2024 08:31:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0j;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH 00/11] reboot: support runtime configuration of emergency
 hw_protection action
Date: Thu, 19 Dec 2024 08:31:21 +0100
Message-Id: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnLY2cC/x2MQQ5AMBAAvyJ71kRbSn1FRKjFXlS2DRLxd43jJ
 DPzQEAmDNBmDzCeFMjvCWSegdvGfUVBc2JQhSqlko3YruFgH9HFZArGyfsorLGVLq2ulRkhpQf
 jQve/7fr3/QCZth26ZgAAAA==
X-Change-ID: 20241218-hw_protection-reboot-96953493726a
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
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
Ahmad Fatoum (11):
      reboot: replace __hw_protection_shutdown bool action parameter with an enum
      reboot: reboot, not shutdown, on hw_protection_reboot timeout
      docs: thermal: sync hardware protection doc with code
      reboot: rename now misleading hw_protection symbols
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
 Documentation/driver-api/thermal/sysfs-api.rst     |  25 +++--
 drivers/platform/chrome/cros_ec_lpc.c              |   2 +-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/irq_helpers.c                    |  16 +--
 drivers/thermal/thermal_core.c                     |  17 +--
 drivers/thermal/thermal_core.h                     |   1 +
 drivers/thermal/thermal_of.c                       |   7 +-
 include/linux/reboot.h                             |  25 +++--
 include/uapi/linux/capability.h                    |   1 +
 kernel/reboot.c                                    | 122 ++++++++++++++++-----
 13 files changed, 173 insertions(+), 66 deletions(-)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241218-hw_protection-reboot-96953493726a

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


