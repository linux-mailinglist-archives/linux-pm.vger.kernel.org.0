Return-Path: <linux-pm+bounces-14508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89297D07E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 06:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9518D1F25209
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A93FB3B;
	Fri, 20 Sep 2024 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZVWdQJt2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C839FF3;
	Fri, 20 Sep 2024 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726805406; cv=none; b=AJ9L2bXrVVsCwq0naFi/f4aQv7GL8WPUV1xdlfEabqoAUBzymioZvsK3frGiEjH3Mo6a3rCHvVodLgx9w65JBdwf4HcNfUzUz8Ztg8FT/EMLbwYjRlYph9HEveaxR5t02B9+CWda0FXoWeMDvnrJRBnAZO8RQqgeRnMAUnPPOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726805406; c=relaxed/simple;
	bh=fGY465fPxPnsIw+Y93jmM0Tu0PBXif6k31w7BflKY9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fvDvjT2JKyS8PPqwafPGCFfwpO14SgKW3aoCqdKGdAnszsz6BSWtBmnb8wvPqZFLqdeQdXkIFEqqPffVYMN7oYdeETWO9M+NItbSLLgD0FGBDqsc6v5ySFkplQ5uJZFG+JjK2vQ+29B//gBqEfK1d44flDxKs2sytniF5x1FdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZVWdQJt2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ3vbi011583;
	Fri, 20 Sep 2024 04:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nOPelszodDz3AmPCLxfhnUFKnxvI6Zqr4ec4XZqs5s=; b=ZVWdQJt2bCQh2QQr
	CXzFrIqOcnEKFi1jcLmkKZ1MITEVS6yik3oOzd4sVy121UjEBdK1ucaQlnuX0wC9
	ymqopjel/UwSx+8smIAjF9W/ZGTWnNqPBru+okDicE5o3pJd4Of5Nx/u2PE3F/Sb
	6DcNeuMeWa12ftqeNxY8BR5GF36rdYhJ9hN2CUefb8B4hDKQo5sSszTRH7ZrurVy
	LB3KyqjTdoYNphc2cS2kCz5A8ngWOVPXd1yItWO1mU4LkvgKMMK7uuLt2MMMtDem
	fNyTu24hRVtLdFo/hpgFg0yJPRfHGMxsQCxLkVmrRnp2M4PlnNofYC6RGJ8IaRTv
	cN8nxw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gd7hq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:10:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K4A0Cw029265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:10:00 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 21:09:54 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Date: Fri, 20 Sep 2024 12:08:43 +0800
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add qcs615 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240920-add_qcs615_powerdomains_driver_support-v1-2-8846efaf9454@quicinc.com>
References: <20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com>
In-Reply-To: <20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>, Tingguo Cheng <quic_tingguoc@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726805387; l=1323;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=fGY465fPxPnsIw+Y93jmM0Tu0PBXif6k31w7BflKY9s=;
 b=4FC6gW6WIHb6qVqJm8WyEjLajCa8aM4V8z1Lsp4bpZ+7Eib78pZljfkuBo1G4IXji1Bu9c9G0
 lKR8NzJe42hA6HZv8rczmqKv/pe7A2hwXZsrRaatLxDkkvRZbNdKbgo
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O3PPrS7NUq1EVai5ZY8T1Xo64HMSqilX
X-Proofpoint-GUID: O3PPrS7NUq1EVai5ZY8T1Xo64HMSqilX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=964 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200026

Add support for power domains exposed by RPMh on the qcs615 platform.
Only CX/CX_AO are exposed by RPMh. Consumers such as VDD_MX, EBI, LPI_
MX and LPI_CX will share the power domains.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 65505e1e221986ad20751b658374dd0e74719703..2ff1a255f27247e26b4ef0f4cbf1f68010bb0aec 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -624,7 +624,19 @@ static const struct rpmhpd_desc x1e80100_desc = {
 	.num_pds = ARRAY_SIZE(x1e80100_rpmhpds),
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
 	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
 	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },

-- 
2.34.1


