Return-Path: <linux-pm+bounces-14504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66397D04F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 05:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4221D1C20A4A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 03:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976F29CFB;
	Fri, 20 Sep 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b/swAbij"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50224B26;
	Fri, 20 Sep 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726803624; cv=none; b=mUOWwASVRSejoIwH4VFyDTBudfmd+b72zNtYj3T4AkpDN0IWOlucYo+Aiv3LMjhPG6pFqxHJ88oRLtFEbLLNlNrSBJNotf1JwBPFS8Ptk1lZkMDq/h3wqkITZN9HXSLZy3MWbGL7CUYTu/rcInkqDIFSMB8VF8xs/Xt8f/1buv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726803624; c=relaxed/simple;
	bh=AM4nbqiXRvsUIGQN+GkMO8sRIzyUncMM7bdQpUuxXIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q2kffnjBSCWy4dtpbXa+prB+Ds48vmtlWkjBh/JLaD+oASP+8SFeup1CKU7cgY1wUQ38MK+b6vsv6tQmGys/55uY4+Wcg75t2CNRgFaUihkICKnGM6Lm702obSpXexxscUXhjy0iUWphYLZv7AEr5rP+759tLDgfl/GIgZ7yvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b/swAbij; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ469k012514;
	Fri, 20 Sep 2024 03:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RcGDA5Fbmx5gVi8sxt+iM+hwQ4LPJu/7KtoLwKM7sXc=; b=b/swAbijd7PVG2KI
	jaq5ifc+9tG4bfVDbFblCO+UVkH/pKc3rEykiACbLk0DJ1bqRnqg3CRgTMmyWhIi
	LI5lupw2+244cEOKWTUS6m6SdB0aUoh5ooHkq4bHoLyFXRknqZP+pN9dT/cBjUfQ
	8oGD3Uot7RkVjcfMaNst1fxVlJGFtQnePwD5lDkveh/jHjwRlrKHbdinw+OTSKX7
	Zc+2gdi2J9FssNn28kwDZ9kaqwp1CSHN/zgiJluoqixBbu4DgXIyDo63u55Obk5T
	ojJt/PZaCC5FG5NJwjb/qda0yBc+C98HsX7J1JuRL88IYzC044YsW9AGU1fCV/x1
	fpxBJg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gd7fpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 03:40:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K3eJl9012606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 03:40:19 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 20:40:12 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Date: Fri, 20 Sep 2024 11:39:33 +0800
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document qcs8300 RPMh
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240920-add_qcs8300_powerdomains_driver_support-v1-1-96a2a08841da@quicinc.com>
References: <20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com>
In-Reply-To: <20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>, Tingguo Cheng <quic_tingguoc@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726803608; l=863;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=AM4nbqiXRvsUIGQN+GkMO8sRIzyUncMM7bdQpUuxXIw=;
 b=+iG/xr1gID/+EXYHymU7P/yKUkWyK5iKAtI5YbJ0frPiVzmm1HJIU8MOFpNTY73KjLp2LtQi5
 lNwtnp0Nn7JBJAcAJT6+3aCJlnq8asqusRcqoaEU4hzBD92MgBi+hpo
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eP8sa0oYvDTAedVQv-P_1uiyBoNzX_UG
X-Proofpoint-GUID: eP8sa0oYvDTAedVQv-P_1uiyBoNzX_UG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200023

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


