Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDFE6C2A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 07:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfJ1GHW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 02:07:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46388 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbfJ1GHV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 02:07:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE9C31A0264;
        Mon, 28 Oct 2019 07:07:19 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F1611A003F;
        Mon, 28 Oct 2019 07:07:06 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B17964030D;
        Mon, 28 Oct 2019 14:06:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, ping.bai@nxp.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        mripard@kernel.org, vkoul@kernel.org, jagan@amarulasolutions.com,
        dinguyen@kernel.org, marcin.juszkiewicz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND 3/4] arm64: defconfig: Enable CONFIG_IMX8MM_THERMAL as module
Date:   Mon, 28 Oct 2019 14:03:37 +0800
Message-Id: <1572242618-18806-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572242618-18806-1-git-send-email-Anson.Huang@nxp.com>
References: <1572242618-18806-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable CONFIG_IMX8MM_THERMAL as module to support i.MX8MM
thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f191a4f..cde02aa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -446,6 +446,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
+CONFIG_IMX8MM_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
-- 
2.7.4

