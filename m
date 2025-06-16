Return-Path: <linux-pm+bounces-28739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861AADA4F4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982113AFDE9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3C1B4231;
	Mon, 16 Jun 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HNaEyeo5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9A1474CC
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033724; cv=none; b=ihM8QIxB2mKL8pin2Q+nnkSP3Nue+RzPEvw+OaqKapDTUnvCUHU75efqM54pYUCM5yV+t/uc5wy5os5DWexXjByYUKuxyHjlG0+yh3HYLTPPa/zukV6Cguxb102ogl2eybLzFlJolD929YqiQBDfFtmwDSwBCFc//hqjk65yseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033724; c=relaxed/simple;
	bh=VETRurUERj/j0hQ2717tH0rcoKos3zad3EecACUuGw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FioNxD0wXI0R4uosPENr43fqaqlHxFI0kDE+/61bG5lM++RfRCDx7ysdaPT1EwHfRTjiXNZZW4nYWEdOCDMhv1dzWuahv8HZoL/1mw1PswlSjiSLIO3+CmM7yhXTstcXBReUZvh15tvozR44hcYCZ7uv9spjY9U42teigcYYX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HNaEyeo5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FMuWEg013835
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yhl2BfJ9E0Be+amjZ/qxn8k1LE0lJRltPQRlEBops7I=; b=HNaEyeo5U/MXckAO
	hheD6DQMJlkkcaVE+JCwuQmiHoo7/GEJxBspT5iOQPCyztkvc+krjdP3rBNlImjE
	ilUL6BjyT7Pk703stdv0BkaEehI1neOutmnr3Q9ghYpPxF44LCRFgokSsPSiaEIJ
	tOQUHz5RQOw1prxpI4Kp9CWIRD6POJmBK8ILe9H3HU9Is53MMT4f0UoV9npN3gN/
	OBZsDQdVSWO38QUaaHmIAdAk3Tva7+T0UQvNG6Q4H9YV3r9aCbxp6xvTfQ0LsBL6
	c/Xk2TDNk47hbne+ClM9uqskKTgWDwNkMfQu7qf4jt//0ki0UEC8PFkHhGmTmPW2
	ajtm2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hctjwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3d3f6471cso73303285a.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033716; x=1750638516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yhl2BfJ9E0Be+amjZ/qxn8k1LE0lJRltPQRlEBops7I=;
        b=N5vO6B/tMhetTna0JM+SdagV9UH58bM7ClIdgIg1yJJ4hOMJXEmk7wV3IMwQU6X0yk
         xl5qZ1wJ/gsktSnAHICNYYwboJCKFsgRIOy1RztKaSkrtKYHs7hUcgt1ZaMgNvwrRBTN
         /lI12zdqBpyRk7+223/MYWWufgTZpZlAjGKtl9agSPfduzZuPonZyFc8PG23qZcI1L/S
         2NjfhpgxAJozL0Wub9aAEUIqeNlorpkHaTfzbyjF88mVt2u8JREmklhNZTwPLF3cWawQ
         1R34QlaNhMKJgeqYbDTnVBt0Y9buZSDpncI8hmhxsXLLLr5mM3VXukFaBPFPvjIdsaWM
         BM3w==
X-Forwarded-Encrypted: i=1; AJvYcCVnGU+jakELqDba2vrc+KmPp66GGNiuIbPxTuWY+mMmSAbRoMBkv9u1c0b9gKFsyZ5LcgelaC+gnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLRaxDAU6qQjofUtzuzeGBbFbl2xKRY8Unof6fYJHdqdsgk39
	wGvdckNoZDYSJBwoSx6ea3k/3u6E8h7TRjRoyAJtay6FF31Ylw4y/2+hl2wJM2cTQJcSvfjQmko
	D7UWrKyA9V85Vv9JShXL75GppkXXVQwFVeQeqC5OHtF4uNDSLQtWd8y7kX2ugvg==
X-Gm-Gg: ASbGncudA3NDfDWQRJle37W+Gu6wMJXXmDAN/ZxLuM861BA4GeWcurFXWPGQHdqfjZY
	wmI94uBiHb2RokuaZ0E6HfVklqD/jm5J7z2jkgLrrbVYsTKbaERR3BjiSBqJi8CcqjYO+mi8a+7
	CWNn4magLvybMcHaDB+XRjuItjQ1LPmOP3Kd7cEsNgrVizRwx135k5cUZ3wR1He+/nqsb2vlaOq
	XAZq9DGAbJVJdr7jJpe54rcrZUBOsdRnGnmGnhtVVB5lVBJW/KEPzNh0fu0SrMuISZLTVq+B4C5
	FXvaxJNftxuu6YNt53rQG0MKjKrEEDULsumqwOU/01EuN+ZTVOBrL7nI6XzTd49fip3JA2PIQQe
	Ktz72q2QiYPi5AxWGOOeaZTdyh+2QG2ZPSNs=
X-Received: by 2002:a05:620a:4594:b0:7d3:8dc9:f438 with SMTP id af79cd13be357-7d3c6c1e581mr1024790485a.17.1750033715530;
        Sun, 15 Jun 2025 17:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdP41sotgKfp4M8ysCVnhXKNIgtsbhI8LrOm1r2YrM22jrh3eWNuLX5rxCNymRL1DDCXiZpQ==
X-Received: by 2002:a05:620a:4594:b0:7d3:8dc9:f438 with SMTP id af79cd13be357-7d3c6c1e581mr1024786285a.17.1750033714479;
        Sun, 15 Jun 2025 17:28:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:28:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:15 +0300
Subject: [PATCH 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-3-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=120340;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VETRurUERj/j0hQ2717tH0rcoKos3zad3EecACUuGw8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2Uh2W3fHce4o1ip40rMSWl1QnETc31sjq9Oe
 0wMJoRlV3eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIQAKCRCLPIo+Aiko
 1dGoCACJeayRDLj/zBbJM/sKnmx4CWU/A7VKs4j+dcMgBpcjP3iQpSejOItsHCjIIma1f/BUBjZ
 1/D4IHyUw9HMhSrnQAeLIQLeBoOrC1x0R7lPfvPq1u+0E2rmnuoW2lZDvDk+xZs5eg5UfHdCb/X
 WFhfBNAMuVnbcUlKCB5p0I6+r4iKMQhmJj5a2wG6kHIzElIow3ft6sG7LRHrZF1Ci0QFCUrFDXL
 3DnJOtNj+nM1VGXixdQFRhVAFFS1YrjSYXa1hYNDbKdCLkNXM4NgK0poD8VIQ4qzqZHFNoDnFYv
 PlnjiCr5AU8zMo6JY7RilgVEMqXF12y1u+h1mYE3B7+JNoIx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMCBTYWx0ZWRfX8t/4uhP84jKT
 sMV9Aoe4bYOT6fyowFTl2ss+7cNEuara3PXIRM/X03pAioan8L1Wz53tkZaItKco7Ie92muQXr2
 s6v45mGk+4zDgaYZj7CtuBUChWni13mNePDoExD/Om4nYcQSpCP26CJov01YatHHSrUxYydfjjV
 cSViy5+aHtxTH/A3ifZFK9/dAlpjVLIgUhLJ9NTkn19sJakdCXAm3w/z6h0bYQa2RTGFZFuuORa
 RK3guWFVjdc4wsfLlzuOknk1LpVKs2PPrqE5niMx9sRlcSHekHI766b0VaRxP6kzWdeQeIarrHb
 XuHhgCMAaQdHFlcHXF8GYi4RL+uLoZ1olGOfnGXW4rfIjFtjDzq5azG0rDrlSeNpRmenIr+A5lD
 Z9C3blUBScjYLIsdBbkqTdxo2UWVFTcw8B3CX3hhpluHyO3S5WdY8BwPedreSnWVzbepaLZP
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=684f6536 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=NY0w9idC-kCSDk-CWXsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: lmufW4AbJhm-E3v55iO7n-i7Ghppe-Se
X-Proofpoint-GUID: lmufW4AbJhm-E3v55iO7n-i7Ghppe-Se
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160000

Having the .num_nodes as a separate struct field can provoke errors as
it is easy to omit it or to put an incorrect value into that field. Turn
.nodes into a NULL-terminated array, removing a need for a separate
.num_nodes field.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/bcm-voter.c |  4 +-
 drivers/interconnect/qcom/icc-rpmh.c  |  2 +-
 drivers/interconnect/qcom/icc-rpmh.h  |  2 -
 drivers/interconnect/qcom/qcs615.c    | 78 ++++++++++-------------------
 drivers/interconnect/qcom/qcs8300.c   | 75 ++++++++++------------------
 drivers/interconnect/qcom/qdu1000.c   | 37 +++++---------
 drivers/interconnect/qcom/sa8775p.c   | 84 +++++++++++--------------------
 drivers/interconnect/qcom/sar2130p.c  | 48 ++++++------------
 drivers/interconnect/qcom/sc7180.c    | 75 +++++++++-------------------
 drivers/interconnect/qcom/sc7280.c    | 81 ++++++++++--------------------
 drivers/interconnect/qcom/sc8180x.c   | 69 +++++++++-----------------
 drivers/interconnect/qcom/sc8280xp.c  | 93 ++++++++++-------------------------
 drivers/interconnect/qcom/sdm670.c    | 74 +++++++++-------------------
 drivers/interconnect/qcom/sdm845.c    | 86 +++++++++++---------------------
 drivers/interconnect/qcom/sdx55.c     | 60 ++++++++--------------
 drivers/interconnect/qcom/sdx65.c     | 61 ++++++++---------------
 drivers/interconnect/qcom/sdx75.c     | 33 +++++--------
 drivers/interconnect/qcom/sm6350.c    | 78 ++++++++++-------------------
 drivers/interconnect/qcom/sm7150.c    | 80 +++++++++---------------------
 drivers/interconnect/qcom/sm8150.c    | 86 +++++++++++---------------------
 drivers/interconnect/qcom/sm8250.c    | 83 +++++++++++--------------------
 drivers/interconnect/qcom/sm8350.c    | 77 ++++++++++-------------------
 drivers/interconnect/qcom/sm8450.c    | 72 +++++++++------------------
 drivers/interconnect/qcom/sm8550.c    | 57 +++++++--------------
 drivers/interconnect/qcom/sm8650.c    | 51 +++++++------------
 drivers/interconnect/qcom/sm8750.c    | 57 +++++++--------------
 drivers/interconnect/qcom/x1e80100.c  | 57 +++++++--------------
 27 files changed, 541 insertions(+), 1119 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a2d437a05a11fa7325f944865c81a3ac7dbb203e..4fa960630d28f338f484794d271a5b52f3e698d3 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -68,7 +68,7 @@ static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
 		bcm->vote_x[bucket] = 0;
 		bcm->vote_y[bucket] = 0;
 
-		for (i = 0; i < bcm->num_nodes; i++) {
+		for (i = 0; bcm->nodes[i]; i++) {
 			node = bcm->nodes[i];
 
 			/* If any vote in this bucket exists, keep the BCM enabled */
@@ -97,7 +97,7 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 	u64 temp;
 
 	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
-		for (i = 0; i < bcm->num_nodes; i++) {
+		for (i = 0; bcm->nodes[i]; i++) {
 			node = bcm->nodes[i];
 			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
 				       node->buswidth * node->channels);
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 41bfc6e7ee1d53d34b919dd8afa97698bc69d79c..5b7d71d5b30043d94490800c1ef8a820f3fdd02d 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -184,7 +184,7 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 		bcm->vote_scale = 1000;
 
 	/* Link Qnodes to their respective BCMs */
-	for (i = 0; i < bcm->num_nodes; i++) {
+	for (i = 0; bcm->nodes[i]; i++) {
 		qn = bcm->nodes[i];
 		qn->bcms[qn->num_bcms] = bcm;
 		qn->num_bcms++;
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index bd8d730249b1c9e5b37afbee485b9500a8028c2e..0018aa74187edcac9a0492c737771d957a133cc0 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -126,7 +126,6 @@ struct qcom_icc_node {
  * communicating with RPMh
  * @list: used to link to other bcms when compiling lists for commit
  * @ws_list: used to keep track of bcms that may transition between wake/sleep
- * @num_nodes: total number of @num_nodes
  * @nodes: list of qcom_icc_nodes that this BCM encapsulates
  */
 struct qcom_icc_bcm {
@@ -142,7 +141,6 @@ struct qcom_icc_bcm {
 	struct bcm_db aux_data;
 	struct list_head list;
 	struct list_head ws_list;
-	size_t num_nodes;
 	struct qcom_icc_node *nodes[];
 };
 
diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
index 7e59e91ce886d641599a780b0f0d56a9e64b7de4..acf452b5ed023b2e42b23f7455e57ab124bfa524 100644
--- a/drivers/interconnect/qcom/qcs615.c
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -1069,20 +1069,17 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 37,
 	.nodes = { &qhm_spdm, &qnm_snoc,
 		   &qhs_a1_noc_cfg, &qhs_aop,
 		   &qhs_aoss, &qhs_camera_cfg,
@@ -1101,157 +1098,134 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_ufs_mem_cfg, &qhs_usb2,
 		   &qhs_usb3, &qhs_venus_cfg,
 		   &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc,
-		   &srvc_cnoc },
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 8,
 	.nodes = { &qhm_qspi, &xm_sdc1,
 		   &xm_sdc2, &qhs_ahb2phy_east,
 		   &qhs_ahb2phy_west, &qhs_qspi,
-		   &qhs_sdc1, &qhs_sdc2 },
+		   &qhs_sdc1, &qhs_sdc2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ip0 = {
 	.name = "IP0",
-	.num_nodes = 1,
-	.nodes = { &ipa_core_slave },
+	.nodes = { &ipa_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
-	.num_nodes = 7,
 	.nodes = { &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp,
 		   &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0,
 		   &qxm_camnoc_hf1, &qxm_mdp0,
-		   &qxm_rot },
+		   &qxm_rot, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
-	.num_nodes = 2,
-	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc },
+	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm3 = {
 	.name = "MM3",
-	.num_nodes = 2,
-	.nodes = { &qxm_venus0, &qxm_venus_arm9 },
+	.nodes = { &qxm_venus0, &qxm_venus_arm9, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 2,
-	.nodes = { &qhm_qup0, &qhm_qup1 },
+	.nodes = { &qhm_qup0, &qhm_qup1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
-	.num_nodes = 1,
-	.nodes = { &acm_apps },
+	.nodes = { &acm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
-	.num_nodes = 1,
-	.nodes = { &qns_gem_noc_snoc },
+	.nodes = { &qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_gc },
+	.nodes = { &qns_memnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 2,
-	.nodes = { &srvc_aggre2_noc, &qns_cnoc },
+	.nodes = { &srvc_aggre2_noc, &qns_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
-	.num_nodes = 2,
-	.nodes = { &qnm_gemnoc_pcie, &xs_pcie },
+	.nodes = { &qnm_gemnoc_pcie, &xs_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn12 = {
 	.name = "SN12",
-	.num_nodes = 2,
-	.nodes = { &qxm_pimem, &xm_gic },
+	.nodes = { &qxm_pimem, &xm_gic, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn13 = {
 	.name = "SN13",
-	.num_nodes = 1,
-	.nodes = { &qnm_lpass_anoc },
+	.nodes = { &qnm_lpass_anoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_snoc },
+	.nodes = { &qns_pcie_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn15 = {
 	.name = "SN15",
-	.num_nodes = 1,
-	.nodes = { &qnm_gemnoc },
+	.nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
index e7a1b2fc69babe15b914da8d3a3769bfed110179..0987a7e9dddda298b1afca4ad95f6d8a909d57e6 100644
--- a/drivers/interconnect/qcom/qcs8300.c
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -1477,26 +1477,22 @@ static struct qcom_icc_node srvc_snoc = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 2,
-	.nodes = { &qxm_crypto_0, &qxm_crypto_1 },
+	.nodes = { &qxm_crypto_0, &qxm_crypto_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 2,
-	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
+	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 66,
 	.nodes = { &qhs_ahb2phy2, &qhs_ahb2phy3,
 		   &qhs_anoc_throttle_cfg, &qhs_aoss,
 		   &qhs_apss, &qhs_boot_rom,
@@ -1529,147 +1525,126 @@ static struct qcom_icc_bcm bcm_cn1 = {
 		   &qns_gpdsp_noc_cfg, &qns_mnoc_hf_cfg,
 		   &qns_mnoc_sf_cfg, &qns_pcie_anoc_cfg,
 		   &qns_snoc_cfg, &qxs_boot_imem,
-		   &qxs_imem, &xs_sys_tcu_cfg },
+		   &qxs_imem, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn2 = {
 	.name = "CN2",
-	.num_nodes = 3,
 	.nodes = { &qhs_qup0, &qhs_qup1,
-		   &qhs_qup3 },
+		   &qhs_qup3, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn3 = {
 	.name = "CN3",
-	.num_nodes = 2,
-	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+	.nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_gna0 = {
 	.name = "GNA0",
-	.num_nodes = 1,
-	.nodes = { &qxm_dsp0 },
+	.nodes = { &qxm_dsp0, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf, &qnm_mdp0_0,
-		   &qnm_mdp0_1, &qns_mem_noc_hf },
+		   &qnm_mdp0_1, &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
-	.num_nodes = 6,
 	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf,
 		   &qnm_video0, &qnm_video_cvp,
-		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+		   &qnm_video_v_cpu, &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsa0 = {
 	.name = "NSA0",
-	.num_nodes = 2,
-	.nodes = { &qns_hcp, &qns_nsp_gemnoc },
+	.nodes = { &qns_hcp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsa1 = {
 	.name = "NSA1",
-	.num_nodes = 1,
-	.nodes = { &qxm_nsp },
+	.nodes = { &qxm_nsp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pci0 = {
 	.name = "PCI0",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.vote_scale = 1,
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.vote_scale = 1,
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.vote_scale = 1,
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qup3_core_slave },
+	.nodes = { &qup3_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
-	.num_nodes = 1,
-	.nodes = { &chm_apps },
+	.nodes = { &chm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 2,
-	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc },
+	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 2,
-	.nodes = { &qns_a2noc_snoc, &qnm_aggre2_noc },
+	.nodes = { &qns_a2noc_snoc, &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
-	.num_nodes = 2,
-	.nodes = { &qns_sysnoc, &qnm_lpass_noc },
+	.nodes = { &qns_sysnoc, &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index a7392eb73d4a990ec65e9d55f3d0429d05270802..727482c0f7f8f15e32cf508a5f7300546e9d2daf 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -770,19 +770,16 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
-	.num_nodes = 44,
 	.nodes = { &qhm_qpic, &qhm_qspi,
 		   &qnm_gemnoc_cnoc, &qnm_gemnoc_modem_slave,
 		   &qnm_gemnoc_pcie, &xm_sdc,
@@ -804,68 +801,56 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_vsense_ctrl_cfg, &qns_ddrss_cfg,
 		   &qns_modem, &qxs_imem,
 		   &qxs_pimem, &xs_ethernet_ss,
-		   &xs_qdss_stm, &xs_sys_tcu_cfg
-	},
+		   &xs_qdss_stm, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.num_nodes = 2,
-	.nodes = { &qup0_core_slave, &qup1_core_slave },
+	.nodes = { &qup0_core_slave, &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
-	.num_nodes = 11,
 	.nodes = { &alm_sys_tcu, &chm_apps,
 		   &qnm_ecpri_dma, &qnm_fec_2_gemnoc,
 		   &qnm_pcie, &qnm_snoc_gc,
 		   &qnm_snoc_sf, &qxm_mdsp,
 		   &qns_gem_noc_cnoc, &qns_modem_slave,
-		   &qns_pcie
-	},
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
-	.num_nodes = 6,
 	.nodes = { &qhm_gic, &qxm_pimem,
 		   &xm_gic, &xm_qdss_etr0,
-		   &xm_qdss_etr1, &qns_gemnoc_gc
-	},
+		   &xm_qdss_etr1, &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 5,
 	.nodes = { &qnm_aggre_noc, &qxm_ecpri_gsi,
 		   &xm_ecpri_dma, &qns_anoc_snoc_gsi,
-		   &qns_ecpri_gemnoc
-	},
+		   &qns_ecpri_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
-	.num_nodes = 2,
-	.nodes = { &qns_pcie_gemnoc, &xs_pcie },
+	.nodes = { &qns_pcie_gemnoc, &xs_pcie, NULL },
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index 04b4abbf44875c767ac67c552b36a8c64a06b2c3..6bbe2fe03f791dd5d3606114d71d62057ddc52d2 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -1603,26 +1603,22 @@ static struct qcom_icc_node srvc_snoc = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = 0x8,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 2,
-	.nodes = { &qxm_crypto_0, &qxm_crypto_1 },
+	.nodes = { &qxm_crypto_0, &qxm_crypto_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 2,
-	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
+	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 76,
 	.nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 		   &qhs_ahb2phy2, &qhs_ahb2phy3,
 		   &qhs_anoc_throttle_cfg, &qhs_aoss,
@@ -1660,164 +1656,140 @@ static struct qcom_icc_bcm bcm_cn1 = {
 		   &qns_gpdsp_noc_cfg, &qns_mnoc_hf_cfg,
 		   &qns_mnoc_sf_cfg, &qns_pcie_anoc_cfg,
 		   &qns_snoc_cfg, &qxs_boot_imem,
-		   &qxs_imem, &xs_sys_tcu_cfg },
+		   &qxs_imem, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn2 = {
 	.name = "CN2",
-	.num_nodes = 4,
 	.nodes = { &qhs_qup0, &qhs_qup1,
-		   &qhs_qup2, &qhs_qup3 },
+		   &qhs_qup2, &qhs_qup3, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn3 = {
 	.name = "CN3",
-	.num_nodes = 2,
-	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+	.nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_gna0 = {
 	.name = "GNA0",
-	.num_nodes = 1,
-	.nodes = { &qxm_dsp0 },
+	.nodes = { &qxm_dsp0, NULL },
 };
 
 static struct qcom_icc_bcm bcm_gnb0 = {
 	.name = "GNB0",
-	.num_nodes = 1,
-	.nodes = { &qxm_dsp1 },
+	.nodes = { &qxm_dsp1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 5,
 	.nodes = { &qnm_camnoc_hf, &qnm_mdp0_0,
 		   &qnm_mdp0_1, &qnm_mdp1_0,
-		   &qns_mem_noc_hf },
+		   &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
-	.num_nodes = 7,
 	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf,
 		   &qnm_video0, &qnm_video1,
 		   &qnm_video_cvp, &qnm_video_v_cpu,
-		   &qns_mem_noc_sf },
+		   &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsa0 = {
 	.name = "NSA0",
-	.num_nodes = 2,
-	.nodes = { &qns_hcp, &qns_nsp_gemnoc },
+	.nodes = { &qns_hcp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsa1 = {
 	.name = "NSA1",
-	.num_nodes = 1,
-	.nodes = { &qxm_nsp },
+	.nodes = { &qxm_nsp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsb0 = {
 	.name = "NSB0",
-	.num_nodes = 2,
-	.nodes = { &qns_nspb_gemnoc, &qns_nspb_hcp },
+	.nodes = { &qns_nspb_gemnoc, &qns_nspb_hcp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsb1 = {
 	.name = "NSB1",
-	.num_nodes = 1,
-	.nodes = { &qxm_nspb },
+	.nodes = { &qxm_nspb, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pci0 = {
 	.name = "PCI0",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.vote_scale = 1,
-	.num_nodes = 2,
-	.nodes = { &qup2_core_slave, &qup3_core_slave },
+	.nodes = { &qup2_core_slave, &qup3_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
-	.num_nodes = 1,
-	.nodes = { &chm_apps },
+	.nodes = { &chm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 2,
-	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc },
+	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 2,
-	.nodes = { &qns_a2noc_snoc, &qnm_aggre2_noc },
+	.nodes = { &qns_a2noc_snoc, &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
-	.num_nodes = 2,
-	.nodes = { &qns_sysnoc, &qnm_lpass_noc },
+	.nodes = { &qns_sysnoc, &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sar2130p.c b/drivers/interconnect/qcom/sar2130p.c
index 9eac0ac7681273d6f4350f4431b81ce94dbada3f..cae3601b6789ff38e7bd88c60c4c8dd8d00e8850 100644
--- a/drivers/interconnect/qcom/sar2130p.c
+++ b/drivers/interconnect/qcom/sar2130p.c
@@ -1490,21 +1490,18 @@ static struct qcom_icc_node srvc_snoc = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.enable_mask = BIT(0),
 	.keepalive = true,
-	.num_nodes = 48,
 	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
 		   &xm_qdss_dap, &qhs_ahb2phy0,
 		   &qhs_aoss, &qhs_camera_cfg,
@@ -1528,109 +1525,96 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qns_snoc_cfg, &qxs_imem,
 		   &qxs_pimem, &srvc_cnoc,
 		   &xs_pcie_0, &xs_pcie_1,
-		   &xs_qdss_stm, &xs_sys_tcu_cfg },
+		   &xs_qdss_stm, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.enable_mask = BIT(0),
-	.num_nodes = 2,
-	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.enable_mask = BIT(0),
-	.num_nodes = 11,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_lsr,
 		   &qnm_mdp, &qnm_mnoc_cfg,
 		   &qnm_video, &qnm_video_cv_cpu,
 		   &qnm_video_cvp, &qnm_video_v_cpu,
-		   &qns_mem_noc_sf },
+		   &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.enable_mask = BIT(0),
-	.num_nodes = 13,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &chm_apps, &qnm_gpu,
 		   &qnm_mnoc_hf, &qnm_mnoc_sf,
 		   &qnm_nsp_gemnoc, &qnm_pcie,
 		   &qnm_snoc_gc, &qnm_snoc_sf,
 		   &qxm_wlan_q6, &qns_gem_noc_cnoc,
-		   &qns_pcie },
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.enable_mask = BIT(0),
-	.num_nodes = 4,
 	.nodes = { &qhm_gic, &qxm_pimem,
-		   &xm_gic, &qns_gemnoc_gc },
+		   &xm_gic, &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &qnm_lpass_noc },
+	.nodes = { &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index af2be15438403e4b46fca464b84abd1e0ebebe76..6397d693918b41e35684b180fd6b8f5cb359386e 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -1240,42 +1240,36 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 48,
 	.nodes = { &qnm_snoc,
 		   &xm_qdss_dap,
 		   &qhs_a1_noc_cfg,
@@ -1323,14 +1317,12 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_venus_cfg,
 		   &qhs_venus_throttle_cfg,
 		   &qhs_vsense_ctrl_cfg,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = false,
-	.num_nodes = 8,
 	.nodes = { &qxm_camnoc_hf0_uncomp,
 		   &qxm_camnoc_hf1_uncomp,
 		   &qxm_camnoc_sf_uncomp,
@@ -1338,70 +1330,60 @@ static struct qcom_icc_bcm bcm_mm1 = {
 		   &qxm_mdp0,
 		   &qxm_rot,
 		   &qxm_venus0,
-		   &qxm_venus_arm9
-	},
+		   &qxm_venus_arm9, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_sys_tcu },
+	.nodes = { &acm_sys_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_sf },
+	.nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qup_core_master_1, &qup_core_master_2 },
+	.nodes = { &qup_core_master_1, &qup_core_master_2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_cmpnoc },
+	.nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_apps0 },
+	.nodes = { &acm_apps0, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_cdsp_gemnoc },
+	.nodes = { &qns_cdsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
 	.keepalive = false,
-	.num_nodes = 8,
 	.nodes = { &qhm_qspi,
 		   &xm_sdc2,
 		   &xm_emmc,
@@ -1409,64 +1391,55 @@ static struct qcom_icc_bcm bcm_cn1 = {
 		   &qhs_emmc_cfg,
 		   &qhs_pdm,
 		   &qhs_qspi,
-		   &qhs_sdc2
-	},
+		   &qhs_sdc2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qxm_pimem, &qns_gemnoc_gc },
+	.nodes = { &qxm_pimem, &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co2 = {
 	.name = "CO2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_npu },
+	.nodes = { &qnm_npu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co3 = {
 	.name = "CO3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_npu_dsp },
+	.nodes = { &qxm_npu_dsp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn12 = {
 	.name = "SN12",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_gemnoc },
+	.nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 905403a3a930a2e1cd01f62e375e60c6b2d524f7..54e4ce9009bd498a840832e3f63dd9abfb86f837 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1462,26 +1462,22 @@ static struct qcom_icc_node srvc_snoc = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 2,
-	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
+	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 47,
 	.nodes = { &qnm_cnoc3_cnoc2, &xm_qdss_dap,
 		   &qhs_ahb2phy0, &qhs_ahb2phy1,
 		   &qhs_camera_cfg, &qhs_clk_ctl,
@@ -1504,154 +1500,131 @@ static struct qcom_icc_bcm bcm_cn1 = {
 		   &qns_mnoc_cfg, &qns_snoc_cfg,
 		   &qnm_cnoc2_cnoc3, &qhs_aoss,
 		   &qhs_apss, &qns_cnoc3_cnoc2,
-		   &qns_cnoc_a2noc, &qns_ddrss_cfg },
+		   &qns_cnoc_a2noc, &qns_ddrss_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn2 = {
 	.name = "CN2",
-	.num_nodes = 6,
 	.nodes = { &qhs_lpass_cfg, &qhs_pdm,
 		   &qhs_qspi, &qhs_sdc1,
-		   &qhs_sdc2, &qhs_sdc4 },
+		   &qhs_sdc2, &qhs_sdc4, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
-	.num_nodes = 1,
-	.nodes = { &qns_nsp_gemnoc },
+	.nodes = { &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co3 = {
 	.name = "CO3",
-	.num_nodes = 1,
-	.nodes = { &qxm_nsp },
+	.nodes = { &qxm_nsp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
-	.num_nodes = 2,
-	.nodes = { &qxm_camnoc_hf, &qxm_mdp0 },
+	.nodes = { &qxm_camnoc_hf, &qxm_mdp0, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm4 = {
 	.name = "MM4",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_sf },
+	.nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm5 = {
 	.name = "MM5",
-	.num_nodes = 3,
 	.nodes = { &qnm_video0, &qxm_camnoc_icp,
-		   &qxm_camnoc_sf },
+		   &qxm_camnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
-	.num_nodes = 2,
-	.nodes = { &alm_gpu_tcu, &alm_sys_tcu },
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
-	.num_nodes = 1,
-	.nodes = { &qnm_cmpnoc },
+	.nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
-	.num_nodes = 1,
-	.nodes = { &chm_apps },
+	.nodes = { &chm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
-	.num_nodes = 1,
-	.nodes = { &xm_pcie3_0 },
+	.nodes = { &xm_pcie3_0, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
-	.num_nodes = 1,
-	.nodes = { &xm_pcie3_1 },
+	.nodes = { &xm_pcie3_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 4dd1d2f2e8216271c15b91b726d4f0c46994ae78..0640ee55220d54fc977dc98f65644ecf7f50508f 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1346,47 +1346,40 @@ static struct qcom_icc_node slv_qup_core_2 = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
-	.num_nodes = 1,
-	.nodes = { &slv_ebi }
+	.nodes = { &slv_ebi, NULL }
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &slv_ebi }
+	.nodes = { &slv_ebi, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &slv_qns_llcc }
+	.nodes = { &slv_qns_llcc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &slv_qns_mem_noc_hf }
+	.nodes = { &slv_qns_mem_noc_hf, NULL }
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &slv_qns_cdsp_mem_noc }
+	.nodes = { &slv_qns_cdsp_mem_noc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &mas_qxm_crypto }
+	.nodes = { &mas_qxm_crypto, NULL }
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 57,
 	.nodes = { &mas_qnm_snoc,
 		   &slv_qhs_a1_noc_cfg,
 		   &slv_qhs_a2_noc_cfg,
@@ -1443,124 +1436,108 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &slv_qhs_usb3_2,
 		   &slv_qhs_venus_cfg,
 		   &slv_qhs_vsense_ctrl_cfg,
-		   &slv_srvc_cnoc }
+		   &slv_srvc_cnoc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
-	.num_nodes = 7,
 	.nodes = { &mas_qxm_camnoc_hf0_uncomp,
 		   &mas_qxm_camnoc_hf1_uncomp,
 		   &mas_qxm_camnoc_sf_uncomp,
 		   &mas_qxm_camnoc_hf0,
 		   &mas_qxm_camnoc_hf1,
 		   &mas_qxm_mdp0,
-		   &mas_qxm_mdp1 }
+		   &mas_qxm_mdp1, NULL }
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.num_nodes = 3,
 	.nodes = { &mas_qup_core_0,
 		   &mas_qup_core_1,
-		   &mas_qup_core_2 }
+		   &mas_qup_core_2, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
-	.num_nodes = 1,
-	.nodes = { &slv_qns_gem_noc_snoc }
+	.nodes = { &slv_qns_gem_noc_snoc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
-	.num_nodes = 6,
 	.nodes = { &mas_qxm_camnoc_sf,
 		   &mas_qxm_rot,
 		   &mas_qxm_venus0,
 		   &mas_qxm_venus1,
 		   &mas_qxm_venus_arm9,
-		   &slv_qns2_mem_noc }
+		   &slv_qns2_mem_noc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &mas_acm_apps }
+	.nodes = { &mas_acm_apps, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
-	.num_nodes = 1,
-	.nodes = { &slv_qns_gemnoc_sf }
+	.nodes = { &slv_qns_gemnoc_sf, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
-	.num_nodes = 1,
-	.nodes = { &slv_qxs_imem }
+	.nodes = { &slv_qxs_imem, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &slv_qns_gemnoc_gc }
+	.nodes = { &slv_qns_gemnoc_gc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_co2 = {
 	.name = "CO2",
-	.num_nodes = 1,
-	.nodes = { &mas_qnm_npu }
+	.nodes = { &mas_qnm_npu, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = true,
-	.num_nodes = 2,
 	.nodes = { &slv_srvc_aggre1_noc,
-		  &slv_qns_cnoc }
+		  &slv_qns_cnoc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &slv_qxs_pimem }
+	.nodes = { &slv_qxs_pimem, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
-	.num_nodes = 4,
 	.nodes = { &slv_xs_pcie_0,
 		   &slv_xs_pcie_1,
 		   &slv_xs_pcie_2,
-		   &slv_xs_pcie_3 }
+		   &slv_xs_pcie_3, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
-	.num_nodes = 1,
-	.nodes = { &mas_qnm_aggre1_noc }
+	.nodes = { &mas_qnm_aggre1_noc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
-	.num_nodes = 1,
-	.nodes = { &mas_qnm_aggre2_noc }
+	.nodes = { &mas_qnm_aggre2_noc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
-	.num_nodes = 1,
-	.nodes = { &slv_qns_pcie_mem_noc }
+	.nodes = { &slv_qns_pcie_mem_noc, NULL }
 };
 
 static struct qcom_icc_bcm bcm_sn15 = {
 	.name = "SN15",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &mas_qnm_gemnoc }
+	.nodes = { &mas_qnm_gemnoc, NULL }
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index c646cdf8a19bf6f5a581cd9491b104259259fff3..1a9b97aa9e1c5bec0cda12cb4c5a8b14af970358 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -1714,20 +1714,17 @@ static struct qcom_icc_node srvc_snoc = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 9,
 	.nodes = { &qnm_gemnoc_cnoc,
 		   &qnm_gemnoc_pcie,
 		   &xs_pcie_0,
@@ -1736,13 +1733,11 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &xs_pcie_2b,
 		   &xs_pcie_3a,
 		   &xs_pcie_3b,
-		   &xs_pcie_4
-	},
+		   &xs_pcie_4, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 67,
 	.nodes = { &qhs_ahb2phy0,
 		   &qhs_ahb2phy1,
 		   &qhs_ahb2phy2,
@@ -1809,51 +1804,42 @@ static struct qcom_icc_bcm bcm_cn1 = {
 		   &qns_mnoc_cfg,
 		   &qns_snoc_cfg,
 		   &qns_snoc_sf_bridge_cfg,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn2 = {
 	.name = "CN2",
-	.num_nodes = 4,
 	.nodes = { &qhs_qspi,
 		   &qhs_qup0,
 		   &qhs_qup1,
-		   &qhs_qup2
-	},
+		   &qhs_qup2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn3 = {
 	.name = "CN3",
-	.num_nodes = 3,
 	.nodes = { &qxs_imem,
 		   &xs_smss,
-		   &xs_sys_tcu_cfg
-	},
+		   &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 5,
 	.nodes = { &qnm_camnoc_hf,
 		   &qnm_mdp0_0,
 		   &qnm_mdp0_1,
 		   &qnm_mdp1_0,
-		   &qns_mem_noc_hf
-	},
+		   &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
-	.num_nodes = 8,
 	.nodes = { &qnm_rot_0,
 		   &qnm_rot_1,
 		   &qnm_video0,
@@ -1861,133 +1847,108 @@ static struct qcom_icc_bcm bcm_mm1 = {
 		   &qnm_video_cvp,
 		   &qxm_camnoc_icp,
 		   &qxm_camnoc_sf,
-		   &qns_mem_noc_sf
-	},
+		   &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsa0 = {
 	.name = "NSA0",
-	.num_nodes = 2,
 	.nodes = { &qns_nsp_gemnoc,
-		   &qxs_nsp_xfr
-	},
+		   &qxs_nsp_xfr, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsa1 = {
 	.name = "NSA1",
-	.num_nodes = 1,
-	.nodes = { &qxm_nsp },
+	.nodes = { &qxm_nsp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsb0 = {
 	.name = "NSB0",
-	.num_nodes = 2,
 	.nodes = { &qns_nspb_gemnoc,
-		   &qxs_nspb_xfr
-	},
+		   &qxs_nspb_xfr, NULL },
 };
 
 static struct qcom_icc_bcm bcm_nsb1 = {
 	.name = "NSB1",
-	.num_nodes = 1,
-	.nodes = { &qxm_nspb },
+	.nodes = { &qxm_nspb, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pci0 = {
 	.name = "PCI0",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_gem_noc },
+	.nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup2_core_slave },
+	.nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
-	.num_nodes = 1,
-	.nodes = { &chm_apps },
+	.nodes = { &chm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 2,
 	.nodes = { &qns_a1noc_snoc,
-		   &qnm_aggre1_noc
-	},
+		   &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 2,
 	.nodes = { &qns_a2noc_snoc,
-		   &qnm_aggre2_noc
-	},
+		   &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
-	.num_nodes = 2,
 	.nodes = { &qns_aggre_usb_snoc,
-		   &qnm_aggre_usb_noc
-	},
+		   &qnm_aggre_usb_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
-	.num_nodes = 2,
 	.nodes = { &qns_sysnoc,
-		   &qnm_lpass_noc
-	},
+		   &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index 907e1ff4ff81796ec9459ccc72a3f8c5d110ec57..7a61e2472319b0f6a2a3dee5df014640345e3e79 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -1049,105 +1049,90 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_apps_io },
+	.nodes = { &qns_apps_io, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = true,
-	.num_nodes = 7,
 	.nodes = { &qxm_camnoc_hf0_uncomp,
 		   &qxm_camnoc_hf1_uncomp,
 		   &qxm_camnoc_sf_uncomp,
 		   &qxm_camnoc_hf0,
 		   &qxm_camnoc_hf1,
 		   &qxm_mdp0,
-		   &qxm_mdp1
-	},
+		   &qxm_mdp1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_snoc },
+	.nodes = { &qns_memnoc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns2_mem_noc },
+	.nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_tcu },
+	.nodes = { &acm_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm3 = {
 	.name = "MM3",
 	.keepalive = false,
-	.num_nodes = 5,
-	.nodes = { &qxm_camnoc_sf, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9 },
+	.nodes = { &qxm_camnoc_sf, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh5 = {
 	.name = "SH5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_apps },
+	.nodes = { &qnm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_sf },
+	.nodes = { &qns_memnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 41,
 	.nodes = { &qhm_spdm,
 		   &qnm_snoc,
 		   &qhs_a1_noc_cfg,
@@ -1188,78 +1173,67 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_venus_cfg,
 		   &qhs_vsense_ctrl_cfg,
 		   &qns_cnoc_a2noc,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_qup1, &qhm_qup2 },
+	.nodes = { &qhm_qup1, &qhm_qup2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_gc },
+	.nodes = { &qns_memnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_cnoc },
+	.nodes = { &qns_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qxm_pimem, &qxs_pimem },
+	.nodes = { &qxm_pimem, &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qnm_aggre1_noc, &srvc_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qnm_aggre2_noc, &srvc_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qnm_gladiator_sodv, &xm_gic },
+	.nodes = { &qnm_gladiator_sodv, &xm_gic, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn13 = {
 	.name = "SN13",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_memnoc },
+	.nodes = { &qnm_memnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 855802be93fea1d999bc8a885f36c3c318e1d86d..9d5bd2c9943b620b41d70e9c56f8ddc32c75d5a7 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1267,105 +1267,90 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_apps_io },
+	.nodes = { &qns_apps_io, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = true,
-	.num_nodes = 7,
 	.nodes = { &qxm_camnoc_hf0_uncomp,
 		   &qxm_camnoc_hf1_uncomp,
 		   &qxm_camnoc_sf_uncomp,
 		   &qxm_camnoc_hf0,
 		   &qxm_camnoc_hf1,
 		   &qxm_mdp0,
-		   &qxm_mdp1
-	},
+		   &qxm_mdp1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_snoc },
+	.nodes = { &qns_memnoc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns2_mem_noc },
+	.nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_tcu },
+	.nodes = { &acm_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm3 = {
 	.name = "MM3",
 	.keepalive = false,
-	.num_nodes = 5,
-	.nodes = { &qxm_camnoc_sf, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9 },
+	.nodes = { &qxm_camnoc_sf, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh5 = {
 	.name = "SH5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_apps },
+	.nodes = { &qnm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_sf },
+	.nodes = { &qns_memnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = false,
-	.num_nodes = 47,
 	.nodes = { &qhm_spdm,
 		   &qhm_tic,
 		   &qnm_snoc,
@@ -1412,106 +1397,91 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_venus_cfg,
 		   &qhs_vsense_ctrl_cfg,
 		   &qns_cnoc_a2noc,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_qup1, &qhm_qup2 },
+	.nodes = { &qhm_qup1, &qhm_qup2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_gc },
+	.nodes = { &qns_memnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_cnoc },
+	.nodes = { &qns_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_pimem },
+	.nodes = { &qxm_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
 	.keepalive = false,
-	.num_nodes = 3,
-	.nodes = { &qhs_apss, &srvc_snoc, &xs_sys_tcu_cfg },
+	.nodes = { &qhs_apss, &srvc_snoc, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pcie },
+	.nodes = { &qxs_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pcie_gen3 },
+	.nodes = { &qxs_pcie_gen3, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &srvc_aggre1_noc, &qnm_aggre1_noc },
+	.nodes = { &srvc_aggre1_noc, &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &srvc_aggre2_noc, &qnm_aggre2_noc },
+	.nodes = { &srvc_aggre2_noc, &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn12 = {
 	.name = "SN12",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qnm_gladiator_sodv, &xm_gic },
+	.nodes = { &qnm_gladiator_sodv, &xm_gic, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_pcie_anoc },
+	.nodes = { &qnm_pcie_anoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn15 = {
 	.name = "SN15",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_memnoc },
+	.nodes = { &qnm_memnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 4117db046fa00c634a43d9287711589315f60210..af273e39eef3e90519635d1c310dc108a9f8b708 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -646,141 +646,121 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn0 = {
 	.name = "PN0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qhm_snoc_cfg },
+	.nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xm_apps_rdwr },
+	.nodes = { &xm_apps_rdwr, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qns_memnoc_snoc, &qns_sys_pcie },
+	.nodes = { &qns_memnoc_snoc, &qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_snoc_memnoc },
+	.nodes = { &qns_snoc_memnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn1 = {
 	.name = "PN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xm_sdc1 },
+	.nodes = { &xm_sdc1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn2 = {
 	.name = "PN2",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_audio, &qhm_spmi_fetcher1 },
+	.nodes = { &qhm_audio, &qhm_spmi_fetcher1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn3 = {
 	.name = "PN3",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_blsp1, &qhm_qpic },
+	.nodes = { &qhm_blsp1, &qhm_qpic, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_sys_tcu_cfg },
+	.nodes = { &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn5 = {
 	.name = "PN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_pcie },
+	.nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
 	.keepalive = false,
-	.num_nodes = 5,
-	.nodes = { &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3, &qns_aggre_noc },
+	.nodes = { &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3, &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_qdss_bam, &xm_qdss_etr },
+	.nodes = { &qhm_qdss_bam, &xm_qdss_etr, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_memnoc },
+	.nodes = { &qnm_memnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_memnoc_pcie },
+	.nodes = { &qnm_memnoc_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv },
+	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv, NULL },
 };
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index d3a6c6c148e5dedc95dbac3ad9b20538ce56a16d..cf24f94eef6e0e1a7c1e957e07a316803942d174 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -607,21 +607,18 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn0 = {
 	.name = "PN0",
 	.keepalive = true,
-	.num_nodes = 26,
 	.nodes = { &qhm_snoc_cfg,
 		   &qhs_aoss,
 		   &qhs_apss,
@@ -647,127 +644,109 @@ static struct qcom_icc_bcm bcm_pn0 = {
 		   &qhs_tlmm,
 		   &qhs_usb3,
 		   &qhs_usb3_phy,
-		   &srvc_snoc
-	},
+		   &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn1 = {
 	.name = "PN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xm_sdc1 },
+	.nodes = { &xm_sdc1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn2 = {
 	.name = "PN2",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_audio, &qhm_spmi_fetcher1 },
+	.nodes = { &qhm_audio, &qhm_spmi_fetcher1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn3 = {
 	.name = "PN3",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_blsp1, &qhm_qpic },
+	.nodes = { &qhm_blsp1, &qhm_qpic, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pn4 = {
 	.name = "PN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_memnoc_snoc },
+	.nodes = { &qns_memnoc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xm_apps_rdwr },
+	.nodes = { &xm_apps_rdwr, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_snoc_memnoc },
+	.nodes = { &qns_snoc_memnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_sys_tcu_cfg },
+	.nodes = { &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_pcie },
+	.nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qhm_qdss_bam, &xm_qdss_etr },
+	.nodes = { &qhm_qdss_bam, &xm_qdss_etr, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
 	.keepalive = false,
-	.num_nodes = 4,
-	.nodes = { &qnm_aggre_noc, &xm_pcie, &xm_usb3, &qns_aggre_noc },
+	.nodes = { &qnm_aggre_noc, &xm_pcie, &xm_usb3, &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_memnoc },
+	.nodes = { &qnm_memnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_memnoc_pcie },
+	.nodes = { &qnm_memnoc_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv },
+	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv, NULL },
 };
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index 7ef1f17f3292e15959cb06e3d8d8c5f3c6ecd060..ea799f7ec0c5a7e87bf6243471120c917d100ff6 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -794,14 +794,12 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 39,
 	.nodes = { &qhm_pcie_rscc, &qnm_gemnoc_cnoc,
 		   &ps_eth0_cfg, &ps_eth1_cfg,
 		   &qhs_audio, &qhs_clk_ctl,
@@ -821,57 +819,50 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &srvc_pcie_system_noc, &srvc_system_noc,
 		   &xs_pcie_0, &xs_pcie_1,
 		   &xs_pcie_2, &xs_qdss_stm,
-		   &xs_sys_tcu_cfg },
+		   &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qp0 = {
 	.name = "QP0",
-	.num_nodes = 1,
-	.nodes = { &qpic_core_slave },
+	.nodes = { &qpic_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
-	.num_nodes = 10,
 	.nodes = { &alm_sys_tcu, &chm_apps,
 		   &qnm_gemnoc_cfg, &qnm_mdsp,
 		   &qnm_snoc_sf, &xm_gic,
 		   &xm_ipa2pcie, &qns_gemnoc_cnoc,
-		   &qns_pcie, &srvc_gemnoc },
+		   &qns_pcie, &srvc_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
-	.num_nodes = 21,
 	.nodes = { &xm_pcie3_0, &xm_pcie3_1,
 		   &xm_pcie3_2, &qhm_audio,
 		   &qhm_gic, &qhm_qdss_bam,
@@ -882,19 +873,17 @@ static struct qcom_icc_bcm bcm_sn1 = {
 		   &xm_emac_0, &xm_emac_1,
 		   &xm_qdss_etr0, &xm_qdss_etr1,
 		   &xm_sdc1, &xm_sdc4,
-		   &xm_usb3 },
+		   &xm_usb3, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 2,
-	.nodes = { &qnm_aggre_noc, &qns_a1noc },
+	.nodes = { &qnm_aggre_noc, &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 2,
-	.nodes = { &qnm_pcie, &qns_pcie_gemnoc },
+	.nodes = { &qnm_pcie, &qns_pcie_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index f41d7e19ba269cba7cc07b0136a6d1fcccd8af4d..016f75ef970648b00a87483a6dee04dd8208726f 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1166,21 +1166,18 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 41,
 	.nodes = { &qnm_snoc,
 		   &xm_qdss_dap,
 		   &qhs_a1_noc_cfg,
@@ -1221,173 +1218,148 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_venus_cfg,
 		   &qhs_venus_throttle_cfg,
 		   &qhs_vsense_ctrl_cfg,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
 	.keepalive = false,
-	.num_nodes = 6,
 	.nodes = { &xm_emmc,
 		   &xm_sdc2,
 		   &qhs_ahb2phy2,
 		   &qhs_emmc_cfg,
 		   &qhs_pdm,
-		   &qhs_sdc2
-	},
+		   &qhs_sdc2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_cdsp_gemnoc },
+	.nodes = { &qns_cdsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co2 = {
 	.name = "CO2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_npu },
+	.nodes = { &qnm_npu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co3 = {
 	.name = "CO3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_npu_dsp },
+	.nodes = { &qxm_npu_dsp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = true,
-	.num_nodes = 5,
 	.nodes = { &qxm_camnoc_hf0_uncomp,
 		   &qxm_camnoc_icp_uncomp,
 		   &qxm_camnoc_sf_uncomp,
 		   &qxm_camnoc_hf,
-		   &qxm_mdp0
-	},
+		   &qxm_mdp0, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_sf },
+	.nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm3 = {
 	.name = "MM3",
 	.keepalive = false,
-	.num_nodes = 4,
-	.nodes = { &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf },
+	.nodes = { &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = false,
-	.num_nodes = 4,
-	.nodes = { &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave },
+	.nodes = { &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_sys_tcu },
+	.nodes = { &acm_sys_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_cmpnoc },
+	.nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_apps },
+	.nodes = { &acm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_gemnoc },
+	.nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm7150.c b/drivers/interconnect/qcom/sm7150.c
index c8c77407cd508dfede2821b7d52bf9da54283bad..3892e49e614ba189d29d9bb6f278835283bfaac0 100644
--- a/drivers/interconnect/qcom/sm7150.c
+++ b/drivers/interconnect/qcom/sm7150.c
@@ -1185,35 +1185,30 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = true,
-	.num_nodes = 8,
 	.nodes = { &qxm_camnoc_hf0_uncomp,
 		   &qxm_camnoc_rt_uncomp,
 		   &qxm_camnoc_sf_uncomp,
@@ -1221,84 +1216,71 @@ static struct qcom_icc_bcm bcm_mm1 = {
 		   &qxm_camnoc_hf,
 		   &qxm_camnoc_rt,
 		   &qxm_mdp0,
-		   &qxm_mdp1
-	},
+		   &qxm_mdp1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_gem_noc_snoc },
+	.nodes = { &qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_sys_tcu },
+	.nodes = { &acm_sys_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
 	.keepalive = false,
-	.num_nodes = 2,
 	.nodes = { &qxm_camnoc_nrt,
-		   &qns2_mem_noc
-	},
+		   &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm3 = {
 	.name = "MM3",
 	.keepalive = false,
-	.num_nodes = 5,
 	.nodes = { &qxm_camnoc_sf,
 		   &qxm_rot,
 		   &qxm_venus0,
 		   &qxm_venus1,
-		   &qxm_venus_arm9
-	},
+		   &qxm_venus_arm9, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh5 = {
 	.name = "SH5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_apps },
+	.nodes = { &acm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh8 = {
 	.name = "SH8",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_cdsp_gemnoc },
+	.nodes = { &qns_cdsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh10 = {
 	.name = "SH10",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_npu },
+	.nodes = { &qnm_npu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 54,
 	.nodes = { &qhm_tsif,
 		   &xm_emmc,
 		   &xm_sdc2,
@@ -1352,79 +1334,65 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_venus_throttle_cfg,
 		   &qhs_vsense_ctrl_cfg,
 		   &qns_cnoc_a2noc,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = false,
-	.num_nodes = 2,
 	.nodes = { &qhm_qup_center,
-		   &qhm_qup_north
-	},
+		   &qhm_qup_north, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
 	.keepalive = false,
-	.num_nodes = 2,
 	.nodes = { &qnm_aggre1_noc,
-		   &qns_a1noc_snoc
-	},
+		   &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
 	.keepalive = false,
-	.num_nodes = 2,
 	.nodes = { &qnm_aggre2_noc,
-		   &qns_a2noc_snoc
-	},
+		   &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn12 = {
 	.name = "SN12",
 	.keepalive = false,
-	.num_nodes = 2,
 	.nodes = { &qxm_pimem,
-		   &xm_gic
-	},
+		   &xm_gic, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_gemnoc },
+	.nodes = { &qns_pcie_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn15 = {
 	.name = "SN15",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_gemnoc },
+	.nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index edfe824cad3533cfc6263c2031838f96e1986fa5..c5dc5b55ae564683dd169de621fffcd7449a70f5 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -1284,126 +1284,108 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = false,
-	.num_nodes = 7,
 	.nodes = { &qxm_camnoc_hf0_uncomp,
 		   &qxm_camnoc_hf1_uncomp,
 		   &qxm_camnoc_sf_uncomp,
 		   &qxm_camnoc_hf0,
 		   &qxm_camnoc_hf1,
 		   &qxm_mdp0,
-		   &qxm_mdp1
-	},
+		   &qxm_mdp1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_gem_noc_snoc },
+	.nodes = { &qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc },
+	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &acm_gpu_tcu, &acm_sys_tcu },
+	.nodes = { &acm_gpu_tcu, &acm_sys_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm3 = {
 	.name = "MM3",
 	.keepalive = false,
-	.num_nodes = 4,
-	.nodes = { &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9 },
+	.nodes = { &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_cmpnoc },
+	.nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh5 = {
 	.name = "SH5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &acm_apps },
+	.nodes = { &acm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_cdsp_mem_noc },
+	.nodes = { &qns_cdsp_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co1 = {
 	.name = "CO1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_npu },
+	.nodes = { &qnm_npu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 53,
 	.nodes = { &qhm_spdm,
 		   &qnm_snoc,
 		   &qhs_a1_noc_cfg,
@@ -1456,85 +1438,73 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_venus_cfg,
 		   &qhs_vsense_ctrl_cfg,
 		   &qns_cnoc_a2noc,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = false,
-	.num_nodes = 3,
-	.nodes = { &qhm_qup0, &qhm_qup1, &qhm_qup2 },
+	.nodes = { &qhm_qup0, &qhm_qup1, &qhm_qup2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 3,
-	.nodes = { &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc },
+	.nodes = { &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+	.nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn12 = {
 	.name = "SN12",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qxm_pimem, &xm_gic },
+	.nodes = { &qxm_pimem, &xm_gic, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn15 = {
 	.name = "SN15",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_gemnoc },
+	.nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index cc1b14c1352910fd450c334fa90f2a0b390bb9bc..cd7a37ecb9b55e40e9a90a9b649ae8cced1d1bb3 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1399,105 +1399,91 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = false,
-	.num_nodes = 3,
-	.nodes = { &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1 },
+	.nodes = { &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &alm_gpu_tcu, &alm_sys_tcu },
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm2 = {
 	.name = "MM2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_sf },
+	.nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = false,
-	.num_nodes = 3,
-	.nodes = { &qup0_core_master, &qup1_core_master, &qup2_core_master },
+	.nodes = { &qup0_core_master, &qup1_core_master, &qup2_core_master, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_cmpnoc },
+	.nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm3 = {
 	.name = "MM3",
 	.keepalive = false,
-	.num_nodes = 5,
-	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_video0, &qnm_video1, &qnm_video_cvp },
+	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf, &qnm_video0, &qnm_video1,
+		   &qnm_video_cvp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &chm_apps },
+	.nodes = { &chm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_cdsp_mem_noc },
+	.nodes = { &qns_cdsp_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 52,
 	.nodes = { &qnm_snoc,
 		   &xm_qdss_dap,
 		   &qhs_a1_noc_cfg,
@@ -1549,92 +1535,79 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_venus_cfg,
 		   &qhs_vsense_ctrl_cfg,
 		   &qns_cnoc_a2noc,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_imem },
+	.nodes = { &qxs_imem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co2 = {
 	.name = "CO2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_npu },
+	.nodes = { &qnm_npu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_pcie_modem },
+	.nodes = { &xs_pcie_modem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+	.nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_gemnoc_pcie },
+	.nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn11 = {
 	.name = "SN11",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_gemnoc },
+	.nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn12 = {
 	.name = "SN12",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &qns_pcie_modem_mem_noc, &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_modem_mem_noc, &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 38105ead4f29548ab32c60aeba224fbf3909667c..3fa17b5786b726a8a61c347f9e2bb61dc0709546 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1270,28 +1270,24 @@ static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 2,
-	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
+	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
 	.keepalive = false,
-	.num_nodes = 47,
 	.nodes = { &xm_qdss_dap,
 		   &qhs_ahb2phy0,
 		   &qhs_ahb2phy1,
@@ -1338,161 +1334,138 @@ static struct qcom_icc_bcm bcm_cn1 = {
 		   &qns_ddrss_cfg,
 		   &qns_mnoc_cfg,
 		   &qns_snoc_cfg,
-		   &srvc_cnoc
-	},
+		   &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn2 = {
 	.name = "CN2",
 	.keepalive = false,
-	.num_nodes = 5,
-	.nodes = { &qhs_lpass_cfg, &qhs_pdm, &qhs_qspi, &qhs_sdc2, &qhs_sdc4 },
+	.nodes = { &qhs_lpass_cfg, &qhs_pdm, &qhs_qspi, &qhs_sdc2, &qhs_sdc4, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_nsp_gemnoc },
+	.nodes = { &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co3 = {
 	.name = "CO3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxm_nsp },
+	.nodes = { &qxm_nsp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.keepalive = false,
-	.num_nodes = 3,
-	.nodes = { &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1 },
+	.nodes = { &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm4 = {
 	.name = "MM4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_sf },
+	.nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm5 = {
 	.name = "MM5",
 	.keepalive = false,
-	.num_nodes = 6,
 	.nodes = { &qnm_camnoc_icp,
 		   &qnm_camnoc_sf,
 		   &qnm_video0,
 		   &qnm_video1,
 		   &qnm_video_cvp,
-		   &qxm_rot
-	},
+		   &qxm_rot, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
 	.keepalive = false,
-	.num_nodes = 2,
-	.nodes = { &alm_gpu_tcu, &alm_sys_tcu },
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh3 = {
 	.name = "SH3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_cmpnoc },
+	.nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh4 = {
 	.name = "SH4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &chm_apps },
+	.nodes = { &chm_apps, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_gc },
+	.nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qxs_pimem },
+	.nodes = { &qxs_pimem, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xs_qdss_stm },
+	.nodes = { &xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn5 = {
 	.name = "SN5",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xm_pcie3_0 },
+	.nodes = { &xm_pcie3_0, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn6 = {
 	.name = "SN6",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &xm_pcie3_1 },
+	.nodes = { &xm_pcie3_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn8 = {
 	.name = "SN8",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn14 = {
 	.name = "SN14",
 	.keepalive = false,
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index eb7e17df32ba656cf1934e0fc112189966b22ac2..94e60b5067625606e2b141fbde1b5d90425386d3 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1340,21 +1340,18 @@ static struct qcom_icc_node qns_mem_noc_sf_disp = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = 0x8,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.enable_mask = 0x1,
 	.keepalive = true,
-	.num_nodes = 55,
 	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
 		   &qhs_ahb2phy0, &qhs_ahb2phy1,
 		   &qhs_aoss, &qhs_camera_cfg,
@@ -1382,160 +1379,139 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qxs_imem, &qxs_pimem,
 		   &srvc_cnoc, &xs_pcie_0,
 		   &xs_pcie_1, &xs_qdss_stm,
-		   &xs_sys_tcu_cfg },
+		   &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.enable_mask = 0x1,
-	.num_nodes = 2,
-	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.num_nodes = 12,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_mdp,
 		   &qnm_mnoc_cfg, &qnm_rot,
 		   &qnm_vapss_hcp, &qnm_video,
 		   &qnm_video_cv_cpu, &qnm_video_cvp,
-		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+		   &qnm_video_v_cpu, &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup2_core_slave },
+	.nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.num_nodes = 7,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &qnm_nsp_gemnoc, &qnm_pcie,
 		   &qnm_snoc_gc, &qns_gem_noc_cnoc,
-		   &qns_pcie },
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.enable_mask = 0x1,
-	.num_nodes = 4,
 	.nodes = { &qhm_gic, &qxm_pimem,
-		   &xm_gic, &qns_gemnoc_gc },
+		   &xm_gic, &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &qnm_lpass_noc },
+	.nodes = { &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
 	.enable_mask = 0x1,
-	.num_nodes = 1,
-	.nodes = { &ebi_disp },
+	.nodes = { &ebi_disp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0_disp = {
 	.name = "MC0",
-	.num_nodes = 1,
-	.nodes = { &ebi_disp },
+	.nodes = { &ebi_disp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0_disp = {
 	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf_disp },
+	.nodes = { &qns_mem_noc_hf_disp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1_disp = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.num_nodes = 3,
 	.nodes = { &qnm_mdp_disp, &qnm_rot_disp,
-		   &qns_mem_noc_sf_disp },
+		   &qns_mem_noc_sf_disp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0_disp = {
 	.name = "SH0",
-	.num_nodes = 1,
-	.nodes = { &qns_llcc_disp },
+	.nodes = { &qns_llcc_disp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1_disp = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.num_nodes = 1,
-	.nodes = { &qnm_pcie_disp },
+	.nodes = { &qnm_pcie_disp, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index fdb97d1f1d074d17b55f10a5852ce80388b611b7..39101b4a423c1bb404a80a83eaf1ff96ccbf2bad 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -1120,21 +1120,18 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = 0x8,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.enable_mask = 0x1,
 	.keepalive = true,
-	.num_nodes = 54,
 	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
 		   &qhs_ahb2phy1, &qhs_apss,
 		   &qhs_camera_cfg, &qhs_clk_ctl,
@@ -1161,126 +1158,110 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_aoss, &qhs_tme_cfg,
 		   &qss_cfg, &qss_ddrss_cfg,
 		   &qxs_boot_imem, &qxs_imem,
-		   &xs_pcie_0, &xs_pcie_1 },
+		   &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 1,
-	.nodes = { &qhs_display_cfg },
+	.nodes = { &qhs_display_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.enable_mask = 0x1,
-	.num_nodes = 2,
-	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_lp0 = {
 	.name = "LP0",
-	.num_nodes = 2,
-	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.enable_mask = 0x1,
-	.num_nodes = 8,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_vapss_hcp,
 		   &qnm_video_cv_cpu, &qnm_video_cvp,
-		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+		   &qnm_video_v_cpu, &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup2_core_slave },
+	.nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.enable_mask = 0x1,
-	.num_nodes = 13,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &chm_apps, &qnm_gpu,
 		   &qnm_mdsp, &qnm_mnoc_hf,
 		   &qnm_mnoc_sf, &qnm_nsp_gemnoc,
 		   &qnm_pcie, &qnm_snoc_gc,
 		   &qnm_snoc_sf, &qns_gem_noc_cnoc,
-		   &qns_pcie },
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
 	.enable_mask = 0x1,
-	.num_nodes = 3,
 	.nodes = { &qhm_gic, &xm_gic,
-		   &qns_gemnoc_gc },
+		   &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index b7c321f4e4b51cbcb138e906e561325393e3e14e..9ec2f1308923e5f69c102d2c2d25d25b42711fa0 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -1492,21 +1492,18 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(0),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.enable_mask = BIT(0),
 	.keepalive = true,
-	.num_nodes = 59,
 	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
 		   &qhs_ahb2phy1, &qhs_camera_cfg,
 		   &qhs_clk_ctl, &qhs_cpr_cx,
@@ -1536,80 +1533,70 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qhs_tme_cfg, &qss_apss,
 		   &qss_cfg, &qss_ddrss_cfg,
 		   &qxs_imem, &srvc_cnoc_main,
-		   &xs_pcie_0, &xs_pcie_1 },
+		   &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.enable_mask = BIT(0),
-	.num_nodes = 2,
-	.nodes = { &qnm_nsp, &qns_nsp_gemnoc },
+	.nodes = { &qnm_nsp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_lp0 = {
 	.name = "LP0",
-	.num_nodes = 2,
-	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.enable_mask = BIT(0),
-	.num_nodes = 8,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_vapss_hcp,
 		   &qnm_video_cv_cpu, &qnm_video_cvp,
-		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+		   &qnm_video_v_cpu, &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup2_core_slave },
+	.nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.enable_mask = BIT(0),
-	.num_nodes = 15,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &alm_ubwc_p_tcu, &chm_apps,
 		   &qnm_gpu, &qnm_mdsp,
@@ -1617,32 +1604,28 @@ static struct qcom_icc_bcm bcm_sh1 = {
 		   &qnm_nsp_gemnoc, &qnm_pcie,
 		   &qnm_snoc_sf, &qnm_ubwc_p,
 		   &xm_gic, &qns_gem_noc_cnoc,
-		   &qns_pcie },
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node * const aggre1_noc_nodes[] = {
diff --git a/drivers/interconnect/qcom/sm8750.c b/drivers/interconnect/qcom/sm8750.c
index 69bc22222075280365eb419f1ad140d1aa4e752d..eba39bf966c27254ca5df43c9acd7435a69726a2 100644
--- a/drivers/interconnect/qcom/sm8750.c
+++ b/drivers/interconnect/qcom/sm8750.c
@@ -1194,21 +1194,18 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(0),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.enable_mask = BIT(0),
 	.keepalive = true,
-	.num_nodes = 44,
 	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
 		   &qhs_ahb2phy1, &qhs_camera_cfg,
 		   &qhs_clk_ctl, &qhs_crypto0_cfg,
@@ -1230,127 +1227,111 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &qns_apss, &qss_cfg,
 		   &qss_ddrss_cfg, &qxs_boot_imem,
 		   &qxs_imem, &qxs_modem_boot_imem,
-		   &srvc_cnoc_main, &xs_pcie },
+		   &srvc_cnoc_main, &xs_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 5,
 	.nodes = { &qhs_display_cfg, &qhs_i2c,
 		   &qhs_qup02, &qhs_qup1,
-		   &qhs_qup2 },
+		   &qhs_qup2, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
 	.enable_mask = BIT(0),
-	.num_nodes = 2,
-	.nodes = { &qnm_nsp, &qns_nsp_gemnoc },
+	.nodes = { &qnm_nsp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_lp0 = {
 	.name = "LP0",
-	.num_nodes = 2,
-	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
 	.enable_mask = BIT(0),
-	.num_nodes = 9,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_nrt_icp_sf,
 		   &qnm_camnoc_rt_cdm_sf, &qnm_camnoc_sf,
 		   &qnm_vapss_hcp, &qnm_video_cv_cpu,
 		   &qnm_video_mvp, &qnm_video_v_cpu,
-		   &qns_mem_noc_sf },
+		   &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup2_core_slave },
+	.nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
 	.enable_mask = BIT(0),
-	.num_nodes = 14,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &chm_apps, &qnm_gpu,
 		   &qnm_mdsp, &qnm_mnoc_hf,
 		   &qnm_mnoc_sf, &qnm_nsp_gemnoc,
 		   &qnm_pcie, &qnm_snoc_sf,
 		   &xm_gic, &chs_ubwc_p,
-		   &qns_gem_noc_cnoc, &qns_pcie },
+		   &qns_gem_noc_cnoc, &qns_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ubw0 = {
 	.name = "UBW0",
-	.num_nodes = 1,
-	.nodes = { &qnm_ubwc_p },
+	.nodes = { &qnm_ubwc_p, NULL },
 };
 
 static struct qcom_icc_node * const aggre1_noc_nodes[] = {
diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 2c46fdb4a0543f8345e03dbfe83d3a7ab95bd17c..f83a881b2becba9f7806bcc8f945e970596554b2 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -1356,20 +1356,17 @@ static struct qcom_icc_node qns_aggre_usb_south_snoc = {
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
 	.enable_mask = BIT(3),
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
-	.num_nodes = 1,
-	.nodes = { &qxm_crypto },
+	.nodes = { &qxm_crypto, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
-	.num_nodes = 63,
 	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
 		   &qhs_ahb2phy1, &qhs_ahb2phy2,
 		   &qhs_av1_enc_cfg, &qhs_camera_cfg,
@@ -1401,122 +1398,106 @@ static struct qcom_icc_bcm bcm_cn0 = {
 		   &xs_pcie_1, &xs_pcie_2,
 		   &xs_pcie_3, &xs_pcie_4,
 		   &xs_pcie_5, &xs_pcie_6a,
-		   &xs_pcie_6b },
+		   &xs_pcie_6b, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
-	.num_nodes = 1,
-	.nodes = { &qhs_display_cfg },
+	.nodes = { &qhs_display_cfg, NULL },
 };
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
-	.num_nodes = 2,
-	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_lp0 = {
 	.name = "LP0",
-	.num_nodes = 2,
-	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &ebi },
+	.nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
-	.num_nodes = 1,
-	.nodes = { &qns_mem_noc_hf },
+	.nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
-	.num_nodes = 10,
 	.nodes = { &qnm_av1_enc, &qnm_camnoc_hf,
 		   &qnm_camnoc_icp, &qnm_camnoc_sf,
 		   &qnm_eva, &qnm_mdp,
 		   &qnm_video, &qnm_video_cv_cpu,
-		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+		   &qnm_video_v_cpu, &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_pc0 = {
 	.name = "PC0",
-	.num_nodes = 1,
-	.nodes = { &qns_pcie_mem_noc },
+	.nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup0_core_slave },
+	.nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup1_core_slave },
+	.nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
 	.vote_scale = 1,
-	.num_nodes = 1,
-	.nodes = { &qup2_core_slave },
+	.nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_llcc },
+	.nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
-	.num_nodes = 13,
 	.nodes = { &alm_gpu_tcu, &alm_pcie_tcu,
 		   &alm_sys_tcu, &chm_apps,
 		   &qnm_gpu, &qnm_lpass,
 		   &qnm_mnoc_hf, &qnm_mnoc_sf,
 		   &qnm_nsp_noc, &qnm_pcie,
 		   &xm_gic, &qns_gem_noc_cnoc,
-		   &qns_pcie },
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
-	.num_nodes = 1,
-	.nodes = { &qns_gemnoc_sf },
+	.nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre1_noc },
+	.nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
-	.num_nodes = 1,
-	.nodes = { &qnm_aggre2_noc },
+	.nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
-	.num_nodes = 1,
-	.nodes = { &qnm_usb_anoc },
+	.nodes = { &qnm_usb_anoc, NULL },
 };
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {

-- 
2.39.5


