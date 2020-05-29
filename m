Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9951E8881
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 22:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgE2UFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 16:05:45 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgE2UFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 16:05:45 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MV5nC-1jXVkY25l0-00S3kf; Fri, 29 May 2020 22:05:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle/firmware: qcom: fix smcc dependencies
Date:   Fri, 29 May 2020 22:04:53 +0200
Message-Id: <20200529200531.31738-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pIXF1xkXVTVFBDyEqcTIFQgUCSi0dC6StFHWCV7m9FMXRoiGaeT
 ZJJh7Ijz/XkAnssfaKOXaaAKXZ6EFNH10fWbZARu9gxcCFsr4GLd/UhWRve3RCCTZyNf+RS
 4NgUCqW/YhGpz+TmJiOjbXs0KLGIybhNYrXJ8CfivTL5bEwyV3Ig9kqozJ80C68AIOEaZUT
 L0qRp0hTu95Xmj9rXffDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q7DYwVUAYas=:fcAKWDbA6tZN1ckkwOCGDG
 mUt1yZCkCa7p3QlBzlYKZ+P/ZidmpiGo3c47Q0BoAGKCamyxZdXF/1MARJAXbpyvNXcxnobB0
 SwVOLUvnVbdaEG7FKQ1pbOR5laSFXOmdTacYbOeoicdFt9+PHZJLVMootmQgGwnDBQQZsFrDS
 wJALx2S4eTKMMzq/+5hTV7tiDEuIl4w1d3lgMo2X4RfTJaFGt/wHQCPf8KS8Wxo4MW0tlcnSc
 6SCffJLa2WJtYVQLjQNNtPjnsfTMtClwziADXXh+H5pVafl9YH2KMktZah+QHseWf9XXBktR8
 hY68ftvoz4Azu87IhraTiVbXbYBtDsxr7IS58VSIFf9aKt3LsiZxNF6iBh8p57UG3psUS98+G
 D93ZCB/cT3bvy3qOHKInx6ZAA33nt6Xi/F4qjom3Gn/LEsEd2LrKe3JUZFIXtfbyHf/tenCXY
 oZYYVaJ0781u6sUAC0/LGjlwB7r4KQ89Vsfn4RX9pYmYUFa2tEpm46h0N1vRfVbDFlfYHmVY2
 q12S/EERIKeXFlA9R+/nrGf+F5uQpnGwB8LzXtGdkLhVvg0czCoRSPG94kULWTXGtOO4Ti7n9
 kjjqlRno5xmbPNNMgCmpTfUYKAyNWxVfXd5w0mLyA/axBDzitNzFaKbZ6gXiFyjUWhNEQMSEp
 PRavV2sYxg1n94t0rXL436OP22euWlbr0bjeD4lvVyOK3iQxdmxTf6kuFyB5ey/knLbnDY99x
 tXhJE+f8l41Et4H+s1smB3XAnAEJpm4KZB5mPAd9iZFwyXmPzfRJXqhBgKailWk8oxIr2iG79
 MxMqrrgbKJFuA2fglLm7HnIXgVjXb+pfpscxKDWpAMQmkcE0xE=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Selecting QCOM_SCM for compile-tests is broken when the smcc firmware
is not provided:

drivers/firmware/qcom_scm-smc.o: in function `scm_smc_call':
qcom_scm-smc.c:(.text+0x110): undefined reference to `__arm_smccc_smc'
drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
qcom_scm-smc.c:(.text+0x1bc): undefined reference to `__arm_smccc_smc'

Add a Kconfig dependency for the QCOM_SCM to make it easier to catch
this, and fix the dependency for the newly added ARM_QCOM_SPM_CPUIDLE
symbol that triggered it this time.

Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
As the bug is currently only present in the cpuidle tree, can we
merge it through that?
---
 drivers/cpuidle/Kconfig.arm | 3 ++-
 drivers/firmware/Kconfig    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 51a7e89085c0..6cdcf5698c4c 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -97,7 +97,8 @@ config ARM_TEGRA_CPUIDLE
 
 config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
-	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
+	depends on ARCH_QCOM || (COMPILE_TEST && HAVE_ARM_SMCCC)
+	depends on ARM
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index fbd785dd0513..297bed30a632 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -238,6 +238,7 @@ config INTEL_STRATIX10_RSU
 config QCOM_SCM
 	bool
 	depends on ARM || ARM64
+	depends on HAVE_ARM_SMCCC
 	select RESET_CONTROLLER
 
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
-- 
2.26.2

