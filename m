Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7639B21E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfHWOhF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 10:37:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48412 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390787AbfHWOhF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 10:37:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D737A200741;
        Fri, 23 Aug 2019 16:37:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C86A920073F;
        Fri, 23 Aug 2019 16:37:02 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E792D205D9;
        Fri, 23 Aug 2019 16:37:01 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        kernel@pengutronix.de, linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv4 0/7] interconnect: Add imx support via devfreq
Date:   Fri, 23 Aug 2019 17:36:53 +0300
Message-Id: <cover.1566570260.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series add imx support for interconnect via devfreq: the ICC
framework is used to aggregate requests from devices and then those are
converted to DEV_PM_QOS_MIN_FREQUENCY requests for devfreq.

The devfreq parts are posted separately, this series only intersects in
devicetree: https://patchwork.kernel.org/cover/11104113/

Since there is no single devicetree node that can represent the "interconnect"
new API is added to allow individual devfreq nodes to act as parsing proxies
all mapping to a single soc-level icc provider. This is still RFC
because this

The rest of the changes are small and deal with review comments.

Changes since RFCv3:
* Remove the virtual "icc" node and add devfreq nodes as proxy providers
* Fix build on 32-bit arm (reported by kbuilt test robot)
* Remove ARCH_MXC_ARM64 (never existed in upstream)
* Remove _numlinks, calculate instead
* Replace __BUSFREQ_H header guard
* Improve commit message and comment spelling
* Fix checkpatch issues
Link to RFCv3: https://patchwork.kernel.org/cover/11078671/

Changes since RFCv2 and initial work by Alexandre Bailon:
* Relying on devfreq and dev_pm_qos instead of CLK
* No more "platform opp" stuff
* No more special suspend handling: use suspend-opp on devfreq instead.
* Replace all mentions of "busfreq" with "interconnect"
Link to v2: https://patchwork.kernel.org/patch/11056789/

Leonard Crestez (7):
  PM / devfreq: Add devfreq_get_devfreq_by_node
  interconnect: Add of_icc_add_proxy
  dt-bindings: devfreq: imx: Describe interconnect properties
  interconnect: Add imx core driver
  interconnect: imx: Add platform driver for imx8mm
  soc: imx8mm: Register interconnect platform device
  arm64: dts: imx8mm: Add interconnect properties

 .../devicetree/bindings/devfreq/imx-ddrc.yaml |   5 +
 .../devicetree/bindings/devfreq/imx.yaml      |   5 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |   5 +
 drivers/devfreq/devfreq.c                     |  42 ++-
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/core.c                   |  88 +++++-
 drivers/interconnect/imx/Kconfig              |   9 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/imx.c                | 279 ++++++++++++++++++
 drivers/interconnect/imx/imx.h                |  60 ++++
 drivers/interconnect/imx/imx8mm.c             | 105 +++++++
 drivers/soc/imx/soc-imx8.c                    |   4 +
 include/dt-bindings/interconnect/imx8mm.h     |  49 +++
 include/linux/devfreq.h                       |   1 +
 include/linux/interconnect-provider.h         |   7 +
 16 files changed, 645 insertions(+), 18 deletions(-)
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx.c
 create mode 100644 drivers/interconnect/imx/imx.h
 create mode 100644 drivers/interconnect/imx/imx8mm.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

-- 
2.17.1

