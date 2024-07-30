Return-Path: <linux-pm+bounces-11637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7F940953
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 09:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF21C22D2F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740E18FDA5;
	Tue, 30 Jul 2024 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CJD5/bmW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BC186289;
	Tue, 30 Jul 2024 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323814; cv=none; b=ST4Xqby1HF1EAwK5awUchHpapbSzf+SBX/pIpTyh0LrrnRQn2863AGzmp+3dYXNxNVg1BH74NmzvDrtK4huBBrBnQK2pt5dJYFzLqdgJQ8Us00aokCbD6aEtUnwJv1mwpb/Ij0/FxnCwwB0TV2P6FfO/y3Vo1vrx5uFvRj6EOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323814; c=relaxed/simple;
	bh=Moxl/HbHI0vpJBQSipP350r5n3fD0CG6czKc+K4Ok+o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QOHc5B5EjPJbsO4Lmev8cSRJ4adxTzdYYMwm+CSLBK9InKULSRvZDCulXbFl31TPfgh9GBBEHr4Ocx8w9K7/FG0BwFIlW2yQrl7f5ZUyqfoAHZyeI3WSiOW2t9Lv7icYB9H/d9PRr54aqZCp5OMBiRdGuLju6864ZkgZfJjDVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CJD5/bmW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U29Jru029906;
	Tue, 30 Jul 2024 07:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+go+ZapqjXwrG2CVDBiJv6
	5Yi7Au5w3umy2e/WFQZRQ=; b=CJD5/bmWwxCNAG7u963HN0yNtHdCyRv9ScCIml
	KTuSFqNotY8i0vcZyRlQVUCpBTxDWZJOUY20D4KLz+80BFB9EHncuMa0que2bYvL
	rj9X6fgDdNR70t9MdNKFRPBVfeqViG0giQqzs5zMYN2ntXOIJ3VcK+GEbUIVdzst
	HFjgoJO//Dxd+mEk/7YqMZs5zTqoMGsO7810bkBIfkXjgf5iWVVlWNQCVMpvy+0+
	A7uvb/Xfe3Fjwllzg29m1d3euIAA/2qmN945wy1TF4+Z+BLN/k/0KZjPaOnSneOZ
	W8v3+1J3omQGhMpxpZ0E8yntr8MZHoRnTW0KD1Z7dFWoWrcA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pq520kfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:16:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U7GmHR005057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:16:48 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 00:16:42 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 0/2] arm64: qcom: Add BWMON support for SA8775p
Date: Tue, 30 Jul 2024 15:16:09 +0800
Message-ID: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmTqGYC/x3MTQ5AMBBA4avIrDUZqimuIiL9GcxCSZsgEXfXW
 H6L9x5IFJkS9MUDkU5OvIeMqizArSYsJNhnQ411g1qiMN5PybRaq2Oy17YHYTtDFpWz0iPk7og
 08/0/h/F9P0/uunljAAAA
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722323802; l=654;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=Moxl/HbHI0vpJBQSipP350r5n3fD0CG6czKc+K4Ok+o=;
 b=hsMZJXqceR+fRMpnGTnR/4oDA+lC+NkOcbuzbQSLboik5tjHAp9VzpW0krhCixHdqXfxmv7Iq
 zcVg5cXvvskB63MGALcZxU8pjJ8nG0gTVUS4PaRXAjm/aiStzRoELlX
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 78pUfiMlaXy74lULXuK-kdaZITcCxi9X
X-Proofpoint-ORIG-GUID: 78pUfiMlaXy74lULXuK-kdaZITcCxi9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=802
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300053

Add CPU and LLCC BWMON nodes and their corresponding OPP tables for
SA8775p SoC.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
Tengfei Fan (2):
      dt-bindings: interconnect: qcom-bwmon: Document SA8775p bwmon compatibles
      arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  2 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 95 ++++++++++++++++++++++
 2 files changed, 97 insertions(+)
---
base-commit: 931a3b3bccc96e7708c82b30b2b5fa82dfd04890
change-id: 20240730-add_sa8775p_bwmon-b9aeb05cb3d0

Best regards,
-- 
Tengfei Fan <quic_tengfan@quicinc.com>


