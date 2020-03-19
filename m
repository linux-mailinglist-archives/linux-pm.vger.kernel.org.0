Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE2818BFD6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCSTEJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36020 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgCSTEJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id s1so2571895lfd.3;
        Thu, 19 Mar 2020 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sgZCorxsVnTvMnes1NBcLuKHRh0Qa0L3u8aGTG6FYwc=;
        b=uQM7ZfU3n6b37nTVfw5pkFRD9VUrTf5REPsD7In3xwXkR4rR+XfhCdyWywKLG4jkp7
         bzEBrzvzXE9eQfCE7os7IBlQy2vmgMKk8r4bErZJ3WOtmTs4NgXK2QCpZ+OP8wZd25bM
         xwFRItXPV+iheXNXbWafVHQWFtVOiZK7KzeYs2hAEYGdJKFfUfHJI8xd1Uerj1Y5oI4t
         4DmZ1MF4MpjjGFS9xqab1u9uur0l966Iv8v1K5qAHM+X6Z08LLIf/ab/OP+/5CLC/+bK
         fW4Hr62cmiRG2N2GlpK6d15o01jvGQsdRW+EFLoq7VnvZZaxbXU67SS0wexdqAU4pArz
         jX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sgZCorxsVnTvMnes1NBcLuKHRh0Qa0L3u8aGTG6FYwc=;
        b=r7VyICMWwyWOTFXJ+CresqiGaLThH/9AAx979q5Y3Yb/XlZYo0nguKt0TXiz+xrF5K
         xUNGf1iy8pYEWR6Kgz/IwhQziYgMRf2Tx1F5GmjhUu+WcRZjdNyMXGyOl62D8bS9KGaS
         HYTEuxKpldjMOSdfkBF9eAbVGfC6l/Erh6AqziR/oSCb6Njuv8ktl+SoUQjbjypVSS3l
         ILRk4szJqaaJ5BBo/12RLD/OZMDk1HVRbXEIct5yG5ipznaZGre5MomwO4Uyj6pNt1yn
         y45AjtHhnOf6nEocWJQDhLzi+xHr4V7g63nsr++3sG5JgnMf6PHEGCPcYtJjI362d7Ix
         Upkg==
X-Gm-Message-State: ANhLgQ22d1E2tontaYWY7jQUcCn0FFYBgEzOePTwj4tyUZGUdaijOaFn
        mDtDyeYykSLD4Jg2xFJ2lpo=
X-Google-Smtp-Source: ADFU+vv9qm41IoQ1F0DtI3bwr/YdLm8G9mCfDH78R2ugb73eNTXYC86SoKiRm6tO4+5o2V7MdCbSQQ==
X-Received: by 2002:a05:6512:10d2:: with SMTP id k18mr2928860lfg.72.1584644646595;
        Thu, 19 Mar 2020 12:04:06 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/12] NVIDIA Tegra20 CPUFreq driver major update
Date:   Thu, 19 Mar 2020 22:02:17 +0300
Message-Id: <20200319190229.32200-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series moves intermediate-clk handling from tegra20-cpufreq into
tegra-clk driver. This allows us to switch to generic cpufreq-dt driver
which brings voltage scaling, per-hardware OPPs and Tegra30 support out
of the box. All boards need to adopt CPU OPPs in their device-trees in
order to get cpufreq support.

Changelog:

v8: - Rebased on a recent linux-next because Thierry merged the cpuidle
      series first and now there is one minor conflict.

    - Added tested-by from Nicolas Chauvet who was one of the first
      testers of the series.

v7: - Added acks from Peter De Schrijver.

    - Added tested-by from Marcel Ziswiler, Peter Geis, Jasper Korten and
      David Heidelberg who tested these patches on Apalis/Colibri devboards,
      Ouya, TF300T and Nexus 7 devices respectively.

    - Rebased series on top of recent linux-next.

v6: - Dropped "cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs"
      patch from the series since Viresh picked up that patch separately.

    - Added two new patches to this series:

        ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
        ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30

      Previously these patches were sent out separately from this series,
      but it should be more consistent to include them into the series since
      they directly relate to enabling of the cpufreq driver on Tegra30.

v5: - The "Use generic cpufreq-dt driver (Tegra30 supported now)" patch
      is separated now into two patches by factoring out the blacklisting
      of cpufreq-dt-platdev into a standalone patch. This is done in a
      response to request from Jon Hunter to fix the warning splats during
      boot that are coming from OPP core because OPPs are unavailable. The
      OPPs will become available once tegra20-cpufreq driver will be updated
      to support the cpufreq-dt.

v4: - Updated CCLK diagram in the "Add custom CCLK implementation" patch.

    - <linux/cpu.h> is now included in the "Use generic cpufreq-dt driver"
      patch, for consistency.

    - Returned value of get_cpu_device() is now checked in the "Use generic
      cpufreq-dt driver" patch, for consistency as well.

v3: - The "Add custom CCLK implementation" patch was updated in accordance
      to the comments from Peter De Schrijver. We will not use the clock
      skipper.

    - Re added OPPs for T30 Beaver board because Thierry has that board ;)

    - Added r-b for the "DT binding" patch from Rob Herring.

v2: - Kept modularity of the tegra20-cpufreq as was requested by Viresh Kumar
      in a review comment to v1.

    - Added acks from Viresh Kumar.

    - Added tested-by from Nicolas Chauvet to the "trimslice" patch.
      Nicolas told me on IRC that it works fine.

    - Fixed compilation of the "Add custom CCLK implementation" patch. The
      error happened because v1 was based on top of yet unreviewed/unapplied
      patch "clk: tegra: divider: Support enable-bit for Super clocks".
      Thanks to Peter Geis for reporting the problem.

    - Replaced Tegra30 "beaver" board with "cardhu-a04" because turned out
      that's what NVIDIA uses in the testing farm.

Dmitry Osipenko (12):
  clk: tegra: Add custom CCLK implementation
  clk: tegra: pll: Add pre/post rate-change hooks
  clk: tegra: cclk: Add helpers for handling PLLX rate changes
  clk: tegra20: Use custom CCLK implementation
  clk: tegra30: Use custom CCLK implementation
  ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
  ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
    now)
  ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
  ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
  ARM: dts: tegra30: beaver: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  56 +++++
 arch/arm/boot/dts/tegra30-beaver.dts          |  40 +++-
 arch/arm/mach-tegra/sleep-tegra30.S           |  16 +-
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/clk/tegra/Makefile                    |   1 +
 drivers/clk/tegra/clk-pll.c                   |  12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c      | 212 +++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c               |   7 +-
 drivers/clk/tegra/clk-tegra30.c               |   6 +-
 drivers/clk/tegra/clk.h                       |  19 +-
 drivers/cpufreq/Kconfig.arm                   |   6 +-
 drivers/cpufreq/tegra20-cpufreq.c             | 217 +++++-------------
 12 files changed, 415 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.25.1

