Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148263E4CCB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhHITQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhHITQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 15:16:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A4C061798
        for <linux-pm@vger.kernel.org>; Mon,  9 Aug 2021 12:16:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z24so13418031qtn.8
        for <linux-pm@vger.kernel.org>; Mon, 09 Aug 2021 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jCUn04Uy/5nEhUoONzVloyladnaZ3tCplSZNJCiC434=;
        b=PfKTTaJAJJZ2D4KXZhWvd4vKnqpucY/bQjwfimMNiABMITFlT+4h2MrxLamSOR/qc/
         XDNtHmk8vjjCnsQAjr5vXmkdTw14nNEXrXQJE6qBlw+3AYcqtny3VZ7+AiCcXrYsdlBM
         WYBpCWRPMH7GBHCNGSfnJA6sISm25CnRFCniQSaMAOJWTyhin3/R1z2MR6Mb5HpADQZN
         rkKg2AnFkSTS/OKte9OOmdGAhdQy76cxs7QK5FygYcO1JmB3FzHis4bc0BuM7NQp9R9C
         MJKz5fRsZcX/6FeYk5f6YVL0gx7pDt5QyOEHIoOohs64dyfxaurKVDU4ZwPZvDDnHKYc
         60ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCUn04Uy/5nEhUoONzVloyladnaZ3tCplSZNJCiC434=;
        b=sObPjLEzmXYj/+rmJzXNDz4UdCVOM4QUVkd2vdiz/7wlxYQ/a45xEM2m7Lj9uLTT7a
         pBjNXa2pv94KHf1NOZtp4Uog5jSuqiu7OHcXgbghLGTOEhosXpcC4wcg6GpKko9stenk
         uUDI5ZA7F2SPqFP5XyAJ4srAmySovzprJSO6gnT+eNZG5s8/K29xnBcPeYKf2XAdmfss
         NwArG7y9TVaQN10Rt00R3DtvC3BH0OqdeHFCg41H1ygDDQ+stm7ijYl9r087dmCZw6sF
         vw1Cz0fxBtjZVdXzNAAd79VrmHvi1yI0ZYPqNZ1Kim8QrdYys4lIOGfFYdI0EcvBeTSj
         kvpQ==
X-Gm-Message-State: AOAM530XDCd8KSLKfxTYCOeFtDuIi/uvZP1fxP3d0XC9ZGgukMWmGByX
        TW0QJuJYE/6vJ1ITHKDuA98R4g==
X-Google-Smtp-Source: ABdhPJyYrBFlubKsm4LysukWo59AZFPq48z6MW4nQhQbxtg2K05KEGkyV1+pvNJ8XuZ07uIOGB2brA==
X-Received: by 2002:aed:279e:: with SMTP id a30mr21429912qtd.300.1628536567899;
        Mon, 09 Aug 2021 12:16:07 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id n14sm7303398qti.47.2021.08.09.12.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:16:07 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v5 1/6] firmware: qcom_scm: Introduce SCM calls to access LMh
Date:   Mon,  9 Aug 2021 15:15:59 -0400
Message-Id: <20210809191605.3742979-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809191605.3742979-1-thara.gopinath@linaro.org>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce SCM calls to access/configure limits management hardware(LMH).

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v2->v3:
	Added freeing of payload_buf after the scm call in qcom_scm_lmh_dcvsh as per
	Matthias review comments.

v1->v2:
	Changed the input parameters in qcom_scm_lmh_dcvsh from payload_buf and
	payload_size to payload_fn, payload_reg, payload_val as per Bjorn's review
	comments.

 drivers/firmware/qcom_scm.c | 58 +++++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h |  4 +++
 include/linux/qcom_scm.h    | 14 +++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 47ea2bd42b10..8a503753fe2a 100644
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
index 632fe3142462..d92156ceb3ac 100644
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
index 0165824c5128..c0475d1c9885 100644
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
-- 
2.25.1

