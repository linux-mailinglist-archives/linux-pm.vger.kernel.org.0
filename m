Return-Path: <linux-pm+bounces-12126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428ED94FBEE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 04:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F83FB21D38
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 02:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F761CD32;
	Tue, 13 Aug 2024 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GLQCe8b2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB621CD02;
	Tue, 13 Aug 2024 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517318; cv=none; b=Mv0k8yjLPkgg7NDDzmh2p6GvENJXzvEWM1AaGNfPJ3ROFmRHvMfaqBhYJv8zxQHxUEBqahg9vDPknAXp9HesXw89KwrkZX0udv7MsY6kwJrLPd3lBhoYvkJfzBXysQ7NPsPvkletIcto3IUEL5lZ2eMGZmDkdPdrXU75AlBB2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517318; c=relaxed/simple;
	bh=nHxYCSIhrrZHy2Zz8cWH/zCNEeRT9D6bZs1i0/yArL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AYvsg/YZImt3JQPQVRZ8wXXfcADbRTmkc9+SZZf5k1wOBzyWIFQLanPtyHaQDjVmHXso9auXiHHYY4uz8L0LF7BDmvJRvodk30DagxOXbtgZqoKQCgZEdoR/r/M9WdsDUohWpijnr2Jkg/cY8zrjcMdmjdyeoJuSIgJW0So+P58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GLQCe8b2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSZT6003134;
	Tue, 13 Aug 2024 02:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/LoA8K6eThkbYmpBAn3js0QXBHor5nfevM1YMu9kW/k=; b=GLQCe8b2n8naWOsl
	6MbXbx3Z+MYC9AAdskdMI9sX4SuOTuHXAJziYmvyCVjNI6JO67C7Fz7UViIS/wD+
	kqsSfguMRO5JaMYHVbmRaFz8gp1MnXkT7Vq9n6+O+Tu6DFq3V2hCVSZbvgrnldx9
	0iERpsXgdGb4cyqSi9ObvhOFzoNWgA2ykvsTNqbw2rIL3bE3pUo1ff8G5xThz2k6
	Rvhl7OK137wLU1QWwN5eXpsaIjli1JRz6+lD4bSLHWW57RAb9sFduJcgVyUCuyLz
	2j5lSZctCEQQZ3v4jWQq+a1o5w1Bsatpczp41beI6S+fKqR2LZX1p2As1Dyr3DpN
	AqZzbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x17se4fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 02:48:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47D2mTQI013535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 02:48:29 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 12 Aug 2024 19:48:24 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 13 Aug 2024 10:47:55 +0800
Subject: [PATCH v4 3/3] arm64: defconfig: Enable interconnect for SM4450
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-sm4450_interconnect-v4-3-41a426f0fc49@quicinc.com>
References: <20240813-sm4450_interconnect-v4-0-41a426f0fc49@quicinc.com>
In-Reply-To: <20240813-sm4450_interconnect-v4-0-41a426f0fc49@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723517295; l=880;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=nHxYCSIhrrZHy2Zz8cWH/zCNEeRT9D6bZs1i0/yArL8=;
 b=FHGJfuC89f0Nht4TUhw14E71XB2Zl9X17kAP4gAse4quWgKUdERPptXpatDbnawdAITIVrK7w
 6JPLBJ3tEIVC5CRERgVGdXz+pwpztVZR33Fc9jE45UBGsac+Jbk+QR7
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MH9EdAgP-PwZQz-hbl5JUqhAQJE2thxl
X-Proofpoint-ORIG-GUID: MH9EdAgP-PwZQz-hbl5JUqhAQJE2thxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=672 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130018

Add the SM4450 interconnect driver as built-in. On SM4450 platform,
support for features such as UFS and USB will be gradually implemented.
These features rely on interconnect, so the internnect functionality
need to be enabled.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 01dd286ba7ef..593b89e66166 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1624,6 +1624,7 @@ CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SDX75=y
+CONFIG_INTERCONNECT_QCOM_SM4450=y
 CONFIG_INTERCONNECT_QCOM_SM6115=y
 CONFIG_INTERCONNECT_QCOM_SM8150=y
 CONFIG_INTERCONNECT_QCOM_SM8250=y

-- 
2.25.1


