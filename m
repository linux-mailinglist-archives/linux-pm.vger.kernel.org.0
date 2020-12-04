Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182552CF253
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 17:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgLDQvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 11:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgLDQvQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Dec 2020 11:51:16 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sibi Sankar <sibis@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: qcom: fix rpmh link failures
Date:   Fri,  4 Dec 2020 17:50:03 +0100
Message-Id: <20201204165030.3747484-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_COMPILE_TEST is set, it is possible to build some
of the interconnect drivers into the kernel while their dependencies
are loadable modules, which is bad:

arm-linux-gnueabi-ld: drivers/interconnect/qcom/bcm-voter.o: in function `qcom_icc_bcm_voter_commit':
(.text+0x1f8): undefined reference to `rpmh_invalidate'
arm-linux-gnueabi-ld: (.text+0x20c): undefined reference to `rpmh_write_batch'
arm-linux-gnueabi-ld: (.text+0x2b0): undefined reference to `rpmh_write_batch'
arm-linux-gnueabi-ld: (.text+0x2e8): undefined reference to `rpmh_write_batch'
arm-linux-gnueabi-ld: drivers/interconnect/qcom/icc-rpmh.o: in function `qcom_icc_bcm_init':
(.text+0x2ac): undefined reference to `cmd_db_read_addr'
arm-linux-gnueabi-ld: (.text+0x2c8): undefined reference to `cmd_db_read_aux_data'

The exact dependencies are a bit complicated, so split them out into a
hidden Kconfig symbol that all drivers can in turn depend on to get it
right.

Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/interconnect/qcom/Kconfig | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index a8f93ba265f8..b3fb5b02bcf1 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -42,13 +42,23 @@ config INTERCONNECT_QCOM_QCS404
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
 	  platforms.
 
+config INTERCONNECT_QCOM_RPMH_POSSIBLE
+	tristate
+	default INTERCONNECT_QCOM
+	depends on QCOM_RPMH || (COMPILE_TEST && !QCOM_RPMH)
+	depends on QCOM_COMMAND_DB || (COMPILE_TEST && !QCOM_COMMAND_DB)
+	depends on OF || COMPILE_TEST
+	help
+	  Compile-testing RPMH drivers is possible on other platforms,
+	  but in order to avoid link failures, drivers must not be built-in
+	  when QCOM_RPMH or QCOM_COMMAND_DB are loadable modules
+
 config INTERCONNECT_QCOM_RPMH
 	tristate
 
 config INTERCONNECT_QCOM_SC7180
 	tristate "Qualcomm SC7180 interconnect driver"
-	depends on INTERCONNECT_QCOM
-	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -57,8 +67,7 @@ config INTERCONNECT_QCOM_SC7180
 
 config INTERCONNECT_QCOM_SDM845
 	tristate "Qualcomm SDM845 interconnect driver"
-	depends on INTERCONNECT_QCOM
-	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -67,8 +76,7 @@ config INTERCONNECT_QCOM_SDM845
 
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
-	depends on INTERCONNECT_QCOM
-	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -77,8 +85,7 @@ config INTERCONNECT_QCOM_SM8150
 
 config INTERCONNECT_QCOM_SM8250
 	tristate "Qualcomm SM8250 interconnect driver"
-	depends on INTERCONNECT_QCOM
-	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
-- 
2.27.0

