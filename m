Return-Path: <linux-pm+bounces-11280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94AD93888B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0218B20D94
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 05:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F11179BF;
	Mon, 22 Jul 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qw7d1yKV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC217741;
	Mon, 22 Jul 2024 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627764; cv=none; b=j/ZoYnETUy1H8w6VHotDL5oypfdNg+I/Lh6wyhwob78mfJ2dGJGV9in79D45gZVGqZ9I8EP9zUbEXVKeQHrnwfSYf6MGvKP5QIclimd4WNuKvREsGoY5K6EoMt13NKsnMrbd1MN5jgjng+7KtJJygdMu7VBvm8ZbrQPK24yII/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627764; c=relaxed/simple;
	bh=GvHUVkcDZ5st6UVWneAHSfHqxmQbhVZkXZa4ccEPCxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cnFDFlkxQn9Sa1/V00TaM/dB8e+lz6AOx2uksW+l8kcHogyelM4owHvxaVCrJX6GabQqFQEpxaAG+ABBD6qCvnc7TmFomTDZBClqtGojh69IoAB26p7NPh+YemLZCB1y4bly9emYMP31wHwpKCGbYki4mq+oP17A2bGL0Cv9kZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qw7d1yKV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M0E2CE005349;
	Mon, 22 Jul 2024 05:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1BlygAZbcT7bdmo5RZY3zO
	BJJ+hLzSUClx2ySZ8mjbI=; b=Qw7d1yKVj8xWUzPGV/w5IFFBCXC89/PX7vXLLc
	omslu3J/2FGqhUKT5BIU5EDFPgpVwsxXXCls15/EdDfIG2vGyjHoDqU5cK4ttC55
	IZsj3IjwYE0Y/wvpKVGaZR9hx4KsnhziGpZRJ/o85Cdb/yPwR5A/4CwdW7hyUB2D
	fbvoPSfmSDDt/o9b/pIpr4n3ksVC9siVR464NJC2VK4YjAxONNCeMHDLYDhKB7sh
	Ym5VHUJoFV0cKb6J2VLOZuvy1kqA/9MpvPLNtrn560HlACp/FO47VYr6a/+PrgHK
	rrsnkSj3obTldNsUotnEXNRMYh9v+PLFPH4JO8T+oCNbF+hg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2kmtwux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:55:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46M5tvPG012585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:55:57 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Jul 2024 22:55:51 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 0/5] Add interconnect driver for IPQ5332 SoC
Date: Mon, 22 Jul 2024 11:25:34 +0530
Message-ID: <20240722055539.2594434-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _YjLbxYd7hZyukL35LlSs4HjPwjkugMC
X-Proofpoint-GUID: _YjLbxYd7hZyukL35LlSs4HjPwjkugMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_02,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxlogscore=675 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220045

Enable icc-clk based interconnect driver for IPQ5332. This is
similar to IPQ9574's icc-clk based driver.

dt_bindings_check and dtbs_check passed.

Ensured that icc_sync_state is called and relevant clocks are
disabled.

v3: Not taking Reviewed-By: Krzysztof, due to minor change in file

    Add 'clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src' to fix
    gpll4_main's CLK_IGNORE_UNUSED issue.

v2: Removed dependency as it is merged
    dt-bindings update to accommodate USB clock names change
    Use icc-clk for USB also

v1:
Dependency:
[1] https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/


Varadarajan Narayanan (5):
  dt-bindings: interconnect: Add Qualcomm IPQ5332 support
  dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details
  clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src
  clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq5332: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq5332-gcc.yaml      |  2 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 17 ++++++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  7 ++-
 drivers/clk/qcom/gcc-ipq5332.c                | 36 ++++++++++-----
 .../dt-bindings/interconnect/qcom,ipq5332.h   | 46 +++++++++++++++++++
 5 files changed, 94 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h

-- 
2.34.1


