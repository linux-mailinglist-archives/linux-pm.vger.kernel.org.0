Return-Path: <linux-pm+bounces-13531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2479B96B4CB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DC51C217F5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55CC1CE6F1;
	Wed,  4 Sep 2024 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PgUp50f9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC531CC178;
	Wed,  4 Sep 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438922; cv=none; b=sRRjcMNQOvVjHoJav6TywdgcmvYiv7KV2kt9VHFO5IbQXokyIr3VkvIkJTw3RO2pgqVH6U1POZqSrFPEb/4xBJ0/VdLMNhZIRk2VcfPg6xKrCwqcVCg/ExJF7Xq0eyOtYmEzV/R+aDKR5arrxlutho9zNuHkSOJcNZsEIuLQ/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438922; c=relaxed/simple;
	bh=PCqWz3HttrDHQ0fam6GVYaF8E5JvB9acjDqZGE71pdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=StObHtdQqoSiXHmWitR41J2m8uH6merVKlu8jlnfAN2egvBW3mjaCdPKUlyWyMatT3NvASwGaWIuOLoVfGyxPMW7LnM/U38sY4M1so+b6psqMxDo4kr8A1iC7oHouvenQZ9FRwFUFghb97+rGDcdmdwlLq5JaPTteqg1Y7FcYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PgUp50f9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Nc0Me014493;
	Wed, 4 Sep 2024 08:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VEdrzyZtEQLwG6OzN9Ws8tbomfUdcxwws2fGajP/eu4=; b=PgUp50f9Qf9HPd+2
	ykgH80j3NtrOZEg4qc6OX3L6GwelzkgD+zLRPUlaJnDXbNVnV9NH7RCDMCJ1gfu4
	eiMGeoh2uNyYYOcAgdf5cNKm4ce+B7RJxJjVRsGLUiwn0A1Xgyeiy875mg9qRwOJ
	5Tk0PlnFQ9jPBDEyH85UleuY9t5CNbsdOw7YV6E0A8VtCWFFhwhUiEojalKpu8Oo
	gcQJHO7T+DRrl2VI/Hh0BQo1OhLQlUKWgc87+t2xRr7JliwUlyAA2oQ/pGSKDLpz
	kklJ0wRBUKp+E7BPILKkNnKbLArp8cRoGhwO6AgSG6iRBaIFx8pf13EpKVbOX9RJ
	hfED/g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dt69c643-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:35:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848Z1gU005798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:35:01 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:34:52 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 4 Sep 2024 16:33:47 +0800
Subject: [PATCH 06/19] dt-bindings: power: rpmpd: Add QCS8300 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240904-qcs8300_initial_dtsi-v1-6-d0ea9afdc007@quicinc.com>
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
        "Shazad
 Hussain" <quic_shazhuss@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=1923;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=JBkO4rE53QYLBmngrXpm2EANBFFeHUzq/IgtvyMCUms=;
 b=Pgk5FeFuJ01qxIFHvMzK+Xvi5ZXTKtasqNjgwwyvU++6sBjSx7WL6pqqhp49ajCvdWXNozb+6
 3JCukYjdzaUA1YCZJH7MQixo+KgHRkDJky4P4EUx6XDNELlDnX93LXR
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6ZogE9kNixaNS9jXjJWTKb95q5vzxPz0
X-Proofpoint-ORIG-GUID: 6ZogE9kNixaNS9jXjJWTKb95q5vzxPz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=875 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

From: Shazad Hussain <quic_shazhuss@quicinc.com>

Add compatible and constants for the power domains exposed by the RPMH
in the Qualcomm QCS8300 platform.

Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
 include/dt-bindings/power/qcom-rpmpd.h                | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 929b7ef9c1bc..be1a9cb71a9b 100644
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
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 608087fb9a3d..7dd7b9ebc480 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -4,6 +4,25 @@
 #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
 #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
 
+/* QCS8300 Power Domain Indexes */
+#define QCS8300_CX	0
+#define QCS8300_CX_AO	1
+#define QCS8300_DDR	2
+#define QCS8300_EBI	3
+#define QCS8300_GFX	4
+#define QCS8300_LCX	5
+#define QCS8300_LMX	6
+#define QCS8300_MMCX	7
+#define QCS8300_MMCX_AO	8
+#define QCS8300_MSS	9
+#define QCS8300_MX	10
+#define QCS8300_MX_AO	11
+#define QCS8300_MXC	12
+#define QCS8300_MXC_AO	13
+#define QCS8300_NSP0	14
+#define QCS8300_NSP1	15
+#define QCS8300_XO	16
+
 /* SA8775P Power Domain Indexes */
 #define SA8775P_CX	0
 #define SA8775P_CX_AO	1

-- 
2.25.1


