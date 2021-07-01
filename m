Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1831B3B9977
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhGAXqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhGAXqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB263C061762;
        Thu,  1 Jul 2021 16:43:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k10so14778033lfv.13;
        Thu, 01 Jul 2021 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxmceOXlSx//Z7AXWshXZETJTGUmHRmXWRqvH0CzuXQ=;
        b=JvIypy2z9SDBnwZ4f3wpB2JNJWN+WoyyQ2FKe3wp1MlfN2Rr7TwZ8DBy6fec4zP2V8
         af8F0t5uAxkeK+vQoDqaq6fVwLgPKE0E6UL5IDEYvnaDu5EiVGYNsWdre8xPury6ACe5
         xCp+TA43FMxkFpK1kHtxYWMNBeZKk+eJVH26ERWzc7Xy6hF3qvWmtq+1nKTEKQCHQY3I
         9o9SyhNWQe31BcQ6lhluLWO4BYiYkr6fWf8UIoKcgr+kCaA9YUN9d7YOaUxz6SU4XSh1
         zID/5Bd6Lh5hhDYcQShw31k/zIYox+pVciSPGRYT8pyuXAjNnc+/HjYJnDsJjvIAmXvz
         VO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxmceOXlSx//Z7AXWshXZETJTGUmHRmXWRqvH0CzuXQ=;
        b=mb7ECcHnJC/IC24fp268h/X6X1gQHzVn1smlO6oveg550bHZWvbx6NcgxDcv+OSG85
         ex/E95qYTwm1/W7XfzHz3mvmCWs+mc/IY3I2TKvfjvTSdH9QGSx3Jk+tFhLO/53CBaFN
         StrJs1ucb/oAtA5OQdS9Aeq7aCOKT9iOegmFkG+iQ91UdqJRX7qUQhn3o6qSbg4mVN3I
         0SDKzAhVCkUoPr2njq1ozUCXYjyhLW0Ke0fYP/Rhf0Pt1rrDYtZygE3srW2U7ONRRkEN
         rZ0FmgrGA7OsQVOIfjBhOCCe9jxY2FWJSxRX1tBiGHGK5h/fSbfg0lE1i9oD3xfx875M
         oeYw==
X-Gm-Message-State: AOAM531fY03MlIodKuQq9GaiEJyOXyfnCh/EytgHmRj03uqDHFgjHCJP
        gANm2qRBGT+aVO5BS2vX59s=
X-Google-Smtp-Source: ABdhPJww81eLXSEUQEKQ4zGmxQndbDRbQvxhqYQpJSQB6vXHcAEwqkwiWSdaIqhn9IYO4qqkgQVz6Q==
X-Received: by 2002:a05:6512:30d:: with SMTP id t13mr1609874lfp.14.1625183030356;
        Thu, 01 Jul 2021 16:43:50 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:50 -0700 (PDT)
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
Subject: [PATCH v2 00/12] Add OTG mode support to Tegra USB PHY, SMB347 and Nexus 7
Date:   Fri,  2 Jul 2021 02:43:05 +0300
Message-Id: <20210701234317.26393-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series adds USB OTG mode support to the NVIDIA Tegra USB PHY driver,
SMB347 charger driver and Nexus 7 tablet.

Changelog:

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
2.30.2

