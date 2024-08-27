Return-Path: <linux-pm+bounces-12993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA04961567
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 19:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDA0282F16
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EDD1CF28F;
	Tue, 27 Aug 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NLdu4Iv7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B481CDFC3;
	Tue, 27 Aug 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779551; cv=none; b=f2/YEGAX58EZyYvIj1FVD+QsdQrQodjK3BuFQU87lhtrSQP+4Y0UUDDo5H2CqdemLuW9otB0bYZ2v7viywl4khLEYMQqc8vXCez7EsPwE/mBjDPR6V63PA98bTtvv1vIj8zk1mwPZrKydGaokHq/2s9ZxR1mscWBO8dUmMuRVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779551; c=relaxed/simple;
	bh=gsynHgCPX56eHP2lMOSf04oHQewytQUubbE7qASTqHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RBWW+VDzaxGWqtwNx717/uxDMw7wTMZ2jGA/VsFZEcK54iX1SywcMNL9cYt21m7v8lzn2fQKRSFEOQkJSTqgHxN01QRj9xur3FXpoNI/+u9k/VrBNLVx9YzoQ8QiQZnPdScNheoKnAsWR0QQik3y216wCH+ovh2lJYMIhDiaUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NLdu4Iv7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R8N0xb006778;
	Tue, 27 Aug 2024 17:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xe7JSXGjfZ1mZqRUQ/ndIl
	0VSdiNuXwfacr3jInpd8Y=; b=NLdu4Iv7+L1F5Ff3wB5z3ZSMCHV+CzNchwv/XT
	W+ynjG2VHekDgjxGMjH2DpOnk9H0HvQp5SHIA2Q2670CKJf3kw3z5Cs5XjZ5tjK/
	HvxLADn1Lrfh4nYDUp2zNH94q4TpGuioOYCBdnJ6J1PPeIz+yaV27uotHrY4ZcMx
	ce+MDEXMvnF+MZPfkQvLTujgXxu8QoA2gDIqT+P1Qg7EioEDKkAY2TcA6gynIdiy
	yIsoaPlnup5l/1qbuOw6Ugj5z8PgaN3J0StqNUIiI0DMZFxnUSwRkX28ZGldwdzQ
	K1Krc7VUfp6y5GkZzz1gz26JugcQDtD2jg09gOYReJEOLVRg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41796kyq5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 17:25:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RHPiXF012501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 17:25:44 GMT
Received: from e94a984817b1.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 Aug 2024 10:25:41 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>, <quic_mdtipton@quicinc.com>,
        <quic_okukatla@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Raviteja
 Laggyshetty" <quic_rlaggysh@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>
Subject: [PATCH] interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency
Date: Tue, 27 Aug 2024 17:25:24 +0000
Message-ID: <20240827172524.89-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3a8WrjPVPFR8F7YSZdWPIymFHk0nOoSX
X-Proofpoint-ORIG-GUID: 3a8WrjPVPFR8F7YSZdWPIymFHk0nOoSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270131

Return -EPROBE_DEFER from interconnect provider incase probe defer is
received from devm_clk_bulk_get_all(). This would help in reattempting
the inteconnect driver probe, once the required QoS clocks are
available.
Rename qos_clks_required flag to qos_requires_clocks in qcom_icc_desc
structure. This flag indicates that interconnect provider requires
clocks for programming QoS.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 10 +++++++---
 drivers/interconnect/qcom/icc-rpmh.h |  2 +-
 drivers/interconnect/qcom/sc7280.c   |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index f49a8e0cb03c..5417abf59e28 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -311,9 +311,13 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		}
 
 		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
-		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
-			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
-			goto skip_qos_config;
+		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_requires_clocks)) {
+			if (qp->num_clks != -EPROBE_DEFER) {
+				dev_info(dev, "Skipping QoS, failed to get clk: %d\n",
+						qp->num_clks);
+				goto skip_qos_config;
+			}
+			return qp->num_clks;
 		}
 
 		ret = qcom_icc_rpmh_configure_qos(qp);
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 14db89850fb3..82344c734091 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -153,7 +153,7 @@ struct qcom_icc_desc {
 	size_t num_nodes;
 	struct qcom_icc_bcm * const *bcms;
 	size_t num_bcms;
-	bool qos_clks_required;
+	bool qos_requires_clocks;
 };
 
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 167971f8e8be..6c314e000c3a 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1691,7 +1691,7 @@ static const struct qcom_icc_desc sc7280_aggre1_noc = {
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
-	.qos_clks_required = true,
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -1723,7 +1723,7 @@ static const struct qcom_icc_desc sc7280_aggre2_noc = {
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
-	.qos_clks_required = true,
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
-- 
2.39.2


