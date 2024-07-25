Return-Path: <linux-pm+bounces-11395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F8993C048
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 12:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CD328231A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB66198E80;
	Thu, 25 Jul 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MUfDQ+xC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D2481A3;
	Thu, 25 Jul 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904354; cv=none; b=ZQST3BPqg2VrtUzEPD/aIacR7YnBPHTCflGbexYc7gTTDIJhkCv//0AC1rUZT8n9ci7hXZBlI0rvgeZXsxCZBeNz3Dnmh7YQywABZXoFQhpjC1OKnt22PmUW/Qf2qpxTNrZE+sDhPvGFrW8ctqN+Nefba1OSZpqp2Pe0qVekQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904354; c=relaxed/simple;
	bh=dYgriG+MyvNEUrTvLG/wwytgoO45SByZA1OLcH7HkZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COMtDtBws9EOE4IX3x6ss/Qi7omLz/9Ej/J61sp//czKW0GYzHgAkJ07/95hpaYpbmuIPJkhAwaiOV+Xjw0l1GAH4i1weZufhbgafHFTkePtC4pcOfQhn+k6kg+Qb2souGt1w61XMYqtExdSNn7/QLh9SH3wYNYlns73jFB47Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MUfDQ+xC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P8OcU6014343;
	Thu, 25 Jul 2024 10:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Y/58zRqrmDm6A+EToepvzU
	J9h1KoyMcqu86qgh08Y6c=; b=MUfDQ+xChuGQ5tsMaI/tWquelFkrgvbou2jtPk
	4pcAaZqVPDZx47nzaoiqumtVRpnvEzs/8jRrz03c//OnpA189I9zmSsoagXuPlbC
	my3YZTNtHzMMpb6Q2l7Hib2yKCrZGyxVceEfYt8bNGraGNFKe7AlxFapimbMSPGM
	ro8iRFrmI/4OYIulAoUi9DQyv4sAT7gVd+1qsPOIq/Gizv3Z9lOIN/GvDD8l10N5
	V9RCPxzoCR+s+pYgto4vldxRnIFv10u5jXtVx4CPsW47gHe9PDJCLnv+2jRGiwZr
	afax1EggR4VOmmnllo/sCDlzwbzZftomW1lx9jWyvPHMZu+A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5auvx1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 10:45:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PAjkOh029253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 10:45:46 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 03:45:40 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v5 0/5] Add interconnect driver for IPQ5332 SoC
Date: Thu, 25 Jul 2024 16:15:23 +0530
Message-ID: <20240725104528.3504967-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: c4Q21Gt8uTTCdX5Ak_tUfWrr7j-19sEU
X-Proofpoint-GUID: c4Q21Gt8uTTCdX5Ak_tUfWrr7j-19sEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=776
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250073

Enable icc-clk based interconnect driver for IPQ5332. This is
similar to IPQ9574's icc-clk based driver.

dt_bindings_check and dtbs_check passed.

Ensured that icc_sync_state is called and relevant clocks are
disabled.

v5: Fix dt-bindings entry in 'dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details'

v4: Add Reviewed-By for the first patch
    Move the gpll4_main change to next patch as suggested in review

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
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  2 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  7 ++-
 drivers/clk/qcom/gcc-ipq5332.c                | 36 ++++++++++-----
 .../dt-bindings/interconnect/qcom,ipq5332.h   | 46 +++++++++++++++++++
 5 files changed, 79 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h

-- 
2.34.1


