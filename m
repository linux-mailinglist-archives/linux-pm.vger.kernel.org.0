Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D2EB94A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 22:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfJaVuf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 17:50:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42258 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbfJaVuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 17:50:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D7391A057E;
        Thu, 31 Oct 2019 22:50:32 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0549F1A00B6;
        Thu, 31 Oct 2019 22:50:32 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E3827205E9;
        Thu, 31 Oct 2019 22:50:30 +0100 (CET)
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
Subject: [PATCH v3 0/6] PM / devfreq: Add dynamic scaling for imx ddr controller
Date:   Thu, 31 Oct 2019 23:50:21 +0200
Message-Id: <cover.1572558427.git.leonard.crestez@nxp.com>
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

Changes since v2:
* Add support for entire imx8m family including imx8mq B0.
* Also mark dram PLLs as CLK_GET_RATE_NO_CACHE (required for imx8mq b0 low OPP)
* Explicitly update dram pll rate at the end of imx_ddrc_set_freq.
* Use do_div in imx-ddrc (kbuild robot)
* Improve explanations around adding CLK_GET_RATE_NO_CACHE to dram clks.
(Stephen Boyd)
* Handle ddrc devfreq-events earlier for fewer probe defers.
* Validate DDRC opp tables versus firmware: supported OPPs depend on board and
SOC revision.
* Move DDRC opp tables to board dts because they can vary based on ram type on
board.
* Verify DDRC rate is changed in clk tree and otherwise report an error.
* Change imx_ddrc_freq.rate to be measure in MT/s and round down from HZ in
imx_ddrc_find_freq instead.
* Split NOC scaling away.
Link to v2: https://patchwork.kernel.org/cover/11104113/

Changes since v1:
* bindings: Stop using "contains" for "compatible"
* bindings: Set "additionalProperties: false" and document missing stuff.
* Remove (c) from NXP copyright notice
* Fix various checkpatch issues
* Remove unused dram_alt_root clk from imx-ddrc
Link to v1: https://patchwork.kernel.org/cover/11090649/

Changes since RFC v3:
* Implement passive support and set NOC's parent to DDRC
* Drop scaling AHB/AXI for now (NOC/DDRC use most power anyway)
* Stop relying on clk_min_rate
* Split into two devreq drivers (and bindings) because the ddrc is
really a distinct piece of hardware.
* Perform DRAM frequency inside devfreq instead of clk, mostly due to
objections to earlier RFCs for imx8m-dram-clk.
* Fetch info about dram clk parents from firmware instead of
hardcoding in driver. This can more easily support additional rates.
* Link: https://patchwork.kernel.org/cover/11056779/
* Link: https://patchwork.kernel.org/patch/11049429/

Scaling buses can cause problems for devices with realtime bandwith
requirements such as display, the intention is to use the interconnect
framework to make DEV_PM_QOS_MIN_FREQUENCY to devfreq. There are
separate patches for that:

* https://patchwork.kernel.org/cover/11104055/
* https://patchwork.kernel.org/cover/11078671/


Leonard Crestez (6):
  clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
  clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE
  dt-bindings: devfreq: Add bindings for imx ddr controller
  PM / devfreq: Add dynamic scaling for imx ddr controller
  PM / devfreq: imx-ddrc: Measure bandwidth with perf
  arm64: dts: imx8m: Add ddr controller nodes

 .../devicetree/bindings/devfreq/imx-ddrc.yaml |  60 ++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  17 +-
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  16 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  16 +-
 drivers/clk/imx/clk-imx8mm.c                  |  13 +-
 drivers/clk/imx/clk-imx8mn.c                  |  14 +-
 drivers/clk/imx/clk-imx8mq.c                  |  15 +-
 drivers/clk/imx/clk-pll14xx.c                 |   7 +
 drivers/clk/imx/clk.h                         |   1 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/imx-ddrc.c                    | 570 ++++++++++++++++++
 14 files changed, 777 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
 create mode 100644 drivers/devfreq/imx-ddrc.c

-- 
2.17.1

