Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66073EF7BD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhHRB6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 21:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhHRB6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 21:58:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74151C06179A
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w4so610674ljh.13
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPDkHm/sSY6oMpp0SW+v38yesloXrz9EOKtY0O2mIRY=;
        b=fJxbVHrdNkCd6HEEb68qF/JKgHSF3xoIFBaQpc8Atr2qWh51nKsK2aEGcjMbC1zHZ0
         3P18jIFwQ4vrUMsSgzl5VSjjBoBo/7gEkZSGjRUagw2NGFYfQ7z6Fvt+Gn0m41iSR8fJ
         BXc7NNBS8G+DxaVxvQmN0G+NfqR2fok+09kDhpYsfCP4p6+lptXq5YpXhucCmndt1LFL
         rHT/KHkAV+p4yyXjUprWZy6MPS3eB5s0hMPQvTEhzDjd6aBVjfuD5BC1loHC5N1JSREn
         WUoSPmReoU+5kA5nKwAVgOxbPsrWai2ND/FzqCqobmT/qOIhDhwc3tWgjlTeqPQYi3J2
         4YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPDkHm/sSY6oMpp0SW+v38yesloXrz9EOKtY0O2mIRY=;
        b=M8n4cdhqJm9Kg2azNYEKHDY7iH9QdKAsbrnYBGjQOo2m9DLnVItk0Zu8E+S7JknrBy
         b8/+d7JE1vjo0ibbhialZLfuAkqbbehBT2rISdCve14LJschdYNlhX1rCTC5sbE2Amva
         zX4Gnm694wc7eKYhfP7Pqv9/haLXmrC2CWmzxS3kAeloF35ERTds3lU3JuA50XGNRdBr
         DRCNG/Am67V79uxV6th5ezWUYruwaY+6Eb/Hf57GGWn8zSJzTGy1qufmmtgnMYGEatzP
         ivbAFJmAYICHaomvlfeX9Z2Yd3ouVe0rSIElXjpu8i78R/Wa14vqihl1bsuh5pMwCsTx
         tHpQ==
X-Gm-Message-State: AOAM532WdY7ykokLsXZEojGpf1K4LSMF91V4gbi1ZC/PBFGH88jfo4j1
        zmHJ3DHtjSYnDvYIZvnYvAT1xisX9AhkSw==
X-Google-Smtp-Source: ABdhPJzA5dStKJMkQEsQmpAuwf+XOn2MrhU65RKi7NKyQsgRNZ0j6X1u+v5sIhsztpfwqnV737+HqA==
X-Received: by 2002:a05:651c:1143:: with SMTP id h3mr5705509ljo.300.1629251856797;
        Tue, 17 Aug 2021 18:57:36 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y8sm349500lfh.249.2021.08.17.18.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:57:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/5] interconnect: icc-rpm: add support for QoS reg offset
Date:   Wed, 18 Aug 2021 04:57:30 +0300
Message-Id: <20210818015732.1717810-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
References: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SDM660 driver expects to have QoS registers at the beginning of NoC
address space (sdm660 platform shifts NoC base address). Add support for
using QoS register offset, so that other platforms do not have to change
existing device trees.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 24 ++++++++++++++----------
 drivers/interconnect/qcom/icc-rpm.h |  3 +++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 05130e74364a..ea41783456b0 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -39,7 +39,7 @@
 #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
 #define NOC_QOS_MODEn_MASK		0x3
 
-static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
+static int qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
 					struct qcom_icc_qos *qos,
 					int regnum)
 {
@@ -58,8 +58,8 @@ static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
 		mask |= M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
 	}
 
-	return regmap_update_bits(rmap,
-				  M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
+	return regmap_update_bits(qp->regmap,
+				  qp->qos_offset + M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
 				  mask, val);
 }
 
@@ -85,7 +85,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
 	 */
 	if (mode != NOC_QOS_MODE_BYPASS) {
 		for (i = 3; i >= 0; i--) {
-			rc = qcom_icc_bimc_set_qos_health(qp->regmap,
+			rc = qcom_icc_bimc_set_qos_health(qp,
 							  &qn->qos, i);
 			if (rc)
 				return rc;
@@ -95,11 +95,12 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
 		val = 1;
 	}
 
-	return regmap_update_bits(qp->regmap, M_BKE_EN_ADDR(qn->qos.qos_port),
+	return regmap_update_bits(qp->regmap,
+				  qp->qos_offset + M_BKE_EN_ADDR(qn->qos.qos_port),
 				  M_BKE_EN_EN_BMASK, val);
 }
 
-static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
+static int qcom_icc_noc_set_qos_priority(struct qcom_icc_provider *qp,
 					 struct qcom_icc_qos *qos)
 {
 	u32 val;
@@ -107,13 +108,15 @@ static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
 
 	/* Must be updated one at a time, P1 first, P0 last */
 	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
-	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+	rc = regmap_update_bits(qp->regmap,
+				qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
 				NOC_QOS_PRIORITY_MASK, val);
 	if (rc)
 		return rc;
 
 	val = qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
-	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+	return regmap_update_bits(qp->regmap,
+				  qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
 				  NOC_QOS_PRIORITY_MASK, val);
 }
 
@@ -142,7 +145,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 	if (mode == NOC_QOS_MODE_FIXED) {
 		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
 			qn->name);
-		rc = qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
+		rc = qcom_icc_noc_set_qos_priority(qp, &qn->qos);
 		if (rc)
 			return rc;
 	} else if (mode == NOC_QOS_MODE_BYPASS) {
@@ -151,7 +154,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 	}
 
 	return regmap_update_bits(qp->regmap,
-				  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
+				  qp->qos_offset + NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
 				  NOC_QOS_MODEn_MASK, mode);
 }
 
@@ -312,6 +315,7 @@ int qnoc_probe(struct platform_device *pdev)
 	qp->num_clks = cd_num;
 
 	qp->is_bimc_node = desc->is_bimc_node;
+	qp->qos_offset = desc->qos_offset;
 
 	if (desc->regmap_cfg) {
 		struct resource *res;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 3cb57d8a20e6..47070520fb08 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -20,6 +20,7 @@
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @is_bimc_node: indicates whether to use bimc specific setting
+ * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
  */
 struct qcom_icc_provider {
@@ -27,6 +28,7 @@ struct qcom_icc_provider {
 	int num_clks;
 	bool is_bimc_node;
 	struct regmap *regmap;
+	unsigned int qos_offset;
 	struct clk_bulk_data bus_clks[];
 };
 
@@ -78,6 +80,7 @@ struct qcom_icc_desc {
 	bool is_bimc_node;
 	bool has_iface_clk;
 	const struct regmap_config *regmap_cfg;
+	unsigned int qos_offset;
 };
 
 #define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
-- 
2.32.0

