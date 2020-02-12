Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7501F15B542
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgBLXwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39130 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgBLXwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so4436904ljg.6;
        Wed, 12 Feb 2020 15:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQi3JWesDA36v7p5yk/m+HYAtk60UEOOQvTiHfyiXRg=;
        b=WQOJF/g5Dd9xStyqDI1NAXVtNFsfEt0bGLQ8JvbA61X47NG/OPwoHlu9+N7DkU0Fk9
         6OjnWbfOBd4aVCXP9OFoafIeiY15o48M1kmZ2SfKQhb4SISsl9cVpcigRyXO0Fq0/Jhu
         SJCtKS72J7xBUbTHqmUH02wHS8wS+XpSUuJKptVbVp+HZJD+1paD6k+OOZFC7W4wF5Z1
         GoYH4xI5QJYYVLVS/EfIBNFGiqIX5plzNYJLqzPh6841HZN7c+mhb5XwZt3QZ8kc1Ikb
         w+AJd8A0KuvMFEYVs/JGcomdLRXL/u46THGpLiUgUtEtbql49gBRg21soMiyFP764WCb
         lhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQi3JWesDA36v7p5yk/m+HYAtk60UEOOQvTiHfyiXRg=;
        b=fi05cTbgqX2O4aRWcKeDtJaLWlhuHrZY2+UuyaVVrtaQSpX2pUepkB+QI2q5TIyjKI
         kaRLFgCEiZuI/CzS9Fbl/ONQUEy/jPV/8WV5CY3e0WvRI58r0amzRYnka6ai47NHZgu/
         LnJBjfygV6/7ftelLBiIIb+lAJ1RAn69hb9xWpybDbZYh05fBzkasiyl+etpIs8CfS+S
         OpAQ1Xbs96bQlzE4ozlWiOEx1nR5MizkSCh9n3rrODnZnTSaLokIsrhyyN3jW+wW9eXQ
         YgOhrmy5rP60hh8G16w6oxUYTmmCGwEbDMJPLL2Q+ZNoBLueJchfDw8S+qDOkTZd2EZQ
         SM2g==
X-Gm-Message-State: APjAAAXqEDj/Uj0MXc/M37PWNg5frNsDI8HL407tWxFOjhomzl8gV9pb
        h4D2nXyLOPvz7SttwCHWc38=
X-Google-Smtp-Source: APXvYqylIfJmTuoPiKCpNcK18bjVTokVZWsgEIc7IWXqRKKycpciWNc4jE48giFVhvx8qF0D1lIv4Q==
X-Received: by 2002:a2e:b044:: with SMTP id d4mr9051467ljl.159.1581551528471;
        Wed, 12 Feb 2020 15:52:08 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/17] Consolidate and improve NVIDIA Tegra CPUIDLE driver(s)
Date:   Thu, 13 Feb 2020 02:51:17 +0300
Message-Id: <20200212235134.12638-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
and of the Tegra's arch code in general. Please apply, thanks!

!!!WARNING!!! This series was made on top of the cpufreq patches [1]. But it
              should be fine as long as Thierry Reding would pick up this and
              the cpufreq patchsets via the Tegra tree, otherwise there will
              one minor merge-conflict.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=158206

Changelog:

v9: - Added acks from Peter De Schrijver.

    - Added tested-by from Peter Geis, Jasper Korten and David Heidelberg
      who tested these patches on Ouya, TF300T and Nexus 7 devices.

    - Temporarily dropped the "cpuidle: tegra: Support CPU cluster power-down
      state on Tegra30" patch because Michał Mirosław reported that it didn't
      work well on his TF300T. After some testing we found that changing
      a way in which firmware performs L2 cache maintenance helps, but later
      on we also found that the current v9 series works just fine without the
      extra firmware changes using recent linux-next and the reason why v8
      didn't work before is still unknown (need more testing). So I decided
      that it will be better to postpone the dropped patch until we know for
      sure that it works well for everyone in every possible configuration.

    - Rebased this series on top of recent linux-next, in a result dropped
      the "cpuidle: Avoid NULL dereference in cpuidle_driver_state_disabled()"
      patch because it's not needed anymore.

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

Dmitry Osipenko (17):
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
  cpuidle: Refactor and move out NVIDIA Tegra20 driver into
    drivers/cpuidle
  cpuidle: tegra: Squash Tegra30 driver into the common driver
  cpuidle: tegra: Squash Tegra114 driver into the common driver
  cpuidle: tegra: Disable CC6 state if LP2 unavailable
  ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
  ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig

 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 arch/arm/mach-tegra/Makefile                  |  19 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c        |  89 ----
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
 drivers/cpuidle/cpuidle-tegra.c               | 389 ++++++++++++++++++
 include/soc/tegra/cpuidle.h                   |   2 +-
 .../mach-tegra => include/soc/tegra}/irq.h    |   8 +-
 include/soc/tegra/pm.h                        |  31 ++
 23 files changed, 482 insertions(+), 761 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c
 rename {arch/arm/mach-tegra => include/soc/tegra}/irq.h (59%)

-- 
2.24.0

