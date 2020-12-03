Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01AA2CDECF
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 20:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgLCTZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 14:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731274AbgLCTZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 14:25:40 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF4C061A4F;
        Thu,  3 Dec 2020 11:24:54 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y7so3803236lji.8;
        Thu, 03 Dec 2020 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vdqoVk7jZ2jxWA9BC/vseouYc6KoArds7fmTvWx1ic=;
        b=RMYisD79xUNJyOuYEIpNL+qBI6QzRZS7dnU5G7l/ngi5uAuA7KDp8yYjPTsMAsnjHV
         byuQdmvjH5mevMbisQSAfoDF/3FHJyQBSiSTaUQtirVIM58NV1AuhDozTtKvCqqMo5wo
         RrcgRA/3fVXNoMv6hLdjWWhrDUq9sZZQ/4xF5d8e82K7aYQxVZXvo28PffZIosP9OOF2
         YVJTHxEBDLcMK1ltKHy05N1KgeNytMxmY7+RUylPTR6tyNvKufZQNVwEVY5FVnuz7qKK
         016RxKKwnVblujB7AKFUPuODy+5p4p78eAUmVm6XvuUm28D1gJO9aD919cQXYwY08tVw
         qnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vdqoVk7jZ2jxWA9BC/vseouYc6KoArds7fmTvWx1ic=;
        b=VtxvUr6kjW8kq9+/OIsSRcMdSLGzXDX/jg8nQqG3Nkm+mvj/vJAAM3Hr/L5fAXkDv9
         zGCnlzo62ekzqkPgHWF8l6GHPcUMDdaQMkHtwtH8rgXr4pqg8zfforEaHtr+OQ8Hc1w3
         R/Dx0+WHidYTAtdLuogJP8ta/iNFFVZhtvFQVzXfOF1GAvRCIUWmiwCAaCMLG7pbR3tc
         fyBqK3e5jiUDJDFJTSa2f5a7KiBnAy4k9cJGeTvSsdEuX3R2GgXF36cKIbL1SrTVV0Dn
         UhpT4uFo7frZtEOtC8QLd9QdfSorc7PeDTpyzB0vD49+WHEKsZLU35dsWtaM4lLZDevZ
         pYxQ==
X-Gm-Message-State: AOAM5326ZFACVkvWh+x3Cg5C5hYkeHEDebuqR1TnyIYKimxagTOYmFNW
        8QWpEUXB8Os0bla7ENip8vs=
X-Google-Smtp-Source: ABdhPJxw4Qgyc1vVgaMWRobIch5SX5jjIzX5fai8cPaaY+T91gaDkGMOwxpj2FF6xBiUDJXWx0Q62g==
X-Received: by 2002:a2e:a547:: with SMTP id e7mr1746599ljn.108.1607023491036;
        Thu, 03 Dec 2020 11:24:51 -0800 (PST)
Received: from localhost.localdomain (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.gmail.com with ESMTPSA id z7sm861932lfq.50.2020.12.03.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:24:50 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v11 00/10] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Thu,  3 Dec 2020 22:24:29 +0300
Message-Id: <20201203192439.16177-1-digetx@gmail.com>
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

v11: - Added acks from Georgi Djakov.

     - CC'ed devicetree@vger.kernel.org in order to make the dt-bindings
       patch ("Document opp-supported-hw property") visible to the DT
       maintainers.

     - Rebased on a recent linux-next, note that some of v10 DT patches
       were already applied by Thierry into tegra tree, as well as one
       devfreq patch which removed the older tegra20-devfreq driver was
       applied by Chanwoo Choi to the devfreq tree.

     - Note that patch "memory: tegra20: Support hardware versioning and
       clean up OPP table initialization" fixes the noisy (but harmless)
       warning which happens because DT patches were applied before the
       code changes. This problem was spotted in current linux-next by
       Jonathan Hunter, hence could be worthwhile to pick up this patch
       for the v5.11.

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

Dmitry Osipenko (10):
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

 .../memory-controllers/nvidia,tegra20-emc.txt |   6 +
 drivers/clk/tegra/Kconfig                     |   3 +
 drivers/clk/tegra/Makefile                    |   2 +-
 drivers/clk/tegra/clk-tegra124-emc.c          |  41 +-
 drivers/clk/tegra/clk-tegra124.c              |  26 +-
 drivers/clk/tegra/clk.h                       |  18 +-
 drivers/devfreq/tegra30-devfreq.c             | 147 ++++---
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/dc.c                    | 359 +++++++++++++++++
 drivers/gpu/drm/tegra/dc.h                    |  19 +
 drivers/gpu/drm/tegra/drm.c                   |  14 +
 drivers/gpu/drm/tegra/hub.c                   |   3 +
 drivers/gpu/drm/tegra/plane.c                 | 121 ++++++
 drivers/gpu/drm/tegra/plane.h                 |  15 +
 drivers/memory/tegra/Kconfig                  |   5 +-
 drivers/memory/tegra/tegra124-emc.c           | 377 ++++++++++++++++--
 drivers/memory/tegra/tegra124.c               |  82 +++-
 drivers/memory/tegra/tegra20-emc.c            |  48 +--
 drivers/memory/tegra/tegra30-emc.c            | 344 +++++++++++++++-
 drivers/memory/tegra/tegra30.c                | 173 +++++++-
 include/linux/clk/tegra.h                     |   8 +
 include/soc/tegra/emc.h                       |  16 -
 22 files changed, 1651 insertions(+), 177 deletions(-)
 delete mode 100644 include/soc/tegra/emc.h

-- 
2.29.2

