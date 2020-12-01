Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8E2C9ED5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 11:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgLAKJy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 05:09:54 -0500
Received: from comms.puri.sm ([159.203.221.185]:53330 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbgLAKJy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 05:09:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7423CDF97D;
        Tue,  1 Dec 2020 02:02:25 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tiHtvklMPdTS; Tue,  1 Dec 2020 02:02:24 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 0/6] imx8mq: updates for the interconnect fabric
Date:   Tue,  1 Dec 2020 11:01:18 +0100
Message-Id: <20201201100124.4676-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Small updates for using interconnect on the imx8mq. In case you
add icc_sync_state yourself, just let me know Georgi, and I can drop
it here. Thanks again for your help.

The last patch of course is optional and just cycles the defconfig.

thanks,
                        martin


Leonard Crestez (1):
  arm64: dts: imx8m: Add NOC nodes

Martin Kepplinger (5):
  arm64: dts: imx8mq: Add interconnect provider property
  arm64: dts: imx8mq: Add interconnect for lcdif
  interconnect: imx8mq: Use icc_sync_state
  arm64: defconfig: Enable interconnect for imx8mq
  arm64: defconfig: updates for 5.10

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 22 ++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 22 ++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 26 +++++++
 arch/arm64/configs/defconfig              | 85 +++++++----------------
 drivers/interconnect/imx/imx8mq.c         |  2 +
 5 files changed, 98 insertions(+), 59 deletions(-)

-- 
2.20.1

