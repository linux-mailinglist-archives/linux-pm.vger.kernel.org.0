Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818CA3CC53F
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhGQS0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhGQS0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E90C061762;
        Sat, 17 Jul 2021 11:23:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q16so21618202lfa.5;
        Sat, 17 Jul 2021 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zMTFJWQmt6hZmARV/A5cQtEbS0/t7Nz3rFuUbk7anw=;
        b=VmuUmdVg/1YLWZb06yjaCAOqc+lzjUFRzBkCgGTdSYu3CC++2DKKER4DMq+yc36xCs
         LqkWX0eAAsNTA3cnO7jaE/i0N80LtCNfmvWnkQcpg/1UZ09IBhfKec7EluFi9y75LAPG
         cFYd/zq9+egdcfFM80m9gRGZkp5nFy9SIfgO8ByaGvuQ6fX6OKgUwRzgJTg2f04A3duZ
         5uSWApHAr+MMiOpHPSAip274ILJ86a0obu8eQGami0GS7eXd/nZgDWL+w9FR+87ogtCC
         vfFLyuhIMC/0Maeq0a1N97MD4SHAgDtIlwEWA9DAeELI2WZLlhipq75tnx09i5kr9iXi
         YULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zMTFJWQmt6hZmARV/A5cQtEbS0/t7Nz3rFuUbk7anw=;
        b=sgCPKHzfhLxP3wM86a8AhYDEMyDXoLoB2RLAVq5Xn39w9Ez09HLCKKpCj7bFJk1rIh
         Ffg6p0NgQ6MwuZoCpGYahqYRN1U8931YPP+B7nStlbu1mecqOsBk9g5jLu2v5BmC6OkA
         vd589/YYG980ouVTEPzs466ufAjIrlv13AMjRPH7eSd7jrJhoxL4DsaHbPrTkRnyEqeT
         O4pmKOOPlsLkdNGBykf/cttSmoAB7itMRrfo4CRByi4+kw8Cz5Tl8GpJWqgBXWzMYGa5
         OTnWXg9MMgffqUzqjLI3VQAT/bdd6Uw1HFgVx8TRyNUGfjMYOkdyfUuMp3Aayn6z9stV
         6GZQ==
X-Gm-Message-State: AOAM531UWPi7qQeQaDUkXJRbjFMlKIdY42rDviNupG8qxo1vof+epjgz
        kWdAjv8Gphv9Oqa3MxVCKs0=
X-Google-Smtp-Source: ABdhPJw+BIkHlhGYIZoXSCNHjlEO7klFfgoIkSs9xOOhT6FkZBzoO9DKB9ZwFo6guCwgmqkARwa5RA==
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr12532479lfu.253.1626546181333;
        Sat, 17 Jul 2021 11:23:01 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:00 -0700 (PDT)
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
Subject: [PATCH v5 00/12] Add OTG mode support to Tegra USB PHY, SMB347 and Nexus 7
Date:   Sat, 17 Jul 2021 21:21:22 +0300
Message-Id: <20210717182134.30262-1-digetx@gmail.com>
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
  usb: otg-fsm: Fix hrtimer list corruption
  dt-bindings: power: supply: smb347-charger: Document USB VBUS
    regulator
  power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
  power: supply: smb347-charger: Utilize generic regmap caching
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
 drivers/power/supply/smb347-charger.c         | 260 +++++++++++-
 drivers/soc/tegra/pmc.c                       |   6 +-
 drivers/usb/common/usb-otg-fsm.c              |   6 +-
 drivers/usb/phy/phy-tegra-usb.c               | 197 ++++++++-
 .../dt-bindings/power/summit,smb347-charger.h |   4 +
 include/linux/usb/otg-fsm.h                   |   1 +
 include/linux/usb/tegra_usb_phy.h             |   5 +
 17 files changed, 906 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml

-- 
2.32.0

