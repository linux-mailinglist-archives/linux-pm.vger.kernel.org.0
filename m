Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B771964DF
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfHTPpX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 11:45:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39104 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfHTPpX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 11:45:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B22CC2001DA;
        Tue, 20 Aug 2019 17:45:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A2692001B7;
        Tue, 20 Aug 2019 17:45:20 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 96E0E20612;
        Tue, 20 Aug 2019 17:45:19 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
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
Subject: [PATCH v2 0/7] PM / devfreq: Add initial imx support
Date:   Tue, 20 Aug 2019 18:45:05 +0300
Message-Id: <cover.1566315740.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds devfreq support for imx8mm, covering dynamic scaling of
internal NOC and DDR Controller

Scaling for simple busses (NIC/NOC) is done through the clk framework
while DRAM scaling is performed in firmware with an "imx-ddrc" wrapper
for devfreq.

Changes since v1:
 * bindings: Stop using "contains" for "compatible"
 * bindings: Set "additionalProperties: false" and document missing stuff.
 * Remove (c) from NXP copyright notice
 * Fix various checkpatch issues
 * Remove unused dram_alt_root clk from imx-ddrc
Link to v1: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=158773

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

Leonard Crestez (7):
  clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram_alt/apb
  dt-bindings: devfreq: Add bindings for generic imx buses
  PM / devfreq: Add generic imx bus driver
  dt-bindings: devfreq: Add bindings for imx ddr controller
  PM / devfreq: Add dynamic scaling for imx ddr controller
  PM / devfreq: imx-ddrc: Measure bandwidth with perf
  arm64: dts: imx8mm: Add devfreq nodes

 .../devicetree/bindings/devfreq/imx-ddrc.yaml |  60 ++
 .../devicetree/bindings/devfreq/imx.yaml      |  68 +++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  53 +-
 drivers/clk/imx/clk-imx8mm.c                  |   6 +-
 drivers/clk/imx/clk-imx8mn.c                  |   6 +-
 drivers/clk/imx/clk-imx8mq.c                  |   7 +-
 drivers/devfreq/Kconfig                       |  12 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/imx-ddrc.c                    | 514 ++++++++++++++++++
 drivers/devfreq/imx-devfreq.c                 | 148 +++++
 10 files changed, 867 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml
 create mode 100644 drivers/devfreq/imx-ddrc.c
 create mode 100644 drivers/devfreq/imx-devfreq.c

-- 
2.17.1

