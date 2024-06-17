Return-Path: <linux-pm+bounces-9310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A990A990
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D4328A70B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E0192B80;
	Mon, 17 Jun 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J+aC9VAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA1161320;
	Mon, 17 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616615; cv=none; b=Tx7j52miqqemaXrCbRVGaskBmv8OBah8TJvXKZoQObUtOv/JkTffQozYFQhasxnchrQ2UtqcL1CuSFUk2kysfmB7H+g5AUPVfMGOjXBf4waOtTwTKhtxTsPbSjfrFJkpl/5RY4wFGTKvqbDRH3tLLe9AEQlv8KjnxFH4bkRqwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616615; c=relaxed/simple;
	bh=vNP4WEhhgNj7o4q3OOnMwZZ0lQTCOjiNm3jP0K3Ak7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfsvHbNGszmwaBDAVs7WsVpAsUfX3v5FuZ/ue4rPIDBjwoMAj8PjD123XtZ3uQv9ZpsB3+U7jrrhC9+jXAhChWN2buujqpZ7nK860zzW92CQkD6kyxLtudZYl8zk523E7ElQnjx/oad6G5AQJQ9rTMD1Daz1vEQOVnu6Z6f97nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J+aC9VAd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GN9UIr009282;
	Mon, 17 Jun 2024 09:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UIzYqNnlh81SFzJY56vFg1
	ODSZdnhxpy/HUIyAB6IDk=; b=J+aC9VAdI3jNb2Y17Q9S7Hc8/6cVxEeDBl3xSD
	wJ3eSk5iAy2oOwX80b2kxfPZnor+N/yGKF1HsoBQ9vy+iFm/3yV2iqFebDu2/bxB
	DoayMGDXhUYB+qS01iqMl9NixDo/IZkYRuoFRsLRcCo7QrapTQgfXwHUoi/C0qdX
	skoJ5hgU59dYm7dKQNz0QMfaokHxslQh0wro/uLQzHCTXQ797rEzjDu1DePdh2r1
	qJqXw6CvORiz/hiFg2kBubPlc7SVenal1TBAYqwHP066Cri+Udt1mYMIeLs1mCLm
	RZ6Wi5cMNc0KykfaXNGvOjKoXFvSomZUTmTDEMc8DtAsxD4Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys0nfbgj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:30:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H9U2jf000649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:30:02 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 02:29:55 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <krzysztof.kozlowski@linaro.org>, <djakov@kernel.org>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [RFC PATCH 0/2] arm64: qcom: Add BWMON support for SA8775p
Date: Mon, 17 Jun 2024 17:29:38 +0800
Message-ID: <20240617092940.1724962-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8g9kyy5441e1V1ZMtA0ZI-TtMm8M19nt
X-Proofpoint-ORIG-GUID: 8g9kyy5441e1V1ZMtA0ZI-TtMm8M19nt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=605 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170072

Add CPU and LLCC BWMON nodes and their corresponding OPP tables for
SA8775p SoC.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

This patch series depends on patch series:
"[PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances"
https://lore.kernel.org/lkml/20240604011157.2358019-3-quic_sibis@quicinc.com/

Tengfei Fan (2):
  dt-bindings: interconnect: qcom-bwmon: Document SA8775p bwmon
    compatibles
  arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON

 .../interconnect/qcom,msm8998-bwmon.yaml      |   2 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 115 ++++++++++++++++++
 2 files changed, 117 insertions(+)


base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
-- 
2.25.1


