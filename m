Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980B53CC2ED
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhGQMOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQMOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C69C06175F;
        Sat, 17 Jul 2021 05:11:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y42so20626813lfa.3;
        Sat, 17 Jul 2021 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZ6H/bMkW5ZZXipTugKwLWwFPWzG9SWqzlX3pr30jNs=;
        b=ixIqfAzzP51AY/xpuVV8H3ayYCSs9yUSgqLUnERJQJhooqfxyqllYJ2GPSUVqfSFVJ
         Bi81vkqZMRGMzyi+KTR8eBCFB3+UfnGRGKGxMXVYrZ1LVmXn8hJW/PohhJ2ELZuuj2wc
         Qe9XqTu6Xhpf4xTySl8ze6CZFih5lzbQuOYMUXpdYaky0gsCp1Sx2EYEUPtenFLnZoLF
         tEUrasHHJzjh+FjEpWWdXiTY6+WKNYqZOCSt9R1bhPbsyaHvKfFzV0WAyr072OOYaTod
         Cu+/8D/0MjvZV2byqYdSd6Vvk8HeFCZZtEDw5mQPxxk5TSUYh4vTPKUYhEzGLUSYwBex
         zVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZ6H/bMkW5ZZXipTugKwLWwFPWzG9SWqzlX3pr30jNs=;
        b=M2J5zhOSFYGO1Bp4UxQqhcJiIy6f2c5ENpazRNhDSR/UoR5Raq0gaStsxhG1UnpPSp
         hXzb88iIDoHOFwoR5AFGNoogrc4G6IdE+vZtK3E0uV1cniIN7NuFKUWp5B+qouBmB1Dl
         zMDf8rupwl2sX+fbOktLPk6tVK0FCRxODEw68dbQWsPhA6amiQYmKDyOUghxFHdfLwth
         tG0XT/4la2SDxTTzJSscqVwqA3kGfMLO2TdifAVRZvNR94jBy4iK/kdSTxNWAizJBRV8
         ngPWEScEkXw4xVNIXlRFSK2IotPHkencCDySQ9aByDf1Sg/HRbzPkIrF+oBH5BMGui63
         qLPA==
X-Gm-Message-State: AOAM5339LFGqyN0fXf2DMl8VoPnieOmDMokq3EGAfqscIpecTbEnB8Fd
        M7tbdngif9yfO5WUdjI5WaU=
X-Google-Smtp-Source: ABdhPJx8FecyXLrfLXAqZMw3gWqjyQ1KqOLzEXIhSOOBc06ieQX6VAdG6qoszx4V1XRSklegfiB4Mw==
X-Received: by 2002:a19:6a09:: with SMTP id u9mr11442485lfu.119.1626523885363;
        Sat, 17 Jul 2021 05:11:25 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:24 -0700 (PDT)
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
Subject: [PATCH v4 00/12] Add OTG mode support to Tegra USB PHY, SMB347 and Nexus 7
Date:   Sat, 17 Jul 2021 15:11:00 +0300
Message-Id: <20210717121112.3248-1-digetx@gmail.com>
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

v4: - Added r-b from Rob Herring.

    - Added unevaluatedProperties into SMB binding for VBUS regulator,
      which was Requested by Rob Herring.

    - Added cell to nvidia,pmc phandle instead of explicit h/w ID
      property. Requested by Rob Herring.

    - Added stack trace to commit message and ack from Peter Chen to
      OTG FSM patch.

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
  ARM: tegra: Add new properties to USB PHY device-tree nodes
  ARM: tegra: nexus7: Enable USB OTG mode
  arm64: tegra132: Add new properties to USB PHY device-tree node

 .../bindings/phy/nvidia,tegra20-usb-phy.txt   |  74 ----
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml  | 373 ++++++++++++++++++
 .../power/supply/summit,smb347-charger.yaml   |  30 ++
 arch/arm/boot/dts/tegra114.dtsi               |   4 +
 arch/arm/boot/dts/tegra124.dtsi               |   6 +
 arch/arm/boot/dts/tegra20.dtsi                |   6 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   |  25 +-
 arch/arm/boot/dts/tegra30.dtsi                |   6 +
 arch/arm64/boot/dts/nvidia/tegra132.dtsi      |   6 +
 drivers/power/supply/Kconfig                  |   1 +
 drivers/power/supply/smb347-charger.c         | 259 +++++++++++-
 drivers/soc/tegra/pmc.c                       |   6 +-
 drivers/usb/common/usb-otg-fsm.c              |   6 +-
 drivers/usb/phy/phy-tegra-usb.c               | 197 ++++++++-
 .../dt-bindings/power/summit,smb347-charger.h |   4 +
 include/linux/usb/otg-fsm.h                   |   1 +
 include/linux/usb/tegra_usb_phy.h             |   5 +
 17 files changed, 905 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml

-- 
2.32.0

