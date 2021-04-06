Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3023553F0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbhDFMdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 08:33:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15497 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbhDFMdn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 08:33:43 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF6Mb2GD5zwRMr;
        Tue,  6 Apr 2021 20:31:23 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 20:33:25 +0800
From:   He Ying <heying24@huawei.com>
To:     <rjw@rjwysocki.net>, <daniel.lezcano@linaro.org>
CC:     <heying24@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH resend] cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration
Date:   Tue, 6 Apr 2021 08:33:28 -0400
Message-ID: <20210406123328.92904-1-heying24@huawei.com>
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

Note that cpu_resume_arm is defined when MMU is set. So, add dependency
on MMU in ARM_QCOM_SPM_CPUIDLE configuration.

Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
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

