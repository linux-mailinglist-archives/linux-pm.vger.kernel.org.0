Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3372F00
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGXMiw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 08:38:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51490 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfGXMiw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jul 2019 08:38:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BC6D1A01FD;
        Wed, 24 Jul 2019 14:38:51 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D2CB1A0148;
        Wed, 24 Jul 2019 14:38:51 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ED221205D8;
        Wed, 24 Jul 2019 14:38:49 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Li <Frank.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFCv2 0/3] PM / devfreq: Add imx driver
Date:   Wed, 24 Jul 2019 15:38:43 +0300
Message-Id: <cover.1563971855.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series attempts to add devfreq support for imx8mm, covering dynamic
scaling of internal buses and dram.

Actual scaling is performed through the clk framework: The NOC and main
NICs are driven by composite clks and a new 'imx8m-dram' clk is used for
scaling dram using firmware calls.

Frequency target is set via "clk_set_min_rate", this allows an unrelated
subsystem (for example interconnect) to also request minimum rates as a
form for proactive scaling.

The dram controller (DDRC) has a performance monitoring block attached
for which a perf driver already exists. Instead of reimplementing that
as devfreq-events the perf in-kernel API is used.

Changes since v2:
* Solve review comments
* Add yaml binding doc
* Add perf event support
Link to v2: https://patchwork.kernel.org/patch/11021571/

DRAM frequency switching through clk framework is here:
* https://patchwork.kernel.org/patch/11049429/
That part might not be accepted in clk and it might have to be moved to
devfreq also.

Leonard Crestez (3):
  dt-bindings: devfreq: Add initial bindings for i.MX
  PM / devfreq: Add imx driver
  PM / devfreq: Add imx perf event support

 .../devicetree/bindings/devfreq/imx.yaml      |  59 ++++
 drivers/devfreq/Kconfig                       |  10 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/imx-devfreq.c                 | 278 ++++++++++++++++++
 4 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml
 create mode 100644 drivers/devfreq/imx-devfreq.c

-- 
2.17.1

