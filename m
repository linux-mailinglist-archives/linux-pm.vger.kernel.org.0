Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2DF819E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKU5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35362 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfKKU5I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id r7so15316666ljg.2;
        Mon, 11 Nov 2019 12:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTH94OcJQ+rwm8Y0+zLHMJ3CU6FJ642OPrWgkaSlRRc=;
        b=C2egRvk23tr3BdxczTQkoV55cfEn4qg1E5PLHMilk2RVNgOb1iZG+419l+Qc81nwlO
         drkXK1AOnGXg6PeLlxHZhXtaD1evwnB1UCYBXO5mZ3WLcIO02mUw/Ge6PPniBaMbvRO/
         6DGPDN22zoXEtJKHLnELRMU9k+if9VmeNTmHXxf6D3wFFD+v8n0zaqf9frvzyPus8ZH8
         Du4BM0BtdqJdZ2nv6ERBk3I/sFYvc2wg2ZlDK1DzVzliMQMEumrmGcEeof1ZQMobObr9
         fFs5uSyva+xSPeMp/w6uQy2CLjWAJGuNVx6BVaiEqV+pldNrOIBUcZ58btAyHaonJMBe
         wk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTH94OcJQ+rwm8Y0+zLHMJ3CU6FJ642OPrWgkaSlRRc=;
        b=gRsjtCfYoNLFqFRz3NHpJRBbhcTkGeEpk3UNwamzrInzeoodhAt/Ok3p4BfLCU31+4
         BjVuAA/Yai4RTkGE066CYHZwpwIi5f5SBj+KcvE1q8jvUxZjGsIJ+t+V4Wi6MJ0UI+1R
         5CQaOu+1a29q2OP/llHKiheZjBZn+cfyxr1NFcrP54BSWGqpWSUhTTGsBphrqhSoqqnh
         7l+wSGKDeDlPtMxxVH6i4tjjCgeMnI98h4nHober90Un+oM4qItEMZ+VfX1o1p6HTwXU
         HJ8t758mOPTrnKeH9Lkv5RkOS9Um2Y/utFWWK/sRe8Uif6q3KZxKFbBf1sBmFWMGusyt
         PIeA==
X-Gm-Message-State: APjAAAW9pmZrTbWOgY1cUJZuDcfytMIg4+HQZSLFLWLynyYPKUQUKMr3
        IHCGCi+QQsy2jlC1+WnKb04=
X-Google-Smtp-Source: APXvYqxBN/xqZEL7Zp0sbSUtqEnhAoVrDOAllD/3Z7J8ja4H034CO/cbOfOGfVatqrROVisObdbsrg==
X-Received: by 2002:a2e:8581:: with SMTP id b1mr17798119lji.200.1573505826439;
        Mon, 11 Nov 2019 12:57:06 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:05 -0800 (PST)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] NVIDIA Tegra20 CPUFreq driver major update
Date:   Mon, 11 Nov 2019 23:54:09 +0300
Message-Id: <20191111205419.16768-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
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

Dmitry Osipenko (10):
  clk: tegra: Add custom CCLK implementation
  clk: tegra: pll: Add pre/post rate-change hooks
  clk: tegra: cclk: Add helpers for handling PLLX rate changes
  clk: tegra20: Use custom CCLK implementation
  clk: tegra30: Use custom CCLK implementation
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
    now)
  ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
  ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
  ARM: dts: tegra30: beaver: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  56 +++++
 arch/arm/boot/dts/tegra30-beaver.dts          |  40 +++-
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/clk/tegra/Makefile                    |   1 +
 drivers/clk/tegra/clk-pll.c                   |  12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c      | 212 +++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c               |   7 +-
 drivers/clk/tegra/clk-tegra30.c               |   6 +-
 drivers/clk/tegra/clk.h                       |  19 +-
 drivers/cpufreq/Kconfig.arm                   |   6 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/tegra20-cpufreq.c             | 217 +++++-------------
 12 files changed, 408 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.23.0

