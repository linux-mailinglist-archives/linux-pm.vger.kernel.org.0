Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 431F249763
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfFRCRH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 22:17:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38048 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFRCRF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 22:17:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E83D1A02E0;
        Tue, 18 Jun 2019 04:17:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BCBD1A02EC;
        Tue, 18 Jun 2019 04:16:48 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A41E5402F1;
        Tue, 18 Jun 2019 10:16:34 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, peng.fan@nxp.com,
        mchehab+samsung@kernel.org, linux@roeck-us.net,
        daniel.baluta@nxp.com, maxime.ripard@bootlin.com,
        horms+renesas@verge.net.au, olof@lixom.net,
        jagan@amarulasolutions.com, bjorn.andersson@linaro.org,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V15 4/5] defconfig: arm64: add i.MX system controller thermal support
Date:   Tue, 18 Jun 2019 10:18:19 +0800
Message-Id: <20190618021820.14885-4-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618021820.14885-1-Anson.Huang@nxp.com>
References: <20190618021820.14885-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c40ec41..29f7768 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -415,6 +415,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
+CONFIG_IMX_SC_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
-- 
2.7.4

