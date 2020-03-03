Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8921771B4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 10:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCCJAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 04:00:19 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56716 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgCCJAT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 04:00:19 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 19C841A14EF;
        Tue,  3 Mar 2020 10:00:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0B261A157D;
        Tue,  3 Mar 2020 10:00:14 +0100 (CET)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7819A40338;
        Tue,  3 Mar 2020 17:00:05 +0800 (SGT)
From:   andy.tang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v2] thermal: qoriq: fix a compiling issue
Date:   Tue,  3 Mar 2020 16:46:41 +0800
Message-Id: <20200303084641.35687-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Qoriq thermal driver is used by both PowerPC and ARM architecture.
When built for PowerPC architecture, it reports error:
undefined reference to `.__devm_regmap_init_mmio_clk'
To fix it, select config REGMAP_MMIO.

Fixes: 4316237bd627 (thermal: qoriq: Convert driver to use regmap API)

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v2:
	- add Fixes tag

 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5a05db5438d6..5a0df0e54ce3 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -265,6 +265,7 @@ config QORIQ_THERMAL
 	tristate "QorIQ Thermal Monitoring Unit"
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	help
 	  Support for Thermal Monitoring Unit (TMU) found on QorIQ platforms.
 	  It supports one critical trip point and one passive trip point. The
--
2.17.1

