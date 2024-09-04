Return-Path: <linux-pm+bounces-13526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED096B4AB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB77B235F2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98B1CC886;
	Wed,  4 Sep 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IV3Q8XJN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BA1CC175;
	Wed,  4 Sep 2024 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438890; cv=none; b=vBVfKQIBmkPspE8eqrzV/fX6VZo8ZS1AUr7qfQ8TCX/t62PsozIK623FygZuc0JuQq8C8Mmkc99pjU1TA50CwNZk4PcEDGw+BvqQoaXPgkGbemeAlAFd0qKgoqdeprvJlt5ViXcgcmx0CwSKgc4MpKehpwJrQ1Kh8VJmUm4w/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438890; c=relaxed/simple;
	bh=7qnOboI4fqKc5XrrI3q9z18NMRMMqBJJw9kgOxQk0bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eBBq7AKoqfBLluEX150Kdal/1hmxspJEl0y6qBff7sbhCQ9buscStWICLSQyv+PXLvtInOuItQwX9UonGHwwizINcovx/fDqgiwNSzuWxazyNh/400Cr9GHh8+EkNgj6J6+VBaejv6o6t8p3KyKg37t4EwioLBNK0mKa1l7+0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IV3Q8XJN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4844Xnad010426;
	Wed, 4 Sep 2024 08:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QnS3/EDK8HR47cM5NE2NfzQ0KgghedA8wZpdrLIzU6w=; b=IV3Q8XJNtXoiGFwK
	SbsP3amoLhi5LMWk2b9Bw3P/1gneQpHsMckuSPL6Wvyhv3zXrN6V/AWI5iF50Jkt
	SiExRM3sGQNOiEchL2a/tNr4KRusAqzfsSSwxy8vnF/Dw/IQkilw+XTCRLw8KuXo
	OCfstUXbq5xusOLJHfCIMwTk6X2cgSGHZ+htB6YvYBhzXjPbSns2NjewQRcRwiww
	VakVKnjLAH6geZSxLTEh2qg4Z7CPHssYde+JuQnjGIuhh63Gkz/OkMvMboEKei6r
	1NmT062OdWm+k+2oNnDF53XM8+f2OqYZb7/KiQnzex+fpnai8T023LC8WGAIzMDd
	qH3oOw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41egmrgha3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:34:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848YI0O028383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:34:18 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:34:09 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 4 Sep 2024 16:33:42 +0800
Subject: [PATCH 01/19] dt-bindings: remoteproc: qcom,sa8775p-pas: Document
 QCS8300 remoteproc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240904-qcs8300_initial_dtsi-v1-1-d0ea9afdc007@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
In-Reply-To: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, "Andy Gross" <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh
	<quic_gurus@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones
	<lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, Jingyi Wang <quic_jingyw@quicinc.com>,
        Xin Liu
	<quic_liuxin@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=1612;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=7qnOboI4fqKc5XrrI3q9z18NMRMMqBJJw9kgOxQk0bQ=;
 b=Wo485Ih1CNVeaDbtWfF0DDBntjURgokd58SjDBoj/xG5d++Ga8vZwDsNWDoNv6zd8gvM2I709
 YZxsL/qMlJFAXt0xb3le7y+Gi/LdzTymB8qP6RWse0C3znLc3z7+ewY
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oL01RJ88BYIa5LcmW0JTb_Vd29LdFJuY
X-Proofpoint-ORIG-GUID: oL01RJ88BYIa5LcmW0JTb_Vd29LdFJuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=921 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

Document the components used to boot the ADSP, CDSP and GPDSP on the
QCS8300 SoC.

Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
index 7fe401a06805..b788dd77e40e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
@@ -16,6 +16,9 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,qcs8300-adsp-pas
+      - qcom,qcs8300-cdsp-pas
+      - qcom,qcs8300-gpdsp-pas
       - qcom,sa8775p-adsp-pas
       - qcom,sa8775p-cdsp0-pas
       - qcom,sa8775p-cdsp1-pas
@@ -64,6 +67,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,qcs8300-adsp-pas
             - qcom,sa8775p-adsp-pas
     then:
       properties:
@@ -80,6 +84,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,qcs8300-cdsp-pas
             - qcom,sa8775p-cdsp0-pas
             - qcom,sa8775p-cdsp1-pas
     then:
@@ -99,6 +104,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,qcs8300-gpdsp-pas
             - qcom,sa8775p-gpdsp0-pas
             - qcom,sa8775p-gpdsp1-pas
     then:

-- 
2.25.1


