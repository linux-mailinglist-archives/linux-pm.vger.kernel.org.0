Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30B52441DE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHNAHD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHNAHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B5C061757;
        Thu, 13 Aug 2020 17:07:02 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v15so3938299lfg.6;
        Thu, 13 Aug 2020 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oci6ZvenIfCUV+1S+AkheVmNIZMQwAhafWey7aektgA=;
        b=iQhlHeLx1aWG1gtpBGYysHbZ/PV+4j4N9vGWyKy1fHBWqCCRWPmkuNhY2pQkvr8A9D
         xFUJXHDnOYKh8xLPZPnzFxuaZkDDtGjU1N1uH0tOrnOvN6XOJkK4rAxBio7A8l5brgiz
         kxBdICFa7K+JymQqhz3MBg78T2b2l0RBvXJHxMNm9uvbQfVR44gZ4DAY5gTG9Cl2VHDp
         S5qmqYTQNorGYUrKuWofCIJ686oX1Kc1/MNidAYi4vJsJKA++Elu2B1T9wcIcr6eYdSs
         6IBrKWke153uOo+xScLoNOQlADaHrhYyOGK+ECSTqDdGNyd0Nq3gLNgRY+B+Y2gKmnun
         qEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oci6ZvenIfCUV+1S+AkheVmNIZMQwAhafWey7aektgA=;
        b=B7Osmu0nZr0Y1X80OvKEZQnBdvgCuDVHNiAOO3O0+Z6QkEsVyzGD8fVwdLMs4MjnJW
         gPV+1Nfqegnthsuc/pGLIyqgO7KVxymDS8akUAlLqsDJzwLqlIIMktDT4sI5mT43gyc5
         gOOC1HIjTkIk42UVA0kgjXN67vm4y9cQacDGfGvUrh+Z6Wm/ocXSNU0MQY37jy0zC+Pq
         u44uA9rfuV41BgsUFhyExYwCne86VvFzxc3kdbnG+yHKX+WgyKRI6yIE3WUKmNtuAyIe
         u1/julA4PLMBmVdAmDeMDrTx9Ai1NAe42oNEu4A5hpn/blmU5xbZ3hoGTUMLeVOIpITk
         UC7g==
X-Gm-Message-State: AOAM530kCVyuo1Jxl9ovKRQsyevG8q220XX2LU+DRdacQOSLV0iT5OeZ
        mkEVN+C5fMBXtHEJtQqCx0c=
X-Google-Smtp-Source: ABdhPJzNloVP09snvdQkyGDrXZJUMn+kRHX128D7Jb4C6GCWlixokjAg1tr/qpTj97IEsubFf26TCw==
X-Received: by 2002:a19:7ec3:: with SMTP id z186mr3302520lfc.3.1597363620834;
        Thu, 13 Aug 2020 17:07:00 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:00 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 00/36] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Fri, 14 Aug 2020 03:05:45 +0300
Message-Id: <20200814000621.8415-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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

v5: - The devfreq drivers now won't probe if memory timings aren't specified
      in a device-tree, like was suggested by Chanwoo Choi in a review comment
      to v4. Initially I wanted to always probe the driver even with a single
      fixed memory freq, but after a closer look turned out it can't be done
      easily for Tegra20 driver.

    - The "interconnect: Relax requirement in of_icc_get_from_provider()"
      patch was already applied, hence one less patch in comparison to v4.

    - Renamed display interconnect paths in accordance to the names that
      were used by Thierry Reding in one of his recent patches that supposed
      to update the Host1x's DT binding.

    - Added acks from Chanwoo Choi.

    - Added clarifying comment to tegra_mc_icc_set() about why it's a dummy
      function, this is done in a response to the review comment made by
      Georgi Djakov to v4.

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
  memory: tegra-mc: Register as interconnect provider
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
 drivers/devfreq/tegra20-devfreq.c             |  50 +--
 drivers/devfreq/tegra30-devfreq.c             | 110 +++++--
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/dc.c                    | 289 +++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h                    |  13 +
 drivers/gpu/drm/tegra/drm.c                   |  19 ++
 drivers/gpu/drm/tegra/plane.c                 |   1 +
 drivers/gpu/drm/tegra/plane.h                 |   4 +-
 drivers/memory/tegra/Kconfig                  |   9 +-
 drivers/memory/tegra/mc.c                     | 121 ++++++++
 drivers/memory/tegra/mc.h                     |   8 +
 drivers/memory/tegra/tegra124-emc.c           |  36 ++-
 drivers/memory/tegra/tegra20-emc.c            | 222 ++++++++++++--
 drivers/memory/tegra/tegra30-emc.c            | 156 ++++++++--
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   2 +
 include/dt-bindings/memory/tegra20-mc.h       |  53 ++++
 include/dt-bindings/memory/tegra30-mc.h       |  67 ++++
 include/linux/clk/tegra.h                     |  11 +
 include/soc/tegra/emc.h                       |  16 -
 include/soc/tegra/mc.h                        |   3 +
 37 files changed, 1228 insertions(+), 199 deletions(-)
 delete mode 100644 include/soc/tegra/emc.h

-- 
2.27.0

