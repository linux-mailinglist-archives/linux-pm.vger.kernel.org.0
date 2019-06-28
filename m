Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2459524
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF1HkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 03:40:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54520 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF1HkD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 03:40:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D542E1A0DB5;
        Fri, 28 Jun 2019 09:40:00 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B8FD71A033F;
        Fri, 28 Jun 2019 09:40:00 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CC6BC205D5;
        Fri, 28 Jun 2019 09:39:59 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv2 0/8] Add imx8mm bus frequency switching
Date:   Fri, 28 Jun 2019 10:39:48 +0300
Message-Id: <cover.1561707104.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series attempts to add upstream DVFS support for imx8mm, covering dynamic
scaling of internal buses and dram. It uses the interconnect framework for
proactive scaling (in response to explicit bandwidth requests from devices) and
devfreq in order expose the buses and eventually implement reactive scaling (in
response to measuredtraffic).

Actual scaling is performed through the clk framework: The NOC and main NICs
are driven by composite clks and a new 'imx8m-dram' clk is included for
scaling dram using firmware calls.

The interconnect and devfreq parts do not communicate explicitly: they both
just call clk_set_min_rate and the clk core picks the minimum value that can
satisfy both. They are thus completely independent.

This is easily extensible to more members of the imx8m family, some of which
expose more detailed controls over interconnect fabric frequencies.

TODO:
* Clarify DT bindings
* Clarify interconnect OPP picking logic
* Implement devfreq_event for imx8m ddrc
* Expose more dram frequencies

The clk_set_min_rate approach does not mesh very well with the OPP framework.
Some of interconnect nodes on imx8m can run at different voltages: OPP can
handle this well but not in response to a clk_set_min_rate from an unrelated
subsystem. Maybe set voltage on a clk notifier?

Vendor tree does not support voltage switching, independent freqs for
different parts of the fabric or any reactive scaling. I think it's important
to pick an upstreaming approach which can support as much as possible.

Feedback welcome.

Some objections were apparently raised to doing DRAM switch inside CLK:
perhaps ICC should make min_freq requests to devfreq instead?

Link to v1 (multiple chunks):
 * https://patchwork.kernel.org/patch/10976897/
 * https://patchwork.kernel.org/patch/10968303/
 * https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=91251

Also as a github branch (with few other changes):
    https://github.com/cdleonard/linux/tree/next_imx8mm_busfreq

Alexandre Bailon (2):
  interconnect: Add generic driver for imx
  interconnect: imx: Add platform driver for imx8mm

Leonard Crestez (6):
  clk: imx8mm: Add dram freq switch support
  clk: imx8m-composite: Switch to determine_rate
  arm64: dts: imx8mm: Add dram dvfs irqs to ccm node
  devfreq: Add imx-devfreq driver
  arm64: dts: imx8mm: Add interconnect node
  arm64: dts: imx8mm: Add devfreq-imx nodes

 arch/arm64/boot/dts/freescale/imx8mm.dtsi |  73 +++
 drivers/clk/imx/Makefile                  |   1 +
 drivers/clk/imx/clk-composite-8m.c        |  34 +-
 drivers/clk/imx/clk-imx8m-dram.c          | 357 ++++++++++++
 drivers/clk/imx/clk-imx8mm.c              |  12 +
 drivers/clk/imx/clk.h                     |  13 +
 drivers/devfreq/Kconfig                   |  10 +
 drivers/devfreq/Makefile                  |   1 +
 drivers/devfreq/imx-devfreq.c             | 142 +++++
 drivers/interconnect/Kconfig              |   1 +
 drivers/interconnect/Makefile             |   1 +
 drivers/interconnect/imx/Kconfig          |  17 +
 drivers/interconnect/imx/Makefile         |   2 +
 drivers/interconnect/imx/busfreq-imx8mm.c | 151 ++++++
 drivers/interconnect/imx/busfreq.c        | 628 ++++++++++++++++++++++
 drivers/interconnect/imx/busfreq.h        | 123 +++++
 include/dt-bindings/clock/imx8mm-clock.h  |   4 +-
 include/dt-bindings/interconnect/imx8mm.h |  49 ++
 18 files changed, 1606 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/imx/clk-imx8m-dram.c
 create mode 100644 drivers/devfreq/imx-devfreq.c
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
 create mode 100644 drivers/interconnect/imx/busfreq.c
 create mode 100644 drivers/interconnect/imx/busfreq.h
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

-- 
2.17.1

