Return-Path: <linux-pm+bounces-13533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD4996B4DC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E4C2821CF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193E1CF5D5;
	Wed,  4 Sep 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2VB9r8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CF1CC8BB;
	Wed,  4 Sep 2024 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438940; cv=none; b=dguUppp2LXnltOPyZCcwTPeD+j791Gt8yhKvnwlA32BwIPYfKOOB+MkGYowF5XpCJ0Axn5m+jrRRc8OTMoymoHn2xT+Rs+AqT7VjBFFUdrfZCgte261zUWbirxi9CLH6TiSXGVnmJPx3z5ih3duyakxXvWdXF78TLrpg34QoKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438940; c=relaxed/simple;
	bh=Vx1cU1UP2irTYGS+CnfdyOGea42puWxvHrczCs+i550=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SK6Anjs0HBKeEcRQjqRaopOHhd1VHEAUgcbeMcNSPsdpnav/XeuIkhZ0SOnPBalZL1y6dxB4FQHA7kzAq1QA5CLvybh35tSTky3zGxG1fABNEMA7AAVtOuPy5r9OQzxWuDn9gFNph/x1/M1/sgkYmnllTNIX6cnAdwm+BCVaRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2VB9r8t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483MH1t9007643;
	Wed, 4 Sep 2024 08:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vixTl57Q8t2AWMH5xIDUc7E7RrXULAwiuUdXe8yc0sE=; b=R2VB9r8tdVxEukXa
	lYN8BkxLVdkbKGqNoM68Q/3rvb0uAmJS86JR6ldDcf6xgzy1xggBN3EgtpEw1uOl
	RqgGavH/+uvABCEMFp1VVQPnddPdnpSPf28/wAUR7U1O2tc0mrsQjSQyZq98qzbk
	dZWVpjzdwkSR32RxsNFWzeqh6U0uR36xnKr8/x8ag0t+HUe0GBuHwFP4m9ZkABHy
	qOddrs1c3Jz0tfNd+YmIA3KbDLu0qixCDWls1xkOtPbjJ5pK6LCFIOhlevkNOsEd
	fvIOQloSIpKnBJcK4y+YbdBQcyhLQb5wXBRfhrTlghArsxB6NezbfStJzk1SJVqJ
	DiuPbA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bvbkhxn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:35:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848ZH6C029773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:35:17 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:35:09 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 4 Sep 2024 16:33:49 +0800
Subject: [PATCH 08/19] dt-bindings: qcom,pdc: document QCS8300 Power Domain
 Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240904-qcs8300_initial_dtsi-v1-8-d0ea9afdc007@quicinc.com>
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
        <iommu@lists.linux.dev>, Jingyi Wang <quic_jingyw@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=934;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=Vx1cU1UP2irTYGS+CnfdyOGea42puWxvHrczCs+i550=;
 b=+uLkYsLcNYYVKiDIWk0ALtteLLVTS2RzjWKOsLjK4r7SYT+hE8x4Jx0fJNcJXUiVp8EAnHKcw
 F9UdjtmkR8sDzXhexwYXsA+Xze4/4Xn7KiRLOntOOS2CvUJV/+7V0vb
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DdFpRd8uRgXh-ku41wLsTVmeCQErJXju
X-Proofpoint-GUID: DdFpRd8uRgXh-ku41wLsTVmeCQErJXju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=808 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

Document Power Domain Controller for QCS8300. PDC is included in QCS8300
SoC. This controller acts as an interrupt controller, enabling the
detection of interrupts when the GIC is non-operational.

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 985fa10abb99..acd6341e9f90 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc
           - qcom,sa8775p-pdc
           - qcom,sc7180-pdc

-- 
2.25.1


