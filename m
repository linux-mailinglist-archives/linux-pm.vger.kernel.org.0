Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B135A88
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfFEKhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:37:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60636 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfFEKhQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:37:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F19A3200782;
        Wed,  5 Jun 2019 12:37:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E4AF320077F;
        Wed,  5 Jun 2019 12:37:12 +0200 (CEST)
Received: from jana.ea.freescale.net (gw_auto.ea.freescale.net [10.171.94.100])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 642AD205FA;
        Wed,  5 Jun 2019 12:37:12 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] Add imx7d speed grading and higher OPPs
Date:   Wed,  5 Jun 2019 13:37:04 +0300
Message-Id: <cover.1559730963.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes since v1:
 * Remove the match list from imx-cpufreq-dt
 * Split arch and cpufreq changes
Link to v1: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=124427

Leonard Crestez (5):
  cpufreq: imx-cpufreq-dt: Remove global platform match list
  cpufreq: Switch imx7d to imx-cpufreq-dt for speed grading
  ARM: imx: Switch imx7d to imx-cpufreq-dt for speed-grading
  ARM: dts: imx7d: Update cpufreq OPP table
  ARM: imx_v6_v7_defconfig: Enable CONFIG_ARM_IMX_CPUFREQ_DT

 arch/arm/boot/dts/imx7d.dtsi         | 16 +++++++++++++---
 arch/arm/boot/dts/imx7s.dtsi         |  4 ++++
 arch/arm/configs/imx_v6_v7_defconfig |  1 +
 arch/arm/mach-imx/mach-imx7d.c       |  7 +++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |  2 +-
 drivers/cpufreq/imx-cpufreq-dt.c     | 18 ++----------------
 6 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.7.4

