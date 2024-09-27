Return-Path: <linux-pm+bounces-14868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F99883AC
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBAC28530C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AD18B48F;
	Fri, 27 Sep 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fSWL/uiL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3C18BB8F;
	Fri, 27 Sep 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438410; cv=none; b=CaRW/AeN6+tdTDP3WAKKlg0lJqgmvxpmsX549aUJiC9tO4qeAApfXiBhQLpZwvz1ffJPvWlqCQfaZUbLM0PqdlyAeXIt66haAvQmriaZSAfqaO6xy89C6cEWRzOYONQTLIHr66VEU7dIbL6HYsafFDq5im2lD2DfIkVmfizCXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438410; c=relaxed/simple;
	bh=AM4nbqiXRvsUIGQN+GkMO8sRIzyUncMM7bdQpUuxXIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TqngUsLzuhSDvJGwx+kjpEo2MSx81sfQ466RLeLFy26R8UmoDnCXHeHS1oVxUIixyb1pCnkjCeQBZ92ydGhY1/9zw3z/3eoyy3tiCE/fZvbYg62aKUDhhRvq0ohe9eZX+/J3zzEF19cDhJN6nlhaI1St07+G0eJm85B+LMpuueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fSWL/uiL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R9V8vp011647;
	Fri, 27 Sep 2024 12:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RcGDA5Fbmx5gVi8sxt+iM+hwQ4LPJu/7KtoLwKM7sXc=; b=fSWL/uiLzuU9EPE0
	rfEYFwKYIM4FPO0IwRpxKTuLQqsXPS3cPRBfW6H4ua9GeNH3DRGjBPdswFtDpGEH
	8+RzthVtLdQOYU0I4owp4+t8jxIH+WJzKm2MkGhR3oIQU1+5UFdL0yOy3xD4enTZ
	QKEp99WQYD2Vi8F993X8MZZv2t4Mi5MyAXzU/p2/oM7Q7c/eKeRWyPDilexKmYpI
	euKPqULiLZWkM14DihelOPdDC52OI/gbks744rrUC38S5z74Bw/9t+x9Ojl5IPx2
	2g20n+IDZE+qGOTfxID6E4AqZCfza2t6fEB8cuBzq+a6LOEOr2lyKzcws0YodFww
	/lbVUQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuf2wx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:00:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RC04Ne005598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:00:04 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 04:59:57 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Date: Fri, 27 Sep 2024 19:59:13 +0800
Subject: [PATCH v2 1/4] dt-bindings: power: qcom,rpmpd: document qcs8300
 RPMh power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-1-18c030ad7b68@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727438390; l=863;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=AM4nbqiXRvsUIGQN+GkMO8sRIzyUncMM7bdQpUuxXIw=;
 b=/7C+mCD6ly1MTM8A2oXtYvL3V3ZhODRrfopVqsCpo3N17pLSZolueOjR14RmgTkQv/XrzbtnS
 opP8BIybXLDAJxyVUs9Mn2Oz6MKOGf236ypJgTq+jtVFvM/0+HXlW1L
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: veUH61tUJJkDjM9yVWIppynHMCDC6dp2
X-Proofpoint-ORIG-GUID: veUH61tUJJkDjM9yVWIppynHMCDC6dp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=932 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270086

Add compatible string for the RPMh power domains on qcs8300 platform.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 929b7ef9c1bcdae8194adfdfd6114573ab4d59cd..be1a9cb71a9babf007bc43f230a04401cd26a6b6 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,msm8998-rpmpd
           - qcom,qcm2290-rpmpd
           - qcom,qcs404-rpmpd
+          - qcom,qcs8300-rpmhpd
           - qcom,qdu1000-rpmhpd
           - qcom,qm215-rpmpd
           - qcom,sa8155p-rpmhpd

-- 
2.34.1


