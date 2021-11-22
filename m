Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F320B458ACF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 09:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhKVIyt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 03:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbhKVIys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 03:54:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337BEC061748
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 00:51:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so14698323pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VyhuPuo3Dr6FLX90Yql2n8R2Vy9SBLHywkAT4A3YPD8=;
        b=d4MYj16tVcgrfBLMoDUp3X7CbZVY0nxFn/r4d1XcMN1Gu+Rh1jDER4Ke3WndkSZFjg
         OmT7xrKtuRswjfWicP8zt+uS3poyUK2xQO1+ijGER7WOx1CgVijU2/3hiGmoeMvmxBwF
         A3jS6UW8hE3mT9ebwbYSWjZzmovKvPhbpN8/iy1wSQ19zZIBERYkxiz08m4t1ekVs2XS
         cklCHc8TtM1xqcH4O5y9D9o57jnB2HdtLO5yjESOG4jsep88/f6ZEg4k4VTMwN7q1IWg
         HXJV2cA7Qu5piKdOBuL368vLVp2/gRkaQmd6as+J4731Lu4RR4KsInUsxY9Wx5OmY1/M
         6KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VyhuPuo3Dr6FLX90Yql2n8R2Vy9SBLHywkAT4A3YPD8=;
        b=y7OZ2Eom/ZGA9BIhgnHnJE0dtcFR7CE+qiTcWTB4pxohS4J3DQbnkbQy3EQ/KaBuiN
         yQxa+6c58rCr3sRELj0LxarIEarX06Ma0IQkUj6IWaVsLikOM6RWbs50d83CEsU2kXXE
         /Mo26tzoKUDUh+a4553JNOlt82Uj8CPBhsBo0w9zjVV7R3CAg3XzovVdRziQZmIY0pGg
         B6FmvbGos/n/uiAWWa+9cVZNM41EmI0bsXFpr98GglO3a3rEaqbhq6JPkAcgS8ThvVS8
         hZPq9zgoLCXWRMi+oxjn6FXAD7OlhzPXDV3nMy25C09sFB2nLkwsCNqdUsX3cmO8AAnY
         K8ug==
X-Gm-Message-State: AOAM532DENOFECVxpH9Dqnp+lJPrShwqyCfIrZszYNgOF4iY9vJPKhDf
        xE1YzbzM7Tl0/KGw57vSGG3pMw==
X-Google-Smtp-Source: ABdhPJx/d+8xRvw94Ekeyd7Hi6/f83hbMZhudPDlORZuVcl3lwSsaIZoWQoUI+P+4u9fvqHGoXgIwQ==
X-Received: by 2002:a17:902:f54f:b0:143:b899:a9ce with SMTP id h15-20020a170902f54f00b00143b899a9cemr91409382plf.28.1637571101760;
        Mon, 22 Nov 2021 00:51:41 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f8sm8445582pfv.135.2021.11.22.00.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 00:51:41 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 3/6] interconnect: icc-rpm: Add QNOC type QoS support
Date:   Mon, 22 Nov 2021 16:51:20 +0800
Message-Id: <20211122085123.21049-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122085123.21049-1-shawn.guo@linaro.org>
References: <20211122085123.21049-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It adds QoS support for QNOC type device which can be found on QCM2290
platform.  The downstream driver[1] includes support for priority,
limiter, regulator and forwarding setup.  As QCM2290 support only
requires priority and forwarding configuration, limiter and regulator
support are omitted for this initial submission.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.19/tree/drivers/soc/qcom/msm_bus/msm_bus_qnoc_adhoc.c?h=kernel.lnx.4.19.r22-rel

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 38 ++++++++++++++++++++++++++---
 drivers/interconnect/qcom/icc-rpm.h |  3 +++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 264a9399fb28..22a98c0b29af 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -17,6 +17,13 @@
 #include "smd-rpm.h"
 #include "icc-rpm.h"
 
+/* QNOC QoS */
+#define QNOC_QOS_MCTL_LOWn_ADDR(n)	(0x8 + (n * 0x1000))
+#define QNOC_QOS_MCTL_DFLT_PRIO_MASK	0x70
+#define QNOC_QOS_MCTL_DFLT_PRIO_SHIFT	4
+#define QNOC_QOS_MCTL_URGFWD_EN_MASK	0x8
+#define QNOC_QOS_MCTL_URGFWD_EN_SHIFT	3
+
 /* BIMC QoS */
 #define M_BKE_REG_BASE(n)		(0x300 + (0x4000 * n))
 #define M_BKE_EN_ADDR(n)		(M_BKE_REG_BASE(n))
@@ -39,6 +46,27 @@
 #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
 #define NOC_QOS_MODEn_MASK		0x3
 
+static int qcom_icc_set_qnoc_qos(struct icc_node *src, u64 max_bw)
+{
+	struct icc_provider *provider = src->provider;
+	struct qcom_icc_provider *qp = to_qcom_provider(provider);
+	struct qcom_icc_node *qn = src->data;
+	struct qcom_icc_qos *qos = &qn->qos;
+	int rc;
+
+	rc = regmap_update_bits(qp->regmap,
+			qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+			QNOC_QOS_MCTL_DFLT_PRIO_MASK,
+			qos->areq_prio << QNOC_QOS_MCTL_DFLT_PRIO_SHIFT);
+	if (rc)
+		return rc;
+
+	return regmap_update_bits(qp->regmap,
+			qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+			QNOC_QOS_MCTL_URGFWD_EN_MASK,
+			!!qos->urg_fwd_en << QNOC_QOS_MCTL_URGFWD_EN_SHIFT);
+}
+
 static int qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
 					struct qcom_icc_qos *qos,
 					int regnum)
@@ -163,10 +191,14 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
 
 	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
 
-	if (qp->type == QCOM_ICC_BIMC)
+	switch (qp->type) {
+	case QCOM_ICC_BIMC:
 		return qcom_icc_set_bimc_qos(node, sum_bw);
-
-	return qcom_icc_set_noc_qos(node, sum_bw);
+	case QCOM_ICC_QNOC:
+		return qcom_icc_set_qnoc_qos(node, sum_bw);
+	default:
+		return qcom_icc_set_noc_qos(node, sum_bw);
+	}
 }
 
 static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d8e77ce7fe06..66ce908a6e65 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -15,6 +15,7 @@
 enum qcom_icc_type {
 	QCOM_ICC_NOC,
 	QCOM_ICC_BIMC,
+	QCOM_ICC_QNOC,
 };
 
 /**
@@ -43,6 +44,7 @@ struct qcom_icc_provider {
  * @ap_owned: indicates if the node is owned by the AP or by the RPM
  * @qos_mode: default qos mode for this node
  * @qos_port: qos port number for finding qos registers of this node
+ * @urg_fwd_en: enable urgent forwarding
  */
 struct qcom_icc_qos {
 	u32 areq_prio;
@@ -51,6 +53,7 @@ struct qcom_icc_qos {
 	bool ap_owned;
 	int qos_mode;
 	int qos_port;
+	bool urg_fwd_en;
 };
 
 /**
-- 
2.17.1

