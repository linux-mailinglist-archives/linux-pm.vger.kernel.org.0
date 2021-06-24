Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684EA3B2E45
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFXMAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 08:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFXMAf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 08:00:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F7C061574
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 04:58:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x21so4544404qtq.9
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eijKYTcdSgjUORNbFd3aQ96Ibey7LIG8Pwg8gaFrgAg=;
        b=JgMRZ1otbqrdr8v6RfG1O5qyiq+sc/UK6pR7wktlQI21P6U9Ot2ebbXpqyOfCswpXD
         vHnOrJq457FEZWbAPtRUd+0QxMYhptRZiNfxVN6WduYqUiNkjrraOj8V/VODKYnMfx7x
         UfS82fN7N2sE+mFkuiJQwL75JYtbA6JksESv3uMIQjW7zSgfAUKNwkGaoESy2x9yuu8N
         nLu0sXn9yBfr3QdST/FrJeuxBaM8SYzPjuFi7DgFg6dlsuBDJdPJgBlR3f+Dz52+qbUK
         pOLofkEx/PZ6MpDUCwec4rDfH9YKzJQIFIYr/xvdBa+SCqbqzUDrl99G966QjMJOtJ1H
         L2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eijKYTcdSgjUORNbFd3aQ96Ibey7LIG8Pwg8gaFrgAg=;
        b=IzUblUQ0WeMxEkJIkAeVoWccmPnpR9qscqGeSM/5FYVJYYALZod1YNqIyxJTFHqGY+
         cjTSSA2ejv8oeVfT2mx93OOw+yBRJ0icIc71GtT/XLj/WqFMu7OoFkB/ll8RYeEHRYxf
         J83qmjrAeINJC7DWOswnC+if/sqHaoqwKD7rSjvri/bjhsWjtqqAwneSodwWacUVOluZ
         HF1cpUzmA4e+enDawcVhZtCpG1JSe0un2RGGW2KoqZEaygk2Z/bj2w6/nzWiGs1PJA/O
         G0pch3LZ//wPbJa4cjetiYlFDUvW++r8qrjXTrnLC3Po39uI8vxu84GMHzQL2aB85TPs
         Py3Q==
X-Gm-Message-State: AOAM530cF9Asrd00KZE1BVXRLpZzRaq/7jgK7UpQyB2ENWhwP+lCTj4P
        FDr5PzTfxFq7vXqxoYwXrjg7bg==
X-Google-Smtp-Source: ABdhPJwGJ5iiNXEz9a2oX13W4as921cItoqK86UfVS7Fxq0F+btKX647Rjq10yY2LWlUAxolUDcpng==
X-Received: by 2002:ac8:7699:: with SMTP id g25mr4231845qtr.309.1624535896000;
        Thu, 24 Jun 2021 04:58:16 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id w3sm2287173qkp.55.2021.06.24.04.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 04:58:15 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v2 1/5] firmware: qcom_scm: Introduce SCM calls to access LMh
Date:   Thu, 24 Jun 2021 07:58:09 -0400
Message-Id: <20210624115813.3613290-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624115813.3613290-1-thara.gopinath@linaro.org>
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce SCM calls to access/configure limits management hardware(LMH).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v1->v2:
	Changed the input parameters in qcom_scm_lmh_dcvsh from payload_buf and
	payload_size to payload_fn, payload_reg, payload_val as per Bjorn's review
	comments.

 drivers/firmware/qcom_scm.c | 54 +++++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h |  4 +++
 include/linux/qcom_scm.h    | 14 ++++++++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index ee9cb545e73b..19e9fb91d084 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1147,6 +1147,60 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
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
+	int payload_size = 5 * sizeof(u32);
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
+	return qcom_scm_call(__scm->dev, &desc, NULL);
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

