Return-Path: <linux-pm+bounces-131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5BD7F60CE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC65281E19
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497ED25770;
	Thu, 23 Nov 2023 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bl1iqIqJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A2FBA;
	Thu, 23 Nov 2023 05:50:54 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANCRMkX017382;
	Thu, 23 Nov 2023 13:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=oZXD2fFXsHF5yC43lnl3y8lNittg+JTRjRA3khNNHHo=;
 b=bl1iqIqJm9sStgYQqVPd+TXdlj+H1S1lv2FyKix0e8d80IcMqY44Mmt4QOle94DE4jz0
 jHSKW5iWIpcidV8ebMuzLv0kXhpjkUzxobw3/WISuEZrdlbhTMH2j1wgQ1Dmglak3hz3
 WY2WVOpNL5mjRt4ee89y8oP6OcjYp6G/QEiaoUNTqiRUEQtwV1zttHGh2Iwg7GTxKuUJ
 GzsTDnGpzsNZhKSKRCY6FpuhJ2yZ7Zp4GvRNpP7pg6OM26379i5fYXbWLyZgXsvFSaoK
 Menlwo1/oxJxen/SBtd5crV/v0A6mciAn2Pg5shrLG8s3vjL3vRZNngXR6M1URWK+cEF oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj4hwgdfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 13:50:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANDonBC023871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 13:50:49 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 05:50:44 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <agross@kernel.org>, <conor+dt@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 0/2] interconnect: qcom: Introduce interconnect drivers for X1E80100
Date: Thu, 23 Nov 2023 19:20:26 +0530
Message-ID: <20231123135028.29433-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zEdJoelmjJw1LI26UaZtQV8E6x4p4G4M
X-Proofpoint-ORIG-GUID: zEdJoelmjJw1LI26UaZtQV8E6x4p4G4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=704
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230099

This series adds interconnect support for the Qualcomm X1E80100 platform,
aka Snapdragon X Elite.

Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
the part number sc8380xp which is now updated to the new part number x1e80100
based on the new branding scheme and refers to the exact same SoC.

V3:
* Fix the index numbers of pcie_center_anoc nodes. [Georgi]

v2:
* Update the part number from sc8380xp to x1e80100.
* Fixup required property ordering [Krzysztof]
* Pickup Rbs.

Dependencies: None
Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat


Rajendra Nayak (2):
  dt-bindings: interconnect: Add Qualcomm X1E80100 SoC
  interconnect: qcom: Add X1E80100 interconnect provider driver

 .../interconnect/qcom,x1e80100-rpmh.yaml      |   83 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/x1e80100.c          | 2328 +++++++++++++++++
 drivers/interconnect/qcom/x1e80100.h          |  192 ++
 .../interconnect/qcom,x1e80100-rpmh.h         |  207 ++
 6 files changed, 2821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/x1e80100.c
 create mode 100644 drivers/interconnect/qcom/x1e80100.h
 create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h

-- 
2.17.1


