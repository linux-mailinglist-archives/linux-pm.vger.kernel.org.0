Return-Path: <linux-pm+bounces-13133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E7963E66
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEAC1C21D45
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C418C033;
	Thu, 29 Aug 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nl+dGyMr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217418C025;
	Thu, 29 Aug 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920159; cv=none; b=TJalwBBeTa8CPCO3VmDVx4FDEHDA25fZO9XAvMdPv3r7hSLQFx1U0TVa1mvXbXB0IQBB2/UeiroZ3WroVVqF1Tnv18HAvGyr+6cByelWkROAQK6shECXBTjk6uLZRRVqGbAVQ5jAONTJcAdwpemG1ZVS/GVIKcGnt4dn1vmOFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920159; c=relaxed/simple;
	bh=E22UVlKfybQ6Tmjaw6PPYSMUlg5345khqFSuT+Vhx8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNYKYQJp+0YFi0PpbR6x3Cdc9K8SiQzPuuNeMZEgcmHQxoQ8Bs0mnDiAuz7OhX1VAfi8OacE9WjccJuwsQJJt0s+WkMY1Ei5TZ/JVI7KZZStmX/HIfsrLvq2hrlwR5sIUmyqhnRbVmDbR5Jj/T+sp/6fo2nDJaiLxnqAjweNDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nl+dGyMr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T8QcaV000605;
	Thu, 29 Aug 2024 08:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7ry3tTO1NvxIQ0xDSdkI6D
	BGk1wEMGklt9PYcx1cDHY=; b=Nl+dGyMrwrKC+czRz5w4HQUwS06UGUWeL7aIJJ
	rZm3pqlVgrDs3DbdSLMoFT153pMx6jl12Kd+wsscicg2Z54O2f5XaS+8Dt4FLscR
	r6J+QYNEClp79f8ETxOg25rr6JqiSociVJX+SUIhiWR2kTodE6f03MzRGGVnHCPW
	IGElkGcv2GZXxEVo7m3sQImQQvw8fcaZczGG7tF2PwKzY7u3yYxyga8GEhgbfANy
	/IA3QTb5KBlMFeHsC8RIJYykmbRJUUyM1QdM7iBV9Jus1wYTWwPub4NFlFtrB8w5
	Ce0b5D9Y8O+q7YqidVRnl+FBmbFJbRq3RuQu8O8p3lbchr2w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puw4h9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T8Sx8C007272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:28:59 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 01:28:52 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <djakov@kernel.org>, <richardcochran@gmail.com>,
        <geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <nfraprado@collabora.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Kathiravan Thirumoorthy
	<quic_kathirav@quicinc.com>
Subject: [PATCH v5 0/8] Add NSS clock controller support for Qualcomm IPQ5332
Date: Thu, 29 Aug 2024 13:58:22 +0530
Message-ID: <20240829082830.56959-1-quic_varada@quicinc.com>
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
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gByXCS-HlPuas1kMDGT_fDzgQ9_XjdC5
X-Proofpoint-GUID: gByXCS-HlPuas1kMDGT_fDzgQ9_XjdC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408290062

Add bindings, driver and devicetree node for networking sub system clock
controller on IPQ5332. Some of the nssnoc clocks present in GCC driver is
enabled by default and its RCG is configured by bootloaders, so enable
those clocks in driver probe.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in v5:
- Rebased on next-20240821
- Addressed review comments
- Dropped 'const qualifier' patches
- Dropped 'clk: qcom: ipq5332: enable few nssnoc clocks in driver probe'
- Enabled icc-clk for NSSCC
- Update ICC master/slave list
- In dt-bindings of nsscc
	Mark #power-domain-cells as false (as it is not applicable)
	Add #interconnect-cells
- Link to v4: https://lore.kernel.org/lkml/20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com/

Changes in v4:
- Rebased on next-20240122
- Fixed the missing space on the nsscc node
- Link to v3: https://lore.kernel.org/linux-arm-msm/20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com/

Changes in v3:
- Collected the tags
- Dropped the dt-binding patch 3/9
- Cleaned up the header file inclusion and updated the module
  description in the driver
- Used the decimal number instead of hex in the NSSCC node
- Link to v2: https://lore.kernel.org/r/20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com

Changes in v2:
- Change logs are in respective patches
- Link to v1: https://lore.kernel.org/r/20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com

---
Kathiravan Thirumoorthy (6):
  dt-bindings: clock: ipq5332: add definition for GPLL0_OUT_AUX clock
  clk: qcom: ipq5332: add gpll0_out_aux clock
  dt-bindings: clock: add Qualcomm IPQ5332 NSSCC clock and reset
    definitions
  clk: qcom: add NSS clock Controller driver for Qualcomm IPQ5332
  arm64: dts: qcom: ipq5332: add support for the NSSCC
  arm64: defconfig: build NSS Clock Controller driver for Qualcomm
    IPQ5332

Varadarajan Narayanan (2):
  dt-bindings: interconnect: Update master/slave id list
  clk: qcom: ipq5332: Add couple of more interconnects

 .../bindings/clock/qcom,ipq5332-nsscc.yaml    |   64 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |   28 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-ipq5332.c                |   16 +
 drivers/clk/qcom/nsscc-ipq5332.c              | 1049 +++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5332-gcc.h  |    1 +
 .../dt-bindings/clock/qcom,ipq5332-nsscc.h    |   86 ++
 .../dt-bindings/interconnect/qcom,ipq5332.h   |    4 +
 10 files changed, 1259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5332-nsscc.yaml
 create mode 100644 drivers/clk/qcom/nsscc-ipq5332.c
 create mode 100644 include/dt-bindings/clock/qcom,ipq5332-nsscc.h

-- 
2.34.1


