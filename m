Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB766C18AC
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfI2SAL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38879 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfI2SAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so7101795ljj.5;
        Sun, 29 Sep 2019 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WT/W6l9M390MQrmHlc97kcL39Da6qFpVsoVprvsUhFo=;
        b=FLQEkV5Z6eYftoxnXQ06HQG61+1bqL3zYwkTi6K1ix4e7w+gQX+afwhODEHNECoCZx
         Y6e5jSiGtxjmdpPkhuWumhptdRXN4cxMiC7qVE2oRCuL6hPHd85fq8fycqzS+hPrQ4FM
         qBH/rriNAWE8RAGsnq02cFqV7Fs2tJHHzed1m5qtcaXHeJIsnLzuVo7Qa3tEuwVIVONm
         j2U+svJGqcAbG0c1osYR5bR5pDSec+gKonggNmKvNlhwL50dapgbVRCXPc4ORFtkc1w6
         atjCPZnwvkyiDS1hFso/YJMrsa0hgTldtLar/Vv19p1LxeRXliJQB8iqsyANC+4/p/w6
         7Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WT/W6l9M390MQrmHlc97kcL39Da6qFpVsoVprvsUhFo=;
        b=E/4K9X0zh7Peqc7vA6K/35a10PoPKjIC0LUrbQrh7khu21jPDe8sGwTNUShvX5FLXa
         N40ZVZF7lrq2vKQgYCoLw7GHUurzCmbVHNxY8yZPno2q/EMEMMCiuGPiDPPjqgwfdqy/
         T5T6FbJ5zoA8/BAa6wK6j+KL2pzOLrprmDbIV9LXuADxseTg9njMH7NUZrt059144Oty
         iux70Cn5QY1oKI6+bmphrtwnvLXj1B5NH3N4SXppuELwa7zYJf39IxyrDtecE9mxLvYo
         H1CseW3ixQ7xizo39TGPmXwhWKhy8v7M4IGd3gG3ZgZ/Ir7DTtMmxpJn/uU5myxbJNeV
         TH2A==
X-Gm-Message-State: APjAAAV4Dr521wdXhustyxLYfPAwEcTHOCHtPUZty22ouHqPHVCWGhlM
        6+t8FHgB4T7lwAtrCFY9/U8=
X-Google-Smtp-Source: APXvYqz0A6PLapVk2flFiPO9eFnivRUa188j6t32S2OvO6Yo/n0MOD0MgpYlV4stZR1uBSSwLzeHig==
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr9861928ljj.138.1569780008237;
        Sun, 29 Sep 2019 11:00:08 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/14] Consolidate and improve NVIDIA Tegra CPUIDLE driver(s)
Date:   Sun, 29 Sep 2019 20:59:38 +0300
Message-Id: <20190929175952.22690-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series does the following:

  1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
     into common drivers/cpuidle/ directory.

  2. Enables CPU cluster power-down idling state on Tegra30.

In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
and of the Tegra's arch code in general. Please review, thanks!

Changelog:

v5: - Rebased on a recent linux-next, fixed one minor conflict in Kconfig.

    - Improved commit's message of the "Support CPU cluster power-down state
      on Tegra30" patch.

    - The "Support CPU cluster power-down state on Tegra30" patch is also
      got split and now there is additional "Make outer_disable() open-coded"
      patch.

    - Made minor cosmetic changes to the "Introduce unified driver for
      NVIDIA Tegra SoCs" patch by improving error message and renaming
      one variable.

v4: - Fixed compilation with !CONFIG_CACHE_L2X0 (and tested that it still
      works).

    - Replaced ktime_compare() with ktime_before() in the new driver,
      for consistency.

v3: - Addressed review comments that were made by Jon Hunter to v2 by
      splitting patches into smaller (and simpler) chunks, better
      documenting changes in the commit messages and using proper error
      codes in the code.

      Warnings are replaced with a useful error messages in the code of
      "Introduce unified driver for NVIDIA Tegra SoCs" patch.

      Secondary CPUs parking timeout increased to 100ms because I found
      that it actually may happen to take more than 1ms if CPU is running
      on a *very* low frequency.

      Added diagnostic messages that are reporting Flow Controller state
      when CPU parking fails.

      Further polished cpuidle driver's code.

      The coupled state entering is now aborted if there is a pending SGI
      (Software Generated Interrupt) because it will be lost after GIC's
      power-cycling. Like it was done by the old Tegra20 CPUIDLE driver.

v2: - Added patches to enable the new cpuidle driver in the defconfigs:

        ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
        ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig

    - Dropped patches that removed CPUIDLE_FLAG_TIMER_STOP from the idling
      states because that flag actually doesn't have any negative effects,
      but still is correct for the case of a local CPU timer on older Tegra
      SoCs:

        cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/124 idle-state
        cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all states

    - The "Add unified driver for NVIDIA Tegra SoCs" patch got more polish.
      Tegra30 and Terga114 states are now squashed into a single common C7
      state (following Parker TRM terminology, see 17.2.2.2 Power Management
      States), more comments added, etc minor changes.

Dmitry Osipenko (14):
  ARM: tegra: Remove cpuidle drivers to replace them with a new driver
  ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
  ARM: tegra: Propagate error from tegra_idle_lp2_last()
  ARM: tegra: Compile sleep-tegra20/30.S unconditionally
  ARM: tegra: Expose PM functions required for new cpuidle driver
  ARM: tegra: Rename some of the newly exposed PM functions
  ARM: tegra: Add tegra_pm_park_secondary_cpu()
  ARM: tegra: Make outer_disable() open-coded
  clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP
  cpuidle: Introduce unified driver for NVIDIA Tegra SoCs
  cpuidle: tegra: Support CPU cluster power-down state on Tegra30
  ARM: tegra: Create simple platform device for cpuidle driver
  ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
  ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig

 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 arch/arm/mach-tegra/Makefile                  |  23 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c        |  89 -----
 arch/arm/mach-tegra/cpuidle-tegra20.c         | 212 -----------
 arch/arm/mach-tegra/cpuidle-tegra30.c         | 132 -------
 arch/arm/mach-tegra/cpuidle.c                 |  50 ---
 arch/arm/mach-tegra/cpuidle.h                 |  21 --
 arch/arm/mach-tegra/irq.c                     |   3 +-
 arch/arm/mach-tegra/pm.c                      |  50 +--
 arch/arm/mach-tegra/pm.h                      |   4 -
 arch/arm/mach-tegra/reset-handler.S           |  11 -
 arch/arm/mach-tegra/reset.h                   |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S           | 170 ---------
 arch/arm/mach-tegra/sleep-tegra30.S           |   6 +-
 arch/arm/mach-tegra/sleep.h                   |  15 -
 arch/arm/mach-tegra/tegra.c                   |   7 +-
 drivers/cpuidle/Kconfig.arm                   |   8 +
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-tegra.c               | 349 ++++++++++++++++++
 drivers/soc/tegra/Kconfig                     |   1 -
 include/linux/clk/tegra.h                     |  13 +
 include/soc/tegra/cpuidle.h                   |   2 +-
 .../mach-tegra => include/soc/tegra}/irq.h    |   8 +-
 include/soc/tegra/pm.h                        |  31 ++
 25 files changed, 453 insertions(+), 764 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c
 rename {arch/arm/mach-tegra => include/soc/tegra}/irq.h (59%)

-- 
2.23.0

