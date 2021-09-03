Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF83400844
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbhICXZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350757AbhICXZa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B1C061760
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g14so1162342ljk.5
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sghiWtzlQ2rh7GwVQZPgVNRESKtI3sTnOWU+E5ytGWY=;
        b=qel2ha5l98HDglOR7KVyNaIQV6oghHJprK7J0b/eW0gJALtdPnrjGtTZlaae1gL0U+
         zhc4+Bpv5EsP+88w9WMWAmKL7Gy5SmygUiImm/t2l3Vlb0G8UVSvlWi+MYAyyJSXEzxz
         L0GnP476/FNq2ItPdX4RpOVkl8BUtAZF/vXYJrJxALptUGVy9u8gJFa2aM9gx2bWD3Yn
         cvVxa1Ch1BcLswqrIiuhpuRHaA1cKQp30CBV/yUiANUPXalNBcsgVPimbRfFwg1iljM+
         8VVs9Ue0ACefayagCcPPvN5as6nNbHY/n/MaAnXEYtnNSMedS9P8tCkizqNR9YQ0Wlkr
         dehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sghiWtzlQ2rh7GwVQZPgVNRESKtI3sTnOWU+E5ytGWY=;
        b=pIc45oSsaMPlGglMZJN//gY2pD5IYZL8Wa+lhpSDaR+lFcmKyddmi6XVLTGJI3PgjT
         Ag18WP4v690cGPphfOsFGY/cvwFt2Sry1QxwxxOCLj9OTotBkeFjQcc3KXzg10cK8IVN
         /UvgNGNFayeBeKTtQ091jiUY8wrCP/AYxG6GaAvtdQnYjh+WpTFREkojNSShzbl2rvEj
         uu9FMedRQFEWxkBwt0OeUNU+YbnCvPUXIA1B4vuRdHE33kYFCY/ROvcJ4e9xdKvbFA0o
         YFjUa4KXlceuQAZ3OhnFBnhmag+EX8S2YfMC7v4qj2LMISnljbnNMrP4jrhmiQVhnt9+
         TUdw==
X-Gm-Message-State: AOAM532iROhnj94ZdMjhjz0fscCP115y/nzKdOYW+iDs0+G9RBNCEbFf
        QkKdfuSbkSczQDPebM1Av26+MA==
X-Google-Smtp-Source: ABdhPJz7hzfKas67Hx3clwBLUCMwQpaomk+7Uwg/sYd87Ekj8t6SP/fQP0iqQccJiOhLhmxPfAk5aQ==
X-Received: by 2002:a2e:991a:: with SMTP id v26mr987286lji.111.1630711468129;
        Fri, 03 Sep 2021 16:24:28 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 05/11] interconnect: icc-rpm: add support for QoS reg offset
Date:   Sat,  4 Sep 2021 02:24:15 +0300
Message-Id: <20210903232421.1384199-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
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
index b8bac738c64f..384b571fffec 100644
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
 
@@ -84,7 +84,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
 	 */
 	if (mode != NOC_QOS_MODE_BYPASS) {
 		for (i = 3; i >= 0; i--) {
-			rc = qcom_icc_bimc_set_qos_health(qp->regmap,
+			rc = qcom_icc_bimc_set_qos_health(qp,
 							  &qn->qos, i);
 			if (rc)
 				return rc;
@@ -94,11 +94,12 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
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
@@ -106,12 +107,14 @@ static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
 
 	/* Must be updated one at a time, P1 first, P0 last */
 	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
-	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+	rc = regmap_update_bits(qp->regmap,
+				qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
 				NOC_QOS_PRIORITY_P1_MASK, val);
 	if (rc)
 		return rc;
 
-	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+	return regmap_update_bits(qp->regmap,
+				  qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
 				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
 }
 
@@ -140,7 +143,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 	if (mode == NOC_QOS_MODE_FIXED) {
 		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
 			qn->name);
-		rc = qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
+		rc = qcom_icc_noc_set_qos_priority(qp, &qn->qos);
 		if (rc)
 			return rc;
 	} else if (mode == NOC_QOS_MODE_BYPASS) {
@@ -149,7 +152,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 	}
 
 	return regmap_update_bits(qp->regmap,
-				  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
+				  qp->qos_offset + NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
 				  NOC_QOS_MODEn_MASK, mode);
 }
 
@@ -305,6 +308,7 @@ int qnoc_probe(struct platform_device *pdev)
 	qp->num_clks = cd_num;
 
 	qp->is_bimc_node = desc->is_bimc_node;
+	qp->qos_offset = desc->qos_offset;
 
 	if (desc->regmap_cfg) {
 		struct resource *res;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 868585c80f38..f6746dabdf28 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -18,6 +18,7 @@
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @is_bimc_node: indicates whether to use bimc specific setting
+ * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
  */
 struct qcom_icc_provider {
@@ -25,6 +26,7 @@ struct qcom_icc_provider {
 	int num_clks;
 	bool is_bimc_node;
 	struct regmap *regmap;
+	unsigned int qos_offset;
 	struct clk_bulk_data bus_clks[];
 };
 
@@ -77,6 +79,7 @@ struct qcom_icc_desc {
 	size_t num_clocks;
 	bool is_bimc_node;
 	const struct regmap_config *regmap_cfg;
+	unsigned int qos_offset;
 };
 
 #define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
-- 
2.33.0

