Return-Path: <linux-pm+bounces-9640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C795790FE6E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5195CB21328
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13A17BB0F;
	Thu, 20 Jun 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oBu9euuO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2868317B402;
	Thu, 20 Jun 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871324; cv=none; b=Y3VlDzAyTWYicK1TFEBhpwFfLZePQU6R6i1G6WyUX8+Fl4ybTF8DuZgfBQ8blm4d5oNaNB8k7fYyLh0BcRaIwTnDkgYVLaapWPZQsMYXdk0zyX1BeaDFOSJePZ48WrcqVB4nwdbZhGv8Xqq85AarKe9L9fHQ3xCj+Rd0eEHbcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871324; c=relaxed/simple;
	bh=ecZzONJSzbydBjHKZzEKnU+9C7vywwQ1yMDmvKYVtrQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SHEgOkCnB3n1h+O7LBR7ZwPjS2iS1RTFshs+l76ONj/6Bj2zALQ+pqevYI1m35u+RD5R7QuD1dZ/UZ+QN0e21ZBzmZA3qoGtVW32sVP2wCZ+3TBg/t+msOylyi+odtD+0aNYS0LmHW8ERlqPmM+WGaqePyrXkaa1VSmo5tCdIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oBu9euuO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K7A9CX019372;
	Thu, 20 Jun 2024 08:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5vRrdL+XbDqQ23ECVw34g6
	vbTmR+1A6/Y8bIUfhDJVY=; b=oBu9euuObx6Uvd/FOKtqMI41CGNyv8YeL6cXi2
	FlhBJP64iif7yoRYHlmp0PAseF8pI2YXwoTsCFMljRr5ILKSqFVDHL+hVNpDbLuC
	xEfRFkjUK1Prs92gLdf4ZeXFgER/88REVBQ37Y0keA+uIIpDeM7u0ZMagoTeLkJJ
	GGzfU3a0HrpwmW2j3Uv2kmnR9bI3b3PFu64SgxRpdbH+d2umzvaDTnMB+hsitEfj
	zOc5MpKV26yrOWJp18uh34m+7Fkr9T3lI2NbwPibvYuvPDQc6z7K+7PSAwA3KQOK
	MdmjCBTR4WaSc8PXyF4pvK9phZUfCu10U1id3QcGWgnaqCiQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv2xu9nhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K8F8t4018260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:08 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 01:15:01 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <quic_varada@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <danila@jiaxyga.com>, <otto.pflueger@abscue.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v1 0/7] Enable CPR for IPQ9574
Date: Thu, 20 Jun 2024 13:44:20 +0530
Message-ID: <20240620081427.2860066-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: iIuSiD1YrF8RgAOsFInS5hdmfWZqILUs
X-Proofpoint-ORIG-GUID: iIuSiD1YrF8RgAOsFInS5hdmfWZqILUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=945 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200058

This series tries to enable CPR on IPQ9574, that implements
CPRv4. Since [1] is older, faced few minor issues. Those are
addressed in [2].

dt_binding_check and dtbs_check passed.

Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/commits/konrad/

Varadarajan Narayanan (7):
  dt-bindings: power: rpmpd: Add IPQ9574 power domains
  dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
  pmdomain: qcom: rpmpd: Add IPQ9574 power domains
  dt-bindings: clock: Add CPR clock defines for IPQ9574
  clk: qcom: gcc-ipq9574: Add CPR clock definition
  soc: qcom: cpr3: Add IPQ9574 definitions
  dts: arm64: qcom: ipq9574: Enable CPR

 .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
 .../bindings/soc/qcom/qcom,cpr3.yaml          |  32 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 269 ++++++++++++++++--
 drivers/clk/qcom/gcc-ipq9574.c                |  38 +++
 drivers/pmdomain/qcom/cpr3.c                  | 137 +++++++++
 drivers/pmdomain/qcom/rpmpd.c                 |  19 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   1 +
 include/dt-bindings/power/qcom-rpmpd.h        |   3 +
 8 files changed, 483 insertions(+), 17 deletions(-)

-- 
2.34.1


