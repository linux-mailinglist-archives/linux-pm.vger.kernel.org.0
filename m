Return-Path: <linux-pm+bounces-14871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B39883C1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301901C22A50
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220518BBB0;
	Fri, 27 Sep 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n6/FUp0/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082C18BBAB;
	Fri, 27 Sep 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438424; cv=none; b=JV+jPuhZqljis3eRmK45dLZZ00Qz+cnRLf2QcJCdegfnWA3SFwhUI7l3I3+BjCLJvQfkWK72a0+N3pzzXGNPpoWB+D4X+qjaZHsMIjTtvV9liumrHSL3yDNAgBz/OL1JLWhGiwYTOg19vQhmJ/zPs4Crn/VCoLVSXjBb+l4Yq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438424; c=relaxed/simple;
	bh=KiWNR4u/65xMmaqypvhKSc5m4ZESgrg/Ieajt/VQUWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UqcXKWkTP8oPkT0WsIuQUt/HOvcKPoHOc1CmeTg1uTo4d+U8DRSK1EFAtcAi3jlyIh0M5/Sc7u9ptapSArIlhjrsNWXIRhoSTo/pPrInM+3yNjakvg754FtWtV95pZN47u/t1TYG3zr9f4iBCGvvwblyuPZaDmBi9GbhdMrApxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n6/FUp0/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6aOWV014838;
	Fri, 27 Sep 2024 12:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B0Vfl7VdKh0tBkOUpt5Cb/KYoBsGDN2QdYVHbAKRIKc=; b=n6/FUp0/08b/OLuK
	BhCEl65qofQUQOs+29vSABJTx6woA5kKx1nBq5Xtz/hK+ty9qjLHjRk4AALmricP
	NNOf38ewwRqorqOUv2aCooRpgjfa0elZRWRxQ5c2h3IsThZfLDX4W+NCKzmQkduU
	K+eHA1gkozquLwWzrlkkOGC1HYFPBodaN1pw6D4VyLVIiITwpFDuZp8dcdueEsfz
	frqUzr+W9QHgbimTutMauiPRT8mpT2NutjXMKzs0zDEooIAGovYJZmzYmPuD2l58
	+Q6oVsx+ECEwz8AzS7XvIzKsFAZ3Tca/QIl0xNWPBc2qyxc333Nb5vZRX5I+esIF
	BKSt5Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41spc32smr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:00:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RC0GD5017298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:00:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 05:00:09 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Date: Fri, 27 Sep 2024 19:59:16 +0800
Subject: [PATCH v2 4/4] pmdomain: qcom: rpmhpd: Add qcs615 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-4-18c030ad7b68@quicinc.com>
References: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com>
In-Reply-To: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <quic_tingweiz@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727438391; l=1321;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=KiWNR4u/65xMmaqypvhKSc5m4ZESgrg/Ieajt/VQUWA=;
 b=YWUxC0OTV3ENrF1LLerQn8r5XNbhk8BX7CX4AdP/MgfNXSigRcvogOQlxQ9/qAV3ilmkzAP+E
 ec+w898+eFHADELzMZMr3qM9P72SVmjQNxIBz4X6BDkKJkqeWjSomKM
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GxxnW90NFOkY4kQC9e7ZNyMyl4Q5w6EM
X-Proofpoint-ORIG-GUID: GxxnW90NFOkY4kQC9e7ZNyMyl4Q5w6EM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=956
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270086

Add support for power domains exposed by RPMh on the qcs615 platform.
Only CX/CX_AO are exposed by RPMh. Consumers such as VDD_MX, EBI, LPI_
MX and LPI_CX will share the power domains.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index d256110225dc517187b2ac1bbbb781eae78b7d59..731feab9f17ddae699815332d193e9a298fff0e1 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -647,7 +647,19 @@ static const struct rpmhpd_desc qcs8300_desc = {
 	.num_pds = ARRAY_SIZE(qcs8300_rpmhpds),
 };
 
+/* QCS615 RPMH powerdomains */
+static struct rpmhpd *qcs615_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+};
+
+static const struct rpmhpd_desc qcs615_desc = {
+	.rpmhpds = qcs615_rpmhpds,
+	.num_pds = ARRAY_SIZE(qcs615_rpmhpds),
+};
+
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
 	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
 	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
 	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },

-- 
2.34.1


