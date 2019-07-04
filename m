Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1281D5F571
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGDJWg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 05:22:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47832 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfGDJWf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 05:22:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AAB51A0562;
        Thu,  4 Jul 2019 11:22:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B9511A0021;
        Thu,  4 Jul 2019 11:22:19 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 10A2D402DF;
        Thu,  4 Jul 2019 17:22:05 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        ping.bai@nxp.com, olof@lixom.net, maxime.ripard@bootlin.com,
        jagan@amarulasolutions.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        marcin.juszkiewicz@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/4] Add support for i.MX8MM thermal sensor driver
Date:   Thu,  4 Jul 2019 17:13:09 +0800
Message-Id: <20190704091313.9516-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MM has a thermal monitor unit (TMU) inside, it ONLY has one sensor
for CPU, add support for temperature reading for CPU, cpu cooling is
also added.

This patch series is based on below i.MX SCU thermal patch series:
https://patchwork.kernel.org/patch/11000821/

Anson Huang (4):
  dt-bindings: thermal: imx8mm-thermal: Add binding doc for i.MX8MM
  thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit
  arm64: defconfig: Enable CONFIG_IMX8MM_THERMAL as module
  arm64: dts: imx8mm: Add thermal zone support

 .../devicetree/bindings/thermal/imx8mm-thermal.txt |  15 +++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |  43 +++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx8mm_thermal.c                   | 134 +++++++++++++++++++++
 6 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
 create mode 100644 drivers/thermal/imx8mm_thermal.c

-- 
2.7.4

