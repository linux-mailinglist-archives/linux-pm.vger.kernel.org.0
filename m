Return-Path: <linux-pm+bounces-14505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A473097D053
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 05:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4281F233A1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 03:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5A1C693;
	Fri, 20 Sep 2024 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F8RF/Yev"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084839FD9;
	Fri, 20 Sep 2024 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726803640; cv=none; b=nP3c/+u0GGaa3rIvy3oaW2hAkhfd+TuzODD9pAGUSyBwRKnh4Nz5s8T7VGrrIpbqzJUvME+uScU0mMmbNovBfMz11fgpjdFOb/lixpMAS8pUe33IF+0cJuY02Z2jI8dh0cZ1iEE5qu3CtcOkp1V8x+0Ww5P3wfkrG9HwuT4D608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726803640; c=relaxed/simple;
	bh=/n1l+08SIXcl6jEihesb7X5FdpgZZK7kyQjy+8BOwS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZTl/83RbadelVDDhVa7mvxkXannQyuoJVieDieym5fmCW74R5Z6cQcvXlPiFt3TIwi/HijPadxCsQHBMFMl/KelMiJ4KBk5Uhzuu2NmSc+ubiUtivtCUsC+kjv/Uz2/n3vPJG3wg+l53sFqSntf8vwzIlN9V7948QPQFsxxKjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F8RF/Yev; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ3u5M018268;
	Fri, 20 Sep 2024 03:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahn7U8Yo0bz2XKR147lH9HgizZfOaNftsyT9uNb3ct0=; b=F8RF/YeveBvzNrU9
	CZYB4LdJqBwfW/5LMqV8dC8dUGgKMvGw1O03ZdULKvreXxX0LXLDE9Vd63uJ8Y0/
	jkjL4LHoASExakUYVzEdvzVLg7hYLV6imqbOxJgZgqskBzgDYRQGfOg5CiKqoJhv
	/2jMMcGewLGl5bAneWrkAkq3zrMiSCgpfUj3suNPMI3v0jC7FyeeU534Gp/woMf/
	+ll0U30TA8Z4eiAshjdk2ZrMLt7efqehd8j6h0EJ7SG9CWBcxmV+BiXBpB3dHJ7+
	RECfpvVmnqpDs2pFElN1zs9Pi9POQElWQRHt7IcqrfIzaSvDu/8Hj4pJuevNnopZ
	ub6SsA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j6yq1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 03:40:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K3eMrO012633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 03:40:22 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 20:40:16 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Date: Fri, 20 Sep 2024 11:39:34 +0800
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add qcs8300 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240920-add_qcs8300_powerdomains_driver_support-v1-2-96a2a08841da@quicinc.com>
References: <20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com>
In-Reply-To: <20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>, Tingguo Cheng <quic_tingguoc@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726803608; l=1740;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=/n1l+08SIXcl6jEihesb7X5FdpgZZK7kyQjy+8BOwS4=;
 b=0dCz2YHxWNPX5llxuRT0lDU4L3+qOG9kBT+P5bg6wVQxWI+WmPMYo4PHpusTQZJprpqvcmjcP
 VMoClJv8WtWBJ/Dlf25ifXX09VbS7MSntCc4I3TQHyk2p+q5A06zlUD
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qHFfXNPNHY4Oa5ejQ_fONESployOJnSR
X-Proofpoint-GUID: qHFfXNPNHY4Oa5ejQ_fONESployOJnSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=898
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200024

Add support for the power domains exposed by RPMh on the qcs8300
platform. MMCX depends on CX, so mark CX as the parent of MMCX.

Co-developed-by: Shazad Hussain <quic_shazhuss@quicinc.com>
Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 65505e1e221986ad20751b658374dd0e74719703..d256110225dc517187b2ac1bbbb781eae78b7d59 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -624,7 +624,31 @@ static const struct rpmhpd_desc x1e80100_desc = {
 	.num_pds = ARRAY_SIZE(x1e80100_rpmhpds),
 };
 
+/* QCS8300 RPMH power domains */
+static struct rpmhpd *qcs8300_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_NSP0] = &nsp0,
+	[RPMHPD_NSP1] = &nsp1,
+};
+
+static const struct rpmhpd_desc qcs8300_desc = {
+	.rpmhpds = qcs8300_rpmhpds,
+	.num_pds = ARRAY_SIZE(qcs8300_rpmhpds),
+};
+
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
 	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
 	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },

-- 
2.34.1


