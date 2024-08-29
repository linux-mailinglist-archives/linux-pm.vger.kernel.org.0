Return-Path: <linux-pm+bounces-13137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4C963E7D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B8C1C2415F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0218C35D;
	Thu, 29 Aug 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FGooIQV8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAD18C32F;
	Thu, 29 Aug 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920190; cv=none; b=TK9ZkV/mYoS9h2sEzl2m+/l85b11OiFEIMVnEemfpDySHdVkWn7fLThSD2aiaV7bmAAH6cRfhMJEXWGEJkbleJUgLbBGi/ZdYhc83BccNSJt4oUIQfRenRtJImWVwi9bPPhHAvLZRICEgeZ9aeQFcIemv9tS2WN6r9x8tEhy8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920190; c=relaxed/simple;
	bh=P9tisSr6ef1lOr5Vhb9KaXIi8OjLo92u/X4jSrhxfQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKmaezudMCkwXCJ/fQDvcKcZN5yol/z3TqEC2YwLFtSzQkBA/nwoJAIeWygPkVVSSyvC1nAGk+RJZ+/qQxMSboR/IrMn0oZNzXe9oi8aQtrMnwajI8f/tHC3sD4mtkSbaZlnPhIwMkVXIQS8sZz+rf2MPgM/ZOrhX2G0oBHG46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FGooIQV8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJMil8014501;
	Thu, 29 Aug 2024 08:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wYuUCkpRDKwdP4oY5+dNatW9Qxgd7C/7zR7jpml/SJ4=; b=FGooIQV8o4SRNt4U
	UP32n+A+r/vu5RoUGoHtGFsyk9gZmLfL8KLiocoZC9M2SDI9ZHGKBl7GkEw2mcvl
	fvvx+/4KVJSMuKBI6NNneWKoCiGR8mIUC0xkHAkRLfqM71AJsrFF7JeEKEreayJd
	CJVDogF8mKdbjCfNXDNOxbfdS8++NXxgaZZa4kPcDiKpgCkdXuGOIWoANHBtVmyl
	ZvaeC8+s3UNRRm5rnb5hUo7USKzQ3XUoEFubY8PIPPjZJKmj+Tz8P+JVM0EWALv9
	x195xaTRaQDV2IK+3HLK5yTEMOCr0ZUOxC+Mvv17PVdyYq4exhZNsPm0T9BeOZB9
	Pjyl5A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv14ew5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T8TY2t023758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:34 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 01:29:28 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <djakov@kernel.org>, <richardcochran@gmail.com>,
        <geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <nfraprado@collabora.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v5 5/8] clk: qcom: ipq5332: Add couple of more interconnects
Date: Thu, 29 Aug 2024 13:58:27 +0530
Message-ID: <20240829082830.56959-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829082830.56959-1-quic_varada@quicinc.com>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: BX42nDhvWJrIc6lkEGnYssF_2hmYxEZ-
X-Proofpoint-ORIG-GUID: BX42nDhvWJrIc6lkEGnYssF_2hmYxEZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290062

Update the GCC master/slave list to include couple of
more interfaces needed by the Network Subsystem Clock
Controller (NSSCC)

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index c3020106dcf8..fadddf30e320 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -3650,6 +3650,8 @@ static struct qcom_icc_hws_data icc_ipq5332_hws[] = {
 	{ MASTER_NSSNOC_QOSGEN_REF, SLAVE_NSSNOC_QOSGEN_REF, GCC_NSSNOC_QOSGEN_REF_CLK },
 	{ MASTER_NSSNOC_TIMEOUT_REF, SLAVE_NSSNOC_TIMEOUT_REF, GCC_NSSNOC_TIMEOUT_REF_CLK },
 	{ MASTER_NSSNOC_XO_DCD, SLAVE_NSSNOC_XO_DCD, GCC_NSSNOC_XO_DCD_CLK },
+	{ MASTER_SNOC_NSSNOC_1_CLK, SLAVE_SNOC_NSSNOC_1_CLK, GCC_SNOC_NSSNOC_1_CLK },
+	{ MASTER_SNOC_NSSNOC_CLK, SLAVE_SNOC_NSSNOC_CLK, GCC_SNOC_NSSNOC_CLK },
 };
 
 static const struct regmap_config gcc_ipq5332_regmap_config = {
-- 
2.34.1


