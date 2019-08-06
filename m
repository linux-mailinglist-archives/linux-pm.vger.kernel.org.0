Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA51D83026
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 12:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfHFK4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 06:56:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58154 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730877AbfHFK4D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 06:56:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A07D1A05E1;
        Tue,  6 Aug 2019 12:55:58 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C6501A05D4;
        Tue,  6 Aug 2019 12:55:58 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 78284205DD;
        Tue,  6 Aug 2019 12:55:57 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv3 0/3] interconnect: Add imx support via devfreq
Date:   Tue,  6 Aug 2019 13:55:51 +0300
Message-Id: <cover.1565088423.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series add imx support for interconnect via devfreq: the ICC
framework is used to aggregate requests from devices and then those are
converted to "min_freq" requests to devfreq.

The dev_pm_qos API is used to request min frequencies from devfreq, it
relies on this patch: https://patchwork.kernel.org/patch/11078475/

This is greatly reduced compared to previous submissions:

 * Relying on devfreq and dev_pm_qos instead of CLK allows a wider range
of implementations for scaling individual nodes. In particular it's no
longer required to force DDR scaling into CLK.
 * No more "platform opp" stuff: forcing everything to scale together
loses many of the benefits of ICC. The devfreq "passive" governor can
still be used to tie some pieces of the fabric together.
 * No more suspend/resume handling: devfreq uses OPP framework which
already supports "suspend-opp".
 * Replace all mentions of "busfreq" with "interconnect"

Link to v2: https://patchwork.kernel.org/patch/11056789/

The per-soc platform drivers still need to defined the interconnect
graph and links to devfreq (by name) as well as bus widths. For example
some of the 128-bit buses on imx8m mini are 64-bit on imx8m nano.

There was another recent series tying icc and devfreq, for exynos:
 * https://lkml.org/lkml/2019/7/23/394

That series defines the interconnect graph/tree entirely inside
devicetree but that seems limiting. I'd rather keep the graph in a SOC
driver and #define ids for all bus masters/slaves. This way if USB1 and
USB2 are on the same bus they can still be treated differently.

One interesting idea from there is to turn devfreq nodes into
interconnect providers, this can avoid the need for a "virtual" ICC node
in devicetree. I expect devicetree folks will object to that?

Leonard Crestez (3):
  dt-bindings: interconnect: Add bindings for imx
  interconnect: Add imx core driver
  interconnect: imx: Add platform driver for imx8mm

 .../devicetree/bindings/interconnect/imx.yaml |  38 +++
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/imx/Kconfig              |   9 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/imx.c                | 258 ++++++++++++++++++
 drivers/interconnect/imx/imx.h                |  62 +++++
 drivers/interconnect/imx/imx8mm.c             | 114 ++++++++
 include/dt-bindings/interconnect/imx8mm.h     |  49 ++++
 9 files changed, 534 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx.yaml
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx.c
 create mode 100644 drivers/interconnect/imx/imx.h
 create mode 100644 drivers/interconnect/imx/imx8mm.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

-- 
2.17.1

