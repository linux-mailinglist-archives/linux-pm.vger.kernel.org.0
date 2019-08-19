Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB391B82
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 05:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHSDeE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 23:34:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfHSDeE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Aug 2019 23:34:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 93D60F1F37B7C96B27CA;
        Mon, 19 Aug 2019 11:33:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 19 Aug 2019 11:33:51 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <agross@kernel.org>, <georgi.djakov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [PATCH v2 linux-next] qcom: qcs404: move COMPILE_TEST to INTERCONNECT_QCOM
Date:   Mon, 19 Aug 2019 11:37:47 +0800
Message-ID: <20190819033747.38339-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818010905.7AD602173B@mail.kernel.org>
References: <20190818010905.7AD602173B@mail.kernel.org>
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
Fix this by moving COMPILE_TEST from CONFIG_INTERCONNECT_QCOM_QCS404 to
CONFIG_INTERCONNECT_QCOM, qcom's interconnect drivers can be compiled on
different platform.

Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v2: change subject of patch, and move COMPILE_TEST to INTERCONNECT_QCOM.
 drivers/interconnect/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 339e8f1..7207248 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INTERCONNECT_QCOM
 	bool "Qualcomm Network-on-Chip interconnect drivers"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
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

