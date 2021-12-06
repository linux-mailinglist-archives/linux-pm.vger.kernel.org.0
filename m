Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE87C46910F
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 08:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhLFICJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Dec 2021 03:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbhLFICH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Dec 2021 03:02:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD121C061359
        for <linux-pm@vger.kernel.org>; Sun,  5 Dec 2021 23:58:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h24so7097774pjq.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Dec 2021 23:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VyhuPuo3Dr6FLX90Yql2n8R2Vy9SBLHywkAT4A3YPD8=;
        b=HLUZuFfIsWLv/iVa3/BaYyO+RmcLovtV6TM9aTnVUITCC6TEiM0lUFNrXqZWxILm01
         99JX5Xg8ZbHNBvdhLkRu3HNw1u2qOsd4oqevuFunbYQu71h0PXQEMEzu9k8dkOvvB73r
         u8B5hO9ldHmtVu/cJ96mbvZ4yqC9DNMULnoKOJiou/Cvqn488tm5OzqGSqVtJPH975kS
         I5KpfN4Qx/EwJBxtE7ReinUJQUlf4m6uzMpe2jW2EE7sWjoQYepto9f7Tg90lADYM/dS
         EsdxLIpnuZbcY/yiQOexsqyoCNnaLR8uYtTkjbMXjekmNiDn9nCokiKYuXlVnt2NOrJp
         XB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VyhuPuo3Dr6FLX90Yql2n8R2Vy9SBLHywkAT4A3YPD8=;
        b=MEvaVdjB3yDSzyfbqMplqzqHSFtepvVWzWy/53Xd4lkUlObNpnS6PTe/X/X+QqBJh7
         HI6v9yFzSHg3IoDWBv6l9xYLll82cRQyFwlWSeAMY7uukdDptKl1aDgd/conCzD0w84Y
         PT3VNpgnq/pvdJk2lQWjocTaYvx8Y9i3R6Tbw7Iqk6MDeKVWIk8uRI5S/RNA2M9xhyNC
         rG7bf5UNtfi72PekNbVsWpLYOuV1ees0JUoJv6ZUGJlI7iv/9gxvZlzV/NlQUcN5sUWS
         /BXQo/fdIxC687GG5EXWtxmRe55TZr1+pempnLgMksygNpbP7/ekgLnMSSABIeIKXNQc
         ginw==
X-Gm-Message-State: AOAM5333Uxz+/Y9Al8t59kq3mMtQ54GPzUeH70Ag8m7qRqiG3I28HdOI
        c+El+ACpl6kE2x2oGn3mf+AtYA==
X-Google-Smtp-Source: ABdhPJzgNpx/N7TJcWuoneXb1anHEXHMRGcKXIeCwXvI9mSDa+2d04t62sU9UVwUmBfaLgaZZKICbw==
X-Received: by 2002:a17:902:e294:b0:143:86a8:c56d with SMTP id o20-20020a170902e29400b0014386a8c56dmr41565823plc.22.1638777519271;
        Sun, 05 Dec 2021 23:58:39 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p15sm11794476pfo.143.2021.12.05.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:58:39 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 3/6] interconnect: icc-rpm: Add QNOC type QoS support
Date:   Mon,  6 Dec 2021 15:58:05 +0800
Message-Id: <20211206075808.18124-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211206075808.18124-1-shawn.guo@linaro.org>
References: <20211206075808.18124-1-shawn.guo@linaro.org>
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

