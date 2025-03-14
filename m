Return-Path: <linux-pm+bounces-24030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C45A6101D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55691B63814
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8F1FF1BD;
	Fri, 14 Mar 2025 11:36:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA41FF1A1
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952210; cv=none; b=Tg5qi/ebcUm/x5bP/PQT5tdUP2ruCdvBqA/xFQaQbXkavEIJpgyFD4eKihwTu/1iqNk9xQaoZH7mqKQzsb1eKjIjuL7U+sJwWNVWRO4AC6QqfMYXZWkQVN2cV9VXvY+swENuPNS2znHwDpJRILO7c1yVr5CCeXQH7GW64Jr0xOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952210; c=relaxed/simple;
	bh=ODrXFOIOKVb1FQOq9Z4f3h6RO94JRw2iLSmd5tbddUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qr/VUl2K8erO3Uruz1QoK72jKXjMcrHZkuqn7nRhVCKy1woiRmFfVn4q0WdbpLjW0ybDndb49tVLjhhKlg7n7mcRxQcT+9SRfb4fJ0yQgzKoPUevQcnoCHfIA4rfv+M4c16KSAJUmrsrfCkODIaMiDuJxOIlXnd5Tk5/4ofc/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kg-0007NY-QD; Fri, 14 Mar 2025 12:36:06 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kf-005h5p-1o;
	Fri, 14 Mar 2025 12:36:05 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kf-007S5u-1X;
	Fri, 14 Mar 2025 12:36:05 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v6 0/7] Introduction of PSCR Framework and Related Components
Date: Fri, 14 Mar 2025 12:35:57 +0100
Message-Id: <20250314113604.1776201-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

changes v6:
- add sysfs documentation
- rebase against latest hw_protection_reboot changes:
  https://web.git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-nonmm-unstable&id=212dd3f6e57f6af8ed3caa23b93adc29334f9652
- push core part of the reset reason the kernel/reboot.c

changes v5:
- fix compile with NVMEM=n and potential issues with NVMEM=m

changes v4:
- fix compile with CONFIG_PSCRR=n

changes v3
- rework to remove devicetree dependencies
- extend NVMEM to search devices and cells by names.

changes v2:
- rename the framework from PSCR to PSCRR (last R is for Recorder)
- extend power on reason header and use it to show detected reason on
  system start and in sysfs.
- remove "unknow" reason
- rebase on top of v6.8-rc1
- yaml fixes
- zero reason state on boot

Hello all,

This patch series introduces the Power State Change Reasons Recording
(PSCRR) framework and its related components into the kernel. The PSCR
framework is designed for systems where traditional methods of storing
power state change reasons, like PMICs or watchdogs, are inadequate. It
provides a structured way to store reasons for system shutdowns and
reboots, such as under-voltage or software-triggered events, in
non-volatile hardware storage.

These changes are critical for systems requiring detailed postmortem
analysis and where immediate power-down scenarios limit traditional
storage options. The framework also assists bootloaders and early-stage
system components in making informed recovery decisions.


Oleksij Rempel (7):
  power: Extend power_on_reason.h for upcoming PSCRR framework
  reboot: hw_protection_trigger: use standardized numeric
    shutdown/reboot reasons instead of strings
  power: reset: Introduce PSCR Recording Framework for Non-Volatile
    Storage
  nvmem: provide consumer access to cell size metrics
  nvmem: add support for device and sysfs-based cell lookups
  power: reset: add PSCR NVMEM Driver for Recording Power State Change
    Reasons
  Documentation: Add sysfs documentation for PSCRR reboot reason
    tracking

 .../ABI/testing/sysfs-kernel-reboot-pscrr     |  46 ++
 drivers/nvmem/core.c                          | 134 ++++++
 drivers/platform/chrome/cros_ec_lpc.c         |   2 +-
 drivers/power/reset/Kconfig                   |  43 ++
 drivers/power/reset/Makefile                  |   2 +
 drivers/power/reset/pscrr-nvmem.c             | 254 +++++++++++
 drivers/power/reset/pscrr.c                   | 417 ++++++++++++++++++
 drivers/regulator/core.c                      |   7 +-
 drivers/regulator/irq_helpers.c               |  22 +-
 drivers/thermal/thermal_core.c                |   3 +-
 include/linux/nvmem-consumer.h                |  25 ++
 include/linux/power/power_on_reason.h         |   4 +
 include/linux/pscrr.h                         |  49 ++
 include/linux/reboot.h                        |  77 +++-
 kernel/reboot.c                               |  89 +++-
 15 files changed, 1156 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
 create mode 100644 drivers/power/reset/pscrr-nvmem.c
 create mode 100644 drivers/power/reset/pscrr.c
 create mode 100644 include/linux/pscrr.h

--
2.39.5


