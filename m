Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50084405936
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350026AbhIIOjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:39:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349847AbhIIOjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:39:47 -0400
Date:   Thu, 09 Sep 2021 14:38:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPj9RF9dWknZgw857UpddLNWG0Sbh4bc1DzlNc7XJng=;
        b=Ui7ZuD69GU4BAT+Ci5fiuS6lMxYX238NgC85nFkUxaDLYSYcLCP/2Hre4sRlHFiC5HXbH3
        8CUBtS9hryKj+V2jPYTqWXNP/ciOThIQgM4DHbQiDMyR63YWy+ZBo5abp3yC2ZZTX0j3mo
        JiDzS78rilNo2X3MUIjGq5qRgR5eBcXX5PBCqK6MpNBRwpJv/Ap6DFe3UOuhT7kDPkL49I
        atD1JwWFh/153uyOHxmF9Egd2NIyiAua0RlEYT9Zntuh0BupEMtujmPZPjC0+ASvqp5/p0
        oD1XLVzdzpVqSRMkLdaieV9ujAMPFEVWrrwpbU7Xvj+lNbnsHdYiPpsgN7COug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPj9RF9dWknZgw857UpddLNWG0Sbh4bc1DzlNc7XJng=;
        b=27COBVEp9qfriQgkmiw6DIGurVxegvQP0E5I5wIObE/B5U2sdDpjeZvrYFsuIuF2oIgduj
        05E2+onfaDl41bDg==
From:   "thermal-bot for Thara Gopinath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] firmware: qcom_scm: Introduce SCM calls to access LMh
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210809191605.3742979-2-thara.gopinath@linaro.org>
References: <20210809191605.3742979-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <163119831603.25758.5754093529075559015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     de3438c47a8ddc75548e62a03736a9321c2b7bac
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//de3438c47a8ddc75548e62a03736a9321c2b7bac
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Mon, 09 Aug 2021 15:15:59 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 Aug 2021 09:31:53 +02:00

firmware: qcom_scm: Introduce SCM calls to access LMh

Introduce SCM calls to access/configure limits management hardware(LMH).

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210809191605.3742979-2-thara.gopinath@linaro.org
---
 drivers/firmware/qcom_scm.c | 58 ++++++++++++++++++++++++++++++++++++-
 drivers/firmware/qcom_scm.h |  4 ++-
 include/linux/qcom_scm.h    | 14 +++++++++-
 3 files changed, 76 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 47ea2bd..8a50375 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1147,6 +1147,64 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 }
 EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
 
+bool qcom_scm_lmh_dcvsh_available(void)
+{
+	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_LMH, QCOM_SCM_LMH_LIMIT_DCVSH);
+}
+EXPORT_SYMBOL(qcom_scm_lmh_dcvsh_available);
+
+int qcom_scm_lmh_profile_change(u32 profile_id)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_LMH,
+		.cmd = QCOM_SCM_LMH_LIMIT_PROFILE_CHANGE,
+		.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL),
+		.args[0] = profile_id,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
+
+int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
+		       u64 limit_node, u32 node_id, u64 version)
+{
+	dma_addr_t payload_phys;
+	u32 *payload_buf;
+	int ret, payload_size = 5 * sizeof(u32);
+
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_LMH,
+		.cmd = QCOM_SCM_LMH_LIMIT_DCVSH,
+		.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_RO, QCOM_SCM_VAL, QCOM_SCM_VAL,
+					QCOM_SCM_VAL, QCOM_SCM_VAL),
+		.args[1] = payload_size,
+		.args[2] = limit_node,
+		.args[3] = node_id,
+		.args[4] = version,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
+	if (!payload_buf)
+		return -ENOMEM;
+
+	payload_buf[0] = payload_fn;
+	payload_buf[1] = 0;
+	payload_buf[2] = payload_reg;
+	payload_buf[3] = 1;
+	payload_buf[4] = payload_val;
+
+	desc.args[0] = payload_phys;
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+
+	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
+	return ret;
+}
+EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
+
 static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
 {
 	struct device_node *tcsr;
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 632fe31..d92156c 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -114,6 +114,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
 
+#define QCOM_SCM_SVC_LMH			0x13
+#define QCOM_SCM_LMH_LIMIT_PROFILE_CHANGE	0x01
+#define QCOM_SCM_LMH_LIMIT_DCVSH		0x10
+
 #define QCOM_SCM_SVC_SMMU_PROGRAM		0x15
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 0165824..c0475d1 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -109,6 +109,12 @@ extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 			     u32 *resp);
 
 extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
+
+extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
+			      u64 limit_node, u32 node_id, u64 version);
+extern int qcom_scm_lmh_profile_change(u32 profile_id);
+extern bool qcom_scm_lmh_dcvsh_available(void);
+
 #else
 
 #include <linux/errno.h>
@@ -170,5 +176,13 @@ static inline int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 
 static inline int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 		{ return -ENODEV; }
+
+static inline int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
+				     u64 limit_node, u32 node_id, u64 version)
+		{ return -ENODEV; }
+
+static inline int qcom_scm_lmh_profile_change(u32 profile_id) { return -ENODEV; }
+
+static inline bool qcom_scm_lmh_dcvsh_available(void) { return -ENODEV; }
 #endif
 #endif
