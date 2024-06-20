Return-Path: <linux-pm+bounces-9641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12690FE75
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 10:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C78B2358E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8ED17C9F5;
	Thu, 20 Jun 2024 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JecD4y9F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5617C7B1;
	Thu, 20 Jun 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871329; cv=none; b=JyhEi6ZKA+UNM+EUmAk9fhgIY1eY35nnHtTpousjUnUQlsmgFOsPFaiMeselcpgCYOO86QLUo8jUJ8a4fULlDKWWc8R0shG3AhQIrJt/d5xxjxDgTY4emO5IeD/hyWK8LDX3QgArbZ8puLwkFDtYJO5WQvR4AFUH9IuO8xyVeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871329; c=relaxed/simple;
	bh=wj3aHk6IHnlYPNTRtgDSbqdxlPkCc4x7y1ohrg50Y8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICG3vFXPlUL6M96oKoNLisvRTIqJ2TVcYuAWF8ClfBFGcwCGyFOvUkU2iTvaIIMUttWPQ9mxldyoQDYqts3ZBkK7ZblTwpX5dL56kEJihGzgbEiTBBVJ6XgIqMcw35/rzSoB1WdfJZlJ+RhA+I5YlwSuKZso14+lZlg9R6Kv9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JecD4y9F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JKckQf023894;
	Thu, 20 Jun 2024 08:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1OcHAXKnKPWdLBaQZAFv15S86mrw4FuJ7eCoMlXHEQE=; b=JecD4y9F20t2gbJb
	EGA2szi5gy7vXYdEOnakJ2rn73v2zE/FKwlp4e81J0JQGXLD/zXp8ijeI7/hSk81
	8HLInI21wzxOn7M55I7HPgKdW7S9ojs5kXpTkp6ypqKxZy1gwS0oHMbcY0MUlqKG
	bIiP5FEDA3oGTC6/dI/a6x8PbSPIDAznBQk5VBu9OrI76GK2zNhat887TKEaYIrJ
	jbnJ46PFCtsLYCyui+xzKtO/G8MuFFSdMhJ2DXpBLXIqRfctiKiw1BM1jqelyQrc
	Yx884YpJGiL0rLT0FvF2IhTNFgO6F/HGyE+4jEzUfKE7diXK3sPmocOb27E66ETQ
	UGiiQg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv6hn16k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K8FEBr009589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:14 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 01:15:08 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <quic_varada@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <danila@jiaxyga.com>, <otto.pflueger@abscue.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v1 1/7] dt-bindings: power: rpmpd: Add IPQ9574 power domains
Date: Thu, 20 Jun 2024 13:44:21 +0530
Message-ID: <20240620081427.2860066-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620081427.2860066-1-quic_varada@quicinc.com>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gkclqC8Xje2CFsLn_lhVrqiF2lVd5goE
X-Proofpoint-GUID: gkclqC8Xje2CFsLn_lhVrqiF2lVd5goE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=973 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200058

Add the compatibles and indexes for the rpmpd in IPQ9574.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom-rpmpd.h                  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 929b7ef9c1bc..e20ba25fa094 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,ipq9574-rpmpd
           - qcom,mdm9607-rpmpd
           - qcom,msm8226-rpmpd
           - qcom,msm8909-rpmpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 608087fb9a3d..0538370bfbb4 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -402,6 +402,9 @@
 #define QCM2290_VDD_LPI_CX	6
 #define QCM2290_VDD_LPI_MX	7
 
+/* IPQ9574 Power Domains */
+#define IPQ9574_VDDAPC		0
+
 /* RPM SMD Power Domain performance levels */
 #define RPM_SMD_LEVEL_RETENTION       16
 #define RPM_SMD_LEVEL_RETENTION_PLUS  32
-- 
2.34.1


