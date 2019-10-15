Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF2D7C9E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfJORBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43112 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbfJORBm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so20997780ljj.10;
        Tue, 15 Oct 2019 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAf/AJSpWGLthNYsr7/ee48YPAv0jKYXu4gpVr7v0Kg=;
        b=O87K9+H+LKKaAGR1hnPRWFRk3vvSH+N/xvJnV91bXzsnyAsjnbYGn32+5AjHOR/fjJ
         2sZMz0v1Nc0anyxoQ3l7j+exj/Wmnr6nEIefblkjwynRQR9BKRHNoHkCKJaFUKcdYvDc
         6tmOWuWGb8eWeWCfrjcJE4iObod1BGVqMBeRZfbJ1LHNAS1W+Ce7TEI7IMY58iH1MW2y
         qnj95uAzUPE3w2oID5xzvdp/k5KeDwf24b856edFM+oS8LCsQTi1CvIiEgdeunaizflm
         xewhyQb2rhKiIaEK5e3vJM2keveiQwgbQBAXL9M8mqNzl35XaAzIi1JdwoiU4cery3Ya
         dKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAf/AJSpWGLthNYsr7/ee48YPAv0jKYXu4gpVr7v0Kg=;
        b=eDWg6EGVgljkdKkPZeXzEn4rL/xBnJKa2K/03AIuxhmPN7ooa/3jkLsOe2KXSF0ua9
         kXdaRksB2gE0Aj8+CcILhMYxT2KaUSkY15t4tYi3Gy5LIPXaO6tthF6ADJkVFMpHvgiP
         aNJC1ma5my5DK8S3xvo4u+UQnbuq62kWh6mE4GiV97u4S2dQZdaTxiBvZJvaOLaU297b
         cDJahuXS1xBfH02J50gnhAxE4zaROiOQHvkdUwhDY38bttSO9LquC2AAiEckhfosP1fo
         sKIdGYv+yQngfLGIOcTIOCeFnMKHT4lx9rYlf9epGGrZRZeTrJJ1ziBCroyvXOMGFGYY
         83Pg==
X-Gm-Message-State: APjAAAUtqNMg4Dn997LPzxyxw/M1Bk5+AFSAvEfT9uOjNSQykJ423oqA
        Wh+k3j08gii5AtCMPHKPz+o=
X-Google-Smtp-Source: APXvYqwVa7YDD7YGwba8GfxI4XSWD9ModJMws3K//NTWxVO2sEEpCANpAYOuscuP4yd8DoPldSBHXA==
X-Received: by 2002:a2e:634e:: with SMTP id x75mr23312475ljb.25.1571158899122;
        Tue, 15 Oct 2019 10:01:39 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/18] Consolidate and improve NVIDIA Tegra CPUIDLE driver(s)
Date:   Tue, 15 Oct 2019 19:59:57 +0300
Message-Id: <20191015170015.1135-1-digetx@gmail.com>
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


Dmitry Osipenko (18):
  ARM: tegra: Compile sleep-tegra20/30.S unconditionally
  ARM: tegra: Add tegra_pm_park_secondary_cpu()
  ARM: tegra: Remove pen-locking from cpuidle-tegra20
  ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
  ARM: tegra: Propagate error from tegra_idle_lp2_last()
  ARM: tegra: Expose PM functions required for new cpuidle driver
  ARM: tegra: Rename some of the newly exposed PM functions
  ARM: tegra: Make outer_disable() open-coded
  clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP
  arm: tegra20: cpuidle: Handle case where secondary CPU hangs on
    entering LP2
  arm: tegra20: cpuidle: Make abort_flag atomic
  arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
  cpuidle: Refactor and move NVIDIA Tegra20 driver into drivers/cpuidle/
  cpuidle: tegra: Squash Tegra30 driver into the common driver
  cpuidle: tegra: Support CPU cluster power-down state on Tegra30
  cpuidle: tegra: Squash Tegra114 driver into the common driver
  ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
  ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig

 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 arch/arm/mach-tegra/Makefile                  |  19 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c        |  89 -----
 arch/arm/mach-tegra/cpuidle-tegra20.c         | 212 -----------
 arch/arm/mach-tegra/cpuidle-tegra30.c         | 132 -------
 arch/arm/mach-tegra/cpuidle.c                 |  50 ---
 arch/arm/mach-tegra/cpuidle.h                 |  21 --
 arch/arm/mach-tegra/irq.c                     |   3 +-
 arch/arm/mach-tegra/pm.c                      |  54 +--
 arch/arm/mach-tegra/pm.h                      |   4 -
 arch/arm/mach-tegra/reset-handler.S           |  11 -
 arch/arm/mach-tegra/reset.h                   |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S           | 170 ---------
 arch/arm/mach-tegra/sleep-tegra30.S           |   6 +-
 arch/arm/mach-tegra/sleep.h                   |  15 -
 arch/arm/mach-tegra/tegra.c                   |   7 +-
 drivers/cpuidle/Kconfig.arm                   |   8 +
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-tegra.c               | 357 ++++++++++++++++++
 include/linux/clk/tegra.h                     |  13 +
 include/soc/tegra/cpuidle.h                   |   2 +-
 .../mach-tegra => include/soc/tegra}/irq.h    |   8 +-
 include/soc/tegra/pm.h                        |  31 ++
 24 files changed, 463 insertions(+), 761 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c
 rename {arch/arm/mach-tegra => include/soc/tegra}/irq.h (59%)

-- 
2.23.0

