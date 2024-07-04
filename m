Return-Path: <linux-pm+bounces-10608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C498927685
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29889B222FD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7A1AE86E;
	Thu,  4 Jul 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l3qk7iYb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD171AE861;
	Thu,  4 Jul 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097754; cv=none; b=n8yypXpdQAx+ORxrEZKvfNP3rXxSlGUJtV2lHvQ9DuD1lSOZvIRFZe7Hd++HiFVf0pB1O876rtXiRiEiU+wYJDZVPUgssMvPxxZDt+nny4A+s1FLUJo7FgDqf1l2uYLZtvyVMhPARUOqO7tcIUeWEOueeU8a3B2WR7cJe32i3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097754; c=relaxed/simple;
	bh=3Gn+5X8kApPn/TQHUrXkCfhIU8vbH4qzNoznN0rMLNw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ke7UfqyTuF/lPdRqyWDCCEAJFSNU62/hIkTHf/cFRmEUvzIbIqhIuvzROEj2yzjQ8qCiUWRbwRqf5eTqInk7pd8iXlU4AYwfXOAMQsLyY/SouGKgZsLuMQ7wf7hcxMiDD94zQo2nX+JpQZKUvaPzFNEwItR01QFiRJ0G9OTqReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l3qk7iYb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4648bkRD000337;
	Thu, 4 Jul 2024 12:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=nFqrxVv5j0XXUicQugiyuQ7XNx0h0LFXvHKht5Lk8gM=; b=l3
	qk7iYbvmy6XZFdIUZ5xyNuIZp3pU+r1ghTijs1lc/Vy7lKxy1S2tmD3sIyBFlorq
	UkeE2EiZ8kSd2B/n7VQeAZBjJyh5iS/qWco4iS9IGD2zU18YDgmLTmt8Kr1f2I3O
	b4s5vvfSAP7TDDGwhqDQIC+dlHzx1Z+D3/t0janRbvPM1vzqdwOhbQacRg/KlfJJ
	vJqY6CrSwCttaz1Rasm3zPbQS74SsPXr/dbQc3v8XUZv93d6u5QfPUEwxis3VvZv
	3NGlLalaZXTbbGU7ibJnBIxKX7dwlKuudl+urJWqv1sDYE6oUhiRgco4BFKJm2pq
	oUdiZHpl+RtkddHETR7g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402abtuh34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 12:55:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 464Ctjxw031604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 12:55:45 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 05:55:40 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>, <quic_okukatla@quicinc.com>
Subject: [PATCH] interconnect: qcom: Fix DT backwards compatibility for QoS
Date: Thu, 4 Jul 2024 18:25:15 +0530
Message-ID: <20240704125515.22194-1-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qWI9-P1L0w6GS7MJ0lnPkwwiJiQtu9Dg
X-Proofpoint-ORIG-GUID: qWI9-P1L0w6GS7MJ0lnPkwwiJiQtu9Dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_09,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040092

Add qos_clks_required flag to skip QoS configuration if clocks property
is not populated in devicetree for providers which require clocks to be
enabled for accessing registers. This is to keep the QoS configuration
backwards compatible with devices that have older DTB.

Reported-by: Bjorn Andersson <andersson@kernel.org>
Closes: https://lore.kernel.org/all/ciji6nlxn752ina4tmh6kwvek52nxpnguomqek6plwvwgvoqef@yrtexkpmn5br/
Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 2 +-
 drivers/interconnect/qcom/icc-rpmh.h | 1 +
 drivers/interconnect/qcom/sc7280.c   | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 93047defd5e2..f49a8e0cb03c 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -311,7 +311,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		}
 
 		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
-		if (qp->num_clks < 0) {
+		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
 			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
 			goto skip_qos_config;
 		}
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 9a5142c70486..14db89850fb3 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -153,6 +153,7 @@ struct qcom_icc_desc {
 	size_t num_nodes;
 	struct qcom_icc_bcm * const *bcms;
 	size_t num_bcms;
+	bool qos_clks_required;
 };
 
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 759c609a20bf..167971f8e8be 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1691,6 +1691,7 @@ static const struct qcom_icc_desc sc7280_aggre1_noc = {
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+	.qos_clks_required = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -1722,6 +1723,7 @@ static const struct qcom_icc_desc sc7280_aggre2_noc = {
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+	.qos_clks_required = true,
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
-- 
2.17.1


