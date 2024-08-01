Return-Path: <linux-pm+bounces-11803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3341944727
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010BB1C244C1
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C2170836;
	Thu,  1 Aug 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c7DqWxRX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B974503A;
	Thu,  1 Aug 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502549; cv=none; b=h1LqiGuAfZcRBolb0/ZPDUHEvVBSmKtrjwTE01P2XKnbA7cRjNqlGQR8aynkTB2rVCO84MOgvXLdKHh45Qi35jPa5h4znYv5mFqzKxH9VHXTQv2CF7Mb0fMr/AtCgZpdOi5MtVcb48bt9u3IIzPFy5HKijPb2R9xwUVHpl3k/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502549; c=relaxed/simple;
	bh=PLUfEgox7CtnZQfwF9dblYIhmu0YYHyX4i6/vkfHk5o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=R8UG04TPJrpLdjeSNbGZ3/XsgkeTbUExCHxOE3aidvJvmtIYZ7wsdg9kbHqBf0wckWVj3b+Iy1umWs0o4w0uERlXrdA7JkQim/DKaXUSkUhe/ZvTJevRmIfbGXoxtx1T2aVAMXNT7OeGO02xxx4EKDE13ETCo1SoLMPaDSYbIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c7DqWxRX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717caAg012068;
	Thu, 1 Aug 2024 08:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lCFv9W/1yqPkptOdArl+Xr
	DedHPQMb/w80hiU9HehYc=; b=c7DqWxRX8sA4Gv4h2b0I4/vc3laNIZnx7YsFgk
	jUwQFEmDwIXiKlQcPTdWMbpQS1tYWYw5UtvaIDqat2HL8MFKIY1m3IelRYVx2x4m
	Wc6E1G5Z6VWKkpX46GNFRjz1rrHvlkzfBYlQAmMEyOfeiqkcpaBnIb390TUXzZC/
	BGIX0i9es7IWYOi4UFcXE2qJ+UFNa7i/2qA8GWdzp3KJnOG6Uo03a8e51xH0MwOi
	b154OzkbqWiKyFtqpglfn4LUXjC2wEnTeIGgOGd7GxaSwAg2JPB2Kx6I2FTI54p0
	BW6SXe+mHRU2/wJ3TYjuDAf47ZcD4brZWx/dzzUSZhX971hg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qugahysx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:55:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4718tB8n003144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 08:55:11 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 Aug 2024 01:55:05 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v3 0/3] interconnect: qcom: Add SM4450 interconnect
Date: Thu, 1 Aug 2024 16:54:35 +0800
Message-ID: <20240801-sm4450_interconnect-v3-0-8e364d0faa99@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExNq2YC/32NQQ6DIBQFr2JYF/NBwNJV79E0xiDoX4gtUNPGe
 PeCq666nJfMvI1EG9BGcqk2EuyKERefoTlVxEy9Hy3FITPhwAWcgdE4CyGhQ59sMIv31iTqWi0
 cDC0oKUk2H8E6fB/V2z3zhDEt4XOcrKyspdeAzkUlBG9rrrTWlNHnC02XrB9d768F0JvaLDMpm
 ZX/qEwCB8Z1zbRi7K+67/sXCy+ZDegAAAA=
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722502505; l=1520;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=PLUfEgox7CtnZQfwF9dblYIhmu0YYHyX4i6/vkfHk5o=;
 b=VWdFqX4Ksr3WAAfzNWgRbi+/MElAuhobA1LwdCgC+OC5JQOk3S6WF/abT0p2xGD5TMQtB8YfE
 iSr/1XsrptcAqMkMJBdoNBMqxrgCPa5eJBhKthAlSdCBqc6DpE9H5nY
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EZ2P_gBkMqeZ_nXS_qEpbLs5zIYTkAjE
X-Proofpoint-ORIG-GUID: EZ2P_gBkMqeZ_nXS_qEpbLs5zIYTkAjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=709 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408010054

Add SM4450 interconnect provider driver and enable it.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
Changes in v3:
- add enable CONFIG_INTERCONNECT_QCOM_SM4450 defconfig patch.
- remove all _disp related paths in sm4450.c
- fix patch check issue

Changes in v2:
- remove DISP related paths
- make compatible and data of of_device_id in one line
- add clock patch series dependence
- redo dt_binding_check

previous discussion here:
[1] https://lore.kernel.org/linux-arm-msm/20230915020129.19611-1-quic_tengfan@quicinc.com/
[2] https://lore.kernel.org/linux-arm-msm/20230908064427.26999-1-quic_tengfan@quicinc.com/

---
Tengfei Fan (3):
      dt-bindings: interconnect: Add Qualcomm SM4450
      interconnect: qcom: Add SM4450 interconnect provider driver
      arm64: defconfig: Enable interconnect for SM4450

 .../bindings/interconnect/qcom,sm4450-rpmh.yaml    |  133 ++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm4450.c                 | 1723 ++++++++++++++++++++
 drivers/interconnect/qcom/sm4450.h                 |  152 ++
 include/dt-bindings/interconnect/qcom,sm4450.h     |  163 ++
 7 files changed, 2183 insertions(+)
---
base-commit: 048d8cb65cde9fe7534eb4440bcfddcf406bb49c
change-id: 20240801-sm4450_interconnect-f794f0d70655

Best regards,
-- 
Tengfei Fan <quic_tengfan@quicinc.com>


