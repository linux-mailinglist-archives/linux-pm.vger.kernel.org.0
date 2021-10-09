Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD70427586
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhJICBS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 22:01:18 -0400
Received: from out0.migadu.com ([94.23.1.103]:31069 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhJICBS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Oct 2021 22:01:18 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633744760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=baOU4ubE+z8CrjkNOJZM7ZxznBxnXbIcqBgb2zvXCKg=;
        b=o0tVxIk9anefKhd/FyfM/JskNJoc+37gCtk4dW6MMKjB0a8hOlulAkx4eGCmoAyKMFk7+8
        ycYzxfXRxvp2ajFOUjaWBPtqnvzQj/ouY0xCtPKXrDQI/SHkCUYzDHmrJ3jjBgb7UMNywS
        TTGvIYuueKTKHYxo2PnbUCGyMtpYg88=
From:   Jackie Liu <liu.yun@linux.dev>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liu.yun@linux.dev
Subject: [PATCH] thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM
Date:   Sat,  9 Oct 2021 09:58:53 +0800
Message-Id: <20211009015853.3509559-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Without QCOM_SCM, build failed, avoid like below:

aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
aarch64-linux-gnu-ld: drivers/thermal/qcom/lmh.o: in function `lmh_probe':
/data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:141: undefined reference to `qcom_scm_lmh_dcvsh_available'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:144: undefined reference to `qcom_scm_lmh_dcvsh'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:149: undefined reference to `qcom_scm_lmh_dcvsh'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:154: undefined reference to `qcom_scm_lmh_dcvsh'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:159: undefined reference to `qcom_scm_lmh_dcvsh'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:166: undefined reference to `qcom_scm_lmh_profile_change'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:173: undefined reference to `qcom_scm_lmh_dcvsh'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:180: undefined reference to `qcom_scm_lmh_dcvsh'
aarch64-linux-gnu-ld: /data/arm/workspace/kernel-build/linux/build/../drivers/thermal/qcom/lmh.c:187: undefined reference to `qcom_scm_lmh_dcvsh'
make[1]: *** [/data/arm/workspace/kernel-build/linux/Makefile:1183: vmlinux] Error 1
make[1]: Leaving directory '/data/arm/workspace/kernel-build/linux/build'
make: *** [Makefile:219: __sub-make] Error 2
make: Leaving directory '/data/arm/workspace/kernel-build/linux'

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/thermal/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 7d942f71e532..bfd889422dd3 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -34,7 +34,7 @@ config QCOM_SPMI_TEMP_ALARM
 
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM && QCOM_SCM
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
-- 
2.25.1

