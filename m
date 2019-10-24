Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A71E3EE8
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfJXWRi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42639 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJXWRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id z12so20399258lfj.9;
        Thu, 24 Oct 2019 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFegYju0pvZ8zy9x0rxcTVaQ8X5qk4V5YxAx+sCZPvQ=;
        b=jtiU+gjgsZp9N42gVu2X+kUrN6z1OdzSLh7TnKKeWmNgQ31BUfwiHeQ4Vy31JXZKns
         0mDNgvBsAeOUwJX8EYYPbehNhV3+5hq9sD+bAlOJmIFKYRDliBFlKX38JXI+rUWjMoCd
         IvKWH4pXhlCfLKZiLizTkcY5mjtrl0B2Ok7hSl7aLGO45pEDS1bbGbzmjrDLPWx5UPyb
         gs+qnRBeriGQ34cpzsklWwBnhtfOVcUwaGYBL27bsfmehCCKpnDaX3QGwa5WYhkqcZ94
         G14eLDhA52wxzCQCSsM40GUMzp/xHNIQqcE3PROB2IEldbaUvxAc5n2EbG8cvAogeH5e
         1xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFegYju0pvZ8zy9x0rxcTVaQ8X5qk4V5YxAx+sCZPvQ=;
        b=B5jpuOrjcMmJPQvyhx22FioyaEXz8aKas1kPLQo9AjG99XW8tcYgq2P5iEtbQR77iI
         oBKcHpwlbI0WvSMlYbk2/CVWZjGNj4q6fqaVbB/cg7v2187cKZWsiM0bE11X8ltBdsoS
         dpVL1ZisCcuQEGvZg+hnTxR/nmo/tt5SwCyOtvW+5DVxJfFTgoK0czCBUROjJmEGpU7r
         lVhDpAM+0OS9GF736OysXOz4f201MGNYXgcchWKP5uy+lTX42XZPRvRZgp1Tauqm62Er
         K4JHZwUZ06exvAgp9ODFiJQ7k+0zEpwTV78xiIjAt8yftrzvc+zA+jwq4CgOHWHgNUCs
         mKgA==
X-Gm-Message-State: APjAAAUUYuLjWIc5CqMXrRl421s3GlWzBX4ieGySUJsjMeajVIlY8zou
        G/0CT14Goc3LDU+E4sMUDNU=
X-Google-Smtp-Source: APXvYqy9sWA5/ZtNYtIDeQljihED8xi6/GdQp7XBqSJmvsz8G79HH5LsaYYF8Kxi/sFBCt63Vn4nVw==
X-Received: by 2002:a19:148:: with SMTP id 69mr332856lfb.76.1571955453849;
        Thu, 24 Oct 2019 15:17:33 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] NVIDIA Tegra20 CPUFreq driver major update
Date:   Fri, 25 Oct 2019 01:13:59 +0300
Message-Id: <20191024221416.14197-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series moves intermediate-clk handling from tegra20-cpufreq into
tegra-clk driver, this allows us to switch to generic cpufreq-dt driver
which brings voltage scaling, per-hardware OPPs and Tegra30 support out
of the box. All boards need to adopt CPU OPPs in their device-trees in
order to get cpufreq support. This series adds OPPs only to selective
boards because there is assumption in a current device-trees that CPU
voltage is set for 1GHz freq and this won't work for those CPUs that
can go over 1GHz and thus require voltage regulators to be set up for
voltage scaling support (CC'ed Marcel for Toradex boards). We could
probably add delete-node for OPPs over 1GHz if there are not actively
maintained boards.

NOTE(!): the voltage scaling functionality depends on a reviewed and yet
unapplied series [0], thus [0] needs to be applied first.

[0] https://lkml.org/lkml/2019/7/25/892

Changelog:

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

Dmitry Osipenko (17):
  clk: tegra: Add custom CCLK implementation
  clk: tegra: pll: Add pre/post rate-change hooks
  clk: tegra: cclk: Add helpers for handling PLLX rate changes
  clk: tegra20: Support custom CCLK implementation
  clk: tegra30: Support custom CCLK implementation
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
    now)
  ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
  ARM: dts: tegra20: Add CPU clock
  ARM: dts: tegra30: Add CPU clock
  ARM: dts: tegra20: Add CPU Operating Performance Points
  ARM: dts: tegra30: Add CPU Operating Performance Points
  ARM: dts: tegra20: paz00: Set up voltage regulators for DVFS
  ARM: dts: tegra20: paz00: Add CPU Operating Performance Points
  ARM: dts: tegra20: trimslice: Add CPU Operating Performance Points
  ARM: dts: tegra30: cardhu-a04: Set up voltage regulators for DVFS
  ARM: dts: tegra30: cardhu-a04: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |   56 +
 .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   |  201 +++
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi        |  302 +++++
 arch/arm/boot/dts/tegra20-paz00.dts           |   41 +-
 arch/arm/boot/dts/tegra20-trimslice.dts       |   11 +
 arch/arm/boot/dts/tegra20.dtsi                |    2 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts      |   48 +
 .../boot/dts/tegra30-cpu-opp-microvolt.dtsi   |  801 +++++++++++
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi        | 1202 +++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |    4 +
 arch/arm/mach-tegra/tegra.c                   |    4 +
 drivers/clk/tegra/Makefile                    |    1 +
 drivers/clk/tegra/clk-pll.c                   |   12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c      |  164 +++
 drivers/clk/tegra/clk-tegra20.c               |    6 +-
 drivers/clk/tegra/clk-tegra30.c               |    6 +-
 drivers/clk/tegra/clk.h                       |   12 +
 drivers/cpufreq/Kconfig.arm                   |    6 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    2 +
 drivers/cpufreq/tegra20-cpufreq.c             |  211 +--
 20 files changed, 2916 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-cpu-opp.dtsi
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.23.0

