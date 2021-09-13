Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4F409AC5
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbhIMRjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:39:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58644 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242897AbhIMRjj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 60EB22005D8;
        Mon, 13 Sep 2021 19:38:22 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 530CD2005AC;
        Mon, 13 Sep 2021 19:38:22 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 812EA20363;
        Mon, 13 Sep 2021 19:38:21 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 00/19] Add interconnect and devfreq support for i.MX8MQ
Date:   Mon, 13 Sep 2021 20:37:55 +0300
Message-Id: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In vendor tree there is something called busfreq but it is
non-upstreamable. This approach with interconnect+devfreq gives us the
same functionality by using already upstream and mature subsystems.
This series is more of a proof-of-concept.

Abel Vesa (19):
  dt-bindings: interconnect: imx8mq: Add missing pl301 and SAI ids
  devfreq: imx-bus: Switch governor to powersave
  devfreq: imx-bus: Decouple imx-bus from icc made
  devfreq: imx8m-ddrc: Change governor to powersave
  devfreq: imx8m-ddrc: Use the opps acquired from EL3
  devfreq: imx8m-ddrc: Add late system sleep PM ops
  interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id
    node assignment
  interconnect: imx8: Remove the imx_icc_node_adj_desc
  interconnect: imx8mq: Add the pl301_per_m and pl301_wakeup nodes and
    subnodes
  interconnect: imx8mq: Add of_match_table
  interconnect: imx: Add imx_icc_get_bw and imx_icc_aggregate functions
  arm64: dts: imx8mq: Add fsl,icc-id property to ddrc node
  arm64: dts: imx8mq: Add fsl,icc-id to noc node
  arm64: dts: imx8mq: Add all pl301 nodes
  arm64: dts: imx8mq: Add the interconnect node
  arm64: dts: imx8mq: Add interconnect properties to icc consumer nodes
  net: ethernet: fec_main: Add interconnect support
  mmc: sdhci-esdhc-imx: Add interconnect support
  arm64: defconfig: Add necessary configs for icc+devfreq on i.MX8MQ

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 222 +++++++++++++++++++++-
 arch/arm64/configs/defconfig              |   9 +-
 drivers/devfreq/imx-bus.c                 |  42 +---
 drivers/devfreq/imx8m-ddrc.c              |  78 +++-----
 drivers/interconnect/imx/imx.c            |  92 +++++----
 drivers/interconnect/imx/imx.h            |  19 +-
 drivers/interconnect/imx/imx8mm.c         |  32 +---
 drivers/interconnect/imx/imx8mn.c         |  28 +--
 drivers/interconnect/imx/imx8mq.c         |  59 +++---
 drivers/mmc/host/sdhci-esdhc-imx.c        |  27 +++
 drivers/net/ethernet/freescale/fec.h      |   3 +
 drivers/net/ethernet/freescale/fec_main.c |  19 ++
 include/dt-bindings/interconnect/imx8mq.h |   9 +
 13 files changed, 422 insertions(+), 217 deletions(-)

-- 
2.31.1

