Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382752CE28B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 00:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgLCXSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 18:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgLCXSy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Dec 2020 18:18:54 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: scmi: add COMMON_CLK dependency
Date:   Fri,  4 Dec 2020 00:17:46 +0100
Message-Id: <20201203231809.1484631-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Wtihout CONFIG_COMMON_CLK, the scmi driver fails to link:

arm-linux-gnueabi-ld: drivers/cpufreq/scmi-cpufreq.o: in function `scmi_cpufreq_probe':
scmi-cpufreq.c:(.text+0x20c): undefined reference to `devm_of_clk_add_hw_provider'
arm-linux-gnueabi-ld: scmi-cpufreq.c:(.text+0x22c): undefined reference to `of_clk_hw_simple_get'

Add a Kconfig dependency for it.

Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dummy clock provider")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1f73fa75b1a0..434ef03d2762 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -264,6 +264,7 @@ config ARM_SA1110_CPUFREQ
 config ARM_SCMI_CPUFREQ
 	tristate "SCMI based CPUfreq driver"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	depends on COMMON_CLK
 	select PM_OPP
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCMI
-- 
2.27.0

