Return-Path: <linux-pm+bounces-13796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE696F7FF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656C31F259A3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A591D1F71;
	Fri,  6 Sep 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GGUpqnQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9C1C7B9B;
	Fri,  6 Sep 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635768; cv=none; b=U/iYp80Rk7Y11J62V3APFQD0n6/5Zd5X3L5hEIDe5PraaVvnW4ZQDUuOyDzp+wgcvHBrGxdohgUg1y4L7ClMWjti2G6mit2fl5dFOUXY39u5I3P3fredK+HLKwtzqLsI+BHFgRlpjlPxOOMohoxt/IYfPVC47+PA0lzNCuQJHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635768; c=relaxed/simple;
	bh=1nAunJi47huK3qzYEye8Bf4twc5GjV2jAQ+Kua4s658=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iu3hOV2/3pDXypKwuz5PK2nEpR8zHSam1LZWjsqIKvIcDxNejHf0o4ytXJMpo0y3lK6D8yT4CANQu6jYukomEYz54ZebTkqQPTLTBlzEbLhM5rHwaHPDC172KR9L+hxeOhsozJt+0BmjdzQAur4+KU8002qquSQxKpWV21H/TCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GGUpqnQk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4868b7bj019562;
	Fri, 6 Sep 2024 15:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q9qqn25jt8zRyLOI3YOHZB
	D2k3nW8hhH/vnrtgUGp/k=; b=GGUpqnQklH1LVlCwzVpOkJzVedLGHO5qc4vbls
	zXn33P5arIdU2f3bvqCxjS6Bcm3uK6Du1Wk+uZZPF/2B18kxH3e7911kST6KPc85
	U7hoisIjo88tlVHlGP9JsB6zK+XxSjYcwF+CRoqdDEFViYHsVtP4SptsWROAdfzS
	S1HuwoaWEqCtmRdKACX1DQZcTtBHSa48a8onwL9OZgEM0r3Fneo16UCvdRsNokQh
	VUP5LB22r8fFCmKAlI9gh8WfR2bafA9mCclo1t2TPBKSbSRxHcmSXAXnF4k5mwYf
	8XoJug/4fveY9si/ga3FJGJ2wGyOuH3Pz5SLd7qlUmKrRlXA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu2mrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 15:15:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 486FFsZg028728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 15:15:54 GMT
Received: from 79f899fcd02a.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Sep 2024 08:15:49 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski
	<a39.skl@gmail.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Odelu
 Kukatla" <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/2] Add interconnect support for QCS8300 SoC
Date: Fri, 6 Sep 2024 15:15:32 +0000
Message-ID: <20240906151534.6418-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
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
X-Proofpoint-ORIG-GUID: mJkUkrhl1j-kotK2tQBcKpc5W93E2vab
X-Proofpoint-GUID: mJkUkrhl1j-kotK2tQBcKpc5W93E2vab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060112

Add interconnect dtbindings and driver support for Qualcomm QCS8300 SoC.

Changes since V1:
 - constify all the array of pointers to structures and provider
   descriptor structures.
 - Dropped all empty nodes.
 - Added reg as required property for all the providers excluding
   clk-virt and mc-virt in dt-bindings.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add compatibles for QCS8300 SoC
  interconnect: qcom: add QCS8300 interconnect provider driver

 .../interconnect/qcom,qcs8300-rpmh.yaml       |   72 +
 drivers/interconnect/qcom/Kconfig             |   11 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/qcs8300.c           | 2088 +++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h           |  177 ++
 .../interconnect/qcom,qcs8300-rpmh.h          |  189 ++
 6 files changed, 2539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/qcs8300.c
 create mode 100644 drivers/interconnect/qcom/qcs8300.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h

-- 
2.39.2


