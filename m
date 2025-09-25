Return-Path: <linux-pm+bounces-35366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28665B9FDFD
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071D92A0605
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1B2C21DD;
	Thu, 25 Sep 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lxebj1BH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357329D294;
	Thu, 25 Sep 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809171; cv=none; b=DAb29jtgEHEXELwyUJLUemClf2rX6qxrEH4OMiHvp75Elw6R+JSGi5Lmkcr9zlTZMwcsJBNzktjj8HpFLqAEkoCB+2cjpB7O66H4PFzmU7udKXLUIi2SD7P+sjh6VGH5jeuXGcImtC5nxQ55m/bTDxeJqnt3IhYte14fHHOBPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809171; c=relaxed/simple;
	bh=XHI8VfssT8TXCoN4er/kyiGN6nl4rHF+YYu+JVq/pus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RdpcyBqDnLY40GP8QL5pO5wR7P2FZAw8RuELWRxMzW+T3wQYXN328TZhzES1me6uZCYy/1eZGDoqjoOOoLVdRL4Oy56fttAIWuINtf2x498c/uu0PqQBghykCkz37YIPW5vzlQaT8GoLxbfPW/Xt15o4qW29HbVqZyxjOWVVEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lxebj1BH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9W4EO027759;
	Thu, 25 Sep 2025 14:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l8/RDSr3wxyj04sQTxGcHVZE/ZHAVLo1f9za9ix8zR4=; b=Lxebj1BH3B7ks7rP
	2OQeT6JJ4jq790P+yF5fdiRf1n0AenMFQpS8BlubTuQAfxKWveeBAPqTdleszUHW
	RRQFbptMNFLbC+rd4eYnHN0Y//J5ImFk2YhjM0Vwmgzdfk8Mtbb1av9j3zYuHSuh
	rZ1RoAGBZpWdLkrckf+a9ywTgsnGBD0OzZ+uV6uWxvxJrMSK5Q/4V36hyN7eofgX
	q/BVHk50J26QEykeiSCFnopfaA+0WCe0Qw88u5pKkK7sTg2noZnJCOvMJ3JzFVCg
	5Y7hOXCEvC94UOD2e4UMj48Ze4fwR8xYYOO64ZciOFRQyEEgeM6ADY46lhpl0yAk
	8APxQQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmp0qfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:05:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58PE5u9q015639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:05:56 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 07:05:50 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 25 Sep 2025 22:05:35 +0800
Subject: [PATCH v6 01/10] clk: qcom: gcc-ipq5424: Correct the
 icc_first_node_id
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250925-qcom_ipq5424_nsscc-v6-1-7fad69b14358@quicinc.com>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
In-Reply-To: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758809144; l=1283;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=XHI8VfssT8TXCoN4er/kyiGN6nl4rHF+YYu+JVq/pus=;
 b=VSy78jZdt6qEvzn0dpU9As7gOA0tHKS8p8WQ45pSteNru/LBOzFnm9hYVYcXnyghNwe9mOvn9
 MmaGvZJz+r/ClUttp46HvxyawGAwA179Xp4n8VFxnqatf+XqGZr8Fmr
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d54c45 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=yUHhXAd9wW1YfvQ6HRQA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: r_xBgym7hRq0UlcSMNNjPNvXC-973mDw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX5fkI1M+8TRci
 2sboO+o+Bl9fxU7TFNnGaRKAZBuPKQosBCun27xdDZRhT2BFLOo3yTBxeZfC1sUFeSWswobeFq+
 UBPxA2G+RxQ4ZuSkm54qmb5fNgmBJi9nHaiLsAxpDd7ZKRc9FDeoQEE3y5XDjr6y4sQGjEGRzj6
 9jZxqf5GZ66YpCXaM3VEec7aZHAD4TVFse18hZmGz1JFGO2I2TNRZOzdKY0APvMMwk/615fbPT1
 wwsBys5EYvu15yMApFXju4pP2a1uUPNkSilehN4R/NdooAOX9GHaAvGf8F86r5tFWf3TXJ3J2iO
 JEFPYdKy22aegbpywBw/jufV2+njlqscGn5ahcEDsCCzEdxf2CWZ/uxffohTdHcCD6cCCgp9BfM
 aRxYAGBX
X-Proofpoint-GUID: r_xBgym7hRq0UlcSMNNjPNvXC-973mDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Update to use the expected icc_first_node_id for registering the icc
clocks, ensuring correct association of clocks with interconnect nodes.

Fixes: 170f3d2c065e ("clk: qcom: ipq5424: Use icc-clk for enabling NoC related clocks")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5424.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
index 3d42f3d85c7a..71afa1b86b72 100644
--- a/drivers/clk/qcom/gcc-ipq5424.c
+++ b/drivers/clk/qcom/gcc-ipq5424.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/clk-provider.h>
@@ -3284,6 +3284,7 @@ static const struct qcom_cc_desc gcc_ipq5424_desc = {
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5424_hws),
 	.icc_hws = icc_ipq5424_hws,
 	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq5424_probe(struct platform_device *pdev)

-- 
2.34.1


