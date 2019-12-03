Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D872210F435
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLCAnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:43:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38524 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCAmD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so1410709lfm.5;
        Mon, 02 Dec 2019 16:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4N1OcUBKXpOd3igKUZEfBbM0cyqXgkxpiVaaCCMo0w=;
        b=cnBoBZIyK102YaUZ+RCdvvZo0+0KaVlNAZqiJGDc12MmRT+pSQ0hTfp5txPpZEoom0
         4m4lBdMUe6gGh3lpWR3zr5iWo0MWlzryfUHC98ZvW+FCk4FsP79y80iTgqf9TDTbbsT8
         tP0sR+PuV+FrEv5FDCWff3Sj2DMq/hvWW78D17JLZtXkTovPGyukgK3GA2no/1yxYE56
         I3lcLkOTV5pBmTv+MpW2sUn48Q55IFYpjqwEHqLaB+Z/O3iXA9Ch3VjV9cwBmoQ1+oPi
         PqYW2YniZbLMEQ8fIho0phek3lcOwLDS9PsWXRX1XhM5mJgubcyiGmPRXwtunciZFVoh
         NzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4N1OcUBKXpOd3igKUZEfBbM0cyqXgkxpiVaaCCMo0w=;
        b=MBR8VcXzMf6dK6L6cDG/v2hxqNr5C7/u7ojoImPrAHYxFJKKcpvpOwld4k4ABppDuu
         Pfhnu+ZpKqLv1HYujVeEqdFHleTnLosZ1sMhAzSuMZnv+sQlPQOHTMmzGEtzyGi1gRTc
         QM4y1oejCvhq5R32PtIZpVG4enEm7Ab8RmJb8HgnL1joqMEufJ2WjRoZPM/JWFx6o18E
         E7tPAjr7f0DwJbArQw4LzpWW8V5v4Y3fX/fUGyGAlFHtGlo0Hpwjbl8XAgTaT8NSfhCA
         80EBcgRQC/A4aYBeZQif2r0f8WD6SQ2/vFZtfywhPkzITJxyzgDrN4cBLQ4/LGxTMgRc
         YfHg==
X-Gm-Message-State: APjAAAUadHWc0NICGeiuim8waE1gY7wVUpkgPJyhub08Gbbt/FGWxlyk
        UTZJ8ppK1tjogoWYTUZrWzM=
X-Google-Smtp-Source: APXvYqw6Jf8V2Q4b3H3bL0Z+TWaZXzpmHICATpunlQj30SAJFSKTUJwEMFlcKl4SH8lPE6b5CuStIA==
X-Received: by 2002:ac2:483c:: with SMTP id 28mr1081814lft.14.1575333719968;
        Mon, 02 Dec 2019 16:41:59 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:41:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE driver(s)
Date:   Tue,  3 Dec 2019 03:40:57 +0300
Message-Id: <20191203004116.11771-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
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

v8: - Rebased on recent linux-next, now making use of
      cpuidle_driver_state_disabled(). Added new patch to make this new API
      usable by the updated Tegra cpuidle driver:

        cpuidle: Avoid NULL dereference in cpuidle_driver_state_disabled()

    - Added new patch to handle case where LP2 isn't available:

        cpuidle: tegra: Disable CC6 state if LP2 unavailable

v7: - drivers/cpuidle/cpuidle-tegra.c now includes an explicit comment that
      clarifies the new terminology that is used for naming of the idling
      states. This change was suggested by Peter De Schrijver in the review
      comment to v6. See the comment to struct tegra_idle_driver in the code.

    - (!) This series is now based on top of the "NVIDIA Tegra20 CPUFreq
      driver major update" patchset. The conflict between these two series
      is trivial to resolve, but still it's worth to mention about that.

v6: - Addressed request from Thierry Reding to change the way patches are
      organized by making changes in a more incremental manner.

    - tegra_sleep_cpu() now checks for the secondary CPUs to be offline
      in the "Make outer_disable() open-coded" patch.

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

Dmitry Osipenko (19):
  ARM: tegra: Compile sleep-tegra20/30.S unconditionally
  ARM: tegra: Add tegra_pm_park_secondary_cpu()
  ARM: tegra: Remove pen-locking from cpuidle-tegra20
  ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
  ARM: tegra: Propagate error from tegra_idle_lp2_last()
  ARM: tegra: Expose PM functions required for new cpuidle driver
  ARM: tegra: Rename some of the newly exposed PM functions
  ARM: tegra: Make outer_disable() open-coded
  arm: tegra20: cpuidle: Handle case where secondary CPU hangs on
    entering LP2
  arm: tegra20: cpuidle: Make abort_flag atomic
  arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
  cpuidle: Avoid NULL dereference in cpuidle_driver_state_disabled()
  cpuidle: Refactor and move out NVIDIA Tegra20 driver into
    drivers/cpuidle
  cpuidle: tegra: Squash Tegra30 driver into the common driver
  cpuidle: tegra: Support CPU cluster power-down state on Tegra30
  cpuidle: tegra: Squash Tegra114 driver into the common driver
  cpuidle: tegra: Disable CC6 state if LP2 unavailable
  ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
  ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig

 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 arch/arm/mach-tegra/Makefile                  |  19 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c        |  89 -----
 arch/arm/mach-tegra/cpuidle-tegra20.c         | 212 ----------
 arch/arm/mach-tegra/cpuidle-tegra30.c         | 132 ------
 arch/arm/mach-tegra/cpuidle.c                 |  50 ---
 arch/arm/mach-tegra/cpuidle.h                 |  21 -
 arch/arm/mach-tegra/irq.c                     |   3 +-
 arch/arm/mach-tegra/pm.c                      |  54 ++-
 arch/arm/mach-tegra/pm.h                      |   4 -
 arch/arm/mach-tegra/reset-handler.S           |  11 -
 arch/arm/mach-tegra/reset.h                   |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S           | 170 --------
 arch/arm/mach-tegra/sleep-tegra30.S           |   6 +-
 arch/arm/mach-tegra/sleep.h                   |  15 -
 arch/arm/mach-tegra/tegra.c                   |   7 +-
 drivers/cpuidle/Kconfig.arm                   |   8 +
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-tegra.c               | 376 ++++++++++++++++++
 drivers/cpuidle/driver.c                      |   4 +
 include/soc/tegra/cpuidle.h                   |   2 +-
 .../mach-tegra => include/soc/tegra}/irq.h    |   8 +-
 include/soc/tegra/pm.h                        |  31 ++
 24 files changed, 473 insertions(+), 761 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c
 rename {arch/arm/mach-tegra => include/soc/tegra}/irq.h (59%)

-- 
2.24.0

