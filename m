Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C9DF5B08
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 23:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfKHWkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 17:40:12 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51082 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfKHWkM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 17:40:12 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6086F1A01BE;
        Fri,  8 Nov 2019 23:40:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 48F2F1A0181;
        Fri,  8 Nov 2019 23:40:09 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 387D5205CD;
        Fri,  8 Nov 2019 23:40:08 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/6] PM / devfreq: Add dynamic scaling for imx8m ddr controller
Date:   Sat,  9 Nov 2019 00:39:50 +0200
Message-Id: <cover.1573252696.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds support for dynamic scaling of the DDR Controller (ddrc) present in
imx8m series. Actual frequency switching is implemented inside TF-A, this
driver wraps the SMC calls and synchronizes the clk tree.

DRAM frequency switching requires clock manipulation but during this operation
DRAM itself is briefly inaccessible so this operation is performed a SMC call
to by TF-A which runs from a SRAM area. Upon returning to linux the clock tree
is updated to correspond to hardware configuration.

This is handled via CLK_GET_RATE_NO_CACHE for dividers but muxes are handled
manually: the driver will prepare/enable the new parents ahead of switching (so
that the expected roots are enabled) and afterwards it will call clk_set_parent
to ensure the parents in clock framework are up-to-date.

This series is atomically useful and roughly similar to devfreq drivers for
tegra and rockchip.

Running at lower dram rates saves power but can affect the functionality of
other blocks in the chip (display, vpu etc). Support for in-kernel constraints
will some separately.

Angus/Martin: You previously attempted to test on purism boards, this updated
version should work without hacks and has no dependencies.

Changes since v3:
* Rename to imx8m-ddrc. Similar blocks are present on imx7d and imx8qxp/imx8qm
but soc integration is different.
* Move dt bindings to /memory-controllers/fsl/
* Fix dt validation issues
* Fix imx8mm.dtsi ddrc referencing ddrc_opp_table which is only defined in evk
* Move opps to child of ddrc device node
* Only add imx_ddrc_get_dev_status in perf patch.
* Adjust print messages
Link to v3: https://patchwork.kernel.org/cover/11221935/

Leonard Crestez (6):
  clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
  clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE
  dt-bindings: memory: Add bindings for imx8m ddr controller
  PM / devfreq: Add dynamic scaling for imx8m ddr controller
  PM / devfreq: imx8m-ddrc: Measure bandwidth with perf
  arm64: dts: imx8m: Add ddr controller nodes

 .../memory-controllers/fsl/imx8m-ddrc.yaml    |  61 ++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  13 +-
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  13 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  13 +-
 drivers/clk/imx/clk-imx8mm.c                  |  13 +-
 drivers/clk/imx/clk-imx8mn.c                  |  14 +-
 drivers/clk/imx/clk-imx8mq.c                  |  15 +-
 drivers/clk/imx/clk-pll14xx.c                 |   7 +
 drivers/clk/imx/clk.h                         |   1 +
 drivers/devfreq/Kconfig                       |  10 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/imx8m-ddrc.c                  | 569 ++++++++++++++++++
 15 files changed, 777 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
 create mode 100644 drivers/devfreq/imx8m-ddrc.c

-- 
2.17.1

