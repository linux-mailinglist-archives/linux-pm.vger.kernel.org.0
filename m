Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE34317B9
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhJRLsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRLsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B03C06161C
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 04:45:58 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:45:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4hPYSWJEBNhlpoSOOmZpKzqq1+a8XkVCCYcNcC9iJM=;
        b=l6YS3BoO+GrlZA/RqEhz2vEPAeKiFEiQGYH3mTlsgcBwydrWOnTdSVEkDmwV6YcC2ajdI0
        nnC1wPu0bliOJsVHK7nNrUixHbS/32kFB0CvfVLXpkQDxFeisFlqx0K5vFpVAodKv3O1RF
        gvh+Z5zSfv59FM8Ylu7+UzvgHt3Xarazg0JEOO4huLu9Cm0+tOQFFwZ/U/YVs4BJWjp/JZ
        foZxFEr9V4d+nSUohgnHwGfpXhnXDXuiwdVnqOrEqIXgMPnqb2AMIJ67Stvd4LnYk0hAzn
        UIYqVFuvziWylZtNCMoAtI1iskLU1wAb+2Cnfnr4mP52INzSdKvmoXcBLBNd0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4hPYSWJEBNhlpoSOOmZpKzqq1+a8XkVCCYcNcC9iJM=;
        b=jFqV7jzuqFEfS4Oem7fSRDnwK+7Uv3cnZdtFluyGG9CHcxsILSaVRE9DNtJ+582KDcn5L7
        gRzcDAeOYF00JgDw==
From:   "thermal-bot for Jackie Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/lmh: make QCOM_LMH
 depends on QCOM_SCM
Cc:     Jackie Liu <liuyun01@kylinos.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211009015853.3509559-1-liu.yun@linux.dev>
References: <20211009015853.3509559-1-liu.yun@linux.dev>
MIME-Version: 1.0
Message-ID: <163455755641.25758.10001373491710171733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9e5a4fb8423081d0efbf165c71c7f4abdf5f918c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9e5a4fb8423081d0efbf165c71c7f4abdf5f918c
Author:        Jackie Liu <liuyun01@kylinos.cn>
AuthorDate:    Sat, 09 Oct 2021 09:58:53 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Oct 2021 20:20:42 +02:00

thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM

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
Link: https://lore.kernel.org/r/20211009015853.3509559-1-liu.yun@linux.dev
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 7d942f7..bfd8894 100644
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
