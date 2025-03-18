Return-Path: <linux-pm+bounces-24241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F167A6703F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 10:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D02A3BFD21
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4D207DF5;
	Tue, 18 Mar 2025 09:48:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3520896C
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291304; cv=none; b=VhCqwEUQXzKuzmyCbb0E6XyYjAsxSuQG8vupsZSX+V1+YQwEtHtustGXaXxZWKBYZVsFf449SgBvgTDivNSFL3MoX/LVcczoqUWM0UIEQBxn6E5ijtUTXi22ldoB9UVrOmiE/9JnGTmJvhOWJEw2WNQDop+YhX0BPF7/94c57LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291304; c=relaxed/simple;
	bh=KNyla2XMdYB1Gk4aC/g/0ae5m1Djndix8XQcFLQ0kvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kVauhV9JJlXmz3Elh4trdTezH9bE8RC+xcd4za5Bxn4VbRuZ5nEeXw4r+EN8S/IjYAkYhFUk/6EtJinUzrdTAfq7l3gbihxg3aMwGhqS6+i6PT+lOIGyhKM74SAP9gDRWx9+HryWthpDmc+oU1yY2ltvxJ7OQdOwaPpH7T07tCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTXc-0008Mk-4q; Tue, 18 Mar 2025 10:47:20 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTXa-000P5l-2L;
	Tue, 18 Mar 2025 10:47:19 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTXb-00CoNI-0C;
	Tue, 18 Mar 2025 10:47:19 +0100
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
Subject: [PATCH v7 0/7] Introduction of PSCR Framework and Related Components
Date: Tue, 18 Mar 2025 10:47:09 +0100
Message-Id: <20250318094716.3053546-1-o.rempel@pengutronix.de>
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

changes v7:
- document expected values in sysfs documentation
- make write support optional

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

 .../ABI/testing/sysfs-kernel-reboot-pscrr     |  79 ++++
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
 include/linux/pscrr.h                         |  58 +++
 include/linux/reboot.h                        |  77 +++-
 kernel/reboot.c                               |  89 +++-
 15 files changed, 1198 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
 create mode 100644 drivers/power/reset/pscrr-nvmem.c
 create mode 100644 drivers/power/reset/pscrr.c
 create mode 100644 include/linux/pscrr.h

--
2.39.5


