Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30543100CF6
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKRUFc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:32 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:46022 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKRUFc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:32 -0500
Received: by mail-lj1-f170.google.com with SMTP id n21so20392550ljg.12;
        Mon, 18 Nov 2019 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lYduyo7vPgxp45RLwsY0ZnQLiYVsuFTry8aLXbx4kM=;
        b=APzSWzS1AWv0t0oARIksAL9UGz8A49gKk4636qenUrw+Td8W04Iz2y8qkPl3AHCr6m
         l/Y7ReHNWM+fX2S6YoWckzLWIag7992BEYqUq4Gn7ppw4+46i/FfNOopAHsAijIGhjKR
         tD7SA9PLTVi2s4wgrPZldc+6eFwRb93c5lbw3Ix93bgb7lhuXJ0PlExD9gV/yxANzVju
         ztDiniGHZn5D2BJ4iYP8hDynklw+eD4ahvr9rBJ6wzY3kA2s+pBf2hpwaxyTKPUB/KNS
         oCMyalrSMkpWiyay05T2MnJa3wwN2B5WySinWwolMDf4wTAKiDFgGzlR2428ByxDD+/O
         jcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lYduyo7vPgxp45RLwsY0ZnQLiYVsuFTry8aLXbx4kM=;
        b=AMrUuEqRyNQAn3dbqdRGGtTItKb5Fqwy8rXr3WzjZenWV+UtT10zk+EnoQkLWpjxBW
         qUGdlehbMOQYlf1cITyuSyeOjDbZt0W26wxL5tjvnHfkl5VyTsQmRQj6JsmEJ00GFDHk
         wpbo9+lDmAOlKtVBa77VW9e+iKzxr1RSCtnv7SGjfxQy93HGeFzTowEHaDlgDlgAo2or
         uSmCKuMPkLnhAjPjaAqPLQ1AE+uGSRg6grlGSAqDVYTO1xOp+mXfGojAFjdI3/SdDhY/
         uoA1F7RKuq7rirncpEBEBzDHSjWzp8uKaih9+Y81U/cAL6oUzILxSilKxhypXJEljdjC
         BcJA==
X-Gm-Message-State: APjAAAWPyEXjNhCZbod6A2BIvO7BmfM+DT0+MYhBcSc9JjBVzIr01DRJ
        v7ngAjC3ipwZPWfQOhAxjck=
X-Google-Smtp-Source: APXvYqxptZWcgvS7sdySo1sH5FxDJRVUucG9P8wDoJrg5exzZstUPyRLwr6nfSCBfGL7tbiFLrJUzA==
X-Received: by 2002:a2e:574d:: with SMTP id r13mr934150ljd.10.1574107529313;
        Mon, 18 Nov 2019 12:05:29 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 00/29] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Mon, 18 Nov 2019 23:02:18 +0300
Message-Id: <20191118200247.3567-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series brings initial support for memory interconnect to Tegra20,
Terga30 and Tegra124 SoCs. The interconnect provides are quite generic
and should be suitable for all Tegra SoCs, but currently upstream kernel
has EMC/MC drivers only for those three generations of Tegra SoCs.

For the start only display controllers are getting interconnect API
support, others could be supported later on. The display controllers
have the biggest demand for interconnect API right now because dynamic
memory frequency scaling can't be done safely without taking into account
bandwidth requirement from the displays.

Dmitry Osipenko (29):
  dt-bindings: memory: tegra20: mc: Document new interconnect property
  dt-bindings: memory: tegra20: emc: Document new interconnect property
  dt-bindings: memory: tegra30: mc: Document new interconnect property
  dt-bindings: memory: tegra30: emc: Document new interconnect property
  dt-bindings: memory: tegra124: mc: Document new interconnect property
  dt-bindings: memory: tegra124: emc: Document new interconnect property
  dt-bindings: host1x: Document new interconnect properties
  dt-bindings: interconnect: tegra: Add initial IDs
  ARM: tegra: Add interconnect properties to Tegra20 device-tree
  ARM: tegra: Add interconnect properties to Tegra30 device-tree
  ARM: tegra: Add interconnect properties to Tegra124 device-tree
  interconnect: Add memory interconnection providers for NVIDIA Tegra
    SoCs
  memory: tegra: Register as interconnect provider
  memory: tegra: Add interconnect nodes for Terga20 display controllers
  memory: tegra: Add interconnect nodes for Terga30 display controllers
  memory: tegra: Add interconnect nodes for Terga124 display controllers
  memory: tegra20-emc: Use devm_platform_ioremap_resource
  memory: tegra20-emc: Continue probing if timings/IRQ are missing in
    device-tree
  memory: tegra20-emc: Register as interconnect provider
  memory: tegra30-emc: Continue probing if timings are missing in
    device-tree
  memory: tegra30-emc: Register as interconnect provider
  memory: tegra124-emc: Use devm_platform_ioremap_resource
  memory: tegra124-emc: Register as interconnect provider
  drm/tegra: dc: Use devm_platform_ioremap_resource
  drm/tegra: dc: Release PM and RGB output when client's registration
    fails
  drm/tegra: dc: Support memory bandwidth management
  ARM: tegra: Enable interconnect API in tegra_defconfig
  ARM: multi_v7_defconfig: Enable NVIDIA Tegra interconnect providers
  MAINTAINERS: Add maintainers for NVIDIA Tegra interconnect drivers

 .../display/tegra/nvidia,tegra20-host1x.txt   |  67 +++++
 .../nvidia,tegra124-emc.txt                   |   3 +
 .../nvidia,tegra124-mc.yaml                   |   5 +
 .../memory-controllers/nvidia,tegra20-emc.txt |   4 +
 .../memory-controllers/nvidia,tegra20-mc.txt  |   4 +
 .../nvidia,tegra30-emc.yaml                   |   6 +
 .../memory-controllers/nvidia,tegra30-mc.yaml |   5 +
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/tegra124.dtsi               |  10 +
 arch/arm/boot/dts/tegra20.dtsi                |  11 +-
 arch/arm/boot/dts/tegra30.dtsi                |  12 +-
 arch/arm/configs/multi_v7_defconfig           |   2 +
 arch/arm/configs/tegra_defconfig              |   2 +
 drivers/gpu/drm/tegra/dc.c                    | 252 +++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h                    |   8 +
 drivers/gpu/drm/tegra/drm.c                   |  18 ++
 drivers/gpu/drm/tegra/plane.c                 |   1 +
 drivers/gpu/drm/tegra/plane.h                 |   4 +-
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/tegra/Kconfig            |   6 +
 drivers/interconnect/tegra/Makefile           |   4 +
 drivers/interconnect/tegra/tegra-icc-emc.c    | 138 ++++++++++
 drivers/interconnect/tegra/tegra-icc-mc.c     | 130 +++++++++
 drivers/memory/tegra/mc.c                     |   4 +
 drivers/memory/tegra/tegra124-emc.c           |  28 +-
 drivers/memory/tegra/tegra124.c               |  16 ++
 drivers/memory/tegra/tegra20-emc.c            |  91 ++++---
 drivers/memory/tegra/tegra20.c                |  14 +
 drivers/memory/tegra/tegra30-emc.c            |  34 ++-
 drivers/memory/tegra/tegra30.c                |  14 +
 include/dt-bindings/interconnect/tegra-icc.h  |  11 +
 include/soc/tegra/mc.h                        |  26 ++
 33 files changed, 883 insertions(+), 58 deletions(-)
 create mode 100644 drivers/interconnect/tegra/Kconfig
 create mode 100644 drivers/interconnect/tegra/Makefile
 create mode 100644 drivers/interconnect/tegra/tegra-icc-emc.c
 create mode 100644 drivers/interconnect/tegra/tegra-icc-mc.c
 create mode 100644 include/dt-bindings/interconnect/tegra-icc.h

-- 
2.23.0

