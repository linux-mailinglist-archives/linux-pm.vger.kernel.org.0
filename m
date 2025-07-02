Return-Path: <linux-pm+bounces-29970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE6AF0F64
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 11:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AA73A66C3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A125D242D9D;
	Wed,  2 Jul 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="duGzASup"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6F233D9E;
	Wed,  2 Jul 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447621; cv=none; b=CgwJg8i+q/+6+7NyFHah1/gJu4U3Q4UJShMnsMUhydRK00PMcfa0Z1+hyDzZ4uDDjZ5yu7VpLEy34Y05CfBXdFT0my8GPAtV4UaAj/NFO58rx3SN8TrOigeMzXa0c/xH+Rorx19qA/BatZD+9nJgOTjfwb0snPCUS3na/Tv+Rc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447621; c=relaxed/simple;
	bh=UapAn8A8IDPEsGCPb5ra1nTwG+CN0OlDyKyLDRx1+ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A6gblWNW+lGvoIqJN4aN6VwCmDioq7lDl0nOosdFMVOuIl2dOQ8IG7M0tPZxfGehGAtX0rSe3qQGHNnulOX8Jkhn49MpCHKklkotM+ffJCP7N3lvSCojDLLJDMVRcgxrMWSTFgAVg50QGgbWP4CfgJtoR9TfQfPkn63crR5BBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=duGzASup; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5625ZQ2A000438;
	Wed, 2 Jul 2025 09:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+TG4jPCo6Vt6d5sGsLlRKNQOUMpKIuhFHkLGMKpSA0=; b=duGzASupQd6JzZL4
	e8izLWrQOdpe+IkDpM/8hrclVB1wH/QpGaFiOZ2xY9JKPrV9zSZy8YRgqtDq96IP
	xTeH23WwOAukoUBdWVSyJvI27pdekLxDkh9eNPTIXAGLxZfZQQFP/1dIlBE7JhUB
	DAHZvwIqLRWJEGt6xq2dcsbdOGqcQPQ8Ada+lTCXEvXAXa59oAK7F5M+BycDFXwy
	ifB9T8rZEk+ok6gMeARTTJzv+p9tb6SKKV/Rprigr2kB1wgb8fdcFM+BhaXlg7S+
	bhsLQSwEw6Kk7eQHlVgMSGAcgwv1+3t1mP/0Vg1aKgjDr5McNCYwF8YSGBYE/Upk
	xaF/pQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qmbwgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 09:13:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5629DWRD010356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 09:13:32 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 2 Jul 2025 02:13:27 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Wed, 2 Jul 2025 14:43:09 +0530
Subject: [PATCH v5 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250702-qcs615-mm-cpu-dt-v4-v5-1-df24896cbb26@quicinc.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>
X-Mailer: b4 0.15-dev-aa3f6
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=6864f83d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=DiV1PRyO1OqbfoddZsgA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: oFIdV9bGupx95wzsfz4OQCO4mLgK8x-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3MyBTYWx0ZWRfXx/BABAaQOrb3
 GX8Sq+nQY4UmVALeakIWYVIJXcVArQsWnixVpgiL4biC4R+ZgX0NoHS2upE8DUK65TipvADXGG9
 GLKob6EeoEcVD1c+6KKnLnA1Q6+Ln9GdtPDXPyJfYF4XzI3QPLZoQNr8uG59oLyIgKSnakk8Py6
 ngYr21AOYQyhXN7HpOweG128V+psWRZXITx4eRIJWrNxOcceS9b3Vf0YFc81ay+/FupUPjbvS80
 QJTbsUbcYtqbhT1/dH3/m5ljy5bvEJR9CkWyjj2aBpCk/Zsb+W0c1gnpgwWmRNUBNq8E3k29+41
 iKRely7VoM3yjouPcVTt/CpFf+vPFhTksZHgws+V5Tp0vW3Yy72h3ToBm5Cx6gygYHOebGP2Pls
 sbyCRuEPuf2wLh8aEY/50mcTrzze/qz92F1hNwWg5tzIo374WmTB0so2smRiAWIJyqI6u66M
X-Proofpoint-GUID: oFIdV9bGupx95wzsfz4OQCO4mLgK8x-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=882
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020073

Document compatible for cpufreq hardware on Qualcomm QCS615 platform.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e0242bed33420a39b8a8cff4229ba9eee994ca30..2d42fc3d8ef811368c990977173f41b26535e0c8 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -22,6 +22,7 @@ properties:
         items:
           - enum:
               - qcom,qcm2290-cpufreq-hw
+              - qcom,qcs615-cpufreq-hw
               - qcom,sc7180-cpufreq-hw
               - qcom,sc8180x-cpufreq-hw
               - qcom,sdm670-cpufreq-hw
@@ -132,6 +133,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcs615-cpufreq-hw
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
               - qcom,sa8775p-cpufreq-epss

-- 
2.34.1


