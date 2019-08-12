Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B28A689
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 20:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHLSt6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 14:49:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51522 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfHLSt6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 14:49:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49584200696;
        Mon, 12 Aug 2019 20:49:55 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31398200692;
        Mon, 12 Aug 2019 20:49:55 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C3EC12060E;
        Mon, 12 Aug 2019 20:49:53 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/7] PM / devfreq: Add initial imx support
Date:   Mon, 12 Aug 2019 21:49:44 +0300
Message-Id: <cover.1565633880.git.leonard.crestez@nxp.com>
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

Changes since RFCv3:
 * Implement passive support and set NOC parent to DDRC
 * Drop scaling AHB/AXI for now (NOC/DDRC use most power anyway)
 * Split into two devreq drivers (and bindings) because the ddrc is
really a distinct piece of hardware.
 * Stop relying on clk_min_rate
 * Fetch info about dram clk parents from firmware instead of
hardcoding in driver. This can more easily support additional rates.
 * Perform DRAM frequency inside devfreq instead of clk, mostly due to
objections to earlier RFCs for "imx8m-dram-clk"
 * Link: https://patchwork.kernel.org/cover/11056779/
 * Link: https://patchwork.kernel.org/patch/11049429/

Stephen: It would be very helpful if you could comment on the dram
frequency switching code. I moved it outside of clk but now I have to
use provider APIs outside of drivers/clk for parent manipulation. Few
other drivers do that so maybe it's OK?

Scaling buses can cause problems for devices with realtime bandwith
requirements such as display, the intention is to use the interconnect
framework to make DEV_PM_QOS_MIN_FREQUENCY to devfreq. There are
separate patches for that:

 * https://patchwork.kernel.org/patch/11084279/
 * https://patchwork.kernel.org/cover/11078671/

Leonard Crestez (7):
  clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram_alt/apb
  dt-bindings: devfreq: Add bindings for generic imx buses
  PM / devfreq: Add generic imx bus driver
  dt-bindings: devfreq: Add bindings for imx ddr controller
  PM / devfreq: Add dynamic scaling for imx ddr controller
  PM / devfreq: imx-ddrc: Measure bandwidth with perf
  arm64: dts: imx8mm: Add devfreq nodes

 .../devicetree/bindings/devfreq/imx-ddrc.yaml |  53 ++
 .../devicetree/bindings/devfreq/imx.yaml      |  50 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  51 +-
 drivers/clk/imx/clk-imx8mm.c                  |   6 +-
 drivers/clk/imx/clk-imx8mn.c                  |   6 +-
 drivers/clk/imx/clk-imx8mq.c                  |   7 +-
 drivers/devfreq/Kconfig                       |  12 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/imx-ddrc.c                    | 511 ++++++++++++++++++
 drivers/devfreq/imx-devfreq.c                 | 148 +++++
 10 files changed, 837 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml
 create mode 100644 drivers/devfreq/imx-ddrc.c
 create mode 100644 drivers/devfreq/imx-devfreq.c

-- 
2.17.1

