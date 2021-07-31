Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC93DC73D
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGaRjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhGaRjF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D91C06175F;
        Sat, 31 Jul 2021 10:38:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h14so24912939lfv.7;
        Sat, 31 Jul 2021 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS9BOsTn1J0RZPkuT9yL2yhtJS7pbjI+aQLQvn2jnHk=;
        b=LVgadFAH8rrcCg5jc7fMaHRMdJiftQfZffdcJ0WMWQogM9HuLeJzVUnsfF3KjRTqa7
         kl9DMNMN4G/Hw/pInUS2LRcqJevpp2JVgJuAFCSByVeBMTJN/dOW/rcvAqaQULUTkOkr
         6C1PS+XF1g755gr/ut/qasbh02Xb2PFyNny+uPETBIk3QMopfMexISGOAOgQt/7W+P9i
         /ylDiaCxOEu9D46GWUDDKRnZCitIfQmS5k3lYi5X5aJv6jkdJ3NthJgZnSvAppU28hlR
         7NOusLki6fZK86Y1uEHGMHPPEI5qBMeIwq1ECbTF0QDD05iEpyrqn7+LR+6Arm80LBoo
         c7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS9BOsTn1J0RZPkuT9yL2yhtJS7pbjI+aQLQvn2jnHk=;
        b=XI/JVgK4sJp23XZj2OQdfnMBwadLXRaiujwkfqemT9WDZcqNjSVxIwjVswlxi/IjSa
         r8OwQ8QRdCTasBbNKtaO4ptOpVrVh4e76vRRoD1CCE3bO4sUG9P9pA6lGbHZwquqdsY/
         cdhtsT2QFIMbzYzgkogUPOeHdIpE5bz+wqhJWxIVznrtRAW7TYAjCgwuWxiC+n18hgmO
         qOHujt85FFYN8vboEruqQ9bhsQb+kTPfpIVSrP6zr9T8yWmkt5omKuZEy03cWcb3h0HT
         BwVwfxKLwbOwaE0kmoBTXSrVnzs1Qq3nD8RhYvcqzSJwULanyfeFpCDA130DwXKt41p/
         q/cw==
X-Gm-Message-State: AOAM530KGfFLpX758p6jf3a36f4lV7CA3UPWCs9jfEq6JpklES7RIZvE
        Bw2anD9NCjV0JkMUOY7Jwd8=
X-Google-Smtp-Source: ABdhPJzQG/TUmm91jxQlHLD70oJmLeD3AMW+ESZcfJ0s7zOmp66gMDJZcCvHGFFdT+9A1z7uuRrP0g==
X-Received: by 2002:ac2:560e:: with SMTP id v14mr6308909lfd.158.1627753137526;
        Sat, 31 Jul 2021 10:38:57 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:38:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 00/12] Add OTG mode support to Tegra USB PHY, SMB347 and Nexus 7
Date:   Sat, 31 Jul 2021 20:38:30 +0300
Message-Id: <20210731173842.19643-1-digetx@gmail.com>
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

v6: - Added r-b from Rob Herring to the OTG properties DT binding patch.

    - Corrected "smb347-charger: generic regmap caching" patch, it now
      sets the .num_reg_defaults_raw, initializing cache properly.

    - Added new patch "smb347-charger: Add missing pin control activation",
      which prevents never-enabled charging on Nexus 7.

    - The "otg-fsm: Fix hrtimer list corruption" patch of v5 was already
      applied to next, so it's not included anymore.

v5: - Replaced "Remove caching of charger state" patch with "Utilize
      generic regmap caching" after Sebastian's notice about disabled
      regmap caching.

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
  dt-bindings: power: supply: smb347-charger: Document USB VBUS
    regulator
  power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
  power: supply: smb347-charger: Utilize generic regmap caching
  power: supply: smb347-charger: Add missing pin control activation
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
 drivers/power/supply/smb347-charger.c         | 271 ++++++++++++-
 drivers/soc/tegra/pmc.c                       |   6 +-
 drivers/usb/phy/phy-tegra-usb.c               | 197 ++++++++-
 .../dt-bindings/power/summit,smb347-charger.h |   4 +
 include/linux/usb/tegra_usb_phy.h             |   5 +
 15 files changed, 911 insertions(+), 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml

-- 
2.32.0

