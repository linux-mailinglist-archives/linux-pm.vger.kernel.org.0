Return-Path: <linux-pm+bounces-30171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E7AF98F8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F5B4A246B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFDE2E2C80;
	Fri,  4 Jul 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAwyvXrQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CB2D839C
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646991; cv=none; b=ONTWuoXY6/g0ZZ4xk2j/bWnsNCWhAYR6BuY85NSn4Zlr4Wy+gNV2jedvlu/9Ve6VJygTFruwML1M6sk36COEdbBEKQJRStiYdjUywBIoErN8GdCEtRobmO+wYnmmFWUfWksaaWsxecPnWFH9RXZLoA7WzccWhSiPBcMAeuXi1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646991; c=relaxed/simple;
	bh=KQJ86D8GRbnXNbA4NpWaKXmc9ZGzczcCFZ788BnLYnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TC+uIpLVOjw/dx8TJFMpp+1TbbTp0RI9qHrH1DODizpTbloMlCREi4BeKdbrGmqZLWWZWrTPnKW+s4I8yjqeiArXEac77ABj8V0y+N+/X2HYlbgEEC+TUXegAGvfGgQw5uDs4G9Tqx6ppOq4WcpL1FRZVnL2Yzg6vp7hMjoXNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAwyvXrQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564EUXA2001269
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PbVMs8TY5pGtocon1FE4uiRBNJhETXsjy9XQYR3R8z8=; b=VAwyvXrQxTuPz/lf
	owzdmWMe8H1PmroOo3aQaBlaGSRroSu7hLEEASmqGvVKb1umsNtYP2P5bGVuoGPa
	jbnScsydujqEarN5gI+y2XmFyHa0ahs0r4XHEk225ALuGMxo8zjY9jHGKfR9ayVs
	YphfF3dlDnDCdAxV5YMnkLrc237DfJutyJWjPswJgn+8u170/D/g9e1zObXhQWoS
	c/pRgwRPKmHglA4B2P2J+TMo5uLHk0JHlC/d8vG8Ab5qcPSsBTZ/OaeBulY603u/
	lnQ+U1XiJ4nrpMKXQt/Y4SA2mVXCNEUU2Hoxy3QKvKPgeMK8gM0C5zlX75F2UPGq
	7ZX5xQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9vh47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:36:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5e2872e57so165677685a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646975; x=1752251775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbVMs8TY5pGtocon1FE4uiRBNJhETXsjy9XQYR3R8z8=;
        b=A2zIqPZdxCjSa58fctsFl7mjPzPe4vAAw5oaTGat7Q8uJZqlIIk4cyfKm570Kq+Io4
         SMNC76Ljt3rdZbEIT0m7w9fgZoJKSKkmsPEGF5brsxluw704oUMBkz8HteM7R8kcP+Y5
         xSiJJvPRCDO+Ek9F8dbskPNHc1sk+kSiLAsvbJ0Gohy9uQgJ+t9xT5b06VZTOIcogh2h
         g6jD+iYa8P1gP0nemMHRzafSsr/98muk/3zMojhvWt1HNX/jZlOmVoYVuudLiD4g/l5s
         mLzeVPO0a5VcbD148LeMU6n8Oh4gp8g+qs+BRFuoAvivKefGbr6HXdUog1fokRHe5MtM
         lq6A==
X-Forwarded-Encrypted: i=1; AJvYcCWyKeob/WOojeYv1vgeNvuauI3xCEWUaHdeEib5R90qNBDC9B5Agh7EfFz8nTJUsP0Mn9ppl3Jgvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1dt/Hmd5Qex/YNpHQ6CG0K9GKk5GSyi+KPfkiQOqiNotjeZY
	HEZadaBFHtb7ml9Uo2BSR0q3WwW335T2FdU82h/vK/bzIaQV22uFyICW0ZH9nNKzeBjfk4ytlg1
	UljIr72mHcohfkBEJwmO5J78tZMTwUjL7djrbL+WWX5nFIGasCK9DSJ/9opB87zcYwHfu/MTi
X-Gm-Gg: ASbGncv0l8cnbrb+x884zfePDTmGpFOkyB0gbYQjerH16oCQ+1f2N011qZ6c53jS7KK
	FXc7aqzB5wAoxaGqHjB5W8dVhOAOcv8mZKOCfcT10UZa34HcVf5SzbjpAoHtS48ioEcWBEnNB7o
	tyrQygsJ96iOy0VhKqaUcqR2zeGBI3riNFfjhk9vCULsAhN2VWCc6YW9Tp5dMpm/P/zpFHqE5gT
	orVl4PRUIc8z6aEuKhhmCAa/O+lJgeHMw3dy6CV0Z/bjIQwpVqaXe5MSnCG5eJZj04T4LTzzblh
	3Y/2fE4NehaqSNKJHSxBPk17GM7tw/ol/C7p6ijJ3Z9niXzrNImOFM72Y0DGbRpbs356urZf+/t
	KfhPP8O7wRb6LY1J0VFEvxWIRqMAHkhEHTCI=
X-Received: by 2002:a05:620a:1707:b0:7d0:a16a:4c7c with SMTP id af79cd13be357-7d5df169c92mr408355385a.46.1751646973930;
        Fri, 04 Jul 2025 09:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ6tWNgdDx0Jk2arIrEN41O5kKXLmhCEwmFUALxr7LLvad2av3uBw6AUbm8PkPzSzwx+mZ8g==
X-Received: by 2002:a05:620a:1707:b0:7d0:a16a:4c7c with SMTP id af79cd13be357-7d5df169c92mr408345685a.46.1751646972942;
        Fri, 04 Jul 2025 09:36:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:36:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:40 +0300
Subject: [PATCH v2 28/28] interconnect: qcom: icc-rpmh: drop support for
 non-dynamic IDS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-28-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=75057;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=KQJ86D8GRbnXNbA4NpWaKXmc9ZGzczcCFZ788BnLYnA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALJx7GubMiwCE/I/rerLa5N5tJdUSXL2G2z3
 rKL7inIU72JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCyQAKCRCLPIo+Aiko
 1el4B/9PDLYW8xCY5BLJMXGg9H0SJNI4SY9k2ATCsijQY4wCvLGDsQ0QZJYwiBMUYM7Q/6Q9qg7
 gNbkXglj/XXOgcTNktMNk4NoIkbA1eFvTSHkUC9jLmKre7lEWl9NG8xIywq5wFbS1V2D9wibpAu
 28YrQC0J1bV4EY7aoKj+ErMKxDuNRy1ODmUoE71i1EGL7sLv6ggmyAZgNNLsC7OUYP6rLGoHtSF
 OAtK+WrIwAsUqdhOpDcyJ8tPZs14E52g8rbIWtSF75z59/2d0VHstKYYglduVYmRbHuqfJQ/fMf
 +ndttF0h72ZrqITML5pQYSZXxl001EFu6nRb0SOZrVNbTfF8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=68680300 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dRK9c6Vhyr5mXIpLRdwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 7vtOZiAgCugsaeVU6w8bR7T-cjJORc4y
X-Proofpoint-GUID: 7vtOZiAgCugsaeVU6w8bR7T-cjJORc4y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfXySFPToef6FlP
 rh5KmU4BuOhoETzxPL2gt7zQR41lA8pz3TDXRb3rPe7lMI7JBv0oD1DGtunpBZxSVANsjBn1sy2
 auUZI4IgklQrJtxFHDqfr8c7A+F9+J4fhmvo/dVn38hEvDXGJG8R50aT6qxKlAW8oB/NduhFF2C
 K1kU0eHUfI2dgymUe/x5x6LuLykLfGz3DXdUqFIBBCVFu7NgVmw/ucFy3E2XmudRiCyqKP6lztk
 pPyElWvu8fXyw3oOpsm0eoE56+IvRt+od7vT6k0oaZFyw0+6og1wpie0nBozBxEC5CuV0C2vOx9
 RRzutdnesUbBp9in5eeQ4LLKuR3uNz8bqiEOtGgcLgURN3I1z9RX0sjCcpeWAPeOxBj/VUTzaC2
 w4HkY5EuzVejgYTA76dLzbtQFr5ceZj+qlWMf1UjoTaR97+5bxpqSi3WZZsTvYiIb3jQY84x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

Now as all RPMh interconnect drivers were converted to using the dynamic
IDs, drop support for non-dynamic ID allocation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 19 +++++--------------
 drivers/interconnect/qcom/icc-rpmh.h |  7 -------
 drivers/interconnect/qcom/qcs615.c   |  9 ---------
 drivers/interconnect/qcom/qcs8300.c  | 13 -------------
 drivers/interconnect/qcom/qdu1000.c  |  4 ----
 drivers/interconnect/qcom/sa8775p.c  | 14 --------------
 drivers/interconnect/qcom/sar2130p.c |  9 ---------
 drivers/interconnect/qcom/sc7180.c   | 12 ------------
 drivers/interconnect/qcom/sc7280.c   | 12 ------------
 drivers/interconnect/qcom/sc8180x.c  | 11 -----------
 drivers/interconnect/qcom/sc8280xp.c | 12 ------------
 drivers/interconnect/qcom/sdm670.c   |  8 --------
 drivers/interconnect/qcom/sdm845.c   |  8 --------
 drivers/interconnect/qcom/sdx55.c    |  3 ---
 drivers/interconnect/qcom/sdx65.c    |  3 ---
 drivers/interconnect/qcom/sdx75.c    |  6 ------
 drivers/interconnect/qcom/sm6350.c   | 10 ----------
 drivers/interconnect/qcom/sm7150.c   | 10 ----------
 drivers/interconnect/qcom/sm8150.c   | 10 ----------
 drivers/interconnect/qcom/sm8350.c   | 10 ----------
 drivers/interconnect/qcom/sm8450.c   | 11 -----------
 drivers/interconnect/qcom/sm8550.c   | 14 --------------
 drivers/interconnect/qcom/sm8650.c   | 14 --------------
 drivers/interconnect/qcom/sm8750.c   | 14 --------------
 drivers/interconnect/qcom/x1e80100.c | 19 -------------------
 25 files changed, 5 insertions(+), 257 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 941692cbaf208c66a27dda2e6902b2f26f605840..796fba9fb316cf58ae2eb77af1607d6d00c38438 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -280,14 +280,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		if (!qn)
 			continue;
 
-		if (desc->alloc_dyn_id) {
-			if (!qn->node)
-				qn->node = icc_node_create_dyn();
-			node = qn->node;
-		} else {
-			node = icc_node_create(qn->id);
-		}
+		if (!qn->node)
+			qn->node = icc_node_create_dyn();
 
+		node = qn->node;
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err_remove_nodes;
@@ -302,13 +298,8 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		node->data = qn;
 		icc_node_add(node, provider);
 
-		if (desc->alloc_dyn_id) {
-			for (j = 0; qn->link_nodes[j]; j++)
-				icc_link_nodes(node, &qn->link_nodes[j]->node);
-		} else {
-			for (j = 0; j < qn->num_links; j++)
-				icc_link_create(node, qn->links[j]);
-		}
+		for (j = 0; qn->link_nodes[j]; j++)
+			icc_link_nodes(node, &qn->link_nodes[j]->node);
 
 		data->nodes[i] = node;
 	}
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 742941a296ac0a2e3d3e7147c25f750965a36647..5eb76da081df024e1f84069ce54f5da5fbb19699 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -81,10 +81,7 @@ struct qcom_icc_qosbox {
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
  * @name: the node name used in debugfs
- * @links: an array of nodes where we can go next while traversing
- * @id: a unique node identifier
  * @node: icc_node associated with this node
- * @num_links: the total number of @links
  * @channels: num of channels at this node
  * @buswidth: width of the interconnect between a node and the bus
  * @sum_avg: current sum aggregate value of all avg bw requests
@@ -96,10 +93,7 @@ struct qcom_icc_qosbox {
  */
 struct qcom_icc_node {
 	const char *name;
-	u16 links[MAX_LINKS];
-	u16 id;
 	struct icc_node *node;
-	u16 num_links;
 	u16 channels;
 	u16 buswidth;
 	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
@@ -156,7 +150,6 @@ struct qcom_icc_desc {
 	struct qcom_icc_bcm * const *bcms;
 	size_t num_bcms;
 	bool qos_requires_clocks;
-	bool alloc_dyn_id;
 };
 
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
index 4fc58de384e9dec2364d78e89630ef61d0338155..bb9c9c0b6fe5b0c402fd9b8cda3ee392839287cb 100644
--- a/drivers/interconnect/qcom/qcs615.c
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -1194,7 +1194,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1213,7 +1212,6 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_camnoc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1272,7 +1270,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1286,7 +1283,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1316,7 +1312,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1333,7 +1328,6 @@ static struct qcom_icc_node * const ipa_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_ipa_virt = {
-	.alloc_dyn_id = true,
 	.nodes = ipa_virt_nodes,
 	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
 	.bcms = ipa_virt_bcms,
@@ -1351,7 +1345,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1380,7 +1373,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1423,7 +1415,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
index ebe9a2eab554bcb199497e4efbfbebeec3bb2c53..d490f8dc1d0120b46d474dae4f7cb9c603aba57f 100644
--- a/drivers/interconnect/qcom/qcs8300.c
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -1582,7 +1582,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1608,7 +1607,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1631,7 +1629,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1726,7 +1723,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1740,7 +1736,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1774,7 +1769,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1792,7 +1786,6 @@ static struct qcom_icc_node * const gpdsp_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_gpdsp_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = gpdsp_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(gpdsp_anoc_nodes),
 	.bcms = gpdsp_anoc_bcms,
@@ -1816,7 +1809,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1834,7 +1826,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1864,7 +1855,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1885,7 +1875,6 @@ static struct qcom_icc_node * const nspa_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_nspa_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nspa_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
@@ -1903,7 +1892,6 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_pcie_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1932,7 +1920,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index 6bd7b16f8129758eca38ed9d348ac745226897dd..0e2f3b19de405989ca60019e6aabc9352cc1c607 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -816,7 +816,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -844,7 +843,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -862,7 +860,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -949,7 +946,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index a7049eb22d1e064afea17812637b720f907de90e..910116bc8b3a7a15f5906473af7018777b122afc 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -1820,7 +1820,6 @@ static const struct qcom_icc_desc sa8775p_aggre1_noc = {
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -1848,7 +1847,6 @@ static const struct qcom_icc_desc sa8775p_aggre2_noc = {
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
@@ -1873,7 +1871,6 @@ static const struct qcom_icc_desc sa8775p_clk_virt = {
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
 	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const config_noc_bcms[] = {
@@ -1979,7 +1976,6 @@ static const struct qcom_icc_desc sa8775p_config_noc = {
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const dc_noc_bcms[] = {
@@ -1996,7 +1992,6 @@ static const struct qcom_icc_desc sa8775p_dc_noc = {
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const gem_noc_bcms[] = {
@@ -2033,7 +2028,6 @@ static const struct qcom_icc_desc sa8775p_gem_noc = {
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const gpdsp_anoc_bcms[] = {
@@ -2052,7 +2046,6 @@ static const struct qcom_icc_desc sa8775p_gpdsp_anoc = {
 	.num_nodes = ARRAY_SIZE(gpdsp_anoc_nodes),
 	.bcms = gpdsp_anoc_bcms,
 	.num_bcms = ARRAY_SIZE(gpdsp_anoc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
@@ -2076,7 +2069,6 @@ static const struct qcom_icc_desc sa8775p_lpass_ag_noc = {
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
 	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
@@ -2094,7 +2086,6 @@ static const struct qcom_icc_desc sa8775p_mc_virt = {
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
@@ -2127,7 +2118,6 @@ static const struct qcom_icc_desc sa8775p_mmss_noc = {
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const nspa_noc_bcms[] = {
@@ -2148,7 +2138,6 @@ static const struct qcom_icc_desc sa8775p_nspa_noc = {
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
 	.num_bcms = ARRAY_SIZE(nspa_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const nspb_noc_bcms[] = {
@@ -2169,7 +2158,6 @@ static const struct qcom_icc_desc sa8775p_nspb_noc = {
 	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
 	.bcms = nspb_noc_bcms,
 	.num_bcms = ARRAY_SIZE(nspb_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
@@ -2187,7 +2175,6 @@ static const struct qcom_icc_desc sa8775p_pcie_anoc = {
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
 	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const system_noc_bcms[] = {
@@ -2216,7 +2203,6 @@ static const struct qcom_icc_desc sa8775p_system_noc = {
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
-	.alloc_dyn_id = true,
 };
 
 static const struct of_device_id qnoc_of_match[] = {
diff --git a/drivers/interconnect/qcom/sar2130p.c b/drivers/interconnect/qcom/sar2130p.c
index df9bd10ffe0589f135a0c6199162b7f33233598f..cb978aae8c8cc1f333eaa91e7277e437fd788acd 100644
--- a/drivers/interconnect/qcom/sar2130p.c
+++ b/drivers/interconnect/qcom/sar2130p.c
@@ -1447,7 +1447,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1510,7 +1509,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_config_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
@@ -1541,7 +1539,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_gem_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
@@ -1565,7 +1562,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
@@ -1584,7 +1580,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1613,7 +1608,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_mmss_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
@@ -1633,7 +1627,6 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_nsp_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
@@ -1652,7 +1645,6 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_pcie_anoc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
@@ -1692,7 +1684,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_system_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 2d9099e909bb9fbc9b82370e488d014391324637..9c2ae0056183918ccc2aa3f55be7febc6f254628 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -1449,7 +1449,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1473,7 +1472,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1492,7 +1490,6 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_camnoc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1512,7 +1509,6 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_compute_noc = {
-	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1581,7 +1577,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1595,7 +1590,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1624,7 +1618,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1642,7 +1635,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1670,7 +1662,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1692,7 +1683,6 @@ static struct qcom_icc_node * const npu_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_npu_noc = {
-	.alloc_dyn_id = true,
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 };
@@ -1709,7 +1699,6 @@ static struct qcom_icc_node * const qup_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_qup_virt = {
-	.alloc_dyn_id = true,
 	.nodes = qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qup_virt_nodes),
 	.bcms = qup_virt_bcms,
@@ -1745,7 +1734,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index c39e79d82b482ae3e35b292fe1a2d4cfc911d969..1ca2e8f55d6fcb0bc8818848a929c25ffe102427 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1585,7 +1585,6 @@ static const struct regmap_config sc7280_aggre1_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
@@ -1618,7 +1617,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
@@ -1640,7 +1638,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1711,7 +1708,6 @@ static const struct regmap_config sc7280_cnoc2_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc2 = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_cnoc2_regmap_config,
 	.nodes = cnoc2_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
@@ -1753,7 +1749,6 @@ static const struct regmap_config sc7280_cnoc3_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc3 = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_cnoc3_regmap_config,
 	.nodes = cnoc3_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
@@ -1779,7 +1774,6 @@ static const struct regmap_config sc7280_dc_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_dc_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
@@ -1825,7 +1819,6 @@ static const struct regmap_config sc7280_gem_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_gem_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
@@ -1855,7 +1848,6 @@ static const struct regmap_config sc7280_lpass_ag_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
@@ -1882,7 +1874,6 @@ static const struct regmap_config sc7280_mc_virt_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_mc_virt = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_mc_virt_regmap_config,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
@@ -1919,7 +1910,6 @@ static const struct regmap_config sc7280_mmss_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_mmss_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
@@ -1948,7 +1938,6 @@ static const struct regmap_config sc7280_nsp_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_nsp_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_nsp_noc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
@@ -1983,7 +1972,6 @@ static const struct regmap_config sc7280_system_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_system_noc = {
-	.alloc_dyn_id = true,
 	.config = &sc7280_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index e68bc35b691276375349585ac03b279e30568c68..5a04126994b4e8bb5501ffb313d96e7794d3e096 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1761,7 +1761,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8180x_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1769,7 +1768,6 @@ static const struct qcom_icc_desc sc8180x_aggre1_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1777,7 +1775,6 @@ static const struct qcom_icc_desc sc8180x_aggre2_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_camnoc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1785,7 +1782,6 @@ static const struct qcom_icc_desc sc8180x_camnoc_virt = {
 };
 
 static const struct qcom_icc_desc sc8180x_compute_noc = {
-	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1793,7 +1789,6 @@ static const struct qcom_icc_desc sc8180x_compute_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1801,13 +1796,11 @@ static const struct qcom_icc_desc sc8180x_config_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
 
 static const struct qcom_icc_desc sc8180x_gem_noc  = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1815,7 +1808,6 @@ static const struct qcom_icc_desc sc8180x_gem_noc  = {
 };
 
 static const struct qcom_icc_desc sc8180x_mc_virt  = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1823,7 +1815,6 @@ static const struct qcom_icc_desc sc8180x_mc_virt  = {
 };
 
 static const struct qcom_icc_desc sc8180x_mmss_noc  = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1831,7 +1822,6 @@ static const struct qcom_icc_desc sc8180x_mmss_noc  = {
 };
 
 static const struct qcom_icc_desc sc8180x_system_noc  = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
@@ -1852,7 +1842,6 @@ static struct qcom_icc_node * const qup_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8180x_qup_virt = {
-	.alloc_dyn_id = true,
 	.nodes = qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qup_virt_nodes),
 	.bcms = qup_virt_bcms,
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index d9fd67ae6258d66ab3e78e06863a5a42da3ac131..2c0f760edee725f5cb0a9de8eb03308c0f98c854 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -1957,7 +1957,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1994,7 +1993,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -2017,7 +2015,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -2122,7 +2119,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -2139,7 +2135,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -2174,7 +2169,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -2198,7 +2192,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -2216,7 +2209,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -2248,7 +2240,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -2269,7 +2260,6 @@ static struct qcom_icc_node * const nspa_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_nspa_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nspa_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
@@ -2290,7 +2280,6 @@ static struct qcom_icc_node * const nspb_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_nspb_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nspb_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
 	.bcms = nspb_noc_bcms,
@@ -2320,7 +2309,6 @@ static struct qcom_icc_node * const system_noc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_system_noc_main = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_main_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_main_nodes),
 	.bcms = system_noc_main_bcms,
diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index d1aa6e3532821659d06373c4082cc6bd77e420ab..6bf641c95d85f0049cf3b69a1878b18d6921c255 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -1222,7 +1222,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1249,7 +1248,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1305,7 +1303,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1322,7 +1319,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1341,7 +1337,6 @@ static struct qcom_icc_node * const gladiator_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_gladiator_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gladiator_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gladiator_noc_nodes),
 	.bcms = gladiator_noc_bcms,
@@ -1377,7 +1372,6 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_mem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -1408,7 +1402,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1453,7 +1446,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index b37de30a9e8f309510818e2619aab2c451f50fe0..8d77e6d00fe03c7b13f932e6f7136336535eaa21 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1464,7 +1464,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1494,7 +1493,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1556,7 +1554,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1573,7 +1570,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1592,7 +1588,6 @@ static struct qcom_icc_node * const gladiator_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_gladiator_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gladiator_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gladiator_noc_nodes),
 	.bcms = gladiator_noc_bcms,
@@ -1628,7 +1623,6 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_mem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -1663,7 +1657,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1710,7 +1703,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 5d85c1e6ec58d3949b30c143440bb6dd0779a605..350fbfbfcba5fae70d2f4e9ecf2d2f064d7adbd0 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -766,7 +766,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -789,7 +788,6 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -869,7 +867,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index 267eeeec0e655e13c9643c432139f4b94542d959..a8aaab3fc3eaacfc717f9cb2a98bc854e7721311 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -751,7 +751,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx65_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -774,7 +773,6 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx65_mem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -851,7 +849,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx65_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index bfd0ec87f68020ea1e832c405237d29054117f70..49d0a14512e9edf5bc5a9524dc70d24485b4389f 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -854,7 +854,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -870,7 +869,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -897,7 +895,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -914,7 +911,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -934,7 +930,6 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_pcie_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1013,7 +1008,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 92a33c307c960157bf537bc5fe28b0348fbb9918..b1df16edff9d71ab2b7284e1a97e6f15bcb1f887 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1360,7 +1360,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1386,7 +1385,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1414,7 +1412,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1434,7 +1431,6 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_compute_noc = {
-	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1495,7 +1491,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1512,7 +1507,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1544,7 +1538,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1572,7 +1565,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1597,7 +1589,6 @@ static struct qcom_icc_node * const npu_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_npu_noc = {
-	.alloc_dyn_id = true,
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 	.bcms = npu_noc_bcms,
@@ -1634,7 +1625,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm7150.c b/drivers/interconnect/qcom/sm7150.c
index 5e2b77f3e1d2245ded149add1548e603a1358295..9857c86f2e45a7e62307e9b6f74fbd6e2c95b6f2 100644
--- a/drivers/interconnect/qcom/sm7150.c
+++ b/drivers/interconnect/qcom/sm7150.c
@@ -1384,7 +1384,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1414,7 +1413,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1434,7 +1432,6 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_camnoc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1452,7 +1449,6 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_compute_noc = {
-	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1518,7 +1514,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1535,7 +1530,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1567,7 +1561,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1585,7 +1578,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1617,7 +1609,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1654,7 +1645,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index a545e780cacd77b0e8834c879d62c1fc1b3a433d..75093a2704fed883b9ea1d2ece6b01e469d2658c 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -1494,7 +1494,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1530,7 +1529,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1549,7 +1547,6 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_camnoc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1567,7 +1564,6 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_compute_noc = {
-	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1636,7 +1632,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1653,7 +1648,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1689,7 +1683,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1707,7 +1700,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1738,7 +1730,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1780,7 +1771,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index d268bb68b18cd7e9b06bd060f905b4f22e565e5e..be5a1752b81388549143796f2b4d103a11034090 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1484,7 +1484,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1516,7 +1515,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1596,7 +1594,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1613,7 +1610,6 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_dc_noc = {
-	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1650,7 +1646,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1671,7 +1666,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1689,7 +1683,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1720,7 +1713,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1740,7 +1732,6 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_compute_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1766,7 +1757,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index eb3c2bb5499da9aaa6cd84b14d3917ab5e119a5f..fdec76e242574d096f834b252ac8bf65f0050d5c 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1442,7 +1442,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1470,7 +1469,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1493,7 +1491,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1563,7 +1560,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1599,7 +1595,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1622,7 +1617,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1644,7 +1638,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1680,7 +1673,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1699,7 +1691,6 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_nsp_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1719,7 +1710,6 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_pcie_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1748,7 +1738,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index 8e3993c189685693d75e184bbaad5692bef6375c..4fad11c369dfce113a2aca65ac7ec694158efde1 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -1207,7 +1207,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1231,7 +1230,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1254,7 +1252,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1315,7 +1312,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1340,7 +1336,6 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_cnoc_main = {
-	.alloc_dyn_id = true,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1371,7 +1366,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1387,7 +1381,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1404,7 +1397,6 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_lpass_lpiaon_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -1420,7 +1412,6 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_lpass_lpicx_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 	.bcms = lpass_lpicx_noc_bcms,
@@ -1438,7 +1429,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1467,7 +1457,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1484,7 +1473,6 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_nsp_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1504,7 +1492,6 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_pcie_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1528,7 +1515,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8550_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index 48b1f9c5e988bebc78f1a724f78664f49e7c1aaa..5282b8ac1658a7933ae5d528c2b88a72d67cbf8b 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -1567,7 +1567,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
@@ -1590,7 +1589,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
@@ -1614,7 +1612,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1676,7 +1673,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_config_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
@@ -1705,7 +1701,6 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_cnoc_main = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
@@ -1739,7 +1734,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_gem_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
@@ -1753,7 +1747,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
@@ -1769,7 +1762,6 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_lpiaon_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
@@ -1783,7 +1775,6 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_lpicx_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
@@ -1800,7 +1791,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1829,7 +1819,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_mmss_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
@@ -1847,7 +1836,6 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_nsp_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
@@ -1868,7 +1856,6 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_pcie_anoc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
@@ -1890,7 +1877,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_system_noc = {
-	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
diff --git a/drivers/interconnect/qcom/sm8750.c b/drivers/interconnect/qcom/sm8750.c
index 0c9b39ea4f9ec970112f2a9117d16e70a6f41c93..e2605b68bb2c05c6d1170f9fc387c5a3f4c30335 100644
--- a/drivers/interconnect/qcom/sm8750.c
+++ b/drivers/interconnect/qcom/sm8750.c
@@ -1155,7 +1155,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 };
@@ -1178,7 +1177,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1201,7 +1199,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1251,7 +1248,6 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_config_noc = {
-	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1281,7 +1277,6 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_cnoc_main = {
-	.alloc_dyn_id = true,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1315,7 +1310,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1328,7 +1322,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 };
@@ -1343,7 +1336,6 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_lpass_lpiaon_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -1356,7 +1348,6 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_lpass_lpicx_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 };
@@ -1372,7 +1363,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1402,7 +1392,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1419,7 +1408,6 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_nsp_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1438,7 +1426,6 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_pcie_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1458,7 +1445,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 8f2a912f403a48826a9ee89df57933f746e4bed6..a4b18f1905dcfe5d7fb59d5a0044624921417f44 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -1424,7 +1424,6 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_aggre1_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1447,7 +1446,6 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_aggre2_noc = {
-	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1470,7 +1468,6 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_clk_virt = {
-	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1534,7 +1531,6 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_cnoc_cfg = {
-	.alloc_dyn_id = true,
 	.nodes = cnoc_cfg_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
 	.bcms = cnoc_cfg_bcms,
@@ -1565,7 +1561,6 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_cnoc_main = {
-	.alloc_dyn_id = true,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1596,7 +1591,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_gem_noc = {
-	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1612,7 +1606,6 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_ag_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1629,7 +1622,6 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_lpiaon_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -1645,7 +1637,6 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_lpicx_noc = {
-	.alloc_dyn_id = true,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 	.bcms = lpass_lpicx_noc_bcms,
@@ -1663,7 +1654,6 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_mc_virt = {
-	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1692,7 +1682,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_mmss_noc = {
-	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1709,7 +1698,6 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_nsp_noc = {
-	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1727,7 +1715,6 @@ static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_center_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_center_anoc_nodes),
 	.bcms = pcie_center_anoc_bcms,
@@ -1745,7 +1732,6 @@ static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_north_anoc_nodes),
 	.bcms = pcie_north_anoc_bcms,
@@ -1765,7 +1751,6 @@ static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = pcie_south_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_south_anoc_nodes),
 	.bcms = pcie_south_anoc_bcms,
@@ -1788,7 +1773,6 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_system_noc = {
-	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
@@ -1805,7 +1789,6 @@ static struct qcom_icc_node * const usb_center_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_center_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = usb_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_center_anoc_nodes),
 	.bcms = usb_center_anoc_bcms,
@@ -1822,7 +1805,6 @@ static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_north_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = usb_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_north_anoc_nodes),
 	.bcms = usb_north_anoc_bcms,
@@ -1843,7 +1825,6 @@ static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_south_anoc = {
-	.alloc_dyn_id = true,
 	.nodes = usb_south_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_south_anoc_nodes),
 	.bcms = usb_south_anoc_bcms,

-- 
2.39.5


