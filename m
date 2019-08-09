Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C887811
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406261AbfHILDV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:03:21 -0400
Received: from foss.arm.com ([217.140.110.172]:45526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406247AbfHILDV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 07:03:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE7EA1596;
        Fri,  9 Aug 2019 04:03:20 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2357D3F575;
        Fri,  9 Aug 2019 04:03:19 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/8] ARM: psci: cpuidle: PSCI CPUidle rework
Date:   Fri,  9 Aug 2019 12:03:06 +0100
Message-Id: <cover.1565348376.git.lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v2 of a previous posting:

v1: https://lore.kernel.org/linux-pm/20190722153745.32446-1-lorenzo.pieralisi@arm.com/

v1->v2:

- Split config files updates into separate patches
- Fixed minor memory leaks/bisectability issues

Original cover letter
---

Current PSCI CPUidle driver is built on top of the generic ARM
CPUidle infrastructure that relies on the architectural back-end
idle operations to initialize and enter idle states.

On ARM64 systems, PSCI is the only interface the kernel ever uses
to enter idle states, so, having to rely on a generic ARM CPUidle
driver when there is and there will always be only one method
for entering idle states proved to be overkill, more so given
that on ARM 32-bit systems (that can also enable the generic
ARM CPUidle driver) only one additional idle back-end was
ever added:

drivers/soc/qcom/spm.c

and it can be easily converted to a full-fledged CPUidle driver
without requiring the generic ARM CPUidle framework.

Furthermore, the generic ARM CPUidle infrastructure forces the
PSCI firmware layer to keep CPUidle specific information in it,
which does not really fit its purpose that should be kernel
control/data structure agnostic.

Lastly, the interface between the generic ARM CPUidle driver and
the arch back-end requires an idle state index to be passed to
suspend operations, with idle states back-end internals (such
as idle state parameters) hidden in architectural back-ends and
not available to the generic ARM CPUidle driver.

To improve the above mentioned shortcomings, implement a stand
alone PSCI CPUidle driver; this improves the current kernel
code from several perspective:

- Move CPUidle internal knowledge into CPUidle driver out of
  the PSCI firmware interface
- Give the PSCI CPUidle driver control over power state parameters,
  in particular in preparation for PSCI OSI support
- Remove generic CPUidle operations infrastructure from the kernel

This patchset does not go as far as removing the generic ARM CPUidle
infrastructure in order to collect feedback on the new approach
before completing the removal from the kernel, the generic and PSCI
CPUidle driver are left to co-exist.

Tested on Juno platform with both DT and ACPI boot firmwares.

Cc: Will Deacon <will@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Lorenzo Pieralisi (8):
  ARM: cpuidle: Remove useless header include
  ARM: cpuidle: Remove overzealous error logging
  drivers: firmware: psci: Decouple checker from generic ARM CPUidle
  ARM: psci: cpuidle: Introduce PSCI CPUidle driver
  ARM: psci: cpuidle: Enable PSCI CPUidle driver
  PSCI: cpuidle: Refactor CPU suspend power_state parameter handling
  arm64: defconfig: Enable the PSCI CPUidle driver
  ARM: imx_v6_v7_defconfig: Enable the PSCI CPUidle driver

 MAINTAINERS                          |   8 +
 arch/arm/configs/imx_v6_v7_defconfig |   1 +
 arch/arm64/configs/defconfig         |   1 +
 arch/arm64/kernel/cpuidle.c          |  50 +++++-
 arch/arm64/kernel/psci.c             |   4 -
 drivers/cpuidle/Kconfig.arm          |  10 ++
 drivers/cpuidle/Makefile             |   1 +
 drivers/cpuidle/cpuidle-arm.c        |  13 +-
 drivers/cpuidle/cpuidle-psci.c       | 236 +++++++++++++++++++++++++++
 drivers/firmware/psci/psci.c         | 167 +------------------
 drivers/firmware/psci/psci_checker.c |  16 +-
 include/linux/cpuidle.h              |  17 +-
 include/linux/psci.h                 |   4 +-
 13 files changed, 342 insertions(+), 186 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci.c

-- 
2.21.0

