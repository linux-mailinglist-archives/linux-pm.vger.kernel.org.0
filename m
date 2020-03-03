Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B90176DD1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 05:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCCEFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 23:05:03 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60952 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgCCEFD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 23:05:03 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DFF50201248;
        Tue,  3 Mar 2020 05:05:01 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5C8020123D;
        Tue,  3 Mar 2020 05:04:58 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D80E54029B;
        Tue,  3 Mar 2020 12:04:54 +0800 (SGT)
From:   andy.tang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] thermal: qoriq: fix a compiling issue
Date:   Tue,  3 Mar 2020 12:02:11 +0800
Message-Id: <20200303040211.31304-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
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

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
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

