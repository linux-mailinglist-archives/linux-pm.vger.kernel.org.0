Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC001F3C20
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgFINOc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgFINO2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB46C05BD1E;
        Tue,  9 Jun 2020 06:14:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n24so24951379lji.10;
        Tue, 09 Jun 2020 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIcWcpLaTLlEzbSLM2kpyPsmSr3GOkVXSLdltQuwKFQ=;
        b=Wi+IOfmAU71v10i/U0f5dSRs7pHU3RA4tSzHKKNIZpxYhSSbN5FHmYiN+DTmsGtCzO
         SS5sMIjNmQmySB7lQbwbYWQI34MQGNRF6BmR41v9jYn555LjUDjIbO3QEYE5zJ8hRXAt
         NXWI9qqm/KIkFKuKlW4D+nnYQB0Q6ANJ1SBIch0047zfy/Rr4Fe+SHqOi0nQTIBPekqJ
         9/7QRKOHVOp0GfGjBJf1UKvqa4wLXk8af/J9sQxuac1QDFbQ/J+BH1vquffOHiaOWhEC
         2r81kzyfS/7ADBqOWEHvR47rXMAbLrLnFxThhmkykfGaUW23O/lg5W5ZAT7NLFKR46t+
         WR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIcWcpLaTLlEzbSLM2kpyPsmSr3GOkVXSLdltQuwKFQ=;
        b=GV4X94VaRJuJuFbS+zplVMWpHyLCbQp+VJele0Uf7DPeVZGV5D7KbgWO5BjYv/f1V0
         YMn4SBO9kNhnOwQ74ndFZH1E2B+qzG9UFTVodrCE1F2yN9MvfLW1A+eXZ0H8cm7ya2/T
         MA2jyLiy/Gqk+NJvD48eIYSqSmpfjOySrZfBytkHOzELZhKvBxhioQHUjNry2r/T6nEZ
         98QkE5VTrDwQCGoVIPqe8osuIDdvP1eY9zQsVC8BrSSzZYCDkjZaR2D+lnevJnzeN989
         jTyuqsFnmEebMwxU9VO7a7A1vGRPXwDDXpbDX2DvxNZAY5KsNVY3FZ1urbxVRrQOPwnh
         aKzw==
X-Gm-Message-State: AOAM531f+fB8tvSTsEeeYfv4bbjr54+cW5zff11l2Vmy4OaJFu0OCqeD
        OAaMoqi5AXPLUOM2fM+cSaw=
X-Google-Smtp-Source: ABdhPJzibtZeGfNEv8ZyPCOsMlDho+/PmqPjuaPSp3pY/M+qFm82Tgu/c87DPerk8Q9iMmDpSshXuQ==
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr13085387ljm.90.1591708464561;
        Tue, 09 Jun 2020 06:14:24 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:23 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 00/37] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Tue,  9 Jun 2020 16:13:27 +0300
Message-Id: <20200609131404.17523-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series brings initial support for memory interconnect to Tegra20 and
Tegra30 SoCs.

For the starter only display controllers are getting interconnect API
support, others could be supported later on. The display controllers
have the biggest demand for interconnect API right now because dynamic
memory frequency scaling can't be done safely without taking into account
bandwidth requirement from the displays.

Changelog:

v4: - All drivers that use interconnect API now select it in the Kconfig in
      order to properly express the build dependency.

    - The IS_ENABLED(CONFIG_INTERCONNECT) is dropped now from all patches.

    - Added MODULE_AUTHOR() to the modularized drivers, for completeness.

    - Added missed TEGRA_MC Kconfig dependency for the Tegra20 EMC driver.

    - Added more acks from Rob Herring that I accidentally missed to add in v3.

v3: - Added acks from Rob Herring that were given to some of the v2 patches.

    - Specified name of the TRM documentation chapter in the patch
      "dt-bindings: host1x: Document new interconnect properties", which was
      suggested by Rob Herring in the review comment to v2.

    - Added patches that allow EMC drivers to be compiled as a loadable kernel
      modules. This came up during of the v2 review when Georgi Djakov pointed
      out that interconnect-core could be compiled as a kernel module. Please
      note that the Tegra124 EMC driver is compile-tested only, I don't have
      Tegra124 HW.

    - In the review comment to [1] Stephen Boyd suggested that it will be
      better not to make changes to clk API, which was needed in order to
      avoid clashing of the interconnect driver with the devfreq in regards
      to memory clk-rate rounding.

      [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200330231617.17079-3-digetx@gmail.com/

      Stephen Boyd suggested that instead we should provide OPP table via DT.
      I tried to investigate whether this could be done and turned out
      it's a bit complicated. Technically it should be doable, but:

        1. For now we don't fully support voltage scaling of the CORE regulator
           and so OPP table in the DT isn't really needed today. We can
           generate table from the memory timings, which is what Tegra devfreq
           drivers already do.

        2. The OPP table should be defined in the DT for the Memory Controller
           node and then its usage somehow should be shared by both interconnect
           and devfreq drivers. It's not obvious what's the best way to do it.

      So, it will be much better to postpone the DT OPP table addition
      until these questions are resolved. We can infer OPPs from the
      memory timings and we could get the memory rates from the memory
      driver directly, avoiding the problems induced by the clk API usage.
      This idea is implemented in v3, see these patches:

        PM / devfreq: tegra20: Use MC timings for building OPP table
        PM / devfreq: tegra30: Use MC timings for building OPP table

v2: - Instead of a single dma-mem interconnect path, the paths are now
      defined per memory client.

    - The EMC provider now uses #interconnect-cells=<0>.

    - Dropped Tegra124 because there is no enough information about how to
      properly calculate required EMC clock rate for it and I don't have
      hardware for testing. Somebody else will have to work on it.

    - Moved interconnect providers code into drivers/memory/tegra/*.

    - Added "Create tegra20-devfreq device" patch because interconnect
      is not very usable without the devfreq memory auto-scaling since
      memory freq will be fixed to the display's requirement.

Artur Świgoń (1):
  interconnect: Relax requirement in of_icc_get_from_provider()

Dmitry Osipenko (36):
  clk: Export clk_hw_reparent()
  clk: tegra: Remove Memory Controller lock
  clk: tegra: Export Tegra20 EMC kernel symbols
  memory: tegra20-emc: Make driver modular
  memory: tegra30-emc: Make driver modular
  memory: tegra124-emc: Make driver modular
  memory: tegra124-emc: Use devm_platform_ioremap_resource
  soc/tegra: fuse: Export tegra_read_ram_code()
  memory: tegra20-emc: Initialize MC timings
  PM / devfreq: tegra20: Silence deferred probe error
  PM / devfreq: tegra30: Silence deferred probe error
  PM / devfreq: tegra20: Use MC timings for building OPP table
  PM / devfreq: tegra30: Use MC timings for building OPP table
  PM / devfreq: tegra20: Add error messages to tegra_devfreq_target()
  PM / devfreq: tegra30: Add error messages to tegra_devfreq_target()
  PM / devfreq: tegra20: Adjust clocks conversion ratio and polling
    interval
  PM / devfreq: tegra20: Relax Kconfig dependency
  dt-bindings: memory: tegra20: mc: Document new interconnect property
  dt-bindings: memory: tegra20: emc: Document new interconnect property
  dt-bindings: memory: tegra30: mc: Document new interconnect property
  dt-bindings: memory: tegra30: emc: Document new interconnect property
  dt-bindings: host1x: Document new interconnect properties
  dt-bindings: memory: tegra20: Add memory client IDs
  dt-bindings: memory: tegra30: Add memory client IDs
  ARM: tegra: Add interconnect properties to Tegra20 device-tree
  ARM: tegra: Add interconnect properties to Tegra30 device-tree
  memory: tegra: Register as interconnect provider
  memory: tegra20-emc: Use devm_platform_ioremap_resource
  memory: tegra20-emc: Continue probing if timings are missing in
    device-tree
  memory: tegra20-emc: Register as interconnect provider
  memory: tegra20-emc: Create tegra20-devfreq device
  memory: tegra30-emc: Continue probing if timings are missing in
    device-tree
  memory: tegra30-emc: Register as interconnect provider
  drm/tegra: dc: Support memory bandwidth management
  drm/tegra: dc: Tune up high priority request controls for Tegra20
  drm/tegra: dc: Extend debug stats with total number of events

 .../display/tegra/nvidia,tegra20-host1x.txt   |  68 +++++
 .../memory-controllers/nvidia,tegra20-emc.txt |   2 +
 .../memory-controllers/nvidia,tegra20-mc.txt  |   3 +
 .../nvidia,tegra30-emc.yaml                   |   6 +
 .../memory-controllers/nvidia,tegra30-mc.yaml |   5 +
 arch/arm/boot/dts/tegra20.dtsi                |  22 +-
 arch/arm/boot/dts/tegra30.dtsi                |  23 +-
 drivers/clk/clk.c                             |   1 +
 drivers/clk/tegra/clk-divider.c               |   4 +-
 drivers/clk/tegra/clk-tegra114.c              |   6 +-
 drivers/clk/tegra/clk-tegra124-emc.c          |  63 ++--
 drivers/clk/tegra/clk-tegra124.c              |   8 +-
 drivers/clk/tegra/clk-tegra20-emc.c           |   3 +
 drivers/clk/tegra/clk-tegra20.c               |   3 +-
 drivers/clk/tegra/clk-tegra30.c               |   3 +-
 drivers/clk/tegra/clk.h                       |  14 +-
 drivers/devfreq/Kconfig                       |   2 +-
 drivers/devfreq/tegra20-devfreq.c             |  52 ++--
 drivers/devfreq/tegra30-devfreq.c             | 115 +++++--
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/dc.c                    | 289 +++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h                    |  13 +
 drivers/gpu/drm/tegra/drm.c                   |  19 ++
 drivers/gpu/drm/tegra/plane.c                 |   1 +
 drivers/gpu/drm/tegra/plane.h                 |   4 +-
 drivers/interconnect/core.c                   |  11 +-
 drivers/memory/tegra/Kconfig                  |   9 +-
 drivers/memory/tegra/mc.c                     | 117 +++++++
 drivers/memory/tegra/mc.h                     |   8 +
 drivers/memory/tegra/tegra124-emc.c           |  36 ++-
 drivers/memory/tegra/tegra20-emc.c            | 215 +++++++++++--
 drivers/memory/tegra/tegra30-emc.c            | 156 ++++++++--
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   2 +
 include/dt-bindings/memory/tegra20-mc.h       |  53 ++++
 include/dt-bindings/memory/tegra30-mc.h       |  67 ++++
 include/linux/clk/tegra.h                     |  11 +
 include/soc/tegra/emc.h                       |  16 -
 include/soc/tegra/mc.h                        |   3 +
 38 files changed, 1235 insertions(+), 199 deletions(-)
 delete mode 100644 include/soc/tegra/emc.h

-- 
2.26.0

