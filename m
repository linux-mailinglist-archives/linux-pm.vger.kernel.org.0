Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF2D818D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfJOVRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34948 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfJOVRB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so21761335lji.2;
        Tue, 15 Oct 2019 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/8G6U48Saagok81vx6tBZq+7O01KyGuxiVxl9Xdy+s=;
        b=nIX8bl/BB4/kLyip7LSWiCaJVov9k/r/c2gj2AsdkxncNMrPESmD62j5dNkEB3sjWw
         wD3NTGOc7zQ1Ju3wUTIUCiDSqcR2UQYZOM3Ngx8FUCW8utsUwIQDpakUTa+9TarIla6Q
         Mf7yJhhorTN/QXNAFrMq24RAADJAcwnCf5ECmEoc0ErGsy+4wFs9ACxz5en+0B3fQWBJ
         2ujpC8zwwL7ODdseRYSaT8IFYi7EfvWybHiM94E1H7KXppEZL/SIgP7fmKEoKlbBgxWQ
         lVP4heJ57hL3dp4XalsEX/LSF9onJaC8VnlVN5QEjaMBVeAuTR8tKc3JPRxaVbNm0u+t
         4HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/8G6U48Saagok81vx6tBZq+7O01KyGuxiVxl9Xdy+s=;
        b=lwxOlTiDSEWBP9RrCjISeo2sWHrPd+8R4K5HStzp/CBbSZ81iOGe3txfV8tvxGoP2r
         aUr3r1I3/TOoM8QI+pPGl6rMX04vURDW27VEqkfHJd483XNrYPpHYsONxUnYlJvYr2oO
         ldSk2hnKUfg47RmUkHMHWMaTnEt1BJ0ba6xCyfPhoBU3PdhPYenos7LCL4i/S6yYuTtE
         1LALEf47/UrAYMoTUJyEX5GkKpT/P1Cqg1D9uWBqhlKJv8Di/PJ8AlUEgp9x5o5zIFOF
         IFZrIo1EX7iyGclzda1HD9qJ3faTnlU6GH7UxjC8jgf+ZeS81aIux5Emckd1/lTYVz1b
         5gGw==
X-Gm-Message-State: APjAAAVlq8WbUMWgjtDCxvsMfcqO9buY/LlSYR29c6C9PUvKdpuv4kEX
        K3PAe8s+L/zK1W7+aXAR9MQ=
X-Google-Smtp-Source: APXvYqxI3SLztQQZtcgy/vwel0XPYAtj8jsU4xiIJwgQ29avdG8sssZx6XfheaG1MtoocxBpaBtexQ==
X-Received: by 2002:a2e:b049:: with SMTP id d9mr18609707ljl.121.1571174218878;
        Tue, 15 Oct 2019 14:16:58 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:16:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/17] NVIDIA Tegra20 CPUFreq driver major update
Date:   Wed, 16 Oct 2019 00:16:01 +0300
Message-Id: <20191015211618.20758-1-digetx@gmail.com>
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

NOTE: the voltage scaling functionality depends on a reviewed and yet
unapplied series [0].

[0] https://lkml.org/lkml/2019/7/25/892

Dmitry Osipenko (17):
  clk: tegra: Add custom CCLK implementation
  clk: tegra: pll: Add pre/post rate-change hooks
  clk: tegra: cclk: Add helpers for handling PLLX rate changes
  clk: tegra20: Support custom CCLK implementation
  clk: tegra30: Support custom CCLK implementation
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
    now)
  ARM: tegra: Remove tegra20-cpufreq platform device creation
  ARM: dts: tegra20: Add CPU clock
  ARM: dts: tegra30: Add CPU clock
  ARM: dts: tegra20: Add CPU Operating Performance Points
  ARM: dts: tegra30: Add CPU Operating Performance Points
  ARM: dts: tegra20: paz00: Set up voltage regulators for DVFS
  ARM: dts: tegra20: paz00: Add CPU Operating Performance Points
  ARM: dts: tegra20: trimslice: Add CPU Operating Performance Points
  ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
  ARM: dts: tegra30: beaver: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |   56 +
 .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   |  201 +++
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi        |  302 +++++
 arch/arm/boot/dts/tegra20-paz00.dts           |   41 +-
 arch/arm/boot/dts/tegra20-trimslice.dts       |   11 +
 arch/arm/boot/dts/tegra20.dtsi                |    2 +
 arch/arm/boot/dts/tegra30-beaver.dts          |   40 +-
 .../boot/dts/tegra30-cpu-opp-microvolt.dtsi   |  801 +++++++++++
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi        | 1202 +++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |    4 +
 arch/arm/mach-tegra/tegra.c                   |    4 -
 drivers/clk/tegra/Makefile                    |    1 +
 drivers/clk/tegra/clk-pll.c                   |   12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c      |  165 +++
 drivers/clk/tegra/clk-tegra20.c               |    6 +-
 drivers/clk/tegra/clk-tegra30.c               |    6 +-
 drivers/clk/tegra/clk.h                       |   12 +
 drivers/cpufreq/Kconfig.arm                   |    4 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    2 +
 drivers/cpufreq/tegra20-cpufreq.c             |  236 +---
 20 files changed, 2902 insertions(+), 206 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-cpu-opp.dtsi
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.23.0

