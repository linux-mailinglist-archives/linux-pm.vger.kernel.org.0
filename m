Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE9F9C82
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 22:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLVvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 16:51:12 -0500
Received: from inva020.nxp.com ([92.121.34.13]:43100 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLVvL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 16:51:11 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B66E1A0075;
        Tue, 12 Nov 2019 22:51:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0DA01A0014;
        Tue, 12 Nov 2019 22:51:08 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E006F205E9;
        Tue, 12 Nov 2019 22:51:07 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
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
Subject: [PATCH v5 0/5] PM / devfreq: Add dynamic scaling for imx8m ddr controller
Date:   Tue, 12 Nov 2019 23:50:50 +0200
Message-Id: <cover.1573595318.git.leonard.crestez@nxp.com>
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

Changes since v4:
* Restore empty _get_dev_status: testing shows this is *NOT* optional. If
absent then switching to simple_ondemand governor will trigger an Oops.
* Keep clk registration on single-line in clk-imx8m* for consistency with rest
of the file.
* Drop explicit "select PM_OPP"
* Check for NULL new_dram_core_parent
* Rename "out_dis_" labels to out_disable_*
* Use dev_warn on imx8m_ddrc_set_freq error paths after SMC call (where
operation is not abandoned).
* More elaborate error messages in imx8m_ddrc_target
* More elaborate checks when fetching clks in imx8m_ddrc_set_freq
* Rename ddrc nodes to memory-controller@* as per devicetree.org "Generic Names
Recommendation"
* Collect reviews
* Defer perf support
Link to v4: https://patchwork.kernel.org/cover/11235685/

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
* Split away from NOC scaling and interconnect support.
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

Leonard Crestez (5):
  clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram clocks
  clk: imx: Mark dram pll on 8mm and 8mn with CLK_GET_RATE_NOCACHE
  dt-bindings: memory: Add bindings for imx8m ddr controller
  PM / devfreq: Add dynamic scaling for imx8m ddr controller
  arm64: dts: imx8m: Add ddr controller nodes

 .../memory-controllers/fsl/imx8m-ddrc.yaml    |  57 +++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  18 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts    |  18 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  10 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  10 +
 drivers/clk/imx/clk-imx8mm.c                  |  11 +-
 drivers/clk/imx/clk-imx8mn.c                  |  12 +-
 drivers/clk/imx/clk-imx8mq.c                  |  12 +-
 drivers/clk/imx/clk-pll14xx.c                 |   7 +
 drivers/clk/imx/clk.h                         |   1 +
 drivers/devfreq/Kconfig                       |   9 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/imx8m-ddrc.c                  | 460 ++++++++++++++++++
 15 files changed, 650 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
 create mode 100644 drivers/devfreq/imx8m-ddrc.c

-- 
2.17.1

