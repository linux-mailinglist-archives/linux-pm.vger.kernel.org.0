Return-Path: <linux-pm+bounces-8547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1498FA757
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 03:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D321C236C4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C498C1F;
	Tue,  4 Jun 2024 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a87amCzr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CE8BEE;
	Tue,  4 Jun 2024 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463596; cv=none; b=CubXfo93oIpovywrK8BbaBfBxCnfRWDrm2IE0uiNS0WtF0+dsRQZvcQehgyXvkf7ZE3bL79BRskBGwQvReOynYAKxCtvO4+3rFXIg5SlxergLACcuXtqF3WwyQFHfPBGI341jfFwORWQZeQfOBeJls0Pp6s4YoTAUKbb2L7l4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463596; c=relaxed/simple;
	bh=ivWSIXQ03RUpEzamFDdjRbL9edghLIKo2coTate4x68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+MWhpy7wWDxrIdiLqBzXkIjtiNO66HWHm4uZFv5NcQFHcis2aAN3e9Zu0G/dj3ncUeucPJzPRhEHV6LLJjGSoxVmaR1L5DZWfmeJ/a88LB5+yFIkylq7r85hWsTSq9PPAd7HxsiUm72D9ESHB37qIrcj/mLgrwVidp+4v9tOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a87amCzr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453BAMNO014994;
	Tue, 4 Jun 2024 01:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dzpP5fauMwOrMst2EJAjYi
	mAjDO41S6iKyRxp7EtFUo=; b=a87amCzrHfnbz7yXuDyCQGWPNi5FU+pCyVkugK
	Jwa2B5Tgi6mhtlzeDgjxt2DsuTds/RXNFebTXLzrf1bm1/W8VgEscIeZ6jp8g9QM
	8/pIPYPeU4DpOkw0crDOKjh0MSQJGjQ90Bqv4UW6C8CjGtFnVVgwninXiwuzRHgW
	JCBqcHPRJA5RdztKvI9FHrITNGJ4+SjFTrArWQdGeWLaX5pkf6SGmonxzhV7bPB8
	TmyOVez3GgoNr7weA9TJYinGdYUurlrI2CPj0GuF1yDhuL4nRaQ7lwOmtqKeJAtU
	7A16Pmo6PklB3I127OphupYkPyMm9gr+RXAI5ro20i2/MOOQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw3r5mr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 01:13:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4541D7M9023231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 01:13:07 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 18:13:02 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH 0/4] arm64: dts: qcom: x1e80100: Enable bwmon and fastrpc support
Date: Tue, 4 Jun 2024 06:41:53 +0530
Message-ID: <20240604011157.2358019-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: xc0BQ0jdKc_T1iT9wYeDwW0QYM7TlWaJ
X-Proofpoint-GUID: xc0BQ0jdKc_T1iT9wYeDwW0QYM7TlWaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxlogscore=652
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040008

This patch series enables bwmon and fastrpc support on X1E80100 SoCs.

This series applies on:
next-20240603 + https://lore.kernel.org/lkml/20240603205859.2212225-1-quic_sibis@quicinc.com/

Sibi Sankar (4):
  dt-bindings: interconnect: qcom,msm8998-bwmon: Add X1E80100 BWMON
    instances
  soc: qcom: icc-bwmon: Allow for interrupts to be shared across
    instances
  arm64: dts: qcom: x1e80100: Add BWMONs
  arm64: dts: qcom: x1e80100: Add fastrpc nodes

 .../interconnect/qcom,msm8998-bwmon.yaml      |   2 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 325 ++++++++++++++++++
 drivers/soc/qcom/icc-bwmon.c                  |   3 +-
 3 files changed, 329 insertions(+), 1 deletion(-)

-- 
2.34.1


