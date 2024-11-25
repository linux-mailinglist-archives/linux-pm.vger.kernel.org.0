Return-Path: <linux-pm+bounces-18098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB59D8B8E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96BE1664E6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E14D1BB6B8;
	Mon, 25 Nov 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W1StGBKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39051B87FC;
	Mon, 25 Nov 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556746; cv=none; b=KuGoaQb1BRaFViPiURPNg/FSCiGfiFEM/jGRzjwlPF0fuPnM7BDyrkr9Fs9bGjXdxuT8bykTxgo+iL3Be3OvMRDrLDmymmWGXbe4QTWUpv/VPb20xlhS+F/SiR8f6afLchhF/lWe2I8phr9ZcbItEjD2Rm/W9/QXNVaxN9k9UcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556746; c=relaxed/simple;
	bh=pIPovQnD815LRJmnOBVmAXkNlXq4FT3eVOByKPec5KM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2Qwz9ixB+BEmGNL6W7Gb6xSg+cO2JhrrgYoMVr7wVwII1RQYp+TZ7fNH2Pz8CnRBcqUo+pp60SEU61Z4UwOqGn56xha+h1paxzauZPbmS3is4bHKEcWEHoTfJnjWV8EcWpYH4cekbHY3lnmkjpTgSNgK2mJOcYueYAui4Geyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W1StGBKi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBHv9C023791;
	Mon, 25 Nov 2024 17:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S4X0O2ksEnrtPzMVCX9xYZeGVi+M7F6pCos2xR4WFmA=; b=W1StGBKiwRfmX30Z
	ghPubLkEaAMG+yr7ZR1TOh1U15v86t9LRQ8prhuCkpeGpL7cexRPOAwzkZPi5rcc
	1GmnMRmbOTtZ7caEc9yVrQLs1RdIdmhCI94fblsVOEXb5nK14CLxqvq+l3SRJKBW
	HtJx4mLHXSnqVo6aSqqkUOEoeCURiExwB/Gnyc5v2bSSBqM83jF0w9uWWIPUSUad
	q/mHb2ZO4KC2YypD8bXWtMdzTxA8WbShacol6vbbxb7gdT+KLQmgpkEx+wTn4lWN
	Va9kkuZMMXQdwt8CiRm1QLnCNZ8QALZZhH9tvwM10q5UHi+kCAA3wnpu1cgSH6nh
	4anqBg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43374swmdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:45:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APHjdW8017880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:45:39 GMT
Received: from 4215f72c9660.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 09:45:35 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V6 2/4] interconnect: qcom: osm-l3: Add generic compatible for epss-l3-perf
Date: Mon, 25 Nov 2024 17:45:09 +0000
Message-ID: <20241125174511.45-3-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: 5jvT9TmnsF1hF_Mo7FKYQrgE-E3ZdQz1
X-Proofpoint-ORIG-GUID: 5jvT9TmnsF1hF_Mo7FKYQrgE-E3ZdQz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250147

The EPSS instance in SA8775P uses PERF_STATE register instead of
REG_L3_VOTE to scale L3 clocks. Add new generic compatible
"qcom,epss-l3-perf" for PERF_STATE register based L3 scaling.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index a9405b7d251b..7937e7c16c71 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -318,6 +318,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
+	{ .compatible = "qcom,epss-l3-perf", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
-- 
2.39.2


