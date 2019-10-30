Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4953CEA569
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfJ3Vf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:35:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33868 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3Vf0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id 139so4365235ljf.1;
        Wed, 30 Oct 2019 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89DBhMAwUuhNmjQB8YcL91mzuXL0pI6vL6Wp1D7Oo0I=;
        b=PUtTT8l42rQSCeM0lUpdELeH2toylgMOFYH9+szuUqsilQV5G9ucXIs+tR5XT3QiQd
         bt9U44/yhyMsJ+ng1cHaNyx2vre2ZT5CblDEKQ9mQoX8DyIe+StViWkRlOkuj+GO6jaB
         kfSXUWSzV45WbMBWOhxuTbJKb3ctjbwq5eMLhceMQDhDYnPOW3q6mGmcgQDHzrhhGxXv
         d5P8EEJHZWVOh9Aslm9BcmyPeLQbxmOVmh1dWrqqS8Qw1iu1wCXQkc5sMHw9bnoV0FOx
         Pl2T3Xso/N9l8qSrhwXtEIyNb4a8RXdeiHjKw/Y6KEmA8eIFPLZzbPn7ZvTIkklR6Gx2
         jqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89DBhMAwUuhNmjQB8YcL91mzuXL0pI6vL6Wp1D7Oo0I=;
        b=GC233hFq7nNj+Nhc45PovM/PZiReatpGZ8OjPN/4sEFagSeKI0+az8ArQnpPLI1L6J
         LUvQh9xtO6Y5iCSFCCCVWFfJhhIu1COpxRiq5AjDNSCwWQO+soYEutOuMro5jm62r1/k
         aoMliQns+UIAiDxV1JEinNBYPXXwxEvIgMoJgknidzarCEoV8niKz27segRfNUAf/z3Q
         9CcJ+hPTSW8llhB0zyv1MqHET8Fi0SbvUiWWRHgZX1TY3yCS6NUBz68RF4ECG98n5/Ii
         LdeQ67JH9JHB7gY/L+pp9TtX3/IPWnaIpFtPgAbSQcexFEYXjcLtonropAlXCkWFtxr4
         kV/A==
X-Gm-Message-State: APjAAAXOCf8WdLQCpyiIWWdnax8AreRUDLCkJ2/R18SffZLr4x9upryW
        zBl5+4zzNdOgOjBBpqEJTgQ=
X-Google-Smtp-Source: APXvYqxOFUcWp3V8SD1KyAeWu5qFw9AmOlxC1ZiPWu/Tw12nQhCodH5BN9rux3m6HjnLYr8PXMwMcg==
X-Received: by 2002:a2e:b4c1:: with SMTP id r1mr1287932ljm.203.1572471323442;
        Wed, 30 Oct 2019 14:35:23 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:22 -0700 (PDT)
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
Subject: [PATCH v3 00/10] NVIDIA Tegra20 CPUFreq driver major update
Date:   Thu, 31 Oct 2019 00:33:50 +0300
Message-Id: <20191030213400.29434-1-digetx@gmail.com>
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
      patch "clk: tegra: divider: Support enable-bit for Super clocks". Thanks
      to Peter Geis for reporting the problem.

    - Replaced Tegra30 "beaver" board with "cardhu-a04" because turned out
      that's what NVIDIA uses in the testing farm.

Dmitry Osipenko (10):
  clk: tegra: Add custom CCLK implementation
  clk: tegra: pll: Add pre/post rate-change hooks
  clk: tegra: cclk: Add helpers for handling PLLX rate changes
  clk: tegra20: Support custom CCLK implementation
  clk: tegra30: Support custom CCLK implementation
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
 drivers/clk/tegra/clk-tegra-super-cclk.c      | 210 +++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c               |   7 +-
 drivers/clk/tegra/clk-tegra30.c               |   6 +-
 drivers/clk/tegra/clk.h                       |  19 +-
 drivers/cpufreq/Kconfig.arm                   |   6 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/tegra20-cpufreq.c             | 211 +++++-------------
 12 files changed, 400 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.23.0

