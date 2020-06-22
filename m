Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D901202E8D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 04:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgFVC7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 22:59:47 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:58722 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731062AbgFVC7q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 22:59:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.088681|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.049363-0.000501963-0.950135;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.HqMydez_1592794774;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.HqMydez_1592794774)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 22 Jun 2020 10:59:39 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        srinivas.kandagatla@linaro.org, linus.walleij@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        frank <frank@allwinnertech.com>
Subject: [PATCH v2 00/11] Allwinner A100 Initial support
Date:   Mon, 22 Jun 2020 10:58:56 +0800
Message-Id: <20200622025907.32574-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: frank <frank@allwinnertech.com>

This patch set adds initial support for allwinner a100 soc,
which is a 64-bit tablet chip.

v2:
-Some naming consistency
-Repair email address
-Fix mmc clock
-Don't export system clock
-Fix checkpatch warning
-Drop unneeded pin function, convert to jtag_gpu and i2s_x

Frank Lee (11):
  dt-bindings: clk: sunxi-ccu: add compatible string for A100 CCU and
    R-CCU
  clk: sunxi-ng: add support for the Allwinner A100 CCU
  dt-bindings: pinctrl: sunxi: Add A100 pinctrl bindings
  pinctrl: sunxi: add support for the Allwinner A100 pin controller
  dt-bindings: nvmem: SID: add binding for A100's SID controller
  nvmem: sunxi-sid: add support for A100's SID controller
  dt-bindings: thermal: sun8i: Add binding for A100's THS controller
  thermal: sun8i: Add A100's THS controller support
  arm64: allwinner: A100: add the basical Allwinner A100 DTSI file
  dt-bindings: arm: sunxi: Add Allwinner A100 Perf1 Board bindings
  arm64: allwinner: A100: add support for Allwinner Perf1 board

 Documentation/devicetree/bindings/arm/sunxi.yaml   |    5 +
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |    7 +-
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |    1 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |   72 +-
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |    6 +-
 arch/arm64/boot/dts/allwinner/Makefile             |    1 +
 .../dts/allwinner/sun50i-a100-allwinner-perf1.dts  |   27 +
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi     |  337 ++++++
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    2 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c           |  214 ++++
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h           |   21 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c             | 1261 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a100.h             |   56 +
 drivers/nvmem/sunxi_sid.c                          |    6 +
 drivers/pinctrl/sunxi/Kconfig                      |   10 +
 drivers/pinctrl/sunxi/Makefile                     |    2 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c      |  105 ++
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c        |  708 +++++++++++
 drivers/thermal/sun8i_thermal.c                    |   14 +
 include/dt-bindings/clock/sun50i-a100-ccu.h        |  116 ++
 include/dt-bindings/clock/sun50i-a100-r-ccu.h      |   23 +
 include/dt-bindings/reset/sun50i-a100-ccu.h        |   68 ++
 include/dt-bindings/reset/sun50i-a100-r-ccu.h      |   18 +
 24 files changed, 3059 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
 create mode 100644 include/dt-bindings/clock/sun50i-a100-ccu.h
 create mode 100644 include/dt-bindings/clock/sun50i-a100-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a100-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a100-r-ccu.h

-- 
1.9.1

