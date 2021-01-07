Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53302ECF82
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbhAGMTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 07:19:31 -0500
Received: from comms.puri.sm ([159.203.221.185]:44030 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbhAGMTb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 07:19:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CBA52E20F5;
        Thu,  7 Jan 2021 04:18:20 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j8ji9IWMj8_o; Thu,  7 Jan 2021 04:18:20 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com, gregkh@linuxfoundation.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 0/5] imx8mq: updates for the interconnect fabric
Date:   Thu,  7 Jan 2021 13:17:49 +0100
Message-Id: <20210107121754.3295-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

revision history:
v4: (thanks Shawn, Georgi and Greg)
 * reorder to have dt-bindings doc before code addition
 * add newline between dt nodes
 * removed "interconnect: imx8mq: Use icc_sync_state" from the patchset
   since it's part of gregkh/char-misc.git
 * Add acks

v3: (thanks Krysztof and Georgi)
 * drop the defconfig cycling patch and fix the interconnect enable config
 * add the noc node to imx8mq only
 * add missing signed-off-by
 * https://lore.kernel.org/linux-arm-kernel/20201210100906.18205-1-martin.kepplinger@puri.sm/T/#t

v2: (thanks Lucas)
 * reorder and clean up defconfig changes
 * use "dram" for the interconnect path name and document it
 * https://lore.kernel.org/linux-arm-kernel/20201201123932.12312-1-martin.kepplinger@puri.sm/T/#t

v1:
 * https://lore.kernel.org/linux-arm-kernel/20201201100124.4676-1-martin.kepplinger@puri.sm/T/#t

thanks,
                        martin


Leonard Crestez (1):
  arm64: dts: imx8mq: Add NOC node

Martin Kepplinger (4):
  arm64: dts: imx8mq: Add interconnect provider property
  dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
  arm64: dts: imx8mq: Add interconnect for lcdif
  arm64: defconfig: Enable interconnect for imx8mq

 .../devicetree/bindings/display/mxsfb.txt     |  6 ++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 28 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  2 ++
 3 files changed, 36 insertions(+)

-- 
2.20.1

