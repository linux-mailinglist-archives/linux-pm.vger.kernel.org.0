Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908A5464EA0
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 14:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbhLANSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 08:18:16 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:10385 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349530AbhLANR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 08:17:58 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 08:17:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638364112;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rFXIorNh5oBlYtvbj4+okXJBlT5MTSDKjJOgJyvnjT8=;
    b=Iyqro4gziV2dvOcOqkcjNsQSzQYiSfmEcuV858zuA/qa4PgPl6cpIbzv0kwINCGyt5
    8cU8LepMGYLyMRriFWDPDNWIOezBjjFoVBc7FsWCXc8OQqpin52dAoiJmWvkcNf76dn+
    twdMiFxDSl9rXkY0vqIKkjuTy6eRT0j8GoDE3DRyKUo4dkVBuyhijyuW2jsAWwhlQbHw
    QYPFU0iB31eYbiUg3ZuHUMPzK+6nJGy6oYpLMUnA8hWAaopxnOd+Y1ADJmvS+mdRVugr
    hlcuZsDnTgj3YuXqnRjPqDEQ5LnNBRVTrRCThvzLbFT0Y7x2wcqCxC6ttqt+2q6aua8w
    lXuw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fyL2moo2"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id j03bcbxB1D8Wgho
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Dec 2021 14:08:32 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 4/4] firmware: qcom: scm: Add support for MC boot address API
Date:   Wed,  1 Dec 2021 14:05:05 +0100
Message-Id: <20211201130505.257379-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201130505.257379-1-stephan@gerhold.net>
References: <20211201130505.257379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It looks like the old QCOM_SCM_BOOT_SET_ADDR API is broken on some
MSM8916 firmware versions that implement the newer SMC32 calling
convention. It just returns -EINVAL no matter which arguments are
being passed.

This does not cause any problems downstream because it first tries
to use the new multi-cluster API replacement which is working fine.

Implement support for the multi-cluster variant of the SCM call
by attempting it first but still fallback to the old call in case
of an error. Also, to be absolutely sure only use the multi-cluster
variant with the SMC calling convention since older platforms should
not need this.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3:
  - Avoid all build testing problems by setting the entry address for
    all CPUs in all affinity levels (~0ULL).
---
 drivers/firmware/qcom_scm.c | 32 ++++++++++++++++++++++++++++++--
 drivers/firmware/qcom_scm.h |  4 ++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e89be2f0cdec..7c50169f6465 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -269,6 +269,28 @@ static int qcom_scm_set_boot_addr(void *entry, const u8 *cpu_bits)
 	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
 
+static int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_ADDR_MC,
+		.owner = ARM_SMCCC_OWNER_SIP,
+		.arginfo = QCOM_SCM_ARGS(6),
+		.args = {
+			virt_to_phys(entry),
+			/* Apply to all CPUs in all affinity levels */
+			~0ULL, ~0ULL, ~0ULL, ~0ULL,
+			flags,
+		},
+	};
+
+	/* Need a device for DMA of the additional arguments */
+	if (!__scm || __get_convention() == SMC_CONVENTION_LEGACY)
+		return -EOPNOTSUPP;
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+
 /**
  * qcom_scm_set_warm_boot_addr() - Set the warm boot address for all cpus
  * @entry: Entry point function for the cpus
@@ -278,7 +300,10 @@ static int qcom_scm_set_boot_addr(void *entry, const u8 *cpu_bits)
  */
 int qcom_scm_set_warm_boot_addr(void *entry)
 {
-	return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_warm_bits);
+	if (qcom_scm_set_boot_addr_mc(entry, QCOM_SCM_BOOT_MC_FLAG_WARMBOOT))
+		/* Fallback to old SCM call */
+		return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_warm_bits);
+	return 0;
 }
 EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
 
@@ -288,7 +313,10 @@ EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
  */
 int qcom_scm_set_cold_boot_addr(void *entry)
 {
-	return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_cold_bits);
+	if (qcom_scm_set_boot_addr_mc(entry, QCOM_SCM_BOOT_MC_FLAG_COLDBOOT))
+		/* Fallback to old SCM call */
+		return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_cold_bits);
+	return 0;
 }
 EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
 
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index fd7d2a5f3e70..83d6885fb71c 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -78,9 +78,13 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
 #define QCOM_SCM_BOOT_TERMINATE_PC	0x02
 #define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
+#define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
 #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
 #define QCOM_SCM_FLUSH_FLAG_MASK	0x3
 #define QCOM_SCM_BOOT_MAX_CPUS		4
+#define QCOM_SCM_BOOT_MC_FLAG_AARCH64	BIT(0)
+#define QCOM_SCM_BOOT_MC_FLAG_COLDBOOT	BIT(1)
+#define QCOM_SCM_BOOT_MC_FLAG_WARMBOOT	BIT(2)
 
 #define QCOM_SCM_SVC_PIL		0x02
 #define QCOM_SCM_PIL_PAS_INIT_IMAGE	0x01
-- 
2.34.1

