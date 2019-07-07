Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92661886
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 01:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGGXi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 19:38:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37427 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfGGXi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 19:38:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so7860334lfh.4;
        Sun, 07 Jul 2019 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9nfwmFB7j0mJGrmDo+8GlD40u5rc6G1Lxi6W8DyoJY=;
        b=A7BbNw56S9eDxSzIzXxI1Xat7yN7WYKZd0IpMSea7taX51wdd6QCewc86oGSXXCT1J
         A/+fHwPW2uO+6xRiQ3Gpv3JdWDUJca+XaSGeTq6GENjtAwqfMpKOe/H3FntYkhnr47Ww
         FlnNfNEQcQEknzzWyB1R0l4O1dOP6UZ3IKSP68A0jJmoN7Pk/Iv8Q1xdobkwrZrmTUWE
         PqxQ4siS+HcqEgUXUfZOruHlSS4gx8trozi0LvAIVVyYktgR+tC5TpUoCRsYsVBEiKNR
         fBGuMENCsusAawqtqRPDQv+hjirKWP+GrEAHGlYPYsZHK1FAi4yC3XpNyW+GlhInV9Ne
         C/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9nfwmFB7j0mJGrmDo+8GlD40u5rc6G1Lxi6W8DyoJY=;
        b=GRtNpW6Evv3tub4OuYfyumDoFpUxAqJ6VJs+nloE7C7YHJkjCH7EHgQjCtU6YC/qf/
         mpzmVZB/55dhfTuFlh6tMa/ToP1PlhCM9hhnfWdT6GYOw86WtSmyOvk+TQuQPt/eofug
         psM/YO2k7KjnwqYjAzujwK9lglNKfXM0d4oHDc3a7sOaryJD+ngytLTh8+C5Tq8rTFYn
         Tkn2/H0p1AmVqXYiW0Wk84OMp+a4+DqFJUyI65xNJw/+Sfx77Nf4k+Eh2aM/vQ2HrtQ3
         DNosA5lWgxVVeSubWYTZN5/9y0ADagmTrNwPn+r9MYInLoWSXmNCvUt8NdtU/OSe3+8L
         VinA==
X-Gm-Message-State: APjAAAVv/F0EVsGHijOkSkcaN5NHyaJjQyT9u8FajncmDscEgsW8AnrY
        iDG6bG123A/XwMdxa6U6p3k=
X-Google-Smtp-Source: APXvYqwMMo5lmtV6pxPnZVt2woZLBwxsQSfmwtPeIXUrBb/DvSkAIebHKVfMeN0rPlDFWGEF45ezsg==
X-Received: by 2002:a19:be03:: with SMTP id o3mr7010779lff.88.1562542737384;
        Sun, 07 Jul 2019 16:38:57 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y5sm3246520ljj.5.2019.07.07.16.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:38:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Consolidate and improve NVIDIA Tegra CPUIDLE driver(s)
Date:   Mon,  8 Jul 2019 02:38:03 +0300
Message-Id: <20190707233809.14400-1-digetx@gmail.com>
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

  3. Removes CPUIDLE_FLAG_TIMER_STOP from all of the states since that
     flag is not relevant anymore.

In the end there is a quite nice clean up of the Terga CPUIDLE driver(s)
and of the Tegra's arch code in general. Please review, thanks!

Dmitry Osipenko (6):
  ARM: tegra: Remove cpuidle drivers
  ARM: tegra: Expose functions required for cpuidle driver
  cpuidle: Add unified driver for NVIDIA Tegra SoCs
  cpuidle: tegra: Support CPU cluster power-down on Tegra30
  cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/124
    idle-state
  cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all states

 arch/arm/mach-tegra/Makefile           |  15 +-
 arch/arm/mach-tegra/cpuidle-tegra114.c |  89 ----------
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 ----------------------
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 --------------
 arch/arm/mach-tegra/cpuidle.c          |  50 ------
 arch/arm/mach-tegra/cpuidle.h          |  21 ---
 arch/arm/mach-tegra/irq.c              |  18 --
 arch/arm/mach-tegra/irq.h              |  11 --
 arch/arm/mach-tegra/platsmp.c          |   2 -
 arch/arm/mach-tegra/pm.c               |  27 +--
 arch/arm/mach-tegra/pm.h               |   4 -
 arch/arm/mach-tegra/reset-handler.S    |  11 --
 arch/arm/mach-tegra/reset.h            |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S    | 190 +-------------------
 arch/arm/mach-tegra/sleep.h            |  13 --
 arch/arm/mach-tegra/tegra.c            |   7 +-
 drivers/cpuidle/Kconfig.arm            |   8 +
 drivers/cpuidle/Makefile               |   1 +
 drivers/cpuidle/cpuidle-tegra.c        | 232 +++++++++++++++++++++++++
 drivers/soc/tegra/Kconfig              |   1 -
 include/linux/clk/tegra.h              |  13 ++
 include/soc/tegra/cpuidle.h            |   2 +-
 include/soc/tegra/pm.h                 |  28 +++
 23 files changed, 302 insertions(+), 794 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle.h
 delete mode 100644 arch/arm/mach-tegra/irq.h
 create mode 100644 drivers/cpuidle/cpuidle-tegra.c

-- 
2.22.0

