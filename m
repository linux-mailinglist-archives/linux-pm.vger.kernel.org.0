Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D758E5AF
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfHOHo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 03:44:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfHOHo7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Aug 2019 03:44:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7EA442442DD3B4FC2EE7;
        Thu, 15 Aug 2019 15:44:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 15 Aug 2019 15:44:44 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <agross@kernel.org>, <georgi.djakov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [PATCH linux-next] qcom: qcs404: remove COMPILE_TEST from CONFIG_INTERCONNECT_QCOM_QCS404
Date:   Thu, 15 Aug 2019 15:48:48 +0800
Message-ID: <20190815074848.195806-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is one compilation error when CONFIG_INTERCONNECT_QCOM_QCS404=y and
CONFIG_INTERCONNECT_QCOM_SMD_RPM=y, as well as CONFIG_COMPILE_TEST=y,
but CONFIG_QCOM_SMD_RPM is not set, logs as below:

drivers/interconnect/qcom/smd-rpm.o: In function `qcom_icc_rpm_smd_send':
smd-rpm.c:(.text+0xe4): undefined reference to `qcom_rpm_smd_write'
Makefile:1071: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

This is because
INTERCONNECT_QCOM_QCS404 depends on QCOM_SMD_RPM || COMPILE_TEST.
Here CONFIG_COMPILE_TEST=y, so CONFIG_INTERCONNECT_QCOM_SMD_RPM
is selected. If CONFIG_QCOM_SMD_RPM is not set, then
qcom_rpm_smd_write() is not defined, and compilation error happen.
Fix this by removing COMPILE_TEST from CONFIG_INTERCONNECT_QCOM_QCS404.

Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/interconnect/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 339e8f1..6ab4012 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -8,7 +8,7 @@ config INTERCONNECT_QCOM
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
-	depends on QCOM_SMD_RPM || COMPILE_TEST
+	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
-- 
2.7.4

