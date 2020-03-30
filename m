Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430CD1971F0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgC3BJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43310 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgC3BJh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id g27so16238725ljn.10;
        Sun, 29 Mar 2020 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Udu7OKRG+/CbZ2nQefBdE74UpfG/AooeTF97o8fdi2s=;
        b=D3O0fT0ZWBVmquYl71TWwdVjHQ7cP8VMkn59W72GwzYWFpkXgmLhldngem2Q7G5LpL
         cOQWy3LBZ5tp1YCHoFaVGwdZUwA6cgq0+kVLIHlT1zbhR729s+VwR9PSvzONITqzM2dK
         YnPKkVFHzDDns8BYeJwFpJFFTQyPXuFzJIfu6skP092aTHfMhRCmN0OHYozPmTtJUNG1
         Mcy2RuSsuWWHa3DB9jpG0h58EEz5/uBh4YViAEUGTl2B6ClktNH6YsPPyUWncMdLSPsa
         Mr5W/PUrO/Nk3ICrA7QxbyayrSYswOy1pjU9rKgORmN1V99uplJ07Jd+hUs3MdOTVb6+
         4rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Udu7OKRG+/CbZ2nQefBdE74UpfG/AooeTF97o8fdi2s=;
        b=cAahNmn1Y9tE1alMX22lceEIeJJjGB3C08rEvyjFCJxK1kXiDpU4xEQr67sp7t0xv3
         NMWfDh4V8mD505INg+QD+/+EPgVcLEoP+9MFp7d/p6vNpZ1Xa1bLlDOg90I5ZVbBbtgH
         G3WlG5eJR3sYjx4NiBhRHGTEzGzqSDR5KmMuFHmbnnwwnQLT5mz+ZY6MCQCpfoeCvnaf
         zzJUXX9Vwt0yY2csd/trHpQJLwsvHen48r7SHLp646cNQH+87iFawL6TaH6l0opcUPYF
         akw+QZsI426gCbxKZDsbK7s/vWE3VTxtB19wTcQ5+Fetf1wqhZjTKiTeLVIOkL1ARNiT
         p4LQ==
X-Gm-Message-State: AGi0PubWok03P8kUy14fkzkhtNas3IrTbYe1kn0c9JHYMYrnxYEbokKA
        Kxj9h3LWf7jbrYCf2S5lGlM=
X-Google-Smtp-Source: APiQypKO9tO+QHLLk4JgIJ/tZL0Ry6Gmfgs/koA0hVjTlWYp+VFlA7h+920qGDYBL3bwmOdrhVGlEA==
X-Received: by 2002:a2e:a173:: with SMTP id u19mr5855125ljl.67.1585530574240;
        Sun, 29 Mar 2020 18:09:34 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/22] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Mon, 30 Mar 2020 04:08:42 +0300
Message-Id: <20200330010904.27643-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series brings initial support for memory interconnect to Tegra20 and
Tegra30 SoCs. The interconnect provides are quite generic and should be
suitable for all Tegra SoCs, but currently support is added only for these
two generations of Tegra SoCs.

For the starter only display controllers are getting interconnect API
support, others could be supported later on. The display controllers
have the biggest demand for interconnect API right now because dynamic
memory frequency scaling can't be done safely without taking into account
bandwidth requirement from the displays.

(!) Please note that the EMC patches are made on top of the other EMC
    patches [1][2] that I was sending out recently.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=164165
[2] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=165451

Changelog:

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

Dmitry Osipenko (21):
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
  ARM: tegra: Enable interconnect API in tegra_defconfig
  ARM: multi_v7_defconfig: Enable interconnect API

 .../display/tegra/nvidia,tegra20-host1x.txt   |  68 +++++
 .../memory-controllers/nvidia,tegra20-emc.txt |   2 +
 .../memory-controllers/nvidia,tegra20-mc.txt  |   3 +
 .../nvidia,tegra30-emc.yaml                   |   6 +
 .../memory-controllers/nvidia,tegra30-mc.yaml |   5 +
 arch/arm/boot/dts/tegra20.dtsi                |  22 +-
 arch/arm/boot/dts/tegra30.dtsi                |  23 +-
 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 drivers/gpu/drm/tegra/dc.c                    | 289 +++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h                    |  13 +
 drivers/gpu/drm/tegra/drm.c                   |  19 ++
 drivers/gpu/drm/tegra/plane.c                 |   1 +
 drivers/gpu/drm/tegra/plane.h                 |   4 +-
 drivers/interconnect/core.c                   |  11 +-
 drivers/memory/tegra/mc.c                     | 118 +++++++
 drivers/memory/tegra/mc.h                     |   8 +
 drivers/memory/tegra/tegra20-emc.c            | 161 ++++++++--
 drivers/memory/tegra/tegra30-emc.c            | 144 ++++++++-
 include/dt-bindings/memory/tegra20-mc.h       |  53 ++++
 include/dt-bindings/memory/tegra30-mc.h       |  67 ++++
 include/soc/tegra/mc.h                        |   3 +
 22 files changed, 975 insertions(+), 47 deletions(-)

-- 
2.25.1

