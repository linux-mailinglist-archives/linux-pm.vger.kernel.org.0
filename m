Return-Path: <linux-pm+bounces-18013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A759D7ADB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C6281E7D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 05:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC52E62B;
	Mon, 25 Nov 2024 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QkAeaeFv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FE2500C8;
	Mon, 25 Nov 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511288; cv=none; b=k8IBXjQfJcKWi3LSW+hQePRyINHWdbmB5WkP/oBYE6bkW6ZHkKcSGDL262TrRUASCXxAu+PnvMzYUBFJw2KX8VS68YALV1oiNq57A9ANWS4j7gf+4qjGZmvfooWQ80OdRWOpT/74cfkr35yW7EFiBDhLG5nNoL5SD36UXYI/Fvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511288; c=relaxed/simple;
	bh=eCTbs0JZb69D9es/iL57YN+Wzq6f9RN1ifl8th7bfFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJabn5/96vuEpiV6LRZtMxzTHZT5yv9tpODknRhkZGq7ERuu0O506NFk4XIFAumAi2NSYO4uPXBjHrwxO9Zo0wH/Gsmlp+TxGDnolxMVsZ17AFyGMCVGJ0f9ujrtQbjQdv63V0b9LbKizrnK8L5EbNSiYXDPW1Nf/bmvzViOEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QkAeaeFv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOMBjMf024879;
	Mon, 25 Nov 2024 05:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qp9FobJU5xuolasioWQMn6
	Hkzg6cB+z8wWzmDeu0srE=; b=QkAeaeFvp2c+sW/qkifCp6dg8uOjmJRNs1Iuti
	5qr3u9R1ES4QoS4nodYj1rEV8cmEktTWPNu7/97miXvbkNiXZ3AjbkqKT0MgLogR
	QCGFZ91G2DypgjecUGWypCgwW1dOgCUkfgMXl6Nu/uefiGgo/rKa/5Y4ODbVMDF8
	qT5jpredhKinpq2HDNk5/ChyVi8bHWhZOiZRdBheNCn4fCN7xUQV0e8KC0jX1iDy
	Ul5J19BRiXMzZA+A5qI1H4hcJtJCSKnI1UB01245PjXJ9gFmKK8QeGzEO1JfO8EO
	D7AvuTEDTBo4hlTXELrWBhHA+v2+3WCw96uobwhSA+y7HKBg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4338b8bb5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:07:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP57uZs000799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:07:56 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 24 Nov 2024 21:07:51 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v9 0/7] Add TSENS support for IPQ5332, IPQ5424 
Date: Mon, 25 Nov 2024 10:37:21 +0530
Message-ID: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wNoyZpgLkc8IGwzbRFKO6o6Hj6ZP2-25
X-Proofpoint-GUID: wNoyZpgLkc8IGwzbRFKO6o6Hj6ZP2-25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=751 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250041

IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
upper/lower and critical. IPQ5332 does not have RPM and
kernel has to take care of TSENS enablement and calibration.

IPQ5424 also uses same tsens v2.3.3 IP and it's similar to IPQ5332
(no RPM) hence add IPQ5424 support in this series itself.

This patch series adds the temperature sensor enablement,
calibration support for IPQ5332 and IPQ5424.

Changes in V9:
	- Fixed all review comments from Konrad Dybico
	- Detailed change logs are added to the respective patches

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

Manikanta Mylavarapu (3):
  dt-bindings: nvmem: Add compatible for IPQ5424
  arm64: dts: qcom: ipq5424: Add tsens node
  arm64: dts: qcom: ipq5424: Add thermal zone nodes

Praveenkumar I (4):
  dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
  thermal/drivers/tsens: Add TSENS enable and calibration support for V2
  arm64: dts: qcom: ipq5332: Add tsens node
  arm64: dts: qcom: ipq5332: Add thermal zone nodes

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |  18 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 135 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 201 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 178 ++++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   8 +-
 drivers/thermal/qcom/tsens.h                  |   4 +-
 7 files changed, 543 insertions(+), 2 deletions(-)

-- 
2.34.1


