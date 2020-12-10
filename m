Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07B02D57F4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 11:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgLJKLz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 05:11:55 -0500
Received: from comms.puri.sm ([159.203.221.185]:40422 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbgLJKLz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 05:11:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 414F7DFD55;
        Thu, 10 Dec 2020 02:09:59 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QNd_Ye23NNu5; Thu, 10 Dec 2020 02:09:58 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 6/6] arm64: defconfig: Enable interconnect for imx8mq
Date:   Thu, 10 Dec 2020 11:09:06 +0100
Message-Id: <20201210100906.18205-7-martin.kepplinger@puri.sm>
In-Reply-To: <20201210100906.18205-1-martin.kepplinger@puri.sm>
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
available.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8ca76751a34..f25748b0fa95 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1074,6 +1074,8 @@ CONFIG_SLIM_QCOM_CTRL=m
 CONFIG_SLIM_QCOM_NGD_CTRL=m
 CONFIG_MUX_MMIO=y
 CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_IMX=m
+CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
-- 
2.20.1

