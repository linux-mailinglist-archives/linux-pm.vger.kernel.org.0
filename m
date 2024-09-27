Return-Path: <linux-pm+bounces-14870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A2A9883BD
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A2EB24B42
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2FD18C033;
	Fri, 27 Sep 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RcgTnc/p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95018C017;
	Fri, 27 Sep 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438418; cv=none; b=eb3LEQwOkeoMOadh+Rnir+/wsx7XumfOlWUtNdW0W8ERa7Lcbf9AxSxHBDDUZmeYBetBUwU6BL6VznRwSFR7n4EoDDJGgvk+T32/eDsqNCGuGLpWFq4B90mVY+JDNj9u/qr9PcBNjiVkNRlRt0B0qnsdkA07bLAewHdIdZWsGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438418; c=relaxed/simple;
	bh=cnOIwgzxq7hwzmkJLyUklKHDjUlag4OLtnk2uhLhgn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rGGAyceUbqeYPXaBOjnXI/OOfgrnZGfTHIqqcLGxH181V7073cT2ELcjnJqb8oRFyD2ty45Yl9wxJhW84YADvXuIVWOU50nZSanOzZ7D87XXh3IzSKtcGctPNemmWfyChbUo963XeQVq+JrgFbGSy4dRupQWTdECCb11FRsuQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RcgTnc/p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6ujS4000899;
	Fri, 27 Sep 2024 12:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbI7nJzPOL8I2ahUhIzyiRus6tA6xHsIRd+3RMfQzvU=; b=RcgTnc/pLbGriBez
	UXXg0V3JEDW7Pr7BHXh159H1Xf5XNtM7AGvAJcI3Bg6fQYaGQjYy93O5n37FjzCs
	7s2ncGnE8+fW/GO+B6e5g7VvV67G2CjHWNdQp6yI4i9BKCckLt0IwEspLE2PQ2LK
	DBokX2J8Ql0WpT6UUrjxIvVVj9Jpa6vdv6k6NkbWdlHSr1hvTxw0cbOb/mOcyfLX
	EyOh+GqX7Poe7mYN81aJM1Emm0AkX24isP5msAA/MoE4dxwHONgQ/3A6/u2vwp6O
	0tfM91ymanl8+aMTvUFNehHh58pn+k3nLH4rzbCZCqpK52znkrAwRvE5Inieno/U
	Ptw4bQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3sjs4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:00:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RC0Ct0029957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:00:12 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 05:00:06 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Date: Fri, 27 Sep 2024 19:59:15 +0800
Subject: [PATCH v2 3/4] dt-bindings: power: qcom,rpmpd: document qcs615
 RPMh power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-3-18c030ad7b68@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727438390; l=861;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=cnOIwgzxq7hwzmkJLyUklKHDjUlag4OLtnk2uhLhgn0=;
 b=JSEYtKSwpP+BKmoYM5IH26jxL5cyE5p8O6QIw3n9Nce+3MOr/O5k3ue5A+kqTb+Wsat0zLh6m
 Ilx3b6kKFGICciXboNmxgodZXO3yG1sM18WA431o/IRaWrBj6sxGw8t
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q2huCPdxj4BC85d_-LlQ5RqmUZs0CZNs
X-Proofpoint-ORIG-GUID: q2huCPdxj4BC85d_-LlQ5RqmUZs0CZNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=937 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270086

Add compatible string for the RPMh power domains on qcs615 platform.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index be1a9cb71a9babf007bc43f230a04401cd26a6b6..17ad46e5552947f08b1be8691e225ed9ddaa736b 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,msm8998-rpmpd
           - qcom,qcm2290-rpmpd
           - qcom,qcs404-rpmpd
+          - qcom,qcs615-rpmhpd
           - qcom,qcs8300-rpmhpd
           - qcom,qdu1000-rpmhpd
           - qcom,qm215-rpmpd

-- 
2.34.1


