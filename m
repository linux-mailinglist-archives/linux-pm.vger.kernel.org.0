Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609472BFD7A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKWAbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKWAbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:15 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D6FC0613CF;
        Sun, 22 Nov 2020 16:31:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so21419755lfj.6;
        Sun, 22 Nov 2020 16:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NysKrV0pcPiBSAXOfC0FlNzl7uYVIoSjVknxgaXHng4=;
        b=IRU7ImYYZtnETV/rORMujVojlkaw/d7sz75fCcckTsCEr5jrFDpkcUP1LOq3+CHSOh
         +66x3b35++XPkitf+7OiwGZF2kfhSVY8yUDv5Uoqbj5eHuPAZPVmihb7gxZan76F3dIt
         RJAr9Arb5pvPMg+krzTtHP74mb1aUqCGw4WakVnS2Bk6oDrWKsOB5g+iuHlfj623RqM8
         owN7IsECYidH9nQ5LfgaIsbylMAA3yG0q8R8gCVgGrqnDfIzcBvJkD0swbJwGR+g2/Qo
         eFm2JNXrV7FxvK0UqmgrvF86SyLFf6d43W5h4OfbdBU24DlUNKbfgYpBB1hbXU3z25Ak
         UzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NysKrV0pcPiBSAXOfC0FlNzl7uYVIoSjVknxgaXHng4=;
        b=QkuKC/7TKPmnFh8JrQqx4mb+mAs5MR69uD0Ti6t+Kpo/xmhZf29C7Fbl0UwmlStkZs
         o8AyIfmWVD/okjFBA2Kz7SNjzs9Qgc7qeQPrbqflIH/dbUbOLVE57Stw8UtfMpvaNYWT
         3TMvKAWRDE40ylnGf72Qv8l68HK/MPkFEYymQadYjxm5+akFtoOkV0aHNANjwoXh8Xad
         LjaDhWMgLbNHuy3hzATenET8zrviFnAznI8oH5Cpv2/vpe5Clue+b0ZcQIpwPIIWKLLn
         Ff2PqXZ2jMVUOotOviYCp7ct9mAKmDd/7EDs8Ky7VSmcToWS6KcS7xk4wQtraCT/eXZ1
         Xpjg==
X-Gm-Message-State: AOAM531bQePtnoww3/8QPNQIupenomRDVr0i/zZxBuiztsg+Bkpx8h4I
        Q/6Xag4wUdjAts3jvhLvfyA=
X-Google-Smtp-Source: ABdhPJwfY3wb7svtcH2N/x7pL5kVqg/D45aaa0qhSOjamxag2xEzjHB/rbczb9fK8r2cbHTAbmJluQ==
X-Received: by 2002:a19:2d4:: with SMTP id 203mr12167911lfc.303.1606091473254;
        Sun, 22 Nov 2020 16:31:13 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:12 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v10 00/19] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Mon, 23 Nov 2020 03:27:04 +0300
Message-Id: <20201123002723.28463-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series brings initial support for memory interconnect to Tegra20,
Tegra30 and Tegra124 SoCs.

For the starter only display controllers and devfreq devices are getting
interconnect API support, others could be supported later on. The display
controllers have the biggest demand for interconnect API right now because
dynamic memory frequency scaling can't be done safely without taking into
account bandwidth requirement from the displays. In particular this series
fixes distorted display output on T30 Ouya and T124 TK1 devices.

Changelog:

v10 - In a longer run it will be much nicer if we could support EMC
      hardware versioning on Tegra20 and it's not late to support it now.
      Hence I added these new patches:

        dt-bindings: memory: tegra20: emc: Document opp-supported-hw property
        memory: tegra20: Support hardware versioning and clean up OPP table initialization

    - Removed error message from tegra30-devfreq driver about missing OPP
      properties in a device-tree because EMC driver already prints that
      message and it uses OPP API error code instead of checking DT directly,
      which is a more correct way of doing that.

v9: - Squashed "memory: tegra30-emc: Factor out clk initialization" into
      patch "tegra30: Support interconnect framework".
      Suggested by Krzysztof Kozlowski.

    - Improved Kconfig in the patch "memory: tegra124-emc: Make driver modular"
      by adding CONFIG_TEGRA124_CLK_EMC entry, which makes clk-driver changes
      to look a bit more cleaner. Suggested by Krzysztof Kozlowski.

    - Dropped voltage regulator support from ICC and DT patches for now
      because there is a new discussion about using a power domain abstraction
      for controlling the regulator, which is likely to happen.

    - Replaced direct "operating-points-v2" property checking in EMC drivers
      with checking of a returned error code from dev_pm_opp_of_add_table().
      Note that I haven't touched T20 EMC driver because it's very likely
      that we'll replace that code with a common helper soon anyways.
      Suggested by Viresh Kumar.

    - The T30 DT patches now include EMC OPP changes for Ouya board, which
      is available now in linux-next.

Dmitry Osipenko (19):
  dt-bindings: memory: tegra20: emc: Document opp-supported-hw property
  memory: tegra20: Support hardware versioning and clean up OPP table
    initialization
  memory: tegra30: Support interconnect framework
  memory: tegra124-emc: Make driver modular
  memory: tegra124-emc: Continue probing if timings are missing in
    device-tree
  memory: tegra124: Support interconnect framework
  drm/tegra: dc: Support memory bandwidth management
  drm/tegra: dc: Extend debug stats with total number of events
  PM / devfreq: tegra30: Support interconnect and OPPs from device-tree
  PM / devfreq: tegra30: Separate configurations per-SoC generation
  PM / devfreq: tegra20: Deprecate in a favor of emc-stat based driver
  ARM: tegra: Correct EMC registers size in Tegra20 device-tree
  ARM: tegra: Add interconnect properties to Tegra20 device-tree
  ARM: tegra: Add interconnect properties to Tegra30 device-tree
  ARM: tegra: Add interconnect properties to Tegra124 device-tree
  ARM: tegra: Add nvidia,memory-controller phandle to Tegra20 EMC
    device-tree
  ARM: tegra: Add EMC OPP properties to Tegra20 device-trees
  ARM: tegra: Add EMC OPP and ICC properties to Tegra30 EMC and ACTMON
    device-tree nodes
  ARM: tegra: Add EMC OPP and ICC properties to Tegra124 EMC and ACTMON
    device-tree nodes

 .../memory-controllers/nvidia,tegra20-emc.txt |   6 +
 MAINTAINERS                                   |   1 -
 arch/arm/boot/dts/tegra124-apalis-emc.dtsi    |   8 +
 .../arm/boot/dts/tegra124-jetson-tk1-emc.dtsi |   8 +
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi  |  10 +
 .../arm/boot/dts/tegra124-nyan-blaze-emc.dtsi |  10 +
 .../boot/dts/tegra124-peripherals-opp.dtsi    | 419 ++++++++++++++++++
 arch/arm/boot/dts/tegra124.dtsi               |  31 ++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |   5 +
 arch/arm/boot/dts/tegra20-colibri.dtsi        |   4 +
 arch/arm/boot/dts/tegra20-paz00.dts           |   4 +
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi | 109 +++++
 arch/arm/boot/dts/tegra20.dtsi                |  33 +-
 ...30-asus-nexus7-grouper-memory-timings.dtsi |  12 +
 arch/arm/boot/dts/tegra30-ouya.dts            |   8 +
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 383 ++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |  33 +-
 drivers/clk/tegra/Kconfig                     |   3 +
 drivers/clk/tegra/Makefile                    |   2 +-
 drivers/clk/tegra/clk-tegra124-emc.c          |  41 +-
 drivers/clk/tegra/clk-tegra124.c              |  26 +-
 drivers/clk/tegra/clk.h                       |  18 +-
 drivers/devfreq/Kconfig                       |  10 -
 drivers/devfreq/Makefile                      |   1 -
 drivers/devfreq/tegra20-devfreq.c             | 210 ---------
 drivers/devfreq/tegra30-devfreq.c             | 147 +++---
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/dc.c                    | 359 +++++++++++++++
 drivers/gpu/drm/tegra/dc.h                    |  19 +
 drivers/gpu/drm/tegra/drm.c                   |  14 +
 drivers/gpu/drm/tegra/hub.c                   |   3 +
 drivers/gpu/drm/tegra/plane.c                 | 121 +++++
 drivers/gpu/drm/tegra/plane.h                 |  15 +
 drivers/memory/tegra/Kconfig                  |   5 +-
 drivers/memory/tegra/tegra124-emc.c           | 377 ++++++++++++++--
 drivers/memory/tegra/tegra124.c               |  82 +++-
 drivers/memory/tegra/tegra20-emc.c            |  48 +-
 drivers/memory/tegra/tegra30-emc.c            | 344 +++++++++++++-
 drivers/memory/tegra/tegra30.c                | 173 +++++++-
 include/linux/clk/tegra.h                     |   8 +
 include/soc/tegra/emc.h                       |  16 -
 41 files changed, 2725 insertions(+), 402 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
 delete mode 100644 drivers/devfreq/tegra20-devfreq.c
 delete mode 100644 include/soc/tegra/emc.h

-- 
2.29.2

