Return-Path: <linux-pm+bounces-30928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77801B079D2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB061A40E0B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86392F530E;
	Wed, 16 Jul 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FaQb4VGb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435702F3C35
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679702; cv=none; b=Et4JIIgXECGOjqN9M566nHx2nJsQQbTAtwbGgDNlCQjL8iMJl49d/MHROVksGlElT5L5qTJ1TsSwAkbQLyDfF2Ss4Q5RR8XA8HB7HPkoi7s7yh/Wa1uRheJIb/1k7bARGOSYahYTJt1YX8Z7oVCXXkunICq+ZnQIYOxEyvxv4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679702; c=relaxed/simple;
	bh=d5TNHXJqe35TYW0XGOrPx+PAjPxH5xNWzgZ20VJX48A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkVGgjOEuC41CA/VmqI125H6lC4hLNJ4XVte4UoX5I5+KVPUUfEGdQdtPHJJZMqEQS1Cv0UgMyncPI58xm9iMx0dtDyPTr4cvm0u1CDglPtGhHXtLHIery3ocAu6ug37UNClbDM5k39uvINgd/46gtjxhwhg/at8mZvxmQWflGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FaQb4VGb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCtdXI023949
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vVo7g4SuoBA
	YE2Kpf8pE4sBdUNQNHKc2NlVal4lHsUo=; b=FaQb4VGbYFWjx+AGOQxR42GdVD1
	BS/SNsaLf7hKd9FMQ+xLCCfKls8cu1IWD8fBWdYy10hcz3T4hz6y1CRdNaeEi7/b
	+3znubwO2Kl7yX8PoL7wj1KQmoS4YFLj9KqC2r1td53O990ozMiHOqc1/f892W7f
	KEEQzTUv4tVDfQc5WgG3Eh5uFflWOJF8CTuvqx/Z8ugGMAzz4RmjCZv3SsB8y6kD
	JVAzF8AYhGf3POU+6tC/asocjHJ/YrY70h9xLoh0DTD0goo3cF11Rh6G3HhY9dAY
	thfkKf1ueY3RmUR8RcCkWYvK9TYovtN/kJAiSOWHj57hOZiPORRq5R/Ak4w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrun8pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313f702d37fso32706a91.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679700; x=1753284500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVo7g4SuoBAYE2Kpf8pE4sBdUNQNHKc2NlVal4lHsUo=;
        b=MDNrQyt1mNO3niR4G0Z2EkskS0tOz2LMMwN6td6ruPP/rKRPvoRAr4dCvF7DB2bWHL
         tzx7IA6LbpMAVG8wmQ5bel7sITv30cXE9VtdaCBnyO4auhPDttuZqytqoHrnpJ1DyJ6F
         P9vUc7X5GjUbZ1l1jeSFLVy8oqXPU0vQsYwBEfHfzKO8IMULiDJC2dqdB/rAtMle5IUJ
         /77iXazzk5HZ+oMDKbHcgrVB8sJtoGAA5wNiagTYrvnnl4eVaHuIc1QvwGCCfn5ejz1v
         OL1fNexehkm8K2AQrM5RuDX/l9fh5HByojuLkvgKKInpkdSaBb5hxrphwu4i6/x/t1Bm
         4l3w==
X-Gm-Message-State: AOJu0YzulEiY7xmXQLg+uvI4y76JMOo1DALUIxWEsxMRIVLqyfcpGj6s
	l2D9XNEO3FpVbVguWTSOJVYe9RjHg5OtfmRHXTCS7gG2BPxpQfBPhP6eoW7PwRl18nUVsGuGhzd
	OJJ97dR/grkVk+hEmjIrMQCOwWx/TiuYkqKC5p+HuNK2Gvj5nZ2cwlGgvAUwd4w==
X-Gm-Gg: ASbGncsoB9FyXdNZ+Efq2LOisGg5pT21lLE/fPf2gEMjN2FRVZnmM+kO2OHL5Pul9XI
	1aiD3VJpAmT9gRRLPyl5H1iwCKFQx/VxewP/fA3yp6yVFE6xHZVp3+u8u/SpBaeXU8zCZjIJ7WY
	HA/57oldId/Mna7LJVBKfK6LNsyHCrDqv27VF6OLxcCMjifGdKCMh/3Hpw33wOuGVQi8S9RjQVh
	9/9fQBcXk+zXomfRM8MOuI93HDqe6FLhtePA0cjqYZimhg9AI6negyXZyejfZ6s5S7z4D7+Lc0k
	4eVAksxbPPl5tAAO5GqsY8cCCTsGGxg6+VeCteVyVSc4MC9/VUskG2nejgzLdDWEqP0IJXhsyCl
	jv1V/vEcZCgRf9ROaLJ23d4GYNC18fLUAvWWsPKr0x+tenGyZINCn3hGxRHf4
X-Received: by 2002:a17:90b:2685:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-31c9f4b50d3mr4106100a91.29.1752679699508;
        Wed, 16 Jul 2025 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeI5v7kP521ZDrKFwcG9h//NS6CzCzK54hgX/qI46bD76bO/lyp3vx7QSU98+WYi8yyBAb9A==
X-Received: by 2002:a17:90b:2685:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-31c9f4b50d3mr4106027a91.29.1752679698969;
        Wed, 16 Jul 2025 08:28:18 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f20e87bsm1688563a91.35.2025.07.16.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:28:18 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, konrad.dybcio@oss.qualcomm.com,
        quic_tingguoc@quicinc.com, quic_rjendra@quicinc.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains
Date: Wed, 16 Jul 2025 20:57:58 +0530
Message-Id: <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M4sTeXMhMSkcPs2hYqTP_GdrlSKW-U3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfX3XCUYtP6hkHW
 rl4np78PPFZXKxaKXJGMNIyopdJoNAyjka5NV6Hk66iXJK7aeqaqkKSfHN/JQrGfnyfyxYvoqCN
 x0CnASe6iRkZwyzvUnWWjfiSj95jIb8H0CmI9OQBOOmKPjE3aAGGVzaIQTNd0OZVnLykw7NABlK
 spQ8p9ivbOGQ1tn2C0Lh1O3sKwrNyWKiqi08Rl4jGiC2mXcLVHaTfBHw0slTMGpwgCEZxqMDje6
 OLxoqGBcKd+A9CoQYCcI/nexNenrl93eSSsAUFi0j27mclZzcOrLgQZIB6HcEdRrH74PJRSGUst
 3uhBlsBajyoinAiO98Q9A04N46fB3BSV+pZedktTTswW6T6PnshcVduSYY6Pf20Nt9cr2xCRW2h
 mT0XJtLeUacd58/MINpKpSXezbsJ5nTBuP0pkZvZARFA/eVcluJA+O02mjN0vc5s2k2FOpu+
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=6877c514 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=o1i6smXM0GLUooxP6f0A:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: M4sTeXMhMSkcPs2hYqTP_GdrlSKW-U3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160139

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add RPMh Power Domains support for the Glymur platform.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 4a8e2047a50b..4faa8a256186 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -684,6 +684,31 @@ static const struct rpmhpd_desc sc8280xp_desc = {
 	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
 };
 
+/* Glymur RPMH powerdomains */
+static struct rpmhpd *glymur_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_NSP2] = &nsp2,
+	[RPMHPD_GMXC] = &gmxc,
+};
+
+static const struct rpmhpd_desc glymur_desc = {
+	.rpmhpds = glymur_rpmhpds,
+	.num_pds = ARRAY_SIZE(glymur_rpmhpds),
+};
+
 /* X1E80100 RPMH powerdomains */
 static struct rpmhpd *x1e80100_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -741,6 +766,7 @@ static const struct rpmhpd_desc qcs615_desc = {
 };
 
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
 	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
-- 
2.34.1


