Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51552C1E6F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 07:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgKXGja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 01:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgKXGj3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 01:39:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB16C0613CF;
        Mon, 23 Nov 2020 22:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zaDovUSC7gRGubGzAVUJJyjyyB8/KDzwT5j5jjzxmlw=; b=YMJyPKJAUkXWeaesG+A2aW7cF+
        p9mjGfyHce1KZ4pyJx5IubMyw/Y9oNDverFOKbXbJcXsFmJ3Bsu5g2b6hwSJ/GQvzJVmRRrpYf88f
        kEQyV1863VUBchW3aKcspukfYlcZLI4jKSV/9ZajbBxFYR4GO1bngBn1xNinHH37//pynePe98YCj
        80pB41YMi2djnsZzb1Bx+3TxNHRy0wKadVTUHOMKoz7n1wcS6kaYOuXxqd7Y6L6Bj+k3kvasdwVvD
        yt0Pn0Gc838WeNBb6MiHoHYSHNDppyaIkh6BTe5khNDCMQOPrUfZgEn1sOaHBr7C7xLRVz55NZLvK
        Y2vZXqZA==;
Received: from [2601:1c0:6280:3f0::cc1f] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khRz4-0002B2-9B; Tue, 24 Nov 2020 06:39:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2] cpuidle: arm: qcom: fix Kconfig problems
Date:   Mon, 23 Nov 2020 22:39:19 -0800
Message-Id: <20201124063919.30243-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig symbol ARM_QCOM_SPM_CPUIDLE wildly selects other
Kconfig symbols when it should not.
This causes kconfig warnings and subsequent build errors,
as listed below, so modify this symbol's Kconfig entry to
constrain and tame it.

WARNING: unmet direct dependencies detected for QCOM_SCM
  Depends on [n]: ARM [=y] && HAVE_ARM_SMCCC [=n] || ARM64
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64

and

arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
(.text+0x68): undefined reference to `cpu_sa110_suspend_size'
arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
suspend.c:(.text+0x138): undefined reference to `cpu_sa110_do_suspend'
arm-linux-gnueabi-ld: suspend.c:(.text+0x170): undefined reference to `cpu_sa110_do_resume'
arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
qcom_scm-smc.c:(.text+0x54): undefined reference to `__arm_smccc_smc'
arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
qcom_scm-legacy.c:(.text+0x168): undefined reference to `__arm_smccc_smc'
arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
qcom_scm-legacy.c:(.text+0x2e0): undefined reference to `__arm_smccc_smc'

Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
---
v2: change to depends on QCOM_SCM (suggested by Bjorn)

 drivers/cpuidle/Kconfig.arm |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201123.orig/drivers/cpuidle/Kconfig.arm
+++ linux-next-20201123/drivers/cpuidle/Kconfig.arm
@@ -108,10 +108,10 @@ config ARM_TEGRA_CPUIDLE
 config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
 	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
+	depends on QCOM_SCM
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
-	select QCOM_SCM
 	help
 	  Select this to enable cpuidle for Qualcomm processors.
 	  The Subsystem Power Manager (SPM) controls low power modes for the
