Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298003BF9BF
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhGHMJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhGHMJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 08:09:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9236DC061765
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 05:06:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e14so5344071qkl.9
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQGpuidZdUasikHf00PLGKYSKqZHy4j8GAIbO90+W4o=;
        b=EeMhmCaAIr/9czG9mwQw1cX8BEIMJBOxtrklgp2vmLqHxW4WFjKaO5oRX2fRRIEvud
         79yf35tz3xB6GP4dhgUchQBVtw8bB/nI2uYQHH+oBuMZNJZq430HHDc838VFCtL7tXhq
         dOOIC4pMAqltXmT3im6gG8hf+vxl54X1NDis/R30UKUyvZNlk3aTq26AkWhm3EXfRVft
         ZjhUcS5sasTc2omgpm09W2NA+qTLbkkvbRA4/icgT/TctYfQ6w1/7mYtZs5xw5ZZb+94
         5IHRD3orgoNIzC5fxJj360M9TCKIkyLrdTbnRzpFF2M6Przi18H7PXSgUz+oqDP/4OwC
         k2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQGpuidZdUasikHf00PLGKYSKqZHy4j8GAIbO90+W4o=;
        b=PG185noWAkmt1v4LFNCpJ4y7Yv1f59j9jK5/ExGieffJL6WTeRWTz7NlZexTH0nhzB
         1S47CqT8d71cZkYyMJ+xI0FDRGpXIkqjhmTQcQe+mbTqFCh5iHmuCa65I0taLakZC/zH
         ziPNekVUSh2U0Tk7ArIRdgYeLgAwwdnHTbPTBRTNl4kaZ/RFn/Cq5WLX5znT6px3UJOs
         q18jcBFFN2li5WU4gUr/Fdh8+E74imP5T/1RUk9U4NjN9FGoZMCHnS23uCnql6RcK8Wn
         O4YA2n2xbB/gq1wTZUnqcd8Nr6GQtBgmrS6zVM4t4hlNZ4LyzLFx6GvRgpel7eFB5pj/
         rFQQ==
X-Gm-Message-State: AOAM532Wo/QD6e3iZT7lltGqw+mr6uN9zgTUmgcc6B1d043sAQoUPB+8
        zwcf2QQ1RCx9BPXZa4AzkNxNLA==
X-Google-Smtp-Source: ABdhPJztacltAD3advS9xNuN5o4JEk+5d6dMGikMfW15NDpsqcG4wW6VyNkUZO3VVlkvCw92eeQKfA==
X-Received: by 2002:a05:620a:31aa:: with SMTP id bi42mr30811000qkb.425.1625746018642;
        Thu, 08 Jul 2021 05:06:58 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i2sm912541qko.43.2021.07.08.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 05:06:58 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v3 1/6] firmware: qcom_scm: Introduce SCM calls to access LMh
Date:   Thu,  8 Jul 2021 08:06:51 -0400
Message-Id: <20210708120656.663851-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708120656.663851-1-thara.gopinath@linaro.org>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce SCM calls to access/configure limits management hardware(LMH).

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
index ee9cb545e73b..a8d236603e90 100644
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

