Return-Path: <linux-pm+bounces-11801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E6944720
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62973284842
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8516EB5B;
	Thu,  1 Aug 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KcsIaeTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598D4503A;
	Thu,  1 Aug 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502544; cv=none; b=CgJ/06d3jcyO886c4Xp9kYvbuun2pyTerayji+dOdI9/YtssuU6tw+s+7M5fblpGkIdABOjxdVVpJMbQVeDBEkxOCA8s+2zIJ3gh+qKmpNxcHZoOplxyAU/UzvAda6gw6ra1o9RsaN1pKouB5S/BVZrQuH12E1pgu5Ro+LCXNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502544; c=relaxed/simple;
	bh=kLw8gwzeVqHhp6F81uYID+qGAj/tTUkFxHEGFmalbkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I8r+s2YtcB6fjXAx8Y8gbhcs7HwV79ZXLtH/XbW2KeuzJF28ung4+C0EmLdIgAB9VdAaYM36dzAGQV7P0nwPBPDSpOSrZEtKuDB3ATTDkxvGrI+jboAa3p7TDXLLIm9Mshtu/3JDH0tfyprofTJ3EfYWc5pb+cbJxGJpUC3e7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KcsIaeTf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47184Wdq022460;
	Thu, 1 Aug 2024 08:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m79gI7m04yvUGwDVELrOtKwh58hpY35nRX81dk/STpQ=; b=KcsIaeTfckjB2L2T
	4MKF23UDoDWp4hM1s2Y3xgdpQBZB3Bt9cBCq0i3dPM5tbBZ+hWGzMYhPmSeNMjl1
	hKYp7zuMhut77HOJtnQHekIFeyfxQD6iUfAF4iUKQA8P8UNsGpVOfCEtIxZrQ9dM
	LkEXhK8B6EcMYdZkJE9L5tR9rGFQiyB5Wk7NiCOWbuxmsIHCePW6SoeywyAvrQRl
	ALnH9+q+BSZPoLMxjBnUhbstbGN3gUqVegYKLwzxoFCm/Rm/HIhyxyUo4yoxwp/T
	/pMiDNvsqUp8yyLw0hGOxYqJadxeDTZReCGZ1kmE2psQKwFcnsMctvTaQ56IcnH6
	tqx1uA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qkv0ud9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:55:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4718tMkP003282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 08:55:22 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 Aug 2024 01:55:17 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Thu, 1 Aug 2024 16:54:38 +0800
Subject: [PATCH v3 3/3] arm64: defconfig: Enable interconnect for SM4450
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240801-sm4450_interconnect-v3-3-8e364d0faa99@quicinc.com>
References: <20240801-sm4450_interconnect-v3-0-8e364d0faa99@quicinc.com>
In-Reply-To: <20240801-sm4450_interconnect-v3-0-8e364d0faa99@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722502505; l=696;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=kLw8gwzeVqHhp6F81uYID+qGAj/tTUkFxHEGFmalbkM=;
 b=odIhgcJeG86BcBqEYh3yjvSdC7bnZXlD9ZehphyUSLFOA0wx7Ymbki3V5HM+JLmsGUCy/hbca
 3zlKnRaMtzpD2L/Z8YtS52IJZP3P0n8Lq0Jq8i9DUGFoOeealIB+ulp
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KWtzgwFAb6TsnmcAC6zzQ4o32fIKdofM
X-Proofpoint-GUID: KWtzgwFAb6TsnmcAC6zzQ4o32fIKdofM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=695 clxscore=1011
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010053

Add the SM4450 interconnect driver as built-in.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 831aa314bc9c..d6f50d31568e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1623,6 +1623,7 @@ CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SDX75=y
+CONFIG_INTERCONNECT_QCOM_SM4450=y
 CONFIG_INTERCONNECT_QCOM_SM6115=y
 CONFIG_INTERCONNECT_QCOM_SM8150=y
 CONFIG_INTERCONNECT_QCOM_SM8250=y

-- 
2.25.1


