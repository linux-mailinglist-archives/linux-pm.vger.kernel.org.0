Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18AF65091
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 05:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfGKDNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 23:13:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34105 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 23:13:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so4203542ljg.1;
        Wed, 10 Jul 2019 20:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpCGft6h9dmrOGcCvZTli+kMxH4PBD8CMHoLHpaOawQ=;
        b=b1b7yPI39e8NdkiSn8/HrpWb3fVO7NhCuqCgRnHHBzfSP1chB3IS7oyzTzgRdDB2Af
         QKyAIYlE1yREJtRepgzZGnlh7h391lpAbPrbE6YMJwuSU5ZeZ0NWA66BdAzkbBq/4L1L
         CZqKJbAG+FYx+3nf53n2RnFulIb0DopDAeIENJhYa5ymZYKyk11yJ0NIHP8mjycnkfNH
         aa4O7sQEdRHr9nungA+sLQ1evJNf1P163iTTBbI8UhCqQCEi53wo5p0ZPDo7LunE9O8a
         UX/jf4AsKUwoGkOghBTyMeXFUaUGp+QXvvW7C7lrIlmqQDJ6gyzBSvLJrNgrffRRL4dc
         LgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpCGft6h9dmrOGcCvZTli+kMxH4PBD8CMHoLHpaOawQ=;
        b=Ipr+haKoh6EnkPG40GbyTm3alQx59CYrScPddKXTJHZPuBqUsMBMvei9/gVhRH0mT4
         kcZmEa5+hHRexiI1eHMR0JwJRVez+grCI60hpvy9dmXizoowlKzrMSliBWOjz7kCG+S7
         FOPGtcBJzMKJPjNumkMl2nLw+1FHxEskxogTQByE/mZQJU443d+4SjU+0R6M6TaHC6Sg
         JA1PQr6wM/CI0TdgtHPUz2F96dv3QiU9TQPm17LuFYlEldjOif8ER/Y94RnDckOzaMEi
         zONeaQOSLWl3j5Edx1+lQYaLRAJQXmlB4U9MeRHAHXRNsCkvgJYJHSDxcgZG0EcmNWsp
         aNsg==
X-Gm-Message-State: APjAAAUy6QnD7bTiMNbgj0+zYKMCCwX+FlYIsDQkG20ITSoOukmpKsEi
        I9yEmDafKPrEXwfUuy6yA1J/Zyrb
X-Google-Smtp-Source: APXvYqx7u63Q6EAdovMQgRC2frOh1N4eUtDlwEHKSYHNaZw/XN+/J+/c8jgY6NnH25y2BTp66FjmjA==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr906935ljj.170.1562814814590;
        Wed, 10 Jul 2019 20:13:34 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id h84sm753915ljf.42.2019.07.10.20.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 20:13:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Consolidate and improve NVIDIA Tegra CPUIDLE driver(s)
Date:   Thu, 11 Jul 2019 06:13:06 +0300
Message-Id: <20190711031312.10038-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I was spending quite some time recently trying to hunt down CPU-suspend
bug on Tegra30 SoC and in the end it was nailed. During that time I
realized that the CPU Idle drivers could get some polish and gain new
features, thus that's what this series does:

  1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
     into common drivers/cpuidle/ directory.

  2. Enables CPU cluster power-down idling state on Tegra30.

In the end there is a quite nice clean up of the Tegra CPUIDLE driver(s)
and of the Tegra's arch code in general. Please review, thanks!

Changelog:

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

Dmitry Osipenko (6):
  ARM: tegra: Remove cpuidle drivers
  ARM: tegra: Expose functions required for cpuidle driver
  cpuidle: Add unified driver for NVIDIA Tegra SoCs
  cpuidle: tegra: Support CPU cluster power-down on Tegra30
  ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
  ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig

 arch/arm/configs/multi_v7_defconfig    |   1 +
 arch/arm/configs/tegra_defconfig       |   1 +
 arch/arm/mach-tegra/Makefile           |  15 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c |  89 --------
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 -----------------
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 -----------
 arch/arm/mach-tegra/cpuidle.c          |  50 ----
 arch/arm/mach-tegra/cpuidle.h          |  21 --
 arch/arm/mach-tegra/irq.c              |  18 --
 arch/arm/mach-tegra/irq.h              |  11 -
 arch/arm/mach-tegra/platsmp.c          |   2 -
 arch/arm/mach-tegra/pm.c               |  27 +--
 arch/arm/mach-tegra/pm.h               |   4 -
 arch/arm/mach-tegra/reset-handler.S    |  11 -
 arch/arm/mach-tegra/reset.h            |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S    | 190 +---------------
 arch/arm/mach-tegra/sleep.h            |  13 --
 arch/arm/mach-tegra/tegra.c            |   7 +-
 drivers/cpuidle/Kconfig.arm            |   8 +
 drivers/cpuidle/Makefile               |   1 +
 drivers/cpuidle/cpuidle-tegra.c        | 303 +++++++++++++++++++++++++
 drivers/soc/tegra/Kconfig              |   1 -
 include/linux/clk/tegra.h              |  13 ++
 include/soc/tegra/cpuidle.h            |   2 +-
 include/soc/tegra/pm.h                 |  28 +++
 25 files changed, 375 insertions(+), 794 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 delete mode 100644 arch/arm/mach-tegra/irq.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c

-- 
2.22.0

