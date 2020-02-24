Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5E16B46E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBXWmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:42:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45783 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgBXWmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id e18so11884276ljn.12;
        Mon, 24 Feb 2020 14:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ni+9+C2OixXBozsO+Vukxpmas05+jGj37YYvv1otaGU=;
        b=mIDmf64usA3lY1ve2h7wNxlX75VUo8vdW1zR6TRiZHBsRf24rNM/rnrJrGhU8Hg+0S
         QnSZTAQbXD3tfA/D6Vgbj0JdFdQivpb4LuF9+nQUh2pGk2Dm3rtxAc58hRSBplT3H8NX
         Kb9wDhQfQKLuXKDFkn+kmmsInPCXM0xmfioSx8hoW9va6kwLKFzrm6y0tQFmh4Rtfj/2
         DH9w0oROR6qGfIL6CMIXzwvoODHXPp5/dWcDw9U1SYAGBdXGoG9xgP486IbO8M6tjBEq
         5B2sAPbMYMC0bYSabNYbQQzh/Eee7VqMpq2r/oT5c7OMqwNNLckuf1bOytP9o2SsuFZ4
         kuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ni+9+C2OixXBozsO+Vukxpmas05+jGj37YYvv1otaGU=;
        b=HpcNd8Tm8R3fih3PGM2qc0wIJoGjU80Xs+piiRSoeAkWltLRxRbLl4Kqw3RO45rAma
         bVEil1O/XImVEqLb8TzR3B0neZ+x1OiJ/k+SqgSzXgk8dWeH/xMssiSJg++BnAnj8Oz4
         bOTl+VRnesitHG1vXAFdeBnla5u92n3RnBM3RNU7IjJkvlL+ysFDr2dnIJ9ZLclEdQWB
         KoG11pnix4NX3JS4zts5avLVNZ2d+5OemmUpYMvlrth892959x2Uxsx4w9TSOR2TwzfE
         lXiPJ1M8L5hK99QN8eiRbchqG4SijZjrvVVSlCyFk+EVvDYbiPIlVbIZyqD17MjrTwJz
         DrEw==
X-Gm-Message-State: APjAAAW2TPCZnNLY8/980LMXk1ELXSLfzxFlV92B7XlbS+aT7m5nKSv7
        6qkcTP3iLH6dDNf2T7cAnW4=
X-Google-Smtp-Source: APXvYqyajfWTUwTxY/nQW9d5FP5Av8CektEP+9OYz9Dm+Lxuq0uwtm7IPeGJZsNsXl+CukmsEysAkA==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr32085323ljg.144.1582584153582;
        Mon, 24 Feb 2020 14:42:33 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 00/17] Consolidate and improve NVIDIA Tegra CPUIDLE driver(s)
Date:   Tue, 25 Feb 2020 01:40:40 +0300
Message-Id: <20200224224057.21877-1-digetx@gmail.com>
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

  2. Prepares upcoming CPU cluster power-down idling state enabling for
     Tegra30.

In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
and of the Tegra's arch code in general. Please apply, thanks!

!!!WARNING!!! This series was made on top of the cpufreq patches [1]. But it
              should be fine as long as Thierry Reding would pick up this and
              the cpufreq patchsets via the Tegra tree, otherwise there will
              one minor merge-conflict.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=158206

Changelog:

v11: - Added acks from Daniel Lezcano.

     - Added t-b from Nicolas Chauvet.

     - @Daniel Lezcano: In regards to -M, I assume it's useless. The
       cpuidle-tegra driver was rewritten from scratch, it's not a simple
       code move.

         rename arch/arm/mach-tegra/cpuidle-tegra20.c => drivers/cpuidle/cpuidle-tegra.c (9%)

     - Replaced ktime_get() with udelay(), thanks to Daniel Lezcano for the
       suggestion.

     - Note to Thierry: this series uses [1] +  next-20200218 for the base,
       you could also cherry-pick the patches from the grate-kernel if it
       makes things easier (it is up-to-date).

v10: - Added acks from Peter De Schrijver.

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

v9: - Rebased on recent linux-next. Dropped the v8 "Avoid NULL dereference.."
      patch as a result, it's not needed anymore.

    - Temporarily dropped "cpuidle: tegra: Support CPU cluster power-down
      state on Tegra30" patch because Michał Mirosław reported that it causes
      problem for ASUS TF300T Tegra30 device, we'll have to resolve the
      problem first.

    - Added ACKs from Peter De Schrijver to the patches.

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
 drivers/cpuidle/cpuidle-tegra.c               | 392 ++++++++++++++++++
 include/soc/tegra/cpuidle.h                   |   2 +-
 .../mach-tegra => include/soc/tegra}/irq.h    |   8 +-
 include/soc/tegra/pm.h                        |  31 ++
 23 files changed, 485 insertions(+), 761 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c
 rename {arch/arm/mach-tegra => include/soc/tegra}/irq.h (59%)

-- 
2.24.0

