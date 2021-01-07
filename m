Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356442ECF87
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 13:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbhAGMUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 07:20:18 -0500
Received: from comms.puri.sm ([159.203.221.185]:44144 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbhAGMUR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 07:20:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CE8D4E20F1;
        Thu,  7 Jan 2021 04:18:47 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6x3jj7FmnTLg; Thu,  7 Jan 2021 04:18:47 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com, gregkh@linuxfoundation.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 5/5] arm64: defconfig: Enable interconnect for imx8mq
Date:   Thu,  7 Jan 2021 13:17:54 +0100
Message-Id: <20210107121754.3295-6-martin.kepplinger@puri.sm>
In-Reply-To: <20210107121754.3295-1-martin.kepplinger@puri.sm>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
available.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ca9d03d5cb3..0095df536f74 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1078,6 +1078,8 @@ CONFIG_SLIM_QCOM_CTRL=m
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

