Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD741CF5A8
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELN0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELN0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 09:26:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16908C061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:26:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so9463052wru.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Go6EA70bJtcKVjvR24qLP1HyJXRwhoEX5J2ggLK/lwQ=;
        b=V9IwWVvxcnMOOd8GRgTS4y27COjD5qrtjdcUZMAxV10Dvh5RLePnyv24HbbmrYTZkX
         GKKfzgDe0UDI6SYRYz/oDmbz3Vf/GybO6G0+nMAF4dL3ViBdTUZj4xaP+LFDaXHskxIF
         qwBoko4GWjQI04zwo1UArfZNOHCJGDbkEi6PqMk5LbaukqduKwtZDT5j4Mqb5cKC+Izy
         p0IZgDYZW64qSUSnSR3lli9NcOzExfZtu/PL9Ww5uVv7/K0CuGo0WYfgfRmA0z2zqFmh
         VVgsN/CJOjb2xq6ccsRMrq1VtofyoY+AuAk+E1U3Lhy7znx6YA8nMylVriZHmXBiP8s7
         xsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Go6EA70bJtcKVjvR24qLP1HyJXRwhoEX5J2ggLK/lwQ=;
        b=sCBW/BCaHrjTUASh2CskLVm4V6e1YcXjJDag8nYbkiTEw7wP7fpyQjUqlkcTQd5FOc
         7Owo3713IILsPO3XIW9rBFPxq9VPpyYl5FeW0HkynjFFZ0Ru2evcDk4CtW2K4X6p3H0/
         TAPt+brG4Yen2hZ8RTNKzH8Mk6sZyCTJf0f48tpgM1ULCAZ2q8mMiBC1JWKWTxdXPXXn
         +TATZXLDnhfizmBp0fbhMbs8AlZtyCu9pXwU54m1j3A5xmxya+1bWYE00suJMM6MCXyu
         pVePxdSDxuZ8QgNtvYrkcHC3BDiLeS0zINjNDS9j6ObWrOjACHLmFKwvOQMzRgN+EgHa
         1Xpg==
X-Gm-Message-State: AGi0PuZN8vJIK/5cwWpthCizjVmW1TCjSwDdieq2nnubMNk3R/dqfFxu
        ixL3KZ3Efq+4QI9NqNizucQxlg==
X-Google-Smtp-Source: APiQypI2kanwMn4n6b+uBjRG3a2Lgj0R69NagRGMzqIb2DZ1OgzPeFumG1+jUYUZSQEWNSEXhZ40Pw==
X-Received: by 2002:adf:face:: with SMTP id a14mr24734851wrs.397.1589289977653;
        Tue, 12 May 2020 06:26:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id g15sm14441844wro.71.2020.05.12.06.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:26:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lee.jones@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        srinivas.kandagatla@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] mfd: Add support for Khadas Microcontroller
Date:   Tue, 12 May 2020 15:26:07 +0200
Message-Id: <20200512132613.31507-1-narmstrong@baylibre.com>
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
- the HWMON cell driver
- the NVMEM cell driver
- updates MAINTAINERS
- add support into the Khadas VIM3/VIM3L DT

Patch 6 depends on [1].

Changes since RFC v1 at [2]:
- moved hwmon driver to thermal-only
- moved the SM1 thermal nodes in a separate serie
- added the bindings review tag from rob

[1] http://lore.kernel.org/r/20200512093916.19676-1-narmstrong@baylibre.com
[2] http://lore.kernel.org/r/20200421080102.22796-1-narmstrong@baylibre.com

Neil Armstrong (6):
  dt-bindings: mfd: add Khadas Microcontroller bindings
  mfd: add support for the Khadas System control Microcontroller
  thermal: add support for the MCU controlled FAN on Khadas boards
  nvmem: add support for the Khadas MCU Programmable User Memory
  MAINTAINERS: add myself as maintainer for Khadas MCU drivers
  arm64: dts: meson-khadas-vim3: add Khadas MCU nodes

 .../devicetree/bindings/mfd/khadas,mcu.yaml   |  44 +++++
 MAINTAINERS                                   |  10 +
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
 drivers/mfd/Kconfig                           |  14 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/khadas-mcu.c                      | 143 ++++++++++++++
 drivers/nvmem/Kconfig                         |   8 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/khadas-mcu-user-mem.c           | 128 +++++++++++++
 drivers/thermal/Kconfig                       |  10 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/khadas_mcu_fan.c              | 174 ++++++++++++++++++
 include/linux/mfd/khadas-mcu.h                |  91 +++++++++
 13 files changed, 649 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
 create mode 100644 drivers/mfd/khadas-mcu.c
 create mode 100644 drivers/nvmem/khadas-mcu-user-mem.c
 create mode 100644 drivers/thermal/khadas_mcu_fan.c
 create mode 100644 include/linux/mfd/khadas-mcu.h

-- 
2.22.0

