Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231EC464EA2
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 14:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhLANSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 08:18:16 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:19370 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349514AbhLANSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 08:18:02 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 08:18:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638364111;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=JnP/Wl21+4EvDLPKqREmvF/JLem8oluj3pulm3BeyTo=;
    b=KxB5czbB+L5BgYZcT+1sDJbBdjW3OwmWBLPkgSXAr2YeXJPbacIBlfOLeGesG7ANl9
    0aXDsfHGO4D/L/3lOxslnui6UiPMcMSQeJNRXaqAx1D1JQ+aty501kl8Yc2OMfYjTl1g
    4C6fqy0xB3qmIRmbJeJxqQ+cbEkfbhjp6SlcgEQ1SZJ47S1Ura2H7deMB7PVM4JjMm3d
    CthHD6o9HHVP+EIcyAZGWY8yc6J2aJxl+bsRJaLEtt84KaWDjSxXErhRGdz6rG3XEFb4
    lr0BR7GK1T4DCuLH8zPnYwsc3q6xloNXxm2uIuxOXi2bEAp8dyUA5+notV9suFr2IHXA
    YyLg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fyL2moo2"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id j03bcbxB1D8Vghm
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
Subject: [PATCH v3 2/4] firmware: qcom: scm: Simplify set_cold/warm_boot_addr()
Date:   Wed,  1 Dec 2021 14:05:03 +0100
Message-Id: <20211201130505.257379-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201130505.257379-1-stephan@gerhold.net>
References: <20211201130505.257379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The qcom_scm_set_cold/warm_boot_addr() implementations have a lot of
functionality that is actually not used.

For example, set_warm_boot_addr() caches the last used entry address
and skips making the SCM call when the entry address is unchanged.
But there is actually just a single call of qcom_scm_set_warm_boot_addr()
in the whole kernel tree, which always configures the entry address
to cpu_resume_arm().

Simplify this by having a single qcom_scm_set_boot_addr() function
for both cold and warm boot address. This is totally sufficient for
the functionality supported in the mainline tree.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/firmware/qcom_scm.c | 105 +++++++++---------------------------
 drivers/firmware/qcom_scm.h |   1 +
 2 files changed, 27 insertions(+), 79 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7db8066b19fd..e0fca80bf6fc 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -49,26 +49,12 @@ struct qcom_scm_mem_map_info {
 	__le64 mem_size;
 };
 
-#define QCOM_SCM_FLAG_COLDBOOT_CPU0	0x00
-#define QCOM_SCM_FLAG_COLDBOOT_CPU1	0x01
-#define QCOM_SCM_FLAG_COLDBOOT_CPU2	0x08
-#define QCOM_SCM_FLAG_COLDBOOT_CPU3	0x20
-
-#define QCOM_SCM_FLAG_WARMBOOT_CPU0	0x04
-#define QCOM_SCM_FLAG_WARMBOOT_CPU1	0x02
-#define QCOM_SCM_FLAG_WARMBOOT_CPU2	0x10
-#define QCOM_SCM_FLAG_WARMBOOT_CPU3	0x40
-
-struct qcom_scm_wb_entry {
-	int flag;
-	void *entry;
+/* Each bit configures cold/warm boot address for one of the 4 CPUs */
+static const u8 qcom_scm_cpu_cold_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
+	0, BIT(0), BIT(3), BIT(5)
 };
-
-static struct qcom_scm_wb_entry qcom_scm_wb[] = {
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU0 },
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU1 },
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU2 },
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU3 },
+static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
+	BIT(2), BIT(1), BIT(4), BIT(6)
 };
 
 static const char * const qcom_scm_convention_names[] = {
@@ -260,49 +246,41 @@ static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 	return ret ? false : !!res.result[0];
 }
 
-/**
- * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
- * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
- *
- * Set the Linux entry point for the SCM to transfer control to when coming
- * out of a power down. CPU power down may be executed on cpuidle or hotplug.
- */
-int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
+static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus,
+				  const u8 *cpu_bits)
 {
-	int ret;
-	int flags = 0;
 	int cpu;
+	unsigned int flags = 0;
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_BOOT,
 		.cmd = QCOM_SCM_BOOT_SET_ADDR,
 		.arginfo = QCOM_SCM_ARGS(2),
+		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	/*
-	 * Reassign only if we are switching from hotplug entry point
-	 * to cpuidle entry point or vice versa.
-	 */
 	for_each_cpu(cpu, cpus) {
-		if (entry == qcom_scm_wb[cpu].entry)
-			continue;
-		flags |= qcom_scm_wb[cpu].flag;
+		if (cpu >= QCOM_SCM_BOOT_MAX_CPUS)
+			return -EINVAL;
+		flags |= cpu_bits[cpu];
 	}
 
-	/* No change in entry function */
-	if (!flags)
-		return 0;
-
 	desc.args[0] = flags;
 	desc.args[1] = virt_to_phys(entry);
 
-	ret = qcom_scm_call(__scm->dev, &desc, NULL);
-	if (!ret) {
-		for_each_cpu(cpu, cpus)
-			qcom_scm_wb[cpu].entry = entry;
-	}
+	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
+}
 
-	return ret;
+/**
+ * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
+ * @entry: Entry point function for the cpus
+ * @cpus: The cpumask of cpus that will use the entry point
+ *
+ * Set the Linux entry point for the SCM to transfer control to when coming
+ * out of a power down. CPU power down may be executed on cpuidle or hotplug.
+ */
+int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
+{
+	return qcom_scm_set_boot_addr(entry, cpus, qcom_scm_cpu_warm_bits);
 }
 EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
 
@@ -310,41 +288,10 @@ EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
  * @entry: Entry point function for the cpus
  * @cpus: The cpumask of cpus that will use the entry point
- *
- * Set the cold boot address of the cpus. Any cpu outside the supported
- * range would be removed from the cpu present mask.
  */
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 {
-	int flags = 0;
-	int cpu;
-	int scm_cb_flags[] = {
-		QCOM_SCM_FLAG_COLDBOOT_CPU0,
-		QCOM_SCM_FLAG_COLDBOOT_CPU1,
-		QCOM_SCM_FLAG_COLDBOOT_CPU2,
-		QCOM_SCM_FLAG_COLDBOOT_CPU3,
-	};
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_ADDR,
-		.arginfo = QCOM_SCM_ARGS(2),
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-
-	if (!cpus || cpumask_empty(cpus))
-		return -EINVAL;
-
-	for_each_cpu(cpu, cpus) {
-		if (cpu < ARRAY_SIZE(scm_cb_flags))
-			flags |= scm_cb_flags[cpu];
-		else
-			set_cpu_present(cpu, false);
-	}
-
-	desc.args[0] = flags;
-	desc.args[1] = virt_to_phys(entry);
-
-	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
+	return qcom_scm_set_boot_addr(entry, cpus, qcom_scm_cpu_cold_bits);
 }
 EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
 
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index d92156ceb3ac..fd7d2a5f3e70 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
 #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
 #define QCOM_SCM_FLUSH_FLAG_MASK	0x3
+#define QCOM_SCM_BOOT_MAX_CPUS		4
 
 #define QCOM_SCM_SVC_PIL		0x02
 #define QCOM_SCM_PIL_PAS_INIT_IMAGE	0x01
-- 
2.34.1

