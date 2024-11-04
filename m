Return-Path: <linux-pm+bounces-16941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54609BB4E5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8EA282885
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572A1B6CF8;
	Mon,  4 Nov 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HiSyNGeq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7B1DFD8;
	Mon,  4 Nov 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724293; cv=none; b=TqKSyGhg+0LyMgvPopw3xtnA/36/Rw1HXylC3TQCjKHtsH2Lg6TFY79dAUGmXtDh+OsqqiQjT+wmP+5ssO8i/Yp4j316eAlwliq5pxynbPEUUJ9d745jZQ4Z1MCtBF9hWH1i/JwQckbYH5ouSfidTtDaJpBJjtx9JfWOXJm23z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724293; c=relaxed/simple;
	bh=XLFKyaBCc7k/Bi+Yg+zStQSzxok+9dy35rk6M8PjV40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fv2xmtDtEJ2iRDazq+1AEkBs6DXMNZW5ZPKlWI9p/vOi1w429eXpIesrsd4JFkCk1EivLLT/iat7VwTJQZTEj6Llxao3kxthKuzwg7g6w27obCFlXP65pBQYlN51pBzzXuaDcRvAHwhmof7vU3cIqgJrWEXNYF5frqQbyTaEhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HiSyNGeq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BA1NH005846;
	Mon, 4 Nov 2024 12:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TeJzf0gLHQuB9pE3jYViCi
	NMn1Lwgsx8/oK1wVQL288=; b=HiSyNGeqxtE7wnMrpi1lauL01ff8XdbF5Pf+PZ
	xYAJCaf3qlM/rhQYVmDPcuRzjCXyLN/Eopgr+4EwKW6/NdHmUEm7zWaeoMhMTDru
	PKsdYUK5hwYsdiF0arPWjH82Xi/gqKNURGfWkd4seRQ+th7majvm76rTezuo3zFY
	XmKSVOXEPKlbAS7lwI1z0mIDBeujNZ/i8GmGTO1gGUtBFwY8Ebj8+HxBy40Y8wMe
	GoHHWMNGKJwBgRauEKrHVcxEXegp9aP+dHv1nD6dtAjtzqew2+tdRb+QpFF+Y0DA
	5zU9PPWhJtg2Z+P02Fwa//UTnq/Z9TSIBU73vqgEqS38ZySA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxv7km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 12:44:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4CieXq009191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 12:44:40 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 04:44:35 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 0/7] Add TSENS support for IPQ5332, IPQ5424
Date: Mon, 4 Nov 2024 18:14:06 +0530
Message-ID: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yHxDmoJ_62-jARGiScQh2G3540Y1IRWC
X-Proofpoint-GUID: yHxDmoJ_62-jARGiScQh2G3540Y1IRWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=889
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040111

IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
upper/lower and critical. IPQ5332 does not have RPM and
kernel has to take care of TSENS enablement and calibration.

IPQ5424 also uses same tsens v2.3.3 IP and it's similar to IPQ5332
(no RPM) hence add IPQ5424 support in this series itself.

This patch series adds the temperature sensor enablement,
calibration support for IPQ5332 and IPQ5424.

Depends On:
https://lore.kernel.org/linux-arm-msm/20241028060506.246606-1-quic_srichara@quicinc.com/

Changes in V6:
	- Patches are re-ordered as follows
	  1) dt-bindings
	  2) driver
	  3) dts
	- Patch #1 and Patch #5 from V5 have been merged and incorporated into
	  Patch #3 in V6
	- Added TSENS support for IPQ5424
	- Detailed change logs are added to the respective patches

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
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 144 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 211 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 182 +++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   8 +-
 drivers/thermal/qcom/tsens.h                  |   4 +-
 7 files changed, 566 insertions(+), 2 deletions(-)


base-commit: 1ffec08567f426a1c593e038cadc61bdc38cb467
prerequisite-patch-id: 1090fe9cee19a52dc8595e2fecef659199828246
prerequisite-patch-id: 491c9f6c32738c4eb4398962c1ae7c625cd43238
prerequisite-patch-id: 1651c75547b539eb46eb4d02630e364f262860bf
prerequisite-patch-id: 7ce54f0af6083e897067a7e5cd9561198f3d4d41
prerequisite-patch-id: 0a04fdee4b5b76cd5b734c666f7c8f5561e3e9d8
prerequisite-patch-id: 084f6dced27c39b600711dde2f797b43393cde73
-- 
2.34.1


