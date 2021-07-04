Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2063BAF6F
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGDW6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhGDW6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBCDC061574;
        Sun,  4 Jul 2021 15:56:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu19so29035948lfb.9;
        Sun, 04 Jul 2021 15:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwDoLURDHKozXTahEpur8mu1fJsMk0Ebl7SqcPMfBPw=;
        b=C/hYSUpFQgC9QKbD1nlcmsQpG1PDQOsT45ZLXQKcIMh7y0iGOolSnubsJ97nuZ/o6f
         8k2j6+wQ1Ao2OpA59+C6ASr8CLUGDidpgj2eItjQPhaOG+7EKVx1cWI/0CTFKr5BfNCP
         Yge5Cq1uzvA81CMTC4Syz5ZzcCy6CSU74fpvjCo700+KBAHNMYBkzD9lKwVB9GwVvUn7
         61eKVv3sWwTE63E7qPMGhHl3ROGv3W/T8FC1NYqMpflZOqvRgoLgLwfrsmahuLegLU8K
         yWkOnfOk2OYQomfyNXcVKhtY/9FerWa4b4qLW5VoFQv4ONx3ww+YwDL8UodI4YOcslNT
         Pwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwDoLURDHKozXTahEpur8mu1fJsMk0Ebl7SqcPMfBPw=;
        b=OHizu0G0V2swkoevRUwHU8bn3/70PpZQbf/J2ux2LWcwUrD0pBgeE4BrQn7lfPn29c
         nVW22HC9HiD7t8lXiiIfOHSmHAQ5dE71h6C6bpP/Dp1depjb6KRwOexmpLcR5UGUCgWa
         AZ8ArZkH+LSha8pGriRtzijqZihLlLVM9IFukaVXVBR03ftSufbpTVzMQhBwjYUGhkmW
         jrjNGARGhxyUINZnGsJ3FW3lxfB1n9L3sM5JHHHsBQO8T4sYyJGsyNb7otRq/91ySFCb
         HtIwRXFdZVg+lxryFnE9ihpUkZ0dpBotpDlTk4jghurI4MiZ4wAvdJbirun1+9JSXH94
         hWtQ==
X-Gm-Message-State: AOAM532dLo4aEWsLuUB/RSLFbbRhJuLtxiG3XfoNEcE+1+FtC75YW3gQ
        Cb9NWNX+BIA1MMPtKGc/8Fc=
X-Google-Smtp-Source: ABdhPJyLSMj3Nn4vxMNiqosM/wWNvkeVTKUemnKgBQKHedyCJUfF2Y9d1Zqvgl8F+PABW24RuD8zNA==
X-Received: by 2002:a05:6512:3618:: with SMTP id f24mr1084494lfs.517.1625439359975;
        Sun, 04 Jul 2021 15:55:59 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 00/12] Add OTG mode support to Tegra USB PHY, SMB347 and Nexus 7
Date:   Mon,  5 Jul 2021 01:54:21 +0300
Message-Id: <20210704225433.32029-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series adds USB OTG mode support to the NVIDIA Tegra USB PHY driver,
SMB347 charger driver and Nexus 7 tablet.

Changelog:

v3: - Further improved interrupt handling in the PHY driver by removing
      assumption that interrupt is enabled by the CI driver at the time
      of set_wakeup() invocation, which makes this function a bit more
      universal.

v2: - The PHY's interrupt is now enabled from PHY's set_wakeup() callback.
      It prevents getting a spurious interrupt during the CI driver probe
      time.

Dmitry Osipenko (12):
  dt-bindings: phy: tegra20-usb-phy: Convert to schema
  dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG
    mode
  soc/tegra: pmc: Expose USB regmap to all SoCs
  usb: phy: tegra: Support OTG mode programming
  usb: otg-fsm: Fix hrtimer list corruption
  dt-bindings: power: supply: smb347-charger: Document USB VBUS
    regulator
  power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
  power: supply: smb347-charger: Remove caching of charger state
  power: supply: smb347-charger: Implement USB VBUS regulator
  arm64: tegra132: Add new properties to USB PHY device-tree node
  ARM: tegra: Add new properties to USB PHY device-tree nodes
  ARM: tegra: nexus7: Enable USB OTG mode

 .../bindings/phy/nvidia,tegra20-usb-phy.txt   |  74 ----
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml  | 377 ++++++++++++++++++
 .../power/supply/summit,smb347-charger.yaml   |  28 ++
 arch/arm/boot/dts/tegra114.dtsi               |   6 +
 arch/arm/boot/dts/tegra124.dtsi               |   9 +
 arch/arm/boot/dts/tegra20.dtsi                |   9 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   |  25 +-
 arch/arm/boot/dts/tegra30.dtsi                |   9 +
 arch/arm64/boot/dts/nvidia/tegra132.dtsi      |   9 +
 drivers/power/supply/Kconfig                  |   1 +
 drivers/power/supply/smb347-charger.c         | 259 +++++++++++-
 drivers/soc/tegra/pmc.c                       |   6 +-
 drivers/usb/common/usb-otg-fsm.c              |   6 +-
 drivers/usb/phy/phy-tegra-usb.c               | 202 +++++++++-
 .../dt-bindings/power/summit,smb347-charger.h |   4 +
 include/linux/usb/otg-fsm.h                   |   1 +
 include/linux/usb/tegra_usb_phy.h             |   5 +
 17 files changed, 926 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml

-- 
2.32.0

