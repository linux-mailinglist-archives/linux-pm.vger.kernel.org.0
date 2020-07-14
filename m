Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE921F9B0
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgGNSoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 14:44:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED297C061755;
        Tue, 14 Jul 2020 11:44:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id 2DC4D2A090D
From:   Walter Lozano <walter.lozano@collabora.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Walter Lozano <walter.lozano@collabora.com>
Subject: [PATCH] cpufreq: imx: Select NVMEM_IMX_OCOTP
Date:   Tue, 14 Jul 2020 15:43:56 -0300
Message-Id: <20200714184356.32749-1-walter.lozano@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When probing cpufreq for iMX6 the values in the efuse needs to be
read which requires NVMEM_IMX_OCOTP. If this option is not enabled,
the probe will be deferred forever and cpufreq won't be available.

This patch forces the selection of the required configuration option.

Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index c6cbfc8baf72..ce0227c429cf 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -93,6 +93,7 @@ config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
 	depends on REGULATOR_ANATOP
+	select NVMEM_IMX_OCOTP
 	select PM_OPP
 	help
 	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
-- 
2.20.1

