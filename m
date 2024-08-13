Return-Path: <linux-pm+bounces-12124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B394FBE6
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 04:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D7B21D2C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 02:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47117C8B;
	Tue, 13 Aug 2024 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QJd0M08O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2EEC7;
	Tue, 13 Aug 2024 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517313; cv=none; b=XuTCjHNA9O6I/SacEGW0JEOrcZNhK1mMQfR2VNdlaCYg877qiuc4k3X3rl6fypsE2R35XcZrzijeRbaim4B0IhJqYOYm12Pw8qrH4Z1w+plxHKkE2FuYv40K3hjaGtvWHTBbzNkbx2+MlxLYEdz+uNAJ30o093C5l6Y8k4MQKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517313; c=relaxed/simple;
	bh=es3ElNIqqKU+cd3o3qpRCaX6cmXairEmsbslsOJzhOw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ENJ3s6Yzmem/v9gC7nxo8UbDLq28HdHGhfc3f3bxL91enCF7aKH1JaX1YpOn1SIk8v5mw+Xq9A12juV6E4a9XaxK2oob4EfEn6MR522YQ/3C6X89cL4S0KmULyizomo2JwDZbIqLiUD+Nib55y9Rm4/AA/tOixAYM6d4wKu6IFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QJd0M08O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSWiO015965;
	Tue, 13 Aug 2024 02:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pabRbJu8yPn/tDWIGGS4Xv
	P93/GPZZHkYHzt+w4/b+E=; b=QJd0M08OD1LWBAzJpQbVfGe6UhVy+F00ykKiSa
	ik1x4mJKekcw+TOFNKKdF5HuecPi8rbSRf81EK4N8xmKtJyHQDE3Cs/stkCbVLAQ
	0KgXk96PKz8hEGMldIWgIn6+vn2aGoQzDja0xzV5+hWMmepCT6HVBmx27c4sBu2t
	jb9G3n2EoaIa9flQJKXcwpnenfui4PCyAFYrh3YXnoAY73N9sJNoE+f9H1qVbEth
	P9hThL79scfDKiMc2WdicsltuGnMSug05gI+DUvLkqGE2gBbVICNcfzOqzzYqUS4
	37PcdU8LtzJ+kX0eBXxz9Q3xRM2D7Zj33SOBcoC5rrRNl6bA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1chnyh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 02:48:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47D2mLpm011081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 02:48:21 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 12 Aug 2024 19:48:15 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v4 0/3] interconnect: qcom: Add SM4450 interconnect
Date: Tue, 13 Aug 2024 10:47:52 +0800
Message-ID: <20240813-sm4450_interconnect-v4-0-41a426f0fc49@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnJumYC/4WP3YrCMBBGX0VyvSkzSfozXu17iJQYpzoXpm5Si
 yJ9d1NhYRcW9vIMnDN8T5U5CWe13TxV4lmyjLGA+9iocPbxxFqOhZUB46BDq/PFuRp6iROnMMb
 IYdI1Y32gQ9t2rVfFvCYe5P6u7vaFz5KnMT3eT2Zcr2vPAkEHjXOmrUxDRBr1101CP3E8DT5+r
 iAxVGG8qDUzmx8q1mAADVVIDeK/qv1WywrAP1fMVoPu2DbuCIP3RL8ry7K8AHLzvv4uAQAA
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723517295; l=1803;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=es3ElNIqqKU+cd3o3qpRCaX6cmXairEmsbslsOJzhOw=;
 b=HajG8o3SAqUVjxS+GR8f7IziH3fe8fEpEzuRqCn3VOlyH+1gS1dAXB1zz+vtTaD5F4nDXa/iJ
 EvYZSIH4KtcDaK9/pomYMFZiLELFwSNMk6KJylXarNTfWmHntbnd+Vi
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Nl_TvB92vjl8acX9yow1Y2H6uqU3ctA
X-Proofpoint-ORIG-GUID: 6Nl_TvB92vjl8acX9yow1Y2H6uqU3ctA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=823 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130018

Add SM4450 interconnect provider driver and enable it.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
Changes in v4:
- Add the Reviewed-by tag back to the binding patch
- Remove duplicate header file references in the interconnect driver
- explain why interconnect need to be enabled in the patch commit
  message
- Link to v3: https://lore.kernel.org/r/20240801-sm4450_interconnect-v3-0-8e364d0faa99@quicinc.com

Changes in v3:
- add enable CONFIG_INTERCONNECT_QCOM_SM4450 defconfig patch
- remove all _disp related paths in sm4450.c
- redo dt_binding_check
- Link to v2: https://lore.kernel.org/r/20230915020129.19611-1-quic_tengfan@quicinc.com

Changes in v2:
- remove DISP related paths
- make compatible and data of of_device_id in one line
- add clock patch series dependence
- redo dt_binding_check
- Link to v1: https://lore.kernel.org/r/20230908064427.26999-1-quic_tengfan@quicinc.com

---
Tengfei Fan (3):
      dt-bindings: interconnect: Add Qualcomm SM4450
      interconnect: qcom: Add SM4450 interconnect provider driver
      arm64: defconfig: Enable interconnect for SM4450

 .../bindings/interconnect/qcom,sm4450-rpmh.yaml    |  133 ++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm4450.c                 | 1722 ++++++++++++++++++++
 drivers/interconnect/qcom/sm4450.h                 |  152 ++
 include/dt-bindings/interconnect/qcom,sm4450.h     |  163 ++
 7 files changed, 2182 insertions(+)
---
base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
change-id: 20240813-sm4450_interconnect-5e15b9b7787a

Best regards,
-- 
Tengfei Fan <quic_tengfan@quicinc.com>


