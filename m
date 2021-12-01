Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507F5464EA1
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbhLANSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 08:18:16 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:32356 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244614AbhLANR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 08:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638364112;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=e/hPvzPGZcI+sVgz2Roj2+S/UwQDvzs55NReIYR6KFc=;
    b=DoRcha2EIjcjpPjh8mVueOuUcRRg/8cJOinvrr4PBe7RYRWW6SrTwjg4O/VdPHGBqg
    0ywAL+ieALjHjnDe/lxrX1f7CaVnUEkfR5pnuMySGyCuCXp/jjWUBpB9BjbGt4tJuwFd
    C3OkVMNHM+AhpB0o9AQdSB+RGrVRsPMSKmeX7w2Uew9MB9Ktyz2HDObcctZ5Y2i7dPLH
    qotzU/Au4apmik1oe65hngeseQoKMbYIvS1gLbrsv3IdogXT/pT/UElng0X6AX3X9D1d
    GaDA0z70Ih1TP5ok5XuQ7Q0xPS7Jp9p7+y8UXCw6xKcEgLG3IrKJYuUbcj1cQnS56g2Z
    N1dA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fyL2moo2"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id j03bcbxB1D8Vghn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Dec 2021 14:08:31 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 3/4] firmware: qcom: scm: Drop cpumask parameter from set_boot_addr()
Date:   Wed,  1 Dec 2021 14:05:04 +0100
Message-Id: <20211201130505.257379-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201130505.257379-1-stephan@gerhold.net>
References: <20211201130505.257379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

qcom_scm_set_cold/warm_boot_addr() currently take a cpumask parameter,
but it's not very useful because at the end we always set the same entry
address for all CPUs. This also allows speeding up probe of
cpuidle-qcom-spm a bit because only one SCM call needs to be made to
the TrustZone firmware, instead of one per CPU.

The main reason for this change is that it allows implementing the
"multi-cluster" variant of the set_boot_addr() call more easily
without having to rely on functions that break in certain build
configurations or that are not exported to modules.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/mach-qcom/platsmp.c       |  3 +--
 drivers/cpuidle/cpuidle-qcom-spm.c |  8 ++++----
 drivers/firmware/qcom_scm.c        | 19 ++++++++-----------
 include/linux/qcom_scm.h           |  4 ++--
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 58a4228455ce..65a0d5ce2bb3 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -357,8 +357,7 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu;
 
-	if (qcom_scm_set_cold_boot_addr(secondary_startup_arm,
-					cpu_present_mask)) {
+	if (qcom_scm_set_cold_boot_addr(secondary_startup_arm)) {
 		for_each_present_cpu(cpu) {
 			if (cpu == smp_processor_id())
 				continue;
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 5f27dcc6c110..beedf22cbe78 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -122,10 +122,6 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 	if (ret <= 0)
 		return ret ? : -ENODEV;
 
-	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm, cpumask_of(cpu));
-	if (ret)
-		return ret;
-
 	return cpuidle_register(&data->cpuidle_driver, NULL);
 }
 
@@ -136,6 +132,10 @@ static int spm_cpuidle_drv_probe(struct platform_device *pdev)
 	if (!qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "set warm boot addr failed");
+
 	for_each_possible_cpu(cpu) {
 		ret = spm_cpuidle_register(&pdev->dev, cpu);
 		if (ret && ret != -ENODEV) {
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e0fca80bf6fc..e89be2f0cdec 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -246,8 +246,7 @@ static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 	return ret ? false : !!res.result[0];
 }
 
-static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus,
-				  const u8 *cpu_bits)
+static int qcom_scm_set_boot_addr(void *entry, const u8 *cpu_bits)
 {
 	int cpu;
 	unsigned int flags = 0;
@@ -258,7 +257,7 @@ static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	for_each_cpu(cpu, cpus) {
+	for_each_present_cpu(cpu) {
 		if (cpu >= QCOM_SCM_BOOT_MAX_CPUS)
 			return -EINVAL;
 		flags |= cpu_bits[cpu];
@@ -271,27 +270,25 @@ static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus,
 }
 
 /**
- * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
+ * qcom_scm_set_warm_boot_addr() - Set the warm boot address for all cpus
  * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
  *
  * Set the Linux entry point for the SCM to transfer control to when coming
  * out of a power down. CPU power down may be executed on cpuidle or hotplug.
  */
-int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
+int qcom_scm_set_warm_boot_addr(void *entry)
 {
-	return qcom_scm_set_boot_addr(entry, cpus, qcom_scm_cpu_warm_bits);
+	return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_warm_bits);
 }
 EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
 
 /**
- * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
+ * qcom_scm_set_cold_boot_addr() - Set the cold boot address for all cpus
  * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
  */
-int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
+int qcom_scm_set_cold_boot_addr(void *entry)
 {
-	return qcom_scm_set_boot_addr(entry, cpus, qcom_scm_cpu_cold_bits);
+	return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_cold_bits);
 }
 EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
 
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 81cad9e1e412..048d09e1965b 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -63,8 +63,8 @@ enum qcom_scm_ice_cipher {
 
 extern bool qcom_scm_is_available(void);
 
-extern int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
-extern int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus);
+extern int qcom_scm_set_cold_boot_addr(void *entry);
+extern int qcom_scm_set_warm_boot_addr(void *entry);
 extern void qcom_scm_cpu_power_down(u32 flags);
 extern int qcom_scm_set_remote_state(u32 state, u32 id);
 
-- 
2.34.1

