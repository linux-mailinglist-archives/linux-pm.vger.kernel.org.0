Return-Path: <linux-pm+bounces-14007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A2974EA7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CB5B288E3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26C155C8D;
	Wed, 11 Sep 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P9Nuur/a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814642056;
	Wed, 11 Sep 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047341; cv=none; b=INO8EcWSJLXqNBDW1HCL9UT1+gbOqn5tSUqm9iFhq57A10aR/onlTGx7XQ6bbpWC6NZTNQjhdSKOYJiPcAjd+7OMtBZ1Mseh4HiPSfcBz28j/Ho/auts3oIvi/Z+0d6luRJseVwpLBtKA/IR+o35c0JQ/3Y4tl6K/B5/TRK/+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047341; c=relaxed/simple;
	bh=+91lVVa3RUDo0l9MfUoea9C8CA6w34PFhLFTz+YksDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQHaugvZ9rV1Pm0ZixTQt3GJtUZNEMe83wppgCQSey9Dj4GS6GNN7iMvIzE0w74ropIjr9cWnFdaiBh4ZancjbJtt3C7G+i1+ZOKIJdAjbl99E+Vg7K1nb85X4xeLpvNYCCxgXGmnHOvWWvccB8JrwcWmy5Iy/KUqCScRy5OD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P9Nuur/a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B3BIkN026760;
	Wed, 11 Sep 2024 09:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GSkiklr25G52KpQ9QtjbXz
	QlfDQ20VKpmU5TPOUyysg=; b=P9Nuur/aJKqFmE+XxSfdCdlDo/aPK0bfFgYMN2
	mPUOMvTIs/e3IXnCA8QuZUA7i3RVtUzk+kC61h2Lqy0scIXoMGEC7V9WFKow22Q7
	gLUh8aXSVjs0qqAKPOpLBa66IDGDETP6g7z29myyr+0HA9L6KzrcOwOlR7LI5U04
	P0fST57c31/0hAgoB9tgrQh67UCrfXHvFYz4xLbwn133BtUswb1MXAQ+SxIse845
	BJ/RxYjw8etoqh7v9CcEBVcytSDMSHeTcyqw/bbdr4xnFtuw4uf3vLKwQ3CJUKOr
	SUVDK1nc6a0MJraCas/KdcL7V60vp8cjSigiaLyVnoD90AKg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy7314hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:35:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48B9ZYj4004156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:35:34 GMT
Received: from 13375c2f25f8.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Sep 2024 02:35:30 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] interconnect: qcom: icc-rpmh: rename qos_clks_required flag
Date: Wed, 11 Sep 2024 09:35:16 +0000
Message-ID: <20240911093516.22347-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: z7MiI2f5n7fPuefjE2oGPcWF_YfctJC2
X-Proofpoint-GUID: z7MiI2f5n7fPuefjE2oGPcWF_YfctJC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409110072

rename qos_clks_required flag to qos_requires_clocks in qcom_icc_desc
structure. This flag indicates that clocks are required for accessing
and programming the QoS registers.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 2 +-
 drivers/interconnect/qcom/icc-rpmh.h | 2 +-
 drivers/interconnect/qcom/sc7280.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index f49a8e0cb03c..70a24f5e6249 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -311,7 +311,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		}
 
 		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
-		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
+		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_requires_clocks)) {
 			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
 			goto skip_qos_config;
 		}
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


