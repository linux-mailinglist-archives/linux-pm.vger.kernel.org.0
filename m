Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4E3A06D8
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 00:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFHWce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 18:32:34 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:36502 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhFHWcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 18:32:31 -0400
Received: by mail-qt1-f171.google.com with SMTP id r20so1235360qtp.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvNr0cURQ5TDqrTkg430MscO613gd9bfT50EURpL3BM=;
        b=iTRt/yLOjwIyBZ7rxne4pyfDmF7fNCafhlPIXasBUEQuXQCkItKNdHMc3IaYElhipB
         h+Xu0qQWmi6dD9j5ozTpy2X9cOKh4QhMzmzHy+O2i8K0RwGSZ3l5apqh78guv6sApjHy
         NPBwBWFH9Ab3BTEWLOlWIhfNQGaR7PN1c5fYc1YJYfPIb1unFReehNP0x7vcgh7JFVsM
         7Y6GvKRF48zjK38I/Q2bJeklbH7Uok8snL7VW2z3g+7vCLaAdixsYBtaK3/v0Ws/Ag0n
         8Tg0oh/iA8VKoRxR3nJjY+N8JtuTXjGs8CSzankRaXFOXQta4UJl/dRp5bPrbJe97gJY
         Yalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvNr0cURQ5TDqrTkg430MscO613gd9bfT50EURpL3BM=;
        b=lzfHF/eF8LAmQcBb1BTaTxdf5XrUqRrnKbT4WvlhBfiQFI4w1N0zFAAgAZMyf0ph9H
         O6maD+x3LWinUuhef9qiZySK2GRFI83hNblNnbFiwKA4O4kPb23gWdt77/kk9Ga6bVAn
         uKkS6W+2bG9U765HMjvAYGZ+xYODJ7KW4tkF8sikuAeCqv/+BxCblPpQNWICi+PyQ5yY
         14LXziCjPxN75b1OgA7CPuKrVx93Ba6S0bBDKT6pTmTxMEQGlEh6okpWef81R7LbaUeQ
         9skS/U9d14Rd363CiORwgsiamswQ4E+YWzsmQsOAYApmpw6mYNKQaajRIzfsF66gaJE6
         Y4oA==
X-Gm-Message-State: AOAM53317F7KTsvn8HkSvrriL+8JxNArk6q9iSnHUXSgZFEutcW8IpOx
        UtjqTASsLUJdgEPRy3yYIJY6URj2hipwM70I
X-Google-Smtp-Source: ABdhPJz9Zb4jsyx6xyqpWTFrCCanff8KX/HO2Z8iTX77W/bHbQOfuE9DgFjUcKaiXI4GsgUyn9BvUA==
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr5294678qta.253.1623191368819;
        Tue, 08 Jun 2021 15:29:28 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h19sm10450736qtq.5.2021.06.08.15.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:29:28 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/5] firmware: qcom_scm: Introduce SCM calls to access LMh
Date:   Tue,  8 Jun 2021 18:29:22 -0400
Message-Id: <20210608222926.2707768-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608222926.2707768-1-thara.gopinath@linaro.org>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce SCM calls to access/configure limits management hardware(LMh).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/firmware/qcom_scm.c | 47 +++++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h |  4 ++++
 include/linux/qcom_scm.h    | 13 ++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index ee9cb545e73b..0259e9ffb8a1 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1147,6 +1147,53 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
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
+int qcom_scm_lmh_dcvsh(u32 *payload, u32 payload_size, u64 limit_node, u32 node_id, u64 version)
+{
+	dma_addr_t payload_phys;
+	void *payload_buf;
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
+	memcpy(payload_buf, payload, payload_size);
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
index 0165824c5128..0c92197769e7 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -109,6 +109,12 @@ extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 			     u32 *resp);
 
 extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
+
+extern int qcom_scm_lmh_dcvsh(u32 *payload, u32 payload_size, u64 limit_node,
+			      u32 node_id, u64 version);
+extern int qcom_scm_lmh_profile_change(u32 profile_id);
+extern bool qcom_scm_lmh_dcvsh_available(void);
+
 #else
 
 #include <linux/errno.h>
@@ -170,5 +176,12 @@ static inline int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 
 static inline int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 		{ return -ENODEV; }
+
+int qcom_scm_lmh_dcvsh(u32 *payload, u32 payload_size, u64 limit_node,
+		       u32 node_id, u64 version)
+		{ return -ENODEV; }
+int qcom_scm_lmh_profile_change(u32 profile_id) { return -ENODEV; }
+
+bool qcom_scm_lmh_dcvsh_available(void) { return -ENODEV; }
 #endif
 #endif
-- 
2.25.1

