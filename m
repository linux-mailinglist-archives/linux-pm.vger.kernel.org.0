Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FEE16541C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 02:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBTBQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 20:16:59 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55668 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbgBTBQ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 20:16:59 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8044D20273A;
        Thu, 20 Feb 2020 02:16:57 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 352CB201E72;
        Thu, 20 Feb 2020 02:16:41 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C9A9402AB;
        Thu, 20 Feb 2020 09:16:16 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        aisheng.dong@nxp.com, linux@roeck-us.net,
        srinivas.kandagatla@linaro.org, krzk@kernel.org,
        fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com,
        bjorn.andersson@linaro.org, olof@lixom.net, dinguyen@kernel.org,
        leonard.crestez@nxp.com, marcin.juszkiewicz@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V15 RESEND 4/5] defconfig: arm64: add i.MX system controller thermal support
Date:   Thu, 20 Feb 2020 09:10:27 +0800
Message-Id: <1582161028-2844-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1c74437..1ff479c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -453,6 +453,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
+CONFIG_IMX_SC_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
-- 
2.7.4

