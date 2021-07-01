Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B823B8C18
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhGAC1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhGAC1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825EC061756;
        Wed, 30 Jun 2021 19:24:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w11so6256876ljh.0;
        Wed, 30 Jun 2021 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrqU3stqnWdI8RnhBwfKj963UQrIAO5dfsy80N5VUiE=;
        b=BdfByYTN95GBLkgXSqMYY+PNPUl5sLnc2mb9hsTqZbtO3N3zWCG0VA4CX/jkTg6Igd
         lIq5S8L0NBCHzrTqFs3kOrZuf/0eVjXjaaUqKVyhkZUvjVP7BihD+B8TkThjmBBsKbLb
         /x/2i7gk4YhkPrEc92SE7e3HWxLhKpBBnBUKqVE+80aPXPHo1rcaUiDcBD3afSm4eX5w
         x4pZ29UxQzCxMEgihQi+J3PMX7GPjNuzyenyB/K0AlTCIH1okDVn6HfIDK28bsE9oMfY
         LAcun0VUI6Yh23I3SA1xuFBcD0AzH67bwp/zAhiIACOppAqJ6yF5xoMNrJ/sPZBUkj4o
         ckNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrqU3stqnWdI8RnhBwfKj963UQrIAO5dfsy80N5VUiE=;
        b=lwDSZSWqsIBhikNdeCn6Nqy4uuwPFFU8KhRDSpSAGOZpbZgrfLW7yyy4QOWNV+Mq++
         AudNg4sQmpSEFyL2rOKY3h99ccQCT+hnLCK33uROcx2UrpTl+irXigVrWFaziwd7hMyu
         cj2ojXYZgMbKgrQMP3CgsDPgiB+yPDer9XLQzuJ5ctvpfn5fH2UEkn0ykDZVqhOje7+T
         EQADO/Cm0OLkNfD9LX/OYOBD3sqQk5T15GoX2FgebRDvXh2S1Y8OX1QlLG2hc3KA9iWv
         R1BXV9FWmr/+WJ5PsjNj9zZat0GM/m3/I3Fyk5CoWXcf93dhK2+5ZnXkuMBUlH2k8Omz
         ynUw==
X-Gm-Message-State: AOAM530PowCfPfrwyMvwMI/xp+EEkhetjVkKmhhrDPdJZfHnDgPil8RW
        Qust9JoBa5R+BcRXD+cQBno=
X-Google-Smtp-Source: ABdhPJzyQYyTHTjeGySupd8Mxc9DWBkUZVa0CrmFxqNvvYXI5Pn+LXIHs10UGZPb7WZjjtuoVEGnEA==
X-Received: by 2002:a2e:7801:: with SMTP id t1mr10090979ljc.330.1625106284458;
        Wed, 30 Jun 2021 19:24:44 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:43 -0700 (PDT)
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
Subject: [PATCH v1 00/12] Add OTG mode support to Tegra USB PHY, SMB347 and Nexus 7
Date:   Thu,  1 Jul 2021 05:23:53 +0300
Message-Id: <20210701022405.10817-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series adds USB OTG mode support to the NVIDIA Tegra USB PHY driver,
SMB347 charger driver and Nexus 7 tablet.

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
 drivers/usb/phy/phy-tegra-usb.c               | 166 +++++++-
 .../dt-bindings/power/summit,smb347-charger.h |   4 +
 include/linux/usb/otg-fsm.h                   |   1 +
 include/linux/usb/tegra_usb_phy.h             |   5 +
 17 files changed, 891 insertions(+), 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml

-- 
2.30.2

