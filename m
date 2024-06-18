Return-Path: <linux-pm+bounces-9478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDB90D7EB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA5AB2E410
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FB4596F;
	Tue, 18 Jun 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z/T0Q6No"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A047A74;
	Tue, 18 Jun 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725412; cv=none; b=LjdTmtJuCbcd8WC6UxRDEO/iyZrT3lLee/KshTSHOqPD7AOMmTirXSVplD281HRk0H63mTzP7a/te66zdpYcPpvjFEPFRWGtPk91+zaqx4AS2oyRsr5EqbNBRdmH97X5HT+GsO3P4mTQIs3//HEegg/hH96n01yiUAGnl7iy/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725412; c=relaxed/simple;
	bh=ebpbN/dNpywtDLCB8DP9glpqyeM0ApP6XhSkY8+iOqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+HBd8iwVpbmlSG8zzebmlPjPBtQ8COfJwrdy6IaFSbuX+19dFbavxE4ERiG1SmrUI+3JiI1wGVBEVexpldMdyNoO2YIFk+Qp9gXsxvSY9OtvN74dp6Jq89SsYOrg7oaRt6LE54VQ3HxNdRs5JXQVptgC/3Wi+MPKSjGTXYrGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z/T0Q6No; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IBCq9C005316;
	Tue, 18 Jun 2024 15:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OqODJXPbx60YyCH10yYajv
	QGq9at/EuxoeSseHwNRC8=; b=Z/T0Q6NomxomoptUYjg6H3EEsw7o3e7rlO2lWq
	79uhgxu6d8uNCiXAYQ6gL3osN6NbxGJKFEPOeLUn+Y/tJkaJRH6nxhENSxX1iXGx
	jYUEWmZZYcvkm+LqRMZmTkjc66pMs8lXHE/fxrcI4T4CAH6bvED/gvWRP6Kw1JHz
	/3fhVMR6vrAELQd85KEyGuXmzVmKXP6ciLs5qPlcRjyrzXIGn3pCZqne7CN1ethW
	olfY7/7VP1pui/P9LlNBHWyR+4zb7iiensLoG+Q7+1N6m4dQkO1SJIQ0nZksIzuj
	+pTM7SIcq1/KMsyi64Vtz6q0hqG0F8venv7hckOxsuT9zDmg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu95rgqpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IFhPxh016645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:25 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 08:43:20 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH V2 0/3] arm64: dts: qcom: x1e80100: Enable bwmon support
Date: Tue, 18 Jun 2024 21:13:03 +0530
Message-ID: <20240618154306.279637-1-quic_sibis@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kBnSRCW1KWj95IMeLd0QO4y1wlHAoiVt
X-Proofpoint-ORIG-GUID: kBnSRCW1KWj95IMeLd0QO4y1wlHAoiVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 mlxlogscore=957 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180118

This patch series enables bwmon support on X1E80100 SoCs.

V2:
* Allow for opp-tables to be optional on X1E cpu-bwmon instances. [Konrad]
* Drop Rb from Krzysztof due to more bindings changes.
* Use explicit request/free irq and add comments regarding the race
  introduced when adding the IRQF_SHARED flag. [Krzysztof/Dmitry]
* Use consistent numbering of the opps across instances. [Shiv]
* Use ICC_TAG_ACTIVE_ONLY instead of magic numbers. [Konrad]
* Drop fastrpc enablement patch. [Bjorn]

tag: next-20240617
base-commit: 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc

Sibi Sankar (3):
  dt-bindings: interconnect: qcom,msm8998-bwmon: Add X1E80100 BWMON
    instances
  soc: qcom: icc-bwmon: Allow for interrupts to be shared across
    instances
  arm64: dts: qcom: x1e80100: Add BWMONs

 .../interconnect/qcom,msm8998-bwmon.yaml      |  14 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 120 ++++++++++++++++++
 drivers/soc/qcom/icc-bwmon.c                  |  14 +-
 3 files changed, 144 insertions(+), 4 deletions(-)

-- 
2.34.1


