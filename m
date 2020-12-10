Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C52D5806
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 11:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgLJKKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 05:10:45 -0500
Received: from comms.puri.sm ([159.203.221.185]:40212 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgLJKKn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 05:10:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 35CE6DF98D;
        Thu, 10 Dec 2020 02:09:38 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dmlePB7Okdbu; Thu, 10 Dec 2020 02:09:33 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/6] imx8mq: updates for the interconnect fabric
Date:   Thu, 10 Dec 2020 11:09:00 +0100
Message-Id: <20201210100906.18205-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

revision history:
v3: (thanks Krysztof and Georgi)
 * drop the defconfig cycling patch and fix the interconnect enable config
 * add the noc node to imx8mq only and use correct properties
 * add missing signed-off-by

v2: (thanks Lucas)
 * reorder and clean up defconfig changes
 * use "dram" for the interconnect path name and document it
 * https://lore.kernel.org/linux-arm-kernel/20201201123932.12312-1-martin.kepplinger@puri.sm/T/#t

v1:
 * link: https://lore.kernel.org/linux-arm-kernel/20201201100124.4676-1-martin.kepplinger@puri.sm/T/

thanks,
                        martin

Leonard Crestez (1):
  arm64: dts: imx8mq: Add NOC node

Martin Kepplinger (5):
  arm64: dts: imx8mq: Add interconnect provider property
  arm64: dts: imx8mq: Add interconnect for lcdif
  dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
  interconnect: imx8mq: Use icc_sync_state
  arm64: defconfig: Enable interconnect for imx8mq

 .../devicetree/bindings/display/mxsfb.txt     |  6 +++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 26 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  2 ++
 drivers/interconnect/imx/imx8mq.c             |  2 ++
 4 files changed, 36 insertions(+)

-- 
2.20.1

