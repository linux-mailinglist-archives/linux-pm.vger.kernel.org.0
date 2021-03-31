Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E8C34FB48
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhCaIMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 04:12:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15051 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhCaILo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 04:11:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9Jqd2BcCzPmMW;
        Wed, 31 Mar 2021 16:09:01 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 16:11:30 +0800
From:   He Ying <heying24@huawei.com>
To:     <rjw@rjwysocki.net>, <daniel.lezcano@linaro.org>
CC:     <heying24@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration
Date:   Wed, 31 Mar 2021 04:11:28 -0400
Message-ID: <20210331081128.158113-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When CONFIG_ARM_QCOM_SPM_CPUIDLE is y and CONFIG_MMU is not set,
compiling errors are encountered as follows:

drivers/cpuidle/cpuidle-qcom-spm.o: In function `spm_dev_probe':
cpuidle-qcom-spm.c:(.text+0x140): undefined reference to `cpu_resume_arm'
cpuidle-qcom-spm.c:(.text+0x148): undefined reference to `cpu_resume_arm'

So, add dependency on MMU in ARM_QCOM_SPM_CPUIDLE configuration.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 0844fadc4be8..334f83e56120 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -107,7 +107,7 @@ config ARM_TEGRA_CPUIDLE
 
 config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
-	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
+	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
-- 
2.17.1

