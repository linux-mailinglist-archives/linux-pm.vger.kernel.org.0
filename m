Return-Path: <linux-pm+bounces-21684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA4A2EC2F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 13:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D69818883FE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B89222567;
	Mon, 10 Feb 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C5W2OVu3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92098221D85;
	Mon, 10 Feb 2025 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189128; cv=none; b=vC/apTpVzaLeO/+/+lYSLVdS2BGXHBPWt2ZkRxrBqlDZdEzNCGzp2jtPBHv9dtlmUc3/thy/PKorCidQxKPDrdpRSj13UW9P5vGu6WIyDVxTb/gEtGwMw/7zWkX7by8138fGYG9+pO1hGOTlAJRXAe4rVV0Bg++kI1pzP+48Ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189128; c=relaxed/simple;
	bh=oID4Ta0xjTrweyhQDnJ52ku0+gAdSFPdKKZGcYJ03iU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1Enf80eJ4rsy6ZtNdy9geciy3TwkhPVRohrtggc68rqfcnAlsj8mAMQTiG8oRT3559taQSzegpJ1Mnca4sAVVMfBTHWiDqCW26ua9X3YsIiJ2O2l2DY2ZJnYlndk4A25bIWQuTtvPfBhdz/en2y+KVp0eeFuhe4ZsW07iSgtbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C5W2OVu3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A8mEct002523;
	Mon, 10 Feb 2025 12:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q/4OenOS+W79WfF8ASpUEh
	WQ02xzgBO3Sm/VwFVR2XM=; b=C5W2OVu3OZ1q1Wxdn5fdljZBMVdnCD5hlLNKfz
	4m+PjatBH63C+UGnKLWB3L6enE864IFrFAWJcu+eO3gDFB+CdaRcuR0yalEnWijA
	fUYvYz7PhQQIl3FcOlhi0viMTLJnq5XTANtJy0qRZ9rrLOBDlurHMvpk6wbHsmob
	m0VUoSEg0vDWaoK6zI+rCYgoQp4Px66p5C/cP2QeqjWJq6I0JTmEK+FjizzgjNuQ
	CHCwlRgyL82Q58X/U03UEAB14LGSTelCqHvpu46+wL0su2AEcKAicfJDvFea8bgM
	wUAinaJ4heK7lj4MlVhPxi+EjBSY0mfKGRqGk8+C1xWED3DA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dym7c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 12:05:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51AC52TT010075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 12:05:02 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Feb 2025 04:04:57 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <amitk@kernel.org>, <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v11 0/6] Add TSENS support for IPQ5332, IPQ5424 
Date: Mon, 10 Feb 2025 17:34:30 +0530
Message-ID: <20250210120436.821684-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: p4qbLoOSLlIAdmsYJKTDQZKvJpr8HLGu
X-Proofpoint-GUID: p4qbLoOSLlIAdmsYJKTDQZKvJpr8HLGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxlogscore=736
 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100102

IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
upper/lower and critical. IPQ5332 does not have RPM and
kernel has to take care of TSENS enablement and calibration.

IPQ5424 also uses same tsens v2.3.3 IP and it's similar to IPQ5332
(no RPM) hence add IPQ5424 support in this series itself.

This patch series adds the temperature sensor enablement,
calibration support for IPQ5332 and IPQ5424.

Changes in V11:
	- Dropped patch #2 because it's merged.
	- Detailed change logs are added to the respective patches.

V10 can be found at:
https://lore.kernel.org/linux-arm-msm/20241219062839.747986-1-quic_mmanikan@quicinc.com/

V9 can be found at:
https://lore.kernel.org/linux-arm-msm/20241125050728.3699241-1-quic_mmanikan@quicinc.com/

V8 can be found at:
https://lore.kernel.org/linux-arm-msm/20241115103957.1157495-1-quic_mmanikan@quicinc.com/

V7 can be found at:
https://lore.kernel.org/linux-arm-msm/20241107140550.3260859-1-quic_mmanikan@quicinc.com/

V6 can be found at:
https://lore.kernel.org/linux-arm-msm/20241104124413.2012794-1-quic_mmanikan@quicinc.com/

V5 can be found at:
https://lore.kernel.org/linux-arm-msm/20230721054619.2366510-1-quic_ipkumar@quicinc.com/

V4 can be found at:
https://lore.kernel.org/linux-arm-msm/20230719104041.126718-1-quic_ipkumar@quicinc.com/

V3 can be found at:
https://lore.kernel.org/linux-arm-msm/20230713052732.787853-1-quic_ipkumar@quicinc.com/

V2 can be found at:
https://lore.kernel.org/linux-arm-msm/20230712113539.4029941-1-quic_ipkumar@quicinc.com/

Manikanta Mylavarapu (2):
  arm64: dts: qcom: ipq5424: Add tsens node
  arm64: dts: qcom: ipq5424: Add thermal zone nodes

Praveenkumar I (4):
  dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
  thermal/drivers/tsens: Add TSENS enable and calibration support for V2
  arm64: dts: qcom: ipq5332: Add tsens node
  arm64: dts: qcom: ipq5332: Add thermal zone nodes

 .../bindings/thermal/qcom-tsens.yaml          |  18 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 135 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 201 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 178 ++++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   8 +-
 drivers/thermal/qcom/tsens.h                  |   3 +
 6 files changed, 542 insertions(+), 1 deletion(-)


base-commit: df5d6180169ae06a2eac57e33b077ad6f6252440
-- 
2.34.1


