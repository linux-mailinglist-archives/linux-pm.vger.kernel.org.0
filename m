Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD31F152D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgFHJRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 05:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgFHJRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 05:17:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7CC08C5C4
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 02:17:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so13812795wmn.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Fm1rwtOISvK8gr+7LuMXZ/qPS5BDlq5HB6zyGZJxGw=;
        b=WFLvXLljBM6V1NmppMID2bA5jT2HXO415vnRZxi3guuwvHkqqI1fio60qbVJenv9y1
         SeVA1WczH4p6ZAdZQXh1Kqfl6k2eD44MmBJsiy/QQHs0A6Oet4X/ux6mzTZvhMhESIHd
         mnXyfKz/WS3zE53m3JdhAiDzmwQrkJ9EMMSFSABw3h5/YlY6Bj/Q+cy0PCmrg1FOr0iu
         5FXCkwzBx2wl86k2NvvfFCDG11F5jgjsI8YcmrOibVTw9lP+EOu0WZxM3ufQU83nZ2HR
         eVRdH02+tYD4NTVAp1jMy2RniJaBZOI4NYzfYIsReSQWsrxnK68oAw9MB/H7C1aWGQnI
         5wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Fm1rwtOISvK8gr+7LuMXZ/qPS5BDlq5HB6zyGZJxGw=;
        b=dVrZ8VX6VNEhhnQve7Fyr4ATKUkjKWV2qlGNgyh9AZ5oyfAQLA6zZ4iN3JM69JI/nh
         rGURV8BRs0iJHuvBWKdqfiMNKJB3x1aF9KbzQ3OigqHR/JfzrysC6J+MST3Gob5y/zMW
         HsppPPAwXP0B2zWMFoFcVKXzx2PbvHOdRqiPgbm1zk6u5O3JcDBcqoK2Zlx752DifTTu
         mTWd7m7ESGn/h1ZjfJiqAtD1SWWH27K2O2UgkBa189zGdJ8WteUuMny0+itr2gsakiol
         BHUdCSI0Tour2ZNvXpZSPInwe+uLODyF4KdGKU/eYGguUdA7bJmDWfyYDs0dW7y43YSp
         Jkig==
X-Gm-Message-State: AOAM530kcQpG9TyjZiCl9Kew5Mk5tyIbLSlb+BMFoZIcPz6WlSJq9cv7
        D3VZhe5BDAcWGKrdWHsXyYTyQw==
X-Google-Smtp-Source: ABdhPJyCtnfLmNUkx7DrKCb4pwHApmhfPCWmAwzBNq7fE7AzanzmZTIYoP+MO6W7EOpfC/5BKbDo9A==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr16300196wmi.126.1591607862942;
        Mon, 08 Jun 2020 02:17:42 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id t7sm22732326wrq.41.2020.06.08.02.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:17:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lee.jones@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] mfd: Add support for Khadas Microcontroller
Date:   Mon,  8 Jun 2020 11:17:34 +0200
Message-Id: <20200608091739.2368-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontroller
connected via I2C.

This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
boards.

It has multiple boot control features like password check, power-on
options, power-off control and system FAN control on recent boards.

Thie serie adds :
- the bindings
- the MFD driver
- the Thermal Cooling cell driver
- updates MAINTAINERS
- add support into the Khadas VIM3/VIM3L DT

Changes since v2 at [3]:
- Removed NVMEM driver for separate submission
- fixed MFD driver, header and Kconfig
- fixed Thermal Kconfig
- fixed MAINTAINERS files and path

Changes since RFC v1 at [2]:
- moved hwmon driver to thermal-only
- moved the SM1 thermal nodes in a separate serie
- added the bindings review tag from rob

[1] http://lore.kernel.org/r/20200512093916.19676-1-narmstrong@baylibre.com
[2] http://lore.kernel.org/r/20200421080102.22796-1-narmstrong@baylibre.com
[3] http://lore.kernel.org/r/20200512132613.31507-1-narmstrong@baylibre.com

Neil Armstrong (5):
  dt-bindings: mfd: add Khadas Microcontroller bindings
  mfd: add support for the Khadas System control Microcontroller
  thermal: add support for the MCU controlled FAN on Khadas boards
  MAINTAINERS: add myself as maintainer for Khadas MCU drivers
  arm64: dts: meson-khadas-vim3: add Khadas MCU nodes

 .../devicetree/bindings/mfd/khadas,mcu.yaml   |  44 +++++
 MAINTAINERS                                   |   9 +
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
 drivers/mfd/Kconfig                           |  21 +++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/khadas-mcu.c                      | 142 ++++++++++++++
 drivers/thermal/Kconfig                       |  11 ++
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/khadas_mcu_fan.c              | 174 ++++++++++++++++++
 include/linux/mfd/khadas-mcu.h                |  91 +++++++++
 10 files changed, 517 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
 create mode 100644 drivers/mfd/khadas-mcu.c
 create mode 100644 drivers/thermal/khadas_mcu_fan.c
 create mode 100644 include/linux/mfd/khadas-mcu.h

-- 
2.22.0

