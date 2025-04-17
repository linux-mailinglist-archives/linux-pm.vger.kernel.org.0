Return-Path: <linux-pm+bounces-25652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE9A92377
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C73189C1BB
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1186255E47;
	Thu, 17 Apr 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gUwgCD3w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6A25525E;
	Thu, 17 Apr 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909693; cv=none; b=KJ9obTPFa2K3rQe7gKW0SsMcGWYms5fuTuNiqo8lpEHVMOZ3y9NyfJAle0T9Dw9470B9M7s5rd0D6xFJ1axkrlDsIpX2Fi4/kt1etdXQxFFFYGil0cdCOOfTlfhochh+nNAiWnPTO4ywQsQuUbP3iV/kB/pyn02UnXS/OK2XibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909693; c=relaxed/simple;
	bh=RGCLGwzKxCnoTaI85CpxNMKLFKCnCNNZaCMkjsSDqWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rDZyKPUGhlyPeg1rCyue4e3VvpvPDpCYPjL7l1Gtv+9hHpX0YrMNvkskgWxGOrqluX149rKW6iR0BSsvPeO5CD7gvB7JNp0Z3sX2p1X3mc1IaX+o48uNuxpI5XYUm6pk0EN3heNRIiy8kXq5A3dyf1JlGZgrP6T88Ai1ExSDknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gUwgCD3w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClULA012773;
	Thu, 17 Apr 2025 17:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3RRwD7Oar1q2FsjGnLXVqNuplLuJfskny2oc8+PDv1E=; b=gUwgCD3wI/5OHZOL
	A5AuS0XLu+hbOolDmVcQJb7ZlGjsKPdwvK6CTvgYcZCRX5hUM99DGMZfMdrflDVp
	4tAzSFyuwVjxbTxqf7NZwa6Y4eqR16xZKg1DjL9xrSY9863YpQkDV3FOFQGtNpBv
	+OP3rOA0mwTI+XVXUAsLVNOm2EPj8Ra94/Wy9DheOTIvAjwhtFIbI7VON0D27fMW
	K9oCIFPiIWx3Jt2iDuHrFViu8WBcnEwJARXVyBmlgERfDmC7+ZbfmYSBQ0oNEyAC
	/vDkEP4S2rGCd6cF8ndMnLaQDPiNjnhUtPhANm0cjkVD+bV+BHqd9w4EnuSTkEcc
	QMcvsw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vqswy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 17:08:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HH87uo026280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 17:08:07 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 10:08:03 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
Date: Thu, 17 Apr 2025 22:37:40 +0530
Subject: [PATCH 2/3] pmdomain: qcom: rpmhpd: Add SM4450 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-sm4450_rpmhpd-v1-2-361846750d3a@quicinc.com>
References: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
In-Reply-To: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sjjmIYvwoJiGZpjQ51nbrGeh7Qi8EdCr
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=68013578 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=kKUzCdw4ExVrULsER6cA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sjjmIYvwoJiGZpjQ51nbrGeh7Qi8EdCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=826 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170125

Add power domains exposed by RPMh in the Qualcomm SM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index dfd0f80154e49d882a59dd23a8e2d755610c896b..078323b85b5648e33dd89e08cf31bdc5ab76d553 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -360,6 +360,21 @@ static const struct rpmhpd_desc sdx75_desc = {
 	.num_pds = ARRAY_SIZE(sdx75_rpmhpds),
 };
 
+/* SM4450 RPMH powerdomains */
+static struct rpmhpd *sm4450_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+};
+
+static const struct rpmhpd_desc sm4450_desc = {
+	.rpmhpds = sm4450_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm4450_rpmhpds),
+};
+
 /* SM6350 RPMH powerdomains */
 static struct rpmhpd *sm6350_rpmhpds[] = {
 	[SM6350_CX] = &cx_w_mx_parent,
@@ -724,6 +739,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
 	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
 	{ .compatible = "qcom,sdx75-rpmhpd", .data = &sdx75_desc},
+	{ .compatible = "qcom,sm4450-rpmhpd", .data = &sm4450_desc },
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
 	{ .compatible = "qcom,sm7150-rpmhpd", .data = &sm7150_desc },
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },

-- 
2.25.1


