Return-Path: <linux-pm+bounces-10985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4292E72E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A16B2A2B5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0BD15B0FD;
	Thu, 11 Jul 2024 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UboI2HkV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4013C3D5;
	Thu, 11 Jul 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697583; cv=none; b=VmxmxZD5lFNrLxUDIc3v5rbrKJ6KTUYnZyvwsKtm62yVo04JeeouiAp2vK3Lz0esvrMEi016usYIOtOLpWgsnkNyDtXyGjzoBWytcFcuWsgS1sYFX1BQsEmKc+BVku34r/PcT8tlYAM6uX/atR1YCth/L1YAZOKsQ9/mS2vePYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697583; c=relaxed/simple;
	bh=kVs5hOR2FzBP3GEd8SYwMmGIonKLK+U1/m7op4XI8Wo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r8COyAfcdoyPnPO+otjiNZ2dzQJQrOC1g8AwIiFlC4fczqSMDyhDQ7++cpAGU6D3AvL8I2eLdCb6v1gz4PRrq7E4LC97rzzzTtOgyZ4gT0jzEa4LQCY9Jgg3xUkq1eL5JpLK4LQm80/llMgQyIVdD70bFg2upll6HTm+HVYlrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UboI2HkV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4mph6008773;
	Thu, 11 Jul 2024 11:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3h70n+wTPt2q93enaQM4qP
	ebLgMvxWzu2rSFpos/UiI=; b=UboI2HkVBc7zzSzkEYYZ6+HQfZsTLQRBwp3jBl
	NHGr9UyDbhuwTsAOyz0h2BRJI/ZtiDuY5l5eHe2mDFB4uI7LWzykvGmq8JKu8bGc
	+2HnA3jj3DUCyMwdpBIHEDwKor4G0efkCzBtPVRoXHxGdl840WsdmAqOVv42Sluh
	pO/YjxKcpQ23X0+Hpu6TX1gl0bBbvymV4Vv6gdz8eZuegjunBU6ey2XVBYzlSXHV
	3H35fA5nHLPKcGDM2DvIymuHRvSP0ZTsRKuW6rvST8GgBhmtwDjWwfwmailxWkys
	P2pwQ8gcwuDC2uTqbRp5ykurYpurf3TmgvF0uJ+o7oPYZTLw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x51cdcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:32:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BBWuMS011979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:32:56 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Jul 2024 04:32:50 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 0/4] Add interconnect driver for IPQ5332 SoC
Date: Thu, 11 Jul 2024 17:02:35 +0530
Message-ID: <20240711113239.3063546-1-quic_varada@quicinc.com>
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
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G9a88L5X6-B4_NShCkQE_T9espEbs5nI
X-Proofpoint-ORIG-GUID: G9a88L5X6-B4_NShCkQE_T9espEbs5nI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=566 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110082

Enable icc-clk based interconnect driver for IPQ5332. This is
similar to IPQ9574's icc-clk based driver.

dt_bindings_check and dtbs_check passed.

Ensured that icc_sync_state is called and relevant clocks are
disabled.
v2: Removed dependency as it is merged
    dt-bindings update to accommodate USB clock names change
    Use icc-clk for USB also

v1:
Dependency:
[1] https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/

Varadarajan Narayanan (4):
  dt-bindings: interconnect: Add Qualcomm IPQ5332 support
  dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details
  clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq5332: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq5332-gcc.yaml      |  2 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 17 ++++++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  7 ++-
 drivers/clk/qcom/gcc-ipq5332.c                | 36 +++++++++++++--
 .../dt-bindings/interconnect/qcom,ipq5332.h   | 46 +++++++++++++++++++
 5 files changed, 100 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h

-- 
2.34.1


