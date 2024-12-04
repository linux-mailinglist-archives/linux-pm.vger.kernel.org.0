Return-Path: <linux-pm+bounces-18580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C29E4698
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27354164D20
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00ED191F6A;
	Wed,  4 Dec 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oT1t4ck+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62E18FC9F;
	Wed,  4 Dec 2024 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347585; cv=none; b=WGex3X4DFwebklzhTc7GyRNIfrDzW1FejZ3NqIAWOrXGv7Req4J9jVbwqzpnM0xLHNrBBRfgpyCHsmm28lZkZaqg6ZfkpT2FwGPMDBC6aavD/SZZNi/ws6pqEHZI93+hsbQa+U813rpRWiXBDA31K6Xhg4FS7/mAyCHilWWt3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347585; c=relaxed/simple;
	bh=5G3TI8FG7sx1hTKz198fF2W7ZL8MBP0RnBOKm4yaOA4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gDxMalyGHSJ1JGnFaM7pVJeb+otbhfjZA+7fTAqkvyquXrN053ORIchPrdZWSiwVcBSU80Z+BylJzfWblsX+9+eLqMGHorAIiT5ZgekcpcOGzBNfOMwJzHbvgWhRRex9ANzNsFglvi6HG4ejbXAwtvGYFS7B8dO1Bq9El0CYMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oT1t4ck+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FamBT023344;
	Wed, 4 Dec 2024 21:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wyOcFOKWssh3221kmAxkUj
	HamyXIeCZqHEsBuUMyod0=; b=oT1t4ck+o3yyRmGVKFkbASCxbAzlFbJq9NHL0Z
	QNravvUcxTBYMajP8hc7QZ7qPM15TPk5DGX3TAtXeI5OEKOj24tUuvIDHYcB50PI
	y+pebh2LeFigkVGXP4Wr9mfO+DJU/n2LW48KEuBZLNnTBr167irXJ4GRY5HUHf9+
	lXSvgSceNOW9L0hR0QotwYpg5Kqk60HC8s6FF3JQaGNxzEtyaoGBJA3gS++VOfAR
	qNzN5/zu2tDMy3X4QieRTbzfqASuOu2Wc6aDJfFepKtjbVvTWztUJQWte2CgnH0x
	KQC4btLrOsiF/TDoEBCrtAhFMV4Hnk8B2GJgPhqCygCObc5Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43aj42a7bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 21:26:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4LQI5W023737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 21:26:18 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 13:26:17 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 0/2] interconnect: qcom: Introduce interconnects for
 SM8750
Date: Wed, 4 Dec 2024 13:26:04 -0800
Message-ID: <20241204-sm8750_master_interconnects-v3-0-3d9aad4200e9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzIUGcC/x3MSwqAMAwA0atI1hZitfi5iohIjZqFUZoignh3i
 5uBt5kHlAKTQpc9EOhi5UMSyjwDv02ykuE5GSzaqrBYGd2b2uG4TxopjCyp/hAhH9U4bFrvWpw
 XcpAOZ6CF7//eD+/7AaEvLVJtAAAA
X-Change-ID: 20241204-sm8750_master_interconnects-5089c590dfe5
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733347577; l=1291;
 i=quic_molvera@quicinc.com; s=20241204; h=from:subject:message-id;
 bh=5G3TI8FG7sx1hTKz198fF2W7ZL8MBP0RnBOKm4yaOA4=;
 b=icVDrlcbHKuXpmcJFvAOZXy8n1nhVtUGFHk/nLDyT/LcU8c1Dw8FzHkQs+9EF4kpix94/H1cl
 pK5ii4xKoJ1CvHI0IFrdO/bBsLsgCe/pMIFk/yvXnNDmhbO5HvPJlHI
X-Developer-Key: i=quic_molvera@quicinc.com; a=ed25519;
 pk=1DGLp3zVYsHAWipMaNZZTHR321e8xK52C9vuAoeca5c=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B5wiJXMgj_mT11rTF0wxszeozJCdXf4H
X-Proofpoint-ORIG-GUID: B5wiJXMgj_mT11rTF0wxszeozJCdXf4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=638 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040165

Add interconnect support for SM8750 SoC.

The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
consumer mobile device SoCs. See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf

Changes in V3:
- merged sm8750.h into sm8750.c

Changes in V2:
- updating style to be consistent with other interconnect drivers
- removed dead code

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: add interconnect bindings for SM8750
      interconnect: qcom: Add interconnect provider driver for SM8750

 .../bindings/interconnect/qcom,sm8750-rpmh.yaml    |  136 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm8750.c                 | 1705 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm8750-rpmh.h    |  143 ++
 5 files changed, 1995 insertions(+)
---
base-commit: bcf2acd8f64b0a5783deeeb5fd70c6163ec5acd7
change-id: 20241204-sm8750_master_interconnects-5089c590dfe5

Best regards,
-- 
Melody Olvera <quic_molvera@quicinc.com>


