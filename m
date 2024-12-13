Return-Path: <linux-pm+bounces-19185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5339F0A3F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 11:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF35F2833C8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27D1D88D0;
	Fri, 13 Dec 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mUPDLJcf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830281C3C05;
	Fri, 13 Dec 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087516; cv=none; b=rpx/n/BBBjSobvhuZBzg3+pcC9KyAcD4mdfsVLp1aosH1S2pBvudnx6PXtlc+miwWVjNm/kjfhAPeLqQ/GyilF9zBXMCQUwOpQLYRg7oJHMg8JejX+gNcPGUCONzppP8OEcCojAEVnVOUcuV4BGHKd8QcQTxk/30F4ncYbN1adw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087516; c=relaxed/simple;
	bh=WHwwhGR0mqZ1PJuHXa6WE/npAJ7nlcGOlL0R7dFoqL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeqK+YPJeB+IGG+Rubgh4xpYkYv3j2SaNd3cLpntMTHU4dnLf5C06vz994qZ+iwjFx5WUWD2586y/s3aKNE8kViZCErM7KRgDodIbsgMMHe9BkpCXVUisk1KiBlIQYg2rx2Aif017GrISg9Cf+OsVBv+3WRIVvfvPO92j4YGIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mUPDLJcf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9nY8C017413;
	Fri, 13 Dec 2024 10:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2pSo3lXRJQtSh+qipR8QpslKqMs5fLPQd7tWTHgAK1k=; b=mUPDLJcfkrwjKqi6
	u+ctPccu8fKQbbSvAeZiUUy9rQ53WsWC05hiWN+JinJZ3nvULI8OSDErFWbwo/W8
	oxeV6tvqBxE15n1+wYuFSZSxXel4llgNjPTyDNJqC/eeMdmp+8HYJ06joGxfxyPz
	0slUcKlcNJnApqEZ2RQoxD+n+H/JzP1gqYdfigLqqSdS37HoptBBK+VsK9TiQhDs
	cEG5qOJIEnuZV3hq0YPcLpfJmhL8+O2tYRXCHqbOfnxrJ4LS53arnAI52Z1g8oBn
	lOgiSVMF+SQtUE2jnMM9h6ujPog8Y/Yg7TFGdFZnUFHS16rqERhD2tqImU1pEkpQ
	xaeGcQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjmt07tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 10:58:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDAwTgK028537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 10:58:29 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 02:58:25 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <djakov@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 2/2] clk: qcom: ipq5424: Use icc-clk for enabling NoC related clocks
Date: Fri, 13 Dec 2024 16:28:08 +0530
Message-ID: <20241213105808.674620-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213105808.674620-1-quic_varada@quicinc.com>
References: <20241213105808.674620-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i3MzLJyya9fDYA7EAzrp8MpZ-q2iB9RQ
X-Proofpoint-ORIG-GUID: i3MzLJyya9fDYA7EAzrp8MpZ-q2iB9RQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130075

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5424.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
index 88a7d5b2e751..eb16f44f6864 100644
--- a/drivers/clk/qcom/gcc-ipq5424.c
+++ b/drivers/clk/qcom/gcc-ipq5424.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/interconnect-provider.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -12,6 +13,7 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq5424.h>
 #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
 
 #include "clk-alpha-pll.h"
@@ -3230,6 +3232,20 @@ static const struct qcom_reset_map gcc_ipq5424_resets[] = {
 	[GCC_QUSB2_1_PHY_BCR] = { 0x3C030, 0 },
 };
 
+#define IPQ_APPS_ID			5424	/* some unique value */
+
+static const struct qcom_icc_hws_data icc_ipq5424_hws[] = {
+	{ MASTER_ANOC_PCIE0, SLAVE_ANOC_PCIE0, GCC_ANOC_PCIE0_1LANE_M_CLK },
+	{ MASTER_CNOC_PCIE0, SLAVE_CNOC_PCIE0, GCC_CNOC_PCIE0_1LANE_S_CLK },
+	{ MASTER_ANOC_PCIE1, SLAVE_ANOC_PCIE1, GCC_ANOC_PCIE1_1LANE_M_CLK },
+	{ MASTER_CNOC_PCIE1, SLAVE_CNOC_PCIE1, GCC_CNOC_PCIE1_1LANE_S_CLK },
+	{ MASTER_ANOC_PCIE2, SLAVE_ANOC_PCIE2, GCC_ANOC_PCIE2_2LANE_M_CLK },
+	{ MASTER_CNOC_PCIE2, SLAVE_CNOC_PCIE2, GCC_CNOC_PCIE2_2LANE_S_CLK },
+	{ MASTER_ANOC_PCIE3, SLAVE_ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK },
+	{ MASTER_CNOC_PCIE3, SLAVE_CNOC_PCIE3, GCC_CNOC_PCIE3_2LANE_S_CLK },
+	{ MASTER_CNOC_USB, SLAVE_CNOC_USB, GCC_CNOC_USB_CLK },
+};
+
 static const struct of_device_id gcc_ipq5424_match_table[] = {
 	{ .compatible = "qcom,ipq5424-gcc" },
 	{ }
@@ -3260,6 +3276,8 @@ static const struct qcom_cc_desc gcc_ipq5424_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq5424_resets),
 	.clk_hws = gcc_ipq5424_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5424_hws),
+	.icc_hws = icc_ipq5424_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_hws),
 };
 
 static int gcc_ipq5424_probe(struct platform_device *pdev)
@@ -3272,6 +3290,7 @@ static struct platform_driver gcc_ipq5424_driver = {
 	.driver = {
 		.name   = "qcom,gcc-ipq5424",
 		.of_match_table = gcc_ipq5424_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.34.1


